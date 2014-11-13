//
//  CityTableViewCell.m
//  MyApp
//
//  Created by hgs泽泓 on 14-8-29.
//  Copyright (c) 2014年 HongZehong. All rights reserved.
//

#import "CityTableViewCell.h"
#import "NecessaryModel.h"

@interface CityTableViewCell()
//商家头像
@property (strong, nonatomic) EGOImageView *headImage;
//商家名称
@property (strong, nonatomic) UILabel *bussinessName;
//商家距离
@property (strong, nonatomic) UILabel *distance;
//详细活动内容
@property (strong, nonatomic) UILabel *details;
@property (strong, nonatomic) UILabel *markPrice;
@property (strong, nonatomic) UILabel *nowPrice;
@property (strong, nonatomic) UILabel *remain;
@property (strong, nonatomic) UILabel *isstar;
//+++++++++++++++++++++++++++++++++++++++//
@property (strong, nonatomic) UILabel *serviceName;
@end
@implementation CityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}
-(void)createCell:(NSDictionary *)info
{
    NSString *imagePath = info[@"header"];
    self.headImage = [[EGOImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 60)];
    self.headImage.imageURL = [[NSURL alloc]initWithString:imagePath];
    [self.contentView addSubview:self.headImage];
    //商家名称
    self.bussinessName = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 245, 20)];
    self.bussinessName.text = info[@"merchant_name"];
    self.bussinessName.font = [UIFont systemFontOfSize:14.f];
    self.bussinessName.textColor =BLUECOLOR;
    [self.contentView addSubview:self.bussinessName];
    //活动是否开始
    self.isstar = [[UILabel alloc]initWithFrame:CGRectMake(245, 5, 70, 15)];
    self.isstar.font = [UIFont systemFontOfSize:13.5f];
    if([info[@"is_start"]integerValue])
    {
        self.isstar.text = @"活动已开始";
        self.isstar.textColor = [UIColor greenColor];
    }else
    {
        self.isstar.text = @"活动未开始";
        self.isstar.textColor = [UIColor redColor];
    }
    [self.contentView addSubview:self.isstar];
    //活动详情
    self.details = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, 245, 10)];
    self.details.text = info[@"name"];
    self.details.lineBreakMode = 0;
    self.details.numberOfLines = 5;
    self.details.textColor = [UIColor grayColor];
    self.details.font = [UIFont systemFontOfSize:13.f];
    self.details.textAlignment = NSTextAlignmentJustified;
    [self.contentView addSubview:self.details];
    
    self.markPrice = [[UILabel alloc]initWithFrame:CGRectMake(70, 50, 80, 10)];
    self.markPrice.text = [NSString stringWithFormat:@"原价:%@", info[@"market_price"]];
    self.markPrice.textColor = [UIColor redColor];
    self.markPrice.font = [UIFont systemFontOfSize:13.f];
    [self.contentView addSubview:self.markPrice];
    
    self.nowPrice = [[UILabel alloc]initWithFrame:CGRectMake(170, 50, 80, 10)];
    self.nowPrice.font = [UIFont systemFontOfSize:13.f];
    self.nowPrice.text = [NSString stringWithFormat:@"现价:%@", info[@"second_price"]];
    [self.contentView addSubview:self.nowPrice];
    
    self.remain = [[UILabel alloc]initWithFrame:CGRectMake(260, 50, 70, 10)];
    self.remain.font = [UIFont systemFontOfSize:13.f];
    self.remain.text = [NSString stringWithFormat:@"剩余:%d",[info[@"second_price"]intValue]];
    [self.contentView addSubview:self.remain];
}
- (void)createNearby:(NSDictionary *)info
{
    NSString *imagePath = info[@"header"];
    self.headImage = [[EGOImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 60)];
    self.headImage.imageURL = [[NSURL alloc]initWithString:imagePath];
    [self.contentView addSubview:self.headImage];
    
    //商家名称
    self.bussinessName = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 245, 20)];
    self.bussinessName.text = info[@"merchant_name"];
    self.bussinessName.font = [UIFont systemFontOfSize:14.f];
    self.bussinessName.textColor =BLUECOLOR;
    [self.contentView addSubview:self.bussinessName];
    
    //服务项目
    self.serviceName  = [[UILabel alloc]initWithFrame:CGRectMake(70, 50, 245, 20)];
    self.serviceName.text = [NSString stringWithFormat:@"%@",info[@"service_name"]];
    self.serviceName.font = [UIFont systemFontOfSize:13.5f];
    [self.contentView addSubview:self.serviceName];
    
    //区域
    UILabel *area = [[UILabel alloc]initWithFrame:CGRectMake(70, 25, 80, 15)];
    area.font = [UIFont systemFontOfSize:12.f];
    NSArray *array = [[NecessaryModel alloc]chooseArea];
    for(int i = 0;i<array.count;i++)
    {
        NSDictionary *dic = array[i];
        if([dic[@"id"] isEqualToString:info[@"area_id"]])
        {
            area.text = dic[@"name"];
        }
    }
    [self.contentView addSubview:area];
    
    //距离
    UILabel *distance = [[UILabel alloc]initWithFrame:CGRectMake(220, 25, 80, 15)];
    distance.text = [NSString stringWithFormat:@"%@m",info[@"distance"]];
    distance.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:distance];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
