//
//  ContactModel.h
//  JiaKe
//
//  Created by fuzhaorui on 14-9-6.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject
//获取公司名称
+(NSString *)corporationName;
//获取电话号码
+(NSString *)call;
//获取QQ号码
+(NSString *)QQ;
//获取邮箱
+(NSString *)email;
//获取网址
+(NSString *)URL;
//获取地址
+(NSString *)address;
//获取合作协商邮箱
+(NSString *)cooperationEmail;
@end
