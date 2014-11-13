//
//  URL.h
//  MyApp
//
//  Created by fuzhaorui on 14-8-13.
//  Copyright (c) 2014年 HongZehong. All rights reserved.
//

#ifndef MyApp_URL_h
#define MyApp_URL_h

#import "UPURL.h"

//返回屏幕大小（CGRect）
#define RECT [UPURL rect]

//设置颜色
#define COLOR(R,G,B,M) [UIColor colorWithRed:R/255 green:G/255 blue:B/255 alpha:M]

//蓝
#define BLUECOLOR      [UIColor colorWithRed:83.0/255 green:198.0/255 blue:243.0/255 alpha:1]

//白
#define WHITECOLOR     [UIColor whiteColor]

//灰
#define GRAYCOLOR [UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1]

//白灰
#define WHITEGRAYCOLOR [UIColor colorWithRed:217./255 green:217./255 blue:217./255 alpha:1]

//浅灰
#define DANGRAYCOLOR [UIColor colorWithRed:170./255 green:170./255 blue:170./255 alpha:1]

//背景图
#define BACKGROUNDIMAGE UIImageView *backgroundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_login"]];backgroundImage.frame = CGRectMake(0, 0, RECT.size.width, RECT.size.height);

//创建视图
#define CREATEVIEW(viewController,viewName,xib4_0,xib3_5)    viewController *viewName=[[viewController alloc]init]; if([[UIScreen mainScreen]bounds].size.height==568){viewName= [[viewController alloc]initWithNibName:xib4_0 bundle:nil];}else if([[UIScreen mainScreen]bounds].size.height==480){viewName= [[viewController alloc]initWithNibName:xib3_5 bundle:nil];}

#endif
