//
//  EventDetailsViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14/11/8.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "EventDetailsViewController.h"

@interface EventDetailsViewController ()

@end

@implementation EventDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if(indexPath.section==0)
    {
        cell.textLabel.text = @"洪泽泓";
    }else
    {
        cell.textLabel.text = @"么么哒";
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    NSArray *arr = [[NSArray alloc]initWithObjects:@"活动内容",@"商家信息",nil];
//    return arr;
//}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return @"活动内容";
    }
    if(section==1)
    {
        return @"商家信息";
    }
    return @"";
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
@end
