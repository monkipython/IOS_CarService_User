//
//  DetailsViewController.m
//  MyApp
//
//  Created by hgs泽泓 on 14-8-22.
//  Copyright (c) 2014年 HongZehong. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;
//商户头像
@property (strong, nonatomic) UIImageView *headView;
//商户
@property (strong, nonatomic) UILabel *businessName;
//商户地址
@property (strong, nonatomic) UILabel *businessAdd;
//活动详情
@property (strong, nonatomic) UITextView *details;
//秒杀价
@property (strong, nonatomic) UILabel *miaoshaPair;
//门市价
@property (strong, nonatomic) UILabel *menshiPair;
//活动期限
@property (strong, nonatomic) UILabel *overTime;
//适用车型
@property (strong, nonatomic) UILabel *useCar;
//评价
@property (strong, nonatomic) UIImageView *assessImage1;
@property (strong, nonatomic) UIImageView *assessImage2;
@property (strong, nonatomic) UIImageView *assessImage3;
@property (strong, nonatomic) UIImageView *assessImage4;
@property (strong, nonatomic) UIImageView *assessImage5;
//剩余时间
@property (strong, nonatomic) UILabel *suplusTime;
//定时器
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation DetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"活动详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //创建视图
    [self createView];
}
#pragma mark-创建视图
- (void)createView
{
    self.view.backgroundColor = [UIColor whiteColor];
    //滚动视图
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, RECT.size.width, RECT.size.height)];
    scroll.contentSize = CGSizeMake(RECT.size.width, 700);
    self.scrollView = scroll;
    [self.view addSubview:scroll];
    //商户头像
    self.headView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    self.headView.image = [UIImage imageNamed:@"818147_082105072519_2.jpg"];
    [scroll addSubview:self.headView];
    //商户
    UILabel *business = [[UILabel alloc]initWithFrame:CGRectMake(123, 15, 40, 15)];
    business.text = @"商家:";
    business.textColor = BLUECOLOR;
    [business setFont:[UIFont systemFontOfSize:14.f]];
    [scroll addSubview:business];
    //商户详情
    self.businessName = [[UILabel alloc]initWithFrame:CGRectMake(162, 13, 148, 20)];
    self.businessName.text = self.infomation[@"name"];
    //xxxxx...
    self.businessName.lineBreakMode = NSLineBreakByTruncatingTail;
    [scroll addSubview:self.businessName];
    //商户地址
    UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(123, 48, 40, 15)];
    address.text = @"地址:";
    address.textColor = BLUECOLOR;
    [address setFont:[UIFont systemFontOfSize:14.f]];
    [scroll addSubview:address];
    //商户详细地址
    self.businessAdd = [[UILabel alloc]initWithFrame:CGRectMake(162, 47, 148, 20)];
    self.businessAdd.text = @"福建省厦门市思明区瑞景广场";
    //xxxxx...
    self.businessAdd.lineBreakMode = NSLineBreakByTruncatingTail;
    [scroll addSubview:self.businessAdd];
    //评价
    UILabel *assessLab = [[UILabel alloc]initWithFrame:CGRectMake(123, 83, 40, 15)];
    assessLab.text = @"评价:";
    assessLab.textColor = BLUECOLOR;
    [assessLab setFont:[UIFont systemFontOfSize:14.f]];
    [scroll addSubview:assessLab];
    self.assessImage1 = [self createImage:0];
    [self.scrollView addSubview:self.assessImage1];
    self.assessImage2 = [self createImage:1];
    [self.scrollView addSubview:self.assessImage2];
    self.assessImage3 = [self createImage:2];
    [self.scrollView addSubview:self.assessImage3];
    self.assessImage4 = [self createImage:3];
    [self.scrollView addSubview:self.assessImage4];
    self.assessImage5 = [self createImage:4];
    [self.scrollView addSubview:self.assessImage5];
    //活动内容
    UILabel *eventLab = [[UILabel alloc]initWithFrame:CGRectMake(10, self.businessAdd.frame.origin.y+70, RECT.size.width-20, 30)];
    eventLab.text = @"活动详情";
    [eventLab setFont:[UIFont systemFontOfSize:14.f]];
    eventLab.textColor = [UIColor whiteColor];
    eventLab.layer.cornerRadius = 5.f;
    eventLab.clipsToBounds = YES;
    eventLab.backgroundColor = BLUECOLOR;
    //文字居中
    eventLab.textAlignment = NSTextAlignmentCenter;
    [scroll addSubview:eventLab];
    
    self.details = [[UITextView alloc]initWithFrame:CGRectMake(10, eventLab.frame.origin.y+35, 300, 80)];
    self.details.layer.borderColor = BLUECOLOR.CGColor;
    self.details.layer.borderWidth = 1;
    self.details.layer.cornerRadius = 5;
    [self.details setUserInteractionEnabled:NO];
    self.details.text = @"特价昭瑞，特价昭瑞，特价昭瑞。特价昭瑞。特价昭瑞，特价昭瑞、特价昭瑞；特价昭瑞。特价昭瑞，特价昭瑞，特价昭瑞。特价昭瑞l特价昭瑞，特价昭瑞特价昭瑞特价昭瑞特价昭瑞特价昭瑞特价昭瑞特价昭瑞";
    [scroll addSubview:self.details];
    //秒杀价
    UILabel *miaoShaPrice = [[UILabel alloc]initWithFrame:CGRectMake(40, 530, 60, 16)];
    miaoShaPrice.text = @"秒杀价:";
    miaoShaPrice.textColor = [UIColor redColor];
    [scroll addSubview:miaoShaPrice];
    self.miaoshaPair = [[UILabel alloc]initWithFrame:CGRectMake(100, 530, 90, 18)];
    self.miaoshaPair.text = @"￥100";
    self.miaoshaPair.textColor = [UIColor redColor];
    [self.scrollView addSubview:self.miaoshaPair];
    //门市价
    UILabel *menShiPrice = [[UILabel alloc]initWithFrame:CGRectMake(RECT.size.width/2+20, 530, 60, 16)];
    menShiPrice.text = @"门市价:";
    menShiPrice.textColor = BLUECOLOR;
    [scroll addSubview:menShiPrice];
    self.menshiPair = [[UILabel alloc]initWithFrame:CGRectMake(RECT.size.width/2+80, 530, 90, 18)];
    self.menshiPair.text = @"$100";
    self.menshiPair.textColor = BLUECOLOR;
    [scroll addSubview:self.menshiPair];
    //剩余时间
    UILabel *suplusTime = [self createLabel:CGRectMake(10, 560, 300, 30) andTitle:nil];
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSinceNow:-28800];
    suplusTime.text = [NSString stringWithFormat:@"剩余时间:%@" ,date];
    self.suplusTime = suplusTime;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(lessTime) userInfo:nil repeats:YES];
    [self.timer fire];
    [scroll addSubview:suplusTime];
    //适用车型
    UILabel *carType = [self createLabel:CGRectMake(10, 240, 300, 30) andTitle:@"适用车型"];
    [scroll addSubview:carType];
    self.useCar = [self createLabel:CGRectMake(10, 280, 300, 100) andTitle:nil];
    self.useCar.layer.borderColor = BLUECOLOR.CGColor;
    self.useCar.layer.borderWidth = 1;
    self.useCar.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.useCar];
    //相关图片
    UILabel *aboutPhoto = [self createLabel:CGRectMake(10, 390, 300, 30) andTitle:@"相关图片"];
    [scroll addSubview:aboutPhoto];
    CGFloat widthAndHeight = 90.f;
    //图片1
    UIImageView *imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 430, widthAndHeight, widthAndHeight)];
    imageV1.image = [UIImage imageNamed:@"818147_082105072519_2.jpg"];
    [scroll addSubview:imageV1];
    //图片2
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(115, 430, widthAndHeight, widthAndHeight)];
    imageV2.image = [UIImage imageNamed:@"818147_082105072519_2.jpg"];
    [scroll addSubview:imageV2];
    //图片3
    UIImageView *imageV3 = [[UIImageView alloc]initWithFrame:CGRectMake(215, 430, widthAndHeight, widthAndHeight)];
    imageV3.image = [UIImage imageNamed:@"818147_082105072519_2.jpg"];
    [scroll addSubview:imageV3];
    //立即秒杀
    UIButton *killRight = [UIButton buttonWithType:UIButtonTypeCustom];
    killRight.frame = CGRectMake(110, 610, 100, 30);
    [killRight setImage:[UIImage imageNamed:@"驾客（活动详情）1136_16"] forState:UIControlStateNormal];
    [scroll addSubview:killRight];
    
    CGFloat chang = RECT.size.width/3-20;
    //导航按钮
    UIButton *navBtn = [self createButton:CGRectMake(10, 700-40, chang, 30) andTitle:@"导航"];
    [scroll addSubview:navBtn];
    //电话联系
    UIButton *callBtn = [self createButton:CGRectMake(RECT.size.width/3+10, 660, chang, 30) andTitle:@"电话联系"];
    [scroll addSubview:callBtn];
    //在线联系
    UIButton *onlineBtn = [self createButton:CGRectMake(RECT.size.width/3*2+10, 660, chang, 30) andTitle:@"在线联系"];
    [scroll addSubview:onlineBtn];
}
#pragma mark-创建下方三个按钮
-(UIButton *)createButton:(CGRect)rect andTitle:(NSString *)string
{
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    newBtn.frame = *(&rect);
    [newBtn setTitle:string forState:UIControlStateNormal];
    newBtn.backgroundColor = BLUECOLOR;
    newBtn.tintColor = [UIColor whiteColor];
    newBtn.layer.cornerRadius = 7;
    return newBtn;
}
#pragma mark-创建标签
-(UILabel *)createLabel:(CGRect)rect andTitle:(NSString *)string
{
    UILabel *newLabel = [[UILabel alloc]initWithFrame:*(&rect)];
    newLabel.text = string;
    newLabel.textAlignment = NSTextAlignmentCenter;
    newLabel.clipsToBounds = YES;
    newLabel.backgroundColor = BLUECOLOR;
    newLabel.textColor = [UIColor whiteColor];
    [newLabel setFont:[UIFont systemFontOfSize:16.f]];
    newLabel.layer.cornerRadius = 5;
    return newLabel;
}
#pragma mark-剩余时间
-(void)lessTime
{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSinceNow:28800];
    _suplusTime.text = [NSString stringWithFormat:@"剩余时间:%@" ,date];
}
#pragma mark-创建图片
-(UIImageView *)createImage:(int)fram
{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(163+fram*25, 80, 20, 20)];
    imageV.image = [UIImage imageNamed:@"驾客（用户评价）1136_06"];
    return imageV;
}
#pragma mark-视图将要消失
-(void)viewWillDisappear:(BOOL)animated
{
    //关闭定时器
    [self.timer invalidate];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
