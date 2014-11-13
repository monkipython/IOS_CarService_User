//
//  ComplaintModel.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "ComplaintModel.h"

@implementation ComplaintModel
+(NSMutableArray *)locationArray{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for (int i=0; i<2; i++)
    {
        for (int j=0; j<3; j++) {
            CGRect rect = CGRectMake(15+j*105, 250+i*90, 80, 80);
            [array addObject:[NSValue valueWithCGRect:rect]];
        }
        
       
    }
    return array;
}
@end
