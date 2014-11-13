//
//  EvaluateViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14/11/11.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "EvaluateViewController.h"

@interface EvaluateViewController ()
@property (weak, nonatomic) IBOutlet UIButton *merchantEavluate;
@property (weak, nonatomic) IBOutlet UIButton *memberEavluate;
@property (weak, nonatomic) IBOutlet UITableView *memberTableView;
@property (weak, nonatomic) IBOutlet UITableView *merchantTableView;

@property (strong, nonatomic) NSArray *merchantArray;
@property (strong, nonatomic) NSArray *memberArray;

@end

@implementation EvaluateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getInfo];
    [self createView];
}
-(void)createView
{
    self.view.backgroundColor = GRAYCOLOR;
    self.merchantEavluate.layer.cornerRadius = 5;
    self.memberEavluate.layer.cornerRadius = 5;
    self.merchantEavluate.backgroundColor = BLUECOLOR;
    self.memberEavluate.backgroundColor = [UIColor clearColor];
}
- (IBAction)fromMerchant:(UIButton *)sender
{
    [self.memberTableView setHidden:YES];
    [self.merchantTableView setHidden:NO];
    self.merchantEavluate.backgroundColor = BLUECOLOR;
    self.memberEavluate.backgroundColor = [UIColor clearColor];
    self.merchantEavluate.tintColor = [UIColor whiteColor];
    self.memberEavluate.tintColor = [UIColor blackColor];
}
- (IBAction)fromMember:(UIButton *)sender
{
    [self.memberTableView setHidden:NO];
    [self.merchantTableView setHidden:YES];
    self.memberEavluate.backgroundColor = BLUECOLOR;
    self.merchantEavluate.backgroundColor = [UIColor clearColor];
    self.memberEavluate.tintColor = [UIColor whiteColor];
    self.merchantEavluate.tintColor = [UIColor blackColor];
}

-(void)getInfo
{
    NSString *member_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"];
    NSString *postString = [NSString stringWithFormat:@"member_session_id=%@&type=0&num=20",member_id];
    NSString *string = @"wo zai ce shi ..";
    NSData *postData = [postString dataUsingEncoding:4];
    //获取用户自己的评论列表
    NSDictionary *memberInfo = [NetWorking send:COMMENT_LIST_MEMBER postBody:postData];
//    NSLog(@"%@",memberInfo);
    if([memberInfo[@"code"]integerValue]==0)
    {
        self.memberArray = [[NSArray alloc]initWithArray:memberInfo[@"data"][@"list"]];
        NSLog(@"%@",self.memberArray);
    }
    NSString *postString1 = [NSString stringWithFormat:@"member_session_id=%@&type=2&num=20",member_id];
    NSData *postData1 = [postString1 dataUsingEncoding:4];
    //获取商户的评论列表
    NSDictionary *merchantInfo = [NetWorking send:COMMENT_LIST_MEMBER postBody:postData1];
//    NSLog(@"%@",merchantInfo);
    if([merchantInfo[@"code"]integerValue]==0)
    {
        self.merchantArray = [[NSArray alloc]initWithArray:merchantInfo[@"data"][@"list"]];
        NSLog(@"%@",self.merchantArray);
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==1212)
    {
        //卖家评价
        return 5;
    }else if(tableView.tag==2121)
    {
        //买家评价
        return 10;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if(tableView.tag==1212)
    {
        cell.textLabel.text = @"merchant";
    }
    if(tableView.tag==2121)
    {
        cell.textLabel.text = @"member";
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
