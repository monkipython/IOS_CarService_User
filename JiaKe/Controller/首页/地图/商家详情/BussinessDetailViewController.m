//
//  BussinessDetailViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-10-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "BussinessDetailViewController.h"
#import "BusinessInfoViewController.h"
#import "SubscriptionViewController.h"
#import "HGSButton.h"

@interface BussinessDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *subscribe;
@property (strong, nonatomic) NSArray *serviceList;
@property (strong, nonatomic) NSMutableArray *beautyArr;
@property (strong, nonatomic) NSMutableArray *decroArr;
@property (strong, nonatomic) NSMutableArray *repairArr;
@property (strong, nonatomic) NSMutableArray *refitArr;
@property (strong, nonatomic) UIButton *tempButton;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) NSMutableArray *selectProjectList;
@property (strong, nonatomic) NSMutableArray *one;
@property (strong, nonatomic) NSMutableArray *two;
@property (strong, nonatomic) NSMutableArray *three;
@property (strong, nonatomic) NSMutableArray *four;
@property (assign) BOOL isSelect;

@end

@implementation BussinessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"预约";
    [self createView];
}
#pragma mark -
#pragma mark -构造区
-(void)createView
{
    self.beautyArr = [NSMutableArray array];
    self.decroArr = [NSMutableArray array];
    self.repairArr = [NSMutableArray array];
    self.refitArr = [NSMutableArray array];
    self.selectProjectList = [NSMutableArray array];
    self.one = [NSMutableArray array];
    self.two = [NSMutableArray array];
    self.three = [NSMutableArray array];
    self.four = [NSMutableArray array];
    self.subscribe.layer.cornerRadius = 4;
//    NSLog(@"商家信息：%@",self.merchant_info);
//    NSLog(@"列表信息：%@",self.merchant_list);
    NSArray *array = self.merchant_list[@"data"][@"list"];
    self.serviceList = [[NSArray alloc]initWithArray:array];
    for(NSDictionary *info in self.serviceList)
    {
        if([info[@"classid"]intValue]==1)
        {
            [self.beautyArr addObject:info];
            self.serviceList = self.beautyArr;
        }else if([info[@"classid"]intValue]==2)
        {
            [self.decroArr addObject:info];
        }else if([info[@"classid"]intValue]==3)
        {
            [self.repairArr addObject:info];
        }else if([info[@"classid"]intValue]==4)
        {
            [self.refitArr addObject:info];
        }
    }
    for(int i = 0;i<self.beautyArr.count;i++)
    {
        [self.one addObject:@"no"];
    }
    for(int i = 0;i<self.decroArr.count;i++)
    {
        [self.two addObject:@"no"];
    }
    for(int i = 0;i<self.repairArr.count;i++)
    {
        [self.three addObject:@"no"];
    }
    for(int i = 0;i<self.refitArr.count;i++)
    {
        [self.four addObject:@"no"];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return self.serviceList.count;
            break;
        default:
            break;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.serviceList[indexPath.row];
    if(indexPath.section==0)
    {
        static NSString *identifier_ = @"businessDetail";
        BOOL isRegister_ = NO;
        if (!isRegister_){
            UINib *nib=[UINib nibWithNibName:@"BusinessDetailCell" bundle:[NSBundle mainBundle]];
            [tableView registerNib:nib forCellReuseIdentifier:identifier_];
            isRegister_ = YES;
        }
        
        UITableViewCell *cell_ = [tableView dequeueReusableCellWithIdentifier:identifier_];
        EGOImageView *image = (EGOImageView *)[cell_ viewWithTag:3465];
        image.placeholderImage = [UIImage imageNamed:@"人像"];
        [image setImageURL:[NSURL URLWithString:self.merchant_info[@"data"][@"header"]]];
        
        UILabel *name = (UILabel *)[cell_ viewWithTag:3466];
        name.text = self.merchant_info[@"data"][@"merchant_name"];
        
        UITextView *intro = (UITextView *)[cell_ viewWithTag:3467];
        intro.text = self.merchant_info[@"data"][@"intro"];
        return cell_;
    }else if(indexPath.section==1)
    {
        NSString *cellId = @"cellIden";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if(indexPath.row==0)
        {
            cell.textLabel.text = @"车型";
        }else if(indexPath.row==1)
        {
            cell.textLabel.text = @"到店时间";
        }
        return cell;
    }else if(indexPath.section==2)
    {
         NSString *identifier_ = [NSString stringWithFormat:@"ProjectDetail%@%d",dic[@"classid"],(int)indexPath.row];
        BOOL isRegister_ = NO;
        if (!isRegister_){
            UINib *nib=[UINib nibWithNibName:@"ProjectDetail" bundle:[NSBundle mainBundle]];
            [tableView registerNib:nib forCellReuseIdentifier:identifier_];
            isRegister_ = YES;
        }
//        NSDictionary *dic = self.serviceList[indexPath.row];
        UITableViewCell *cell_choose = [tableView dequeueReusableCellWithIdentifier:identifier_];
        HGSButton *check = (HGSButton *)[cell_choose viewWithTag:500];
        check.titleLabel.text = @"wx";
        check.projectId = dic[@"id"];
        //美容类
        check.whichClass = [NSString stringWithFormat:@"%@",dic[@"classid"]];
        //第几个
        check.num = indexPath.row;
        //如果是美容
        if([dic[@"classid"]integerValue]==1)
        {
            NSString *checkOrNot = [self.one objectAtIndex:indexPath.row];
            if([checkOrNot isEqualToString:@"yes"])
            {
                [check setImage:[UIImage imageNamed:@"选中状态"] forState:UIControlStateNormal];
            }
        }else if([dic[@"classid"]integerValue]==2)
        {
            NSString *checkOrNot = [self.two objectAtIndex:indexPath.row];
            if([checkOrNot isEqualToString:@"yes"])
            {
                [check setImage:[UIImage imageNamed:@"选中状态"] forState:UIControlStateNormal];
            }
        }else if([dic[@"classid"]integerValue]==3)
        {
            NSString *checkOrNot = [self.three objectAtIndex:indexPath.row];
            if([checkOrNot isEqualToString:@"yes"])
            {
                [check setImage:[UIImage imageNamed:@"选中状态"] forState:UIControlStateNormal];
            }
        }else if([dic[@"classid"]integerValue]==4)
        {
            NSString *checkOrNot = [self.four objectAtIndex:indexPath.row];
            if([checkOrNot isEqualToString:@"yes"])
            {
                [check setImage:[UIImage imageNamed:@"选中状态"] forState:UIControlStateNormal];
            }
        }
        UILabel *serviceName = (UILabel *)[cell_choose viewWithTag:1777];
        serviceName.text = dic[@"name"];
        UILabel *price = (UILabel *)[cell_choose viewWithTag:1778];
        price = dic[@"price"];
        UILabel *timeOut = (UILabel *)[cell_choose viewWithTag:1779];
        timeOut.text = [NSString stringWithFormat:@"%@分钟",dic[@"timeout"]];
        cell_choose.selectionStyle = UITableViewCellSelectionStyleNone;
        [check addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell_choose;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==2)
    {
        UIButton *mei = (UIButton *)[self.headerView viewWithTag:600];
        self.tempButton = mei;
        [mei addTarget:self action:@selector(beauty:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *zhuang = (UIButton *)[self.headerView viewWithTag:601];
//        self.two = [[NSMutableArray alloc]initWithCapacity:self.serviceList.count];
//        for(int i = 0;i<self.serviceList.count;i++)
//        {
//            [self.two addObject:@"no"];
//        }
        [zhuang addTarget:self action:@selector(decore:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *wei = (UIButton *)[self.headerView viewWithTag:602];
//        self.three = [[NSMutableArray alloc]initWithCapacity:self.serviceList.count];
//        for(int i = 0;i<self.serviceList.count;i++)
//        {
//            [self.three addObject:@"no"];
//        }
        [wei addTarget:self action:@selector(repair:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *gai = (UIButton *)[self.headerView viewWithTag:603];
//        self.four = [[NSMutableArray alloc]initWithCapacity:self.serviceList.count];
//        for(int i = 0;i<self.serviceList.count;i++)
//        {
//            [self.four addObject:@"no"];
//        }
        [gai addTarget:self action:@selector(refit:) forControlEvents:UIControlEventTouchUpInside];

        return self.headerView;
    }
    return nil;
}
-(void)confirmAction:(HGSButton *)sender
{
    NSLog(@"%d",sender.num);
    if([sender.titleLabel.text isEqualToString:@"wx"])
    {
        [sender setImage:[UIImage imageNamed:@"选中状态"] forState:UIControlStateNormal];
        sender.titleLabel.text = @"xz";
        
        if([sender.whichClass isEqualToString:@"1"])
        {
            [self.one replaceObjectAtIndex:sender.num withObject:@"yes"];
        }
        if([sender.whichClass isEqualToString:@"2"])
        {
            [self.two replaceObjectAtIndex:sender.num withObject:@"yes"];
        }
        if([sender.whichClass isEqualToString:@"3"])
        {
            [self.three replaceObjectAtIndex:sender.num withObject:@"yes"];
        }
        if([sender.whichClass isEqualToString:@"4"])
        {
            [self.four replaceObjectAtIndex:sender.num withObject:@"yes"];
        }
    }else if([sender.titleLabel.text isEqualToString:@"xz"])
    {
        sender.titleLabel.text = @"wx";
        [sender setImage:[UIImage imageNamed:@"到店支付btn"] forState:UIControlStateNormal];
        NSLog(@"calcel~~");
        if([sender.whichClass isEqualToString:@"1"])
        {
            [self.one replaceObjectAtIndex:sender.num withObject:@"no"];
        }
        if([sender.whichClass isEqualToString:@"2"])
        {
            [self.two replaceObjectAtIndex:sender.num withObject:@"no"];
        }
        if([sender.whichClass isEqualToString:@"3"])
        {
            [self.three replaceObjectAtIndex:sender.num withObject:@"no"];
        }
        if([sender.whichClass isEqualToString:@"4"])
        {
            [self.four replaceObjectAtIndex:sender.num withObject:@"no"];
        }
    }
        
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 100;
    }else if(indexPath.section==1)
    {
        return 44;
    }else if(indexPath.section==2)
    {
        return 70;
    }else
        return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==2)
    {
        return 44;
    }
    return 5;
}

#pragma mark -
#pragma mark -行为区（Action）
//美容
-(void)beauty:(UIButton *)sender
{
    [self.tempButton setBackgroundColor:DANGRAYCOLOR];
    [sender setBackgroundColor:BLUECOLOR];
    self.serviceList = self.beautyArr;
    NSIndexSet *index = [[NSIndexSet alloc]initWithIndex:2];
    [self.tableView reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];
    self.tempButton = sender;
}
//装饰
-(void)decore:(UIButton *)sender
{
    [self.tempButton setBackgroundColor:DANGRAYCOLOR];
    [sender setBackgroundColor:BLUECOLOR];
    self.serviceList = self.decroArr;
    NSIndexSet *index = [[NSIndexSet alloc]initWithIndex:2];
    [self.tableView reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];
    self.tempButton = sender;
}
//维修
-(void)repair:(UIButton *)sender
{
    [self.tempButton setBackgroundColor:DANGRAYCOLOR];
    [sender setBackgroundColor:BLUECOLOR];
    self.serviceList = self.repairArr;
    NSIndexSet *index = [[NSIndexSet alloc]initWithIndex:2];
    [self.tableView reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];
    self.tempButton = sender;
}
//改装
-(void)refit:(UIButton *)sender
{
    [self.tempButton setBackgroundColor:DANGRAYCOLOR];
    [sender setBackgroundColor:BLUECOLOR];
    self.serviceList = self.refitArr;
    NSIndexSet *index = [[NSIndexSet alloc]initWithIndex:2];
    [self.tableView reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];
    self.tempButton = sender;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        CREATEVIEW(BusinessInfoViewController, infoVC, @"BusinessInfoView4_0", @"BusinessInfoView3_5");
        infoVC.merchantId = self.merchant_info[@"data"][@"merchant_id"];
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}
- (IBAction)submitAction:(UIButton *)sender
{
    CREATEVIEW(SubscriptionViewController, subscriptionVC, @"SubscriptionView4_0", @"SubscriptionView3_5");
    [self.navigationController pushViewController:subscriptionVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
