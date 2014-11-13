//
//  ForMeViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "ForMeViewController.h"
#import "ForMeModel.h"
#import "MyOrdersViewController.h"
#import "MyCollectViewController.h"
#import "MyCarViewController.h"
#import "EvaluateViewController.h"
#import "MyDemandViewController.h"
#import "HeadViewController.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "NetWorking.h"
#import "EGOImageView.h"

@interface ForMeViewController ()
//账号头像

@property (strong, nonatomic) IBOutlet UIView *headerView;
//@property(nonatomic,strong)IBOutlet UIButton *headButton;
@property (strong, nonatomic) EGOImageView *headerImage;

//账号昵称
@property(nonatomic,strong)IBOutlet UILabel *nameLabel;
//我的订单，收藏，爱车
@property(nonatomic,strong)IBOutlet UITableView *tableView;
//背景图片
@property(nonatomic,strong)IBOutlet UIImageView  *backgroundImageVC;
//创建设置按钮
@property(nonatomic,strong)UIBarButtonItem *rightItem;
//设置数组存放选项
@property(nonatomic,strong)NSArray *optionArray;
//设置数组存放选项图标
@property(nonatomic,strong)NSArray *optionImageArray;
//个人信息
@property(strong, nonatomic) NSDictionary *infomation;
-(IBAction)head:(UIButton *)sender;


@end
static BOOL isNumberOne;
static int isCreate;
static NSIndexPath *isIndexPath;


@implementation ForMeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"Me";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}

#pragma mark -加载视图
-(void)createView
{
    //设置背景颜色为白色
    self.tableView.backgroundColor = [UIColor whiteColor];
    //设置不滑动
    self.tableView.scrollEnabled = NO;
    //设置背景未白色
    self.view.backgroundColor=[UIColor whiteColor];
    //设置设置为天蓝色
    self.nameLabel.textColor = BLUECOLOR;
    self.headerImage = [[EGOImageView alloc]initWithFrame:CGRectMake(130, 80, 60, 60)];
    self.headerImage.layer.cornerRadius = (RECT.size.width/4-20)/2;
    self.headerImage.clipsToBounds = YES;
    self.headerImage.layer.borderWidth = 1.5;
    self.headerImage.layer.borderColor = BLUECOLOR.CGColor;
    self.headerImage.placeholderImage = [UIImage imageNamed:@"头像"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(head:)];
    [self.headerImage setUserInteractionEnabled:YES];
    [self.headerImage addGestureRecognizer:tap];
    [self.view addSubview:self.headerImage];
    isNumberOne = YES;
    isCreate = 1;
}
#pragma mark -点击设置响应的方法
-(void)settingAction:(UIBarButtonItem *)sender
{
    if(isCreate==1)
    {
        isCreate++;
    }
    //创建设置界面 并实现跳转
    CREATEVIEW(SettingViewController, settingVC, @"SettingView4_0", @"SettingView3_5")
    settingVC.title = @"设置";
    [self.navigationController pushViewController:settingVC animated:YES];
}
#pragma mark -点击头像响应的方法
-(void)head:(UITapGestureRecognizer *)sender
{
    //创建个人信息界面 并实现跳转
    CREATEVIEW(HeadViewController, headVC, @"HeadView4_0", @"HeadView3_5");
    headVC.title=@"个人信息";
    headVC.infomation = self.infomation;
    [self.navigationController pushViewController:headVC animated:YES];

}
-(void)getInfomation
{
    BOOL result = [[NSUserDefaults standardUserDefaults]boolForKey:@"isLogin"];
    //有登陆就加载信息，没登陆到登陆界面登陆
    if(result)
    {
        NSString *member_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"];
        NSLog(@"%@",member_id);
        NSString *postString = [NSString stringWithFormat:@"member_session_id=%@",member_id];
        NSData *postData = [postString dataUsingEncoding:4];
        NSDictionary *dic = [NetWorking send:GET_MEMBER postBody:postData];
        NSLog(@"%@",dic);
        if([dic[@"code"]integerValue]==2)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登陆过期请重新登陆!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
            alert.tag = 2001;
            [alert show];
        }
        if([dic[@"code"]integerValue]==0)
        {
            NSString *headerUrl = [[NSString alloc]initWithString:dic[@"data"][@"header"]];
            [self.tableView setUserInteractionEnabled:YES];
            self.headerImage.imageURL = [NSURL URLWithString:headerUrl];
            self.infomation = [[NSDictionary alloc]initWithDictionary:dic];
        }
        if([dic[@"code"]integerValue]==1010)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"Net  desconnect" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请先登陆" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 1991;
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1991)
    {
        if(buttonIndex==1)
        {
            CREATEVIEW(LoginViewController, loginVC, @"LoginView4_0", @"LoginView3_5");
            loginVC.whichView = @"event";
            [self presentViewController:loginVC animated:YES completion:nil];
        }
        else
        {
            [self.tableView setUserInteractionEnabled:NO];
        }
    }
    if(alertView.tag == 2001)
    {
        if(buttonIndex==0)
        {
            CREATEVIEW(LoginViewController, loginVC, @"LoginView4_0", @"LoginView3_5");
            loginVC.whichView = @"event";
            [self presentViewController:loginVC animated:YES completion:nil];
        }else
        {
            [self.tableView setUserInteractionEnabled:NO];
        }
        
    }
}
#pragma mark -tabieView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //返回组数
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //返回行数
    return self.optionArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"ForMeTableViewCellID";
    BOOL isRegister=NO;
    if (!isRegister) {
        UINib *nib=[UINib nibWithNibName:@"ForMeTableViewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:cellID];
        isRegister=YES;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UILabel *label = (UILabel *)[cell viewWithTag:1002];
    label.text=self.optionArray[indexPath.row];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1001];
    imageView.image=[UIImage imageNamed:self.optionImageArray[indexPath.row]];
    return cell;
}

