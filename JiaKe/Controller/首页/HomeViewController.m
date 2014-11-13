//
//  HomeViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "NecessaryViewController.h"
#import "EventViewController.h"
#import "NearbyBusinessViewController.h"
#import "SelectCityViewController.h"
#import "MapViewController.h"
#import "BDRRViewController.h"
#import "BusinessListViewController.h"

@interface HomeViewController ()
//搜索栏
//@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *beautyBtn;
@property (weak, nonatomic) IBOutlet UIButton *decoretBtn;
@property (weak, nonatomic) IBOutlet UIButton *repairBtn;
@property (weak, nonatomic) IBOutlet UIButton *refitBtn;
@property (weak, nonatomic) IBOutlet UIButton *necessaryBtn;
@property (weak, nonatomic) IBOutlet UIButton *eventBtn;
@property (weak, nonatomic) IBOutlet UIButton *businessBtn;
@property (strong, nonatomic) UIBarButtonItem *leftBtn;
//搜索列表
@property (strong, nonatomic) NSArray *searchList;
@property (strong, nonatomic) UISearchDisplayController *displayController;
@property (strong, nonatomic) NSDictionary *projectList;
@end
//static NSString *cityTitle;
@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //标题
        self.title = @"首页";
//        NSDictionary *projectList = [NetWorking send:CATEGORY_LIST postBody:nil];
//        self.projectList = projectList;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self navigationView];
//    cityTitle = [NSString new];
    self.searchList = @[@"1",@"2",@"2",@"2",@"2",@"2",@"2"];
    [self createView];
}
-(void)viewDidAppear:(BOOL)animated
{
    NSDictionary *projectList = [NetWorking send:CATEGORY_LIST postBody:nil];
    self.projectList = projectList;
}
#pragma mark -创建视图
-(void)createView
{
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.barStyle = 0;
    self.searchBar.showsScopeBar = YES;
    self.searchBar.placeholder = @"搜索商家";
    self.searchBar.delegate = self;
    self.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"h",@"d",@"q", nil];
    self.searchList = [NSArray arrayWithObjects:@"h",@"d",@"q",@"q",@"q", nil];
    self.searchBar.frame = CGRectMake(0, 64, RECT.size.width, 0);
    self.displayController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    self.displayController.delegate = self;
    self.displayController.searchResultsDataSource = self;
    self.displayController.searchResultsDelegate = self;
    self.searchBar.showsScopeBar = YES;
    [self.displayController setSearchResultsTitle:@"hong"];
    
    
    [self.view addSubview:self.searchBar];
    
}
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    
}
-(void)navigationView
{
    NSString *cityName = [[NSUserDefaults standardUserDefaults]objectForKey:@"cityName"];
    if(cityName.length>0)
    {
        self.leftBtn = [[UIBarButtonItem alloc]initWithTitle:cityName style:UIBarButtonItemStylePlain target:self action:@selector(cityAction:)];
        self.tabBarController.navigationItem.leftBarButtonItem =self.leftBtn;
    }else
    {
        self.leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"城市" style:UIBarButtonItemStylePlain target:self action:@selector(cityAction:)];
        self.tabBarController.navigationItem.leftBarButtonItem =self.leftBtn;
    }
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"地图" style:UIBarButtonItemStylePlain target:self action:@selector(mapAction:)];
    self.tabBarController.navigationItem.rightBarButtonItem = rightBtn;
}
- (void)cityAction:(UIButton *)sender
{
    CREATEVIEW(SelectCityViewController, selectCityVC, @"SelectCityView4_0", @"SelectCityView3_5");
    selectCityVC.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:selectCityVC];
    [self presentViewController:nav animated:YES completion:nil];
}
-(void)selectProvinceName:(NSString *)provinceName andCity:(NSString *)cityName
{
    NSString *city = [[NSUserDefaults standardUserDefaults]objectForKey:@"pid"];
    NSString *postString = [NSString stringWithFormat:@"pid=%@",city];
    NSData *postData = [postString dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:CITY_LIST postBody:postData];
    NSLog(@"%@",dic);
    NSArray *cityArray = dic[@"data"][@"list"];
    //注册沙盒目录
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //获取沙盒路径
    NSString *filename=[path stringByAppendingPathComponent:@"CityArray.plist"];
    //将数据存储到沙盒中
    [cityArray writeToFile:filename atomically:YES];
}
- (void)mapAction:(UIBarButtonItem *)sender
{
    CREATEVIEW(MapViewController, mapVC, @"MapView4_0", @"MapView3_5");
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (IBAction)BDRRAction:(UIButton *)sender
{   
    CREATEVIEW(BDRRViewController, bdrrVC, @"BDRRView4_0", @"BDRRView3_5");
    bdrrVC.projectList = self.projectList;
    [self.navigationController pushViewController:bdrrVC animated:YES];
}


#pragma mark-发布需求
- (IBAction)necessaryAction:(UIButton *)sender
{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"isLogin"])
    {
        CREATEVIEW(NecessaryViewController, necessaryVC, @"NecessaryView4_0", @"NecessaryView3_5");
        necessaryVC.projectList = self.projectList;
        [self.navigationController pushViewController:necessaryVC animated:YES];
    }else
    {
        UIAlertView *waring = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登陆", nil];
        waring.tag = 1000;
        [waring show];
    }
}
-(void)filterContentForSearchText:(NSString*)searchText                              scope:(NSString*)scope
{
    
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:searchOption]];
    return 1;
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles ]objectAtIndex:self.searchDisplayController.searchBar.selectedScopeButtonIndex]];
    return 1;
}
#pragma mark-限时活动
- (IBAction)eventAction:(UIButton *)sender
{
    NSDictionary *dic =[NetWorking send:ACTIVITY_LIST postBody:nil];
    
    CREATEVIEW(BusinessListViewController, businessList, @"BusinessListView4_0", @"BusinessListView3_5");
    businessList.activityList = [[NSArray alloc]initWithArray:dic[@"data"][@"list"]];
    [self.navigationController pushViewController:businessList animated:YES];
}
- (IBAction)nearbyAction:(UIButton *)sender
{
    CREATEVIEW(NearbyBusinessViewController, nearbyVC, @"NearbyView4_0", @"NearbyView3_5");
    [self.navigationController pushViewController:nearbyVC animated:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1000)
    {
        if(buttonIndex==1)
        {
            CREATEVIEW(LoginViewController, loginVC, @"LoginView4_0", @"LoginView3_5");
            loginVC.whichView = @"event";
            [self presentViewController:loginVC animated:YES completion:nil];
        }
    }
}
#pragma mark-
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-
#pragma mark -视图将要出现
- (void)viewWillAppear:(BOOL)animated
{
    [self navigationView];
    //开启标签栏控制
    [self.tabBarController.tabBar setHidden:NO];
    self.tabBarController.title = @"驾客";
    self.tabBarController.tabBar.frame=CGRectMake(0, RECT.size.height-49, RECT.size.width, 49);
    for(UIButton *btnview in self.tabBarController.tabBar.subviews)
    {
        
        if(btnview.tag==1000)
        {
            [btnview setImage:[UIImage imageNamed:@"首页h@2x"] forState:UIControlStateNormal];
            btnview.alpha = .65;
        }
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual:self.displayController.searchResultsTableView])
    {
        return 1;
    }else
        return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        return self.searchList.count;
    }
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:self.displayController.searchResultsTableView])
    {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = self.searchList[indexPath.row];
        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = @"dasda";
    return cell;
}

#pragma mark-视图将要消失
-(void)viewWillDisappear:(BOOL)animated
{
    for(UIButton *btnview in self.tabBarController.tabBar.subviews)
    {
        
        if(btnview.tag==1000)
        {
            [btnview setImage:[UIImage imageNamed:@"首页n@2x"] forState:UIControlStateNormal];
        }
    }
}
#pragma mark - 点击屏幕
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.searchBar resignFirstResponder];
    self.searchBar.text = @"";
    [self.searchBar endEditing:YES];
}
@end
