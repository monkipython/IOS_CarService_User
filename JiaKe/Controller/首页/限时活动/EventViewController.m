//
//  EventViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "EventViewController.h"
#import "BusinessListViewController.h"
#import "EventModel.h"

@interface EventViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tableList;
@end

@implementation EventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"限时活动";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getData];
    [self createView];
}
-(void)getData
{
//    NSString *postString = [NSString stringWithFormat:@""]
//    NSDictionary *dic =[NetWorking send:ACTIVITY_LIST postBody:nil];
//    NSLog(@"%@",dic);
//    self.tableList = dic[@"data"][@"list"];
    
}
#pragma mark -创建视图
-(void)createView
{
    self.title = @"限时活动";
    self.segment.tintColor = BLUECOLOR;
    self.tableView.separatorColor = BLUECOLOR;
}
#pragma mark -
#pragma mark -列表代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    cell.textLabel.text = self.tableList[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *activityInfo = self.tableList[indexPath.row];
    NSString *idStr = activityInfo[@"id"];
    NSString *postString = [NSString stringWithFormat:@"id=%@",idStr];
    NSData *postData = [postString dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:GET_ACTIVITY postBody:postData];
    NSLog(@"%@",dic);
    
//    CREATEVIEW(BusinessListViewController, businessList, @"BusinessListView4_0", @"BusinessListView3_5");
//    [self.navigationController pushViewController:businessList animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 5;
}
#pragma mark -
- (IBAction)segmentAction:(UISegmentedControl *)sender
{
    if(sender.selectedSegmentIndex==0)
    {
        [self.tableView setHidden:NO];
    }
    if(sender.selectedSegmentIndex==1)
    {
        [self.tableView setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
