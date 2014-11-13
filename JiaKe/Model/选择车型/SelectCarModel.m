//
//  MyCarModel.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "SelectCarModel.h"

@implementation SelectCarModel
#pragma mark -返回汽车品牌
+(NSArray *)CarBrandArray
{
    NSString *str=[[NSBundle mainBundle]pathForResource:@"CarBrand" ofType:@"plist"];
    
    NSArray *array=[NSArray arrayWithContentsOfFile:str];
    
    return array;
   
}
#pragma mark -返回汽车型号
+(NSArray *)CarModelArray
{
    NSString *str=[[NSBundle mainBundle]pathForResource:@"CarModel" ofType:@"plist"];
    
    NSArray *array=[NSArray arrayWithContentsOfFile:str];
    return array;
    
}
#pragma mark -返回汽车款式
+(NSArray *)CarStyleArray
{
    NSString *str=[[NSBundle mainBundle]pathForResource:@"CarStyle" ofType:@"plist"];
    
    NSArray *array=[NSArray arrayWithContentsOfFile:str];
    return array;
    
}
#pragma mark -返回汽车详情
+(NSArray *)CarDetailsArray
{
    
    NSString *str=[[NSBundle mainBundle]pathForResource:@"CarDetails" ofType:@"plist"];
    
    NSArray *array=[NSArray arrayWithContentsOfFile:str];
    return array;
}
@end
