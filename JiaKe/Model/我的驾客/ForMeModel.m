//
//  ForMeModel.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "ForMeModel.h"

@implementation ForMeModel
+(NSArray *)optionName
{
    NSArray *array = @[@"我的订单",@"我的需求",@"我的收藏",@"我的爱车",@"评价管理"];
    return array;
}
+(NSArray *)optionInamgeName
{
    NSArray *array = @[@"2_03",@"3_03",@"4_03",@"1_03",@"1_03"];
    return array;
}
@end