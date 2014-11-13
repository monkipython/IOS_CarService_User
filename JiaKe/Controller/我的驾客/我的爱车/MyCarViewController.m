//
//  MyCarViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "MyCarViewController.h"
#import "SelectCarViewController.h"


@interface MyCarViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)UIBarButtonItem *rightItem;
@property(strong,nonatomic)NSMutableArray *myCarArray;
@property(strong,nonatomic)NSString *carName;
@property(assign,nonatomic)BOOL *isModify;
@property (strong, nonatomic) NSString *carString;
@property (strong, nonatomic) NSArray *carARRAY;
@end
static NSIndexPath *isIndexPath;


@implementation MyCarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getCarList];
}

#pragma mark -加载视图
-(void)createView
{
    self.myCarArray = [[NSMutableArray alloc]init];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
   [ button setImage:[UIImage imageNamed:@"添加btn"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addCarAction:) forControlEvents:UIControlEventTouchUpInside];
    self.rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = self.rightItem;
}
- (void)addCarAction:(UIBarButtonItem *)sender
{
    CREATEVIEW(SelectCarViewController, selectCarVC, @"SelectCarView4_0", @"SelectCarView3_5")

    UINavigationController *selectCarNVC = [[UINavigationController alloc]initWithRootViewController:selectCarVC];
    selectCarNVC.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    selectCarVC.delegate=self;
    [self presentViewController:selectCarNVC animated:YES completion:nil];
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
    return self.myCarArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"MyCarTableViewCellID";
    BOOL isRegister=NO;
    if (!isRegister) {
        UINib *nib=[UINib nibWithNibName:@"MyCarTableViewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:cellID];
        isRegister=YES;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    NSDictionary *dic = self.myCarArray[indexPath.row];
    UILabel *brandName = (UILabel *)[cell viewWithTag:1000];
    brandName.text= dic[@"brandName"];
    UILabel *modelName = (UILabel *)[cell viewWithTag:1001];
    modelName.text = dic[@"modelName"];
    UILabel *detailsName = (UILabel *)[cell viewWithTag:1002];
    detailsName.text = dic[@"detailsName"];
    return cell;
}

#pragma mark -点击单元格响应方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *aleView =[[UIAlertView alloc]initWithTitle:@"提示" message:
                           self.carName delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    aleView.tag = 2000;
    NSDictionary *dic = self.carARRAY[indexPath.row];
    self.carString = [NSString stringWithFormat:@"%@",dic[@"cat_id"]];
    [aleView show];
}


#pragma mark UIAlertView 代理

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView.tag==2000)
    {
        if (buttonIndex==0)
        {
            NSLog(@"取消");
        }
        else if (buttonIndex==1)
        {
            NSLog(@"删除");
            NSLog(@"%@",self.carString);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定删除车辆?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.tag = 3000;
            [alert show];
            
//            NSString *postString = [NSString stringWithFormat:@"car_id=%@",self.carString];
//            NSData *postData = [postString dataUsingEncoding:4];
//            NSDictionary *dic = [NetWorking send:DEL_CAR postBody:postData];
//            if([dic[@"code"]integerValue]==0)
//            {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"删除车辆成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                [alert show];
//                [self getCarList];
//            }
        }
    }
    if (alertView.tag==3000)
    {
        if(buttonIndex==1)
        {
            NSString *postString = [NSString stringWithFormat:@"car_id=%@",self.carString];
            NSData *postData = [postString dataUsingEncoding:4];
            NSDictionary *dic = [NetWorking send:DEL_CAR postBody:postData];
            if([dic[@"code"]integerValue]==0)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"删除车辆成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                [self getCarList];
            }
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(void)sendCarBrand:(NSString *)brandName andCarModel:(NSString *)modelName andDetails:(NSString *)detailsName andCarName:(NSString *)carName
{
    NSString *str = [NSString stringWithFormat:@"%@,%@,%@",brandName,modelName,detailsName];
    NSString *postString = [NSString stringWithFormat:@"cart_model=%@&member_session_id=%@",str,[[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"]];
    NSData *postData = [postString dataUsingEncoding:4];
    //添加车辆
    NSDictionary *returnDic = [NetWorking send:ADDCAR postBody:postData];
    if([returnDic[@"code"]integerValue]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"车辆信息已添加" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}
//获取车辆列表
-(void)getCarList
{
    NSString *postString = [NSString stringWithFormat:@"member_session_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"]];
    NSData *data = [postString dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:GETCAR_LIST postBody:data];
    
    [self.myCarArray removeAllObjects];
    NSArray *carList = dic[@"data"][@"list"];
    self.carARRAY = [[NSArray alloc]initWithArray:carList];
    for (int i = 0; i<carList.count; i++) {
        NSString *str = dic[@"data"][@"list"][i][@"cart_model"];
        NSArray *arr = [str componentsSeparatedByString:@","];
        NSString *str0 = arr[0];
        NSString *str1 = arr[1];
        NSString *str2 = arr[2];
        NSString *carModel = [NSString stringWithFormat:@"%@%@",str1,str2];
        NSLog(@"%@",carModel);
        NSDictionary *Car=[[NSDictionary alloc]initWithObjectsAndKeys:str0,@"brandName",str1,@"modelName",str2,@"detailsName",nil];
        [self.myCarArray addObject:Car];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
