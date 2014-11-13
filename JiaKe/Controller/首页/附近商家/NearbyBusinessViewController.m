//
//  NearbyBusinessViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-2.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "NearbyBusinessViewController.h"
#import "CityTableViewCell.h"
#import "NearbyModel.h"
#import "DetailsViewController.h"

@interface NearbyBusinessViewController ()
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UIButton *areaBtn;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//商家数据
@property (strong, nonatomic) NSArray *businessInfo;
@property (strong, nonatomic) NSMutableArray *tableViewArray;
@end

@implementation NearbyBusinessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getInfo];
    [self createView];
}
-(void)getInfo
{
    self.businessInfo = [NearbyModel returnInfomation:0];
    self.tableViewArray = [[NSMutableArray alloc]initWithArray:self.businessInfo];
}
#pragma mark-按钮方法
- (IBAction)chooseAction:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"选择项目" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"美容",@"装饰",@"维修",@"改装", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //清空数据源
    [self.tableViewArray removeAllObjects];
    if(buttonIndex==1)
    {
        //美容
        [self BDRRinfomation:1];
    }
    if(buttonIndex==2)
    {
        //装饰
       [self BDRRinfomation:2];
    }
    if(buttonIndex==3)
    {
        //维修
        [self BDRRinfomation:3];
        
    }
    if(buttonIndex==4)
    {
        //改装
        [self BDRRinfomation:4];
    }
}
//加载不同的数据！
-(void)BDRRinfomation:(NSInteger)num
{
    self.businessInfo = [NearbyModel returnInfomation:num];
    self.tableViewArray = [[NSMutableArray alloc]initWithArray:self.businessInfo];
    [self.tableView reloadData];
}
- (IBAction)areaAction:(UIButton *)sender
{
    
}
- (IBAction)locationAction:(UIButton *)sender
{
    
}

#pragma mark - 构建视图
-(void)createView
{
    self.title = @"附近商家";
    self.chooseBtn.layer.borderWidth = .5;
    self.chooseBtn.layer.cornerRadius = 4;
    self.chooseBtn.layer.borderColor = BLUECOLOR.CGColor;
    self.areaBtn.layer.borderWidth = .5;
    self.areaBtn.layer.cornerRadius = 4;
    self.areaBtn.layer.borderColor = BLUECOLOR.CGColor;
    self.locationBtn.layer.borderWidth = .5;
    self.locationBtn.layer.cornerRadius = 4;
    self.locationBtn.layer.borderColor = BLUECOLOR.CGColor;
}
#pragma mark-
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellIdentifire";
    //出列可重用队列中获取cell
    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[CityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
//    cell.textLabel.text = @"qwertyyui";
    NSDictionary *dic = self.tableViewArray[indexPath.row];
//    double distance = [dic[@"distance"] doubleValue];
    //创建自定义单元格
    [cell createNearby:dic];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *details = [[DetailsViewController alloc]init];
    details.infomation = self.tableViewArray[indexPath.row];
    [self.navigationController pushViewController:details animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
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
