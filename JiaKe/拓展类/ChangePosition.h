//
//  ChangePosition.h
//  JiaKeB
//
//  Created by fuzhaorui on 14-9-19.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangePosition : NSObject
//视图移动的方法
+(void)addAnimation:(UIView *)view andDuration:(NSTimeInterval)duration andDelay:(NSTimeInterval)delay andRect:(CGRect)rect;
@end
