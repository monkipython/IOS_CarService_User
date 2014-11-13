//
//  SelectCityModel.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-3.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "SelectCityModel.h"

@implementation SelectCityModel
+(NSArray *)provinceArray
{
    NSString *str=[[NSBundle mainBundle]pathForResource:@"ProvincesAndCities" ofType:@"plist"];
     NSArray *array=[NSArray arrayWithContentsOfFile:str];
    return array;
}
@end
