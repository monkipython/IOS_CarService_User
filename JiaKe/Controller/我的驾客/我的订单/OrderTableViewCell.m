//
//  OrderTableViewCell.m
//  JiaKe
//
//  Created by hgs泽泓 on 14/11/1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}
-(void)createOrderCell
{
    //订单号
    UILabel *order_id = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 170, 15)];
    order_id.tag = 500;
    order_id.font = [UIFont systemFontOfSize:13.5f];
    [self.contentView addSubview:order_id];
    //头像
    EGOImageView *headerImage = [[EGOImageView alloc]initWithFrame:CGRectMake(5, 25, 60, 60)];
    headerImage.placeholderImage = [UIImage imageNamed:@"头像"];
    headerImage.tag = 501;
    [self.contentView addSubview:headerImage];
    //添加时间
    UILabel *addtime = [[UILabel alloc]initWithFrame:CGRectMake(180, 5, 150, 15)];
    addtime.tag = 502;
    addtime.font = [UIFont systemFontOfSize:13.5f];
    [self.contentView addSubview:addtime];
    //商户名
    UILabel *merchantName = [[UILabel alloc]initWithFrame:CGRectMake(70, 25, 200, 20)];
    merchantName.tag = 503;
    merchantName.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:merchantName];
    //项目名
    UILabel *projectName = [[UILabel alloc]initWithFrame:CGRectMake(70, 47, 200, 20)];
    projectName.tag = 504;
    projectName.font = [UIFont systemFontOfSize:14.];
    [self.contentView addSubview:projectName];
    //价格
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(70, 70, 100, 15)];
    price.tag = 505;
    [price setFont:[UIFont systemFontOfSize:13.f]];
    [price setTextColor:[UIColor redColor]];
    [self.contentView addSubview:price];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
