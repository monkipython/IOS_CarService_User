//
//  BussinessListModel.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-2.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "BussinessListModel.h"

@implementation BussinessListModel
+(NSArray *)returnInfomation:(NSString *)urlPath
{
    NSString *pathString = [[NSBundle mainBundle]pathForResource:@"business" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:pathString];
    NSError *err = nil;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    if(err)
    {
        NSLog(@"%@",err);
    }else
    {
        return arr;
    }
    return arr;
}
@end