#pragma mark -点击单元格响应方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isNumberOne==YES) {
        isNumberOne=NO;
    }
    if(isCreate==1)
    {
        isCreate++;
    }
    isIndexPath = indexPath;
    switch (indexPath.row)
    {
        case 0:{
            //创建未完成订单信息界面 并实现跳转
            CREATEVIEW(MyOrdersViewController, myOrdersVC, @"MyOrdersView4_0", @"MyOrdersView3_5")
            myOrdersVC.title=@"我的订单";
            [self.navigationController pushViewController:myOrdersVC animated:YES];
        }
            break;
        case 1:{
            CREATEVIEW(MyDemandViewController, myDemandVC, @"MyDemandView4_0", @"MyDemandView3_5");
            myDemandVC.title = @"我的需求";
            [self.navigationController pushViewController:myDemandVC animated:YES];

        }
            break;
        case 2:{
            //创建我的收藏信息界面 并实现跳转
            CREATEVIEW(MyCollectViewController, myCollectVC, @"MyCollectView4_0", @"MyCollectView3_5")
            myCollectVC.title = @"我的收藏";
            [self.navigationController pushViewController:myCollectVC animated:YES];
        }
            break;
        case 3:{
            //创建我的爱车信息界面 并实现跳转
            CREATEVIEW(MyCarViewController, myCarVC, @"MyCarView4_0", @"MyCarView3_5")
            myCarVC.title = @"我的爱车";
            [self.navigationController pushViewController:myCarVC animated:YES];
        }
            break;
        case 4:{
            //创建评价管理界面 并实现跳转
            CREATEVIEW(EvaluateViewController, evaluateVC, @"EvaluateView4_0", @"EvaluateView3_5")
            evaluateVC.title = @"评价管理";
            [self.navigationController pushViewController:evaluateVC animated:YES];
        }
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
-(void)viewDidAppear:(BOOL)animated
{
    [self getInfomation];
    [self putInfomation:nil];
}
#pragma mark -进入视图时
-(void)viewWillAppear:(BOOL)animated
{
//    [self getInfomation];
//    [self putInfomation:nil];
    //获取选项名称数组
    self.optionArray = [ForMeModel optionName];
    //获取选项图片数组
    self.optionImageArray = [ForMeModel optionInamgeName];
    //开启标签栏控制
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.titleView = nil;
    self.tabBarController.title = @"Me";
    self.tabBarController.tabBar.frame=CGRectMake(0, RECT.size.height-49, RECT.size.width, 49);
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [ button setImage:[UIImage imageNamed:@"驾客（我的）11361_03"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    self.rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.tabBarController.navigationItem.rightBarButtonItem = self.rightItem;
    for(UIButton *btnview in self.tabBarController.tabBar.subviews)
    {
        
        if(btnview.tag==1002)
        {
            [btnview setImage:[UIImage imageNamed:@"个人中心h@2x"] forState:UIControlStateNormal];
            btnview.alpha = .65;
        }
    }
    if (isNumberOne==NO) {
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:isIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toHomeView) name:@"tohome" object:nil];
}
#pragma mark -跳到首页
-(void)toHomeView
{
    self.tabBarController.selectedIndex = 0;
}
#pragma mark -放入信息
-(void)putInfomation:(NSDictionary *)info
{
    NSString *nick = self.infomation[@"data"][@"nick_name"];
    self.nameLabel.text = nick;
    NSString *mobile = self.infomation[@"data"][@"mobile"];
    [[NSUserDefaults standardUserDefaults]setObject:mobile forKey:@"mobile"];
    
}
-(void)writeTodatabase:(NSDictionary *)info
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"work.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"Could not open db.");
    }else
    {
        if([db executeUpdate:@"CREATE TABLE work (name text,time text,which text,date text)"])
        {
            NSLog(@"创建表成功！");
            [db close];
        }
    }
}
#pragma mark -离开视图时
-(void)viewWillDisappear:(BOOL)animated
{
//    //开启标签栏控制
//    [self.tabBarController.tabBar setHidden:NO];
    
    for(UIButton *btnview in self.tabBarController.tabBar.subviews)
    {
        
        if(btnview.tag==1002)
        {
            [btnview setImage:[UIImage imageNamed:@"个人中心n@2x"] forState:UIControlStateNormal];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
