//
//  SelectCityDelegate.h
//  JiaKe
//
//  Created by fuzhaorui on 14-9-3.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SelectCityDelegate <NSObject>
//委托实现的方法
-(void)selectProvinceName:(NSString *)provinceName
                  andCity:(NSString *)cityName;
@end
