//
//  ChooseCarViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14/10/20.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "ChooseCarViewController.h"
#import "NecessaryViewController.h"

@interface ChooseCarViewController ()
@property (strong, nonatomic) NSMutableArray *myCarArray;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSDictionary *car_dic;

@end

@implementation ChooseCarViewController
-(instancetype)init
{
    self = [super init];
    if(self)
    {
        self.myCarArray = [[NSMutableArray alloc]init];
        [self getCarList];
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)createView
{
    self.title = @"选择车型";
    //防止上移
    UIView *v =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:v];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, RECT.size.width, RECT.size.height-49) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
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
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSDictionary *dic = self.myCarArray[indexPath.row];
//    NSString *brand = dic[@"brandName"];
    NSString *model = dic[@"modelName"];
    NSString *detail = dic[@"detailsName"];
    NSString *dddd = [NSString stringWithFormat:@"%@%@",model,detail];
    cell.textLabel.text = dddd;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.myCarArray[indexPath.row];
    self.car_dic = dic;
    NSString *model = dic[@"modelName"];
    NSString *detail = dic[@"detailsName"];
    NSString *message = [NSString stringWithFormat:@"%@%@",model,detail];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
//        NSString *car_id = self.car_dic[@"car_id"];
//        NecessaryViewController *necessVC = [NecessaryViewController new];
        self.necessary.car_dic = self.car_dic;
        [self.navigationController popViewControllerAnimated:YES];
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

//获取车辆列表
-(void)getCarList
{
    NSString *postString = [NSString stringWithFormat:@"member_session_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"]];
    NSData *data = [postString dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:GETCAR_LIST postBody:data];
    NSLog(@"%@",dic);
    NSArray *carList = dic[@"data"][@"list"];
    
    for (int i = 0; i<carList.count; i++)
    {
        NSString *str = dic[@"data"][@"list"][i][@"cart_model"];
        NSArray *arr = [str componentsSeparatedByString:@","];
        NSString *str0 = arr[0];
        NSString *str1 = arr[1];
        NSString *str2 = arr[2];
        NSString *car_id = dic[@"data"][@"list"][i][@"cat_id"];
        
        NSString *carModel = [NSString stringWithFormat:@"%@%@",str1,str2];
        NSLog(@"%@",carModel);
        NSDictionary *Car=[[NSDictionary alloc]initWithObjectsAndKeys:str0,@"brandName",str1,@"modelName",str2,@"detailsName",car_id,@"car_id", nil];
        self.car_dic = [NSDictionary dictionaryWithDictionary:Car];
        [self.myCarArray addObject:Car];
    }
    
    [self.tableView reloadData];
}
@end
