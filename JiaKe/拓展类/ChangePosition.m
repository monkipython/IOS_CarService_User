//
//  ChangePosition.m
//  JiaKeB
//
//  Created by fuzhaorui on 14-9-19.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "ChangePosition.h"

@implementation ChangePosition
#pragma mark -添加移动动画  
+(void)addAnimation:(UIView *)view andDuration:(NSTimeInterval)duration andDelay:(NSTimeInterval)delay andRect:(CGRect)rect
{
    //创建动画
    [UIView beginAnimations:nil context:nil];
    //动画时间
    [UIView setAnimationDuration:duration];
    //延迟时间
    [UIView setAnimationDelay:delay];
    //移动后的位置
    view.frame = *(&rect);
    //开始动画
    [UIView commitAnimations];
}
@end
