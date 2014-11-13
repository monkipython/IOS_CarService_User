//
//  NearbyModel.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-2.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "NearbyModel.h"

@implementation NearbyModel
+(NSArray *)returnInfomation:(NSInteger)num
{
    if(num>0&&num<5)
    {
        NSString *postString = [NSString stringWithFormat:@"latitude=24.0913&longitude=116.3232&cat_id=%d&num=15",num];
        NSData *postData = [postString dataUsingEncoding:4];
        NSDictionary *dic = [NetWorking send:AROUND_MERCHANT postBody:postData];
        NSLog(@"%@",dic);
        NSArray *arr;
        if([dic[@"code"]integerValue]==0)
        {
            arr = [[NSArray alloc]initWithArray:dic[@"data"][@"list"]];
        }
        return arr;
    }else
    {
        NSString *postString = [NSString stringWithFormat:@"latitude=24.0913&longitude=116.3232"];
        NSData *postData = [postString dataUsingEncoding:4];
        NSDictionary *dic = [NetWorking send:AROUND_MERCHANT postBody:postData];
        NSLog(@"%@",dic);
        NSArray *arr;
        if([dic[@"code"]integerValue]==0)
        {
            arr = [[NSArray alloc]initWithArray:dic[@"data"][@"list"]];
        }
        return arr;
    }
    return nil;
}

@end
