//
//  BusinessListViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-2.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "BusinessListViewController.h"
#import "BussinessListModel.h"
#import "CityTableViewCell.h"
#import "DetailsViewController.h"
#import "EventDetailsViewController.h"

@interface BusinessListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//商家数据
@property (strong, nonatomic) NSArray *businessInfo;
@property (strong, nonatomic) NSMutableArray *tableViewArray;
@end

@implementation BusinessListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"商家列表";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self getInfo];
}
#pragma mark - 获得数据
-(void)getInfo
{
    self.businessInfo = [BussinessListModel returnInfomation:nil];
    NSLog(@"%@",self.businessInfo);
    self.tableViewArray = [[NSMutableArray alloc]initWithArray:self.businessInfo];

}
#pragma mark-
#pragma mark -列表的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.activityList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellIdentifire";
    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[CityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        NSDictionary *dic = self.activityList[indexPath.row];
        NSLog(@"%@",dic);
        //创建自定义单元格
        [cell createCell:dic];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *activityInfo = self.activityList[indexPath.row];
    NSString *idStr = activityInfo[@"id"];
    NSString *postString = [NSString stringWithFormat:@"id=%@",idStr];
    NSData *postData = [postString dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:GET_ACTIVITY postBody:postData];
    CREATEVIEW(EventDetailsViewController, eventDetail, @"EventDetails4_0", @"EventDetails3_5");
    [self.navigationController pushViewController:eventDetail animated:YES];
    NSLog(@"%@",dic);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
#pragma mark-
#pragma mark -内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
