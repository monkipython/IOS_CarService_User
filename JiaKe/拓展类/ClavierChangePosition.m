//
//  ClavierChangePosition.m
//  JiaKeB
//
//  Created by fuzhaorui on 14-9-20.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "ClavierChangePosition.h"
#import "ChangePosition.h"
@implementation ClavierChangePosition


+(void)addAnimation:(UIView *)view andImportRect:(CGRect)rect
{
    
    CGFloat position =(RECT.size.height-(rect.origin.y+rect.size.height))-250;
    double time =(position/250.0)*0.3;
    if (position<0) {
        [ChangePosition addAnimation:view andDuration:time andDelay:0 andRect:CGRectMake(0, position-15, RECT.size.width, RECT.size.height)];
    }
    else
    {
        [ChangePosition addAnimation:view andDuration:time andDelay:0 andRect:CGRectMake(0, 0, RECT.size.width, RECT.size.height)];
    }
}
@end
