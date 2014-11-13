//
//  MyOrdersViewController.m
//  JiaKeB
//
//  Created by fuzhaorui on 14-9-15.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "MyOrdersViewController.h"
#import "OrdersDetailsViewController.h"
#import "OrderTableViewCell.h"
#import "OrderAlreadyViewController.h"

@interface MyOrdersViewController ()
@property (weak, nonatomic) IBOutlet UIButton *undoneOrdersButton;
@property (weak, nonatomic) IBOutlet UIButton *completedOrdersButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *alreadyTableView;

@property (assign,nonatomic) BOOL iscompleted;
@property (assign,nonatomic) NSString *ordersString;
@property (strong, nonatomic) NSArray *order_no_list;
@property (strong, nonatomic) NSArray *order_al_list;
@end
//BOOL isRegister;
static BOOL isNumberOne;
static NSIndexPath *isIndexPathOne;
static NSIndexPath *isIndexPathTwo;
static int abcdef;
@implementation MyOrdersViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getInfo];
    [self createView];
//    abcdef = 0;
}
-(void)viewDidAppear:(BOOL)animated
{
    
}
-(void)getInfo
{
    NSString *member_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"member_id"];
    NSString *no_order = [NSString stringWithFormat:@"member_session_id=%@&type=1&num=20",member_id];
    NSData *no_data = [no_order dataUsingEncoding:4];
    NSString *already_order = [NSString stringWithFormat:@"member_session_id=%@&type=2&num=20",member_id];
    NSData *already_data = [already_order dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:ORDER_LIST postBody:no_data];
    self.order_no_list = [[NSArray alloc]initWithArray:dic[@"data"][@"list"]];
    NSDictionary *al_dic = [NetWorking send:ORDER_LIST postBody:already_data];
    self.order_al_list = [[NSArray alloc]initWithArray:al_dic[@"data"][@"list"]];
}
#pragma mark -加载视图
-(void)createView
{
    self.view.backgroundColor = GRAYCOLOR;
    [self undoneOrdersAction:nil];
    self.undoneOrdersButton.layer.cornerRadius = 5;
    self.completedOrdersButton.layer.cornerRadius = 5;
    isNumberOne =YES;

}
- (IBAction)undoneOrdersAction:(UIButton *)sender {
    [self.tableView setHidden:NO];
    [self.alreadyTableView setHidden:YES];
    self.undoneOrdersButton.backgroundColor = BLUECOLOR;
    self.completedOrdersButton.backgroundColor = [UIColor clearColor];
    self.undoneOrdersButton.tintColor = [UIColor whiteColor];
    self.completedOrdersButton.tintColor = [UIColor blackColor];
    self.ordersString = @"未完成订单";
    
}
- (IBAction)completedOrdersAction:(UIButton *)sender {
    [self.tableView setHidden:YES];
    [self.alreadyTableView setHidden:NO];
    self.completedOrdersButton.backgroundColor = BLUECOLOR;
    self.undoneOrdersButton.backgroundColor =  [UIColor clearColor];
    self.completedOrdersButton.tintColor = [UIColor whiteColor];
    self.undoneOrdersButton.tintColor = [UIColor blackColor];
    self.ordersString = @"已完成订单";
   
}
-(void)viewWillAppear:(BOOL)animated
{
    if(isIndexPathOne)
    {
        
        if(!self.tableView.hidden)
        {
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:isIndexPathOne, nil] withRowAnimation:UITableViewRowAnimationAutomatic
             ];
        }
    }
    if(isIndexPathTwo)
    {
        if(!self.alreadyTableView.hidden)
        {
            [self.alreadyTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:isIndexPathTwo, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    if(tableView.tag==3330)
    {
        return self.order_no_list.count;
    }else if(tableView.tag==4440)
    {
        return self.order_al_list.count;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"cellIdentifier";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        abcdef++;
        cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [cell createOrderCell];
    }
    NSDictionary *dic = [NSDictionary dictionary];
    if(tableView.tag==3330)
    {
        dic = self.order_no_list[indexPath.row];
    }else if(tableView.tag==4440)
    {
        dic = self.order_al_list[indexPath.row];
    }
    //订单号
    UILabel *or_id = (UILabel *)[cell.contentView viewWithTag:500];
    or_id.text = [NSString stringWithFormat:@"订单号:%@",dic[@"order_no"]];
    
    //头像
    EGOImageView *header = (EGOImageView *)[cell.contentView viewWithTag:501];
    header.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"header"]]];
    
    //添加时间
    UILabel *or_add = (UILabel *)[cell.contentView viewWithTag:502];
    or_add.text = [NSString stringWithFormat:@"添加时间:%@",dic[@"addtime"]];
    
    //商户名
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:503];
    name.text = dic[@"merchant_name"];
    UILabel *project = (UILabel *)[cell.contentView viewWithTag:504];
    project.text = dic[@"obj_name"];
    UILabel *price = (UILabel *)[cell.contentView viewWithTag:505];
    price.text = [NSString stringWithFormat:@"￥:%@", dic[@"total_price"]];
    return cell;
}
#pragma mark -点击单元格响应方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==3330)
    {
        isIndexPathOne = [[NSIndexPath alloc]init];
        isIndexPathOne = indexPath;
        NSDictionary *dic = self.order_no_list[indexPath.row];
        CREATEVIEW(OrderAlreadyViewController, ordersDetailsVC, @"OrderAlreadrView4_0", @"OrderAlreadrView3_5")
        ordersDetailsVC.order_id = dic[@"id"];
        ordersDetailsVC.alreadyOrNot = [NSString stringWithFormat:@"NO"];
        [self.navigationController pushViewController:ordersDetailsVC animated:YES];
    }
    if(tableView.tag==4440)
    {
        isIndexPathTwo = [[NSIndexPath alloc]init];
        isIndexPathTwo = indexPath;
        NSDictionary *dic = self.order_al_list[indexPath.row];
        CREATEVIEW(OrderAlreadyViewController, ordersDetailsVC, @"OrderAlreadrView4_0", @"OrderAlreadrView3_5")
        ordersDetailsVC.order_id = dic[@"id"];
        ordersDetailsVC.alreadyOrNot = [NSString stringWithFormat:@"YES"];
        [self.navigationController pushViewController:ordersDetailsVC animated:YES];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
