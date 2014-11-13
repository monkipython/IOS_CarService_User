//
//  NetWorking.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-10-13.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "NetWorking.h"

@implementation NetWorking

+(NSDictionary *)send:(NSString *)url postBody:(NSData *)postData
{
    NSURL *urlStr = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlStr cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    NSError *err = nil;
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if(err)
    {
        NSLog(@"%@",err);
    }else
    {
        NSLog(@"%@",response);
        err = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&err];
        if(err)
        {
            NSLog(@"%@",err);
        }else
            return dic;
        
    }
    NSDictionary *dic = [[NSDictionary alloc]initWithObjects:@[@"1010"] forKeys:@[@"code"]];
    return dic;
}

@end
