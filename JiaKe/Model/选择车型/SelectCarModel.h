//
//  MyCarModel.h
//  JiaKe
//
//  Created by fuzhaorui on 14-9-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectCarModel : NSObject
//返回汽车品牌的数组
+(NSArray *)CarBrandArray;
//返回当前汽车品牌的型号数组
+(NSArray *)CarModelArray;
//返回当前汽车品牌的款式数组
+(NSArray *)CarStyleArray;
//返回当前汽车品牌的基本详情
+(NSArray *)CarDetailsArray;

@end
