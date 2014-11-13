//
//  BusinessInfoViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-10-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "BusinessInfoViewController.h"

@interface BusinessInfoViewController ()
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *merchantName;
@property (weak, nonatomic) IBOutlet UILabel *merchantPhone;
@property (weak, nonatomic) IBOutlet UILabel *merchantAddress;
@property (weak, nonatomic) IBOutlet UILabel *businessTime;
@property (weak, nonatomic) IBOutlet UITextView *merchantIntroduce;
@property (weak, nonatomic) IBOutlet UILabel *attitude;
@property (weak, nonatomic) IBOutlet UILabel *quality;
@property (weak, nonatomic) IBOutlet UILabel *environment;

@end

@implementation BusinessInfoViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.title = @"商家详情";
    }
    return self;
}
#pragma mark -
#pragma mark -构造区(View)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}
-(void)createView
{
    self.merchantIntroduce.layer.borderWidth = .6;
    self.merchantIntroduce.layer.cornerRadius = 5;
}
-(void)viewDidAppear:(BOOL)animated
{
    NSString *member = [[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"];
    NSString *postString = [NSString stringWithFormat:@"member_session_id=%@&merchant_id=%@",member,self.merchantId];
    NSData *data = [postString dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:GETMERCHANT postBody:data];
    NSLog(@"%@",dic);
    if([dic[@"code"]integerValue]==0)
    {
        NSDictionary *info = dic[@"data"];
        self.merchantName.text = info[@"merchant_name"];
        self.merchantPhone.text = info[@"tel"];
        self.merchantAddress.text = info[@"address"];
        self.merchantIntroduce.text = info[@"intro"];
        self.attitude.text = [NSString stringWithFormat:@"%@",info[@"service_attitude"]];
        self.quality.text = [NSString stringWithFormat:@"%@",info[@"service_quality"]];
        self.environment.text = [NSString stringWithFormat:@"%@",info[@"merchant_setting"]];
        
    }
    if([dic[@"code"]integerValue]==1)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"获取商家信息失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return 25;
    }else
    {
        return 165;
    }
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 280;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.text = @"评论";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.text = @"共10条";
        return cell;
    }else
    {
        static NSString *identifire = @"CommentCell";
        BOOL isRegist = NO;
        if(!isRegist)
        {
            UINib *nib = [UINib nibWithNibName:@"CommentCell" bundle:[NSBundle mainBundle]];
            [tableView registerNib:nib forCellReuseIdentifier:@"CommentCell"];
            isRegist=YES;
        }
        UITableViewCell *cell_ = [tableView dequeueReusableCellWithIdentifier:identifire];
        cell_.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell_;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}
#pragma mark -
#pragma mark -行为区（Action）
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
