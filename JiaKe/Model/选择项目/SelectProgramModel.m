//
//  SelectProgramModel.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-17.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "SelectProgramModel.h"

@implementation SelectProgramModel
+(NSArray *)programArray
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    
    NSString *path = [paths objectAtIndex:0];
    
    
    NSString *filename=[path stringByAppendingPathComponent:@"Program.plist"];
    
    NSArray *array=[[NSArray alloc]initWithContentsOfFile:filename];
    
    return array;
}
@end
