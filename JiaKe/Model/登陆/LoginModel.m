//
//  LoginModel.m
//  JiaKe
//
//  Created by hgs泽泓 on 14/11/10.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
+(void)loadProjectInfo
{
    NSDictionary *dic = [NetWorking send:CATEGORY_LIST postBody:nil];
    NSArray *array =dic[@"data"][@"list"];
    NSMutableArray *arr1 =  [[NSMutableArray alloc]init];
    NSMutableArray *arr2 =  [[NSMutableArray alloc]init];
    NSMutableArray *arr3 =  [[NSMutableArray alloc]init];
    NSMutableArray *arr4 =  [[NSMutableArray alloc]init];
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = dic=array[i];
        if ([@"1" isEqualToString:dic[@"pid"]]) {
            [arr1 addObject:dic];
        }
        if ([@"2" isEqualToString:dic[@"pid"]]) {
            [arr2 addObject:dic];
        }
        if ([@"3" isEqualToString:dic[@"pid"]]) {
            [arr3 addObject:dic];
        }
        if ([@"4" isEqualToString:dic[@"pid"]]) {
            [arr4 addObject:dic];
        }
        
    }
    NSDictionary *dic1 =[[NSDictionary alloc]initWithObjectsAndKeys:@"美容",@"Category",arr1,@"Program",@"1",@"id",nil];
    NSDictionary *dic2 =[[NSDictionary alloc]initWithObjectsAndKeys:@"装饰",@"Category",arr2,@"Program",@"2",@"id",nil];
    NSDictionary *dic3 =[[NSDictionary alloc]initWithObjectsAndKeys:@"维修",@"Category",arr3,@"Program",@"3",@"id",nil];
    NSDictionary *dic4 =[[NSDictionary alloc]initWithObjectsAndKeys:@"改装",@"Category",arr4,@"Program",@"4",@"id",nil];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    [arr addObject:dic1];
    [arr addObject:dic2];
    [arr addObject:dic3];
    [arr addObject:dic4];
    //注册沙盒目录
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path = [paths objectAtIndex:0];
    
    //获取沙盒路径
    NSString *filename=[path stringByAppendingPathComponent:@"Program.plist"];
    
    //将数据存储到沙盒中
    [arr writeToFile:filename atomically:YES];
}
@end
