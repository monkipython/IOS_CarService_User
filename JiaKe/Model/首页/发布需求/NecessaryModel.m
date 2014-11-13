//
//  NecessaryModel.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-10-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "NecessaryModel.h"

@implementation NecessaryModel
-(NSArray *)chooseArea
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"CityArray.plist"];
    NSArray *array=[[NSArray alloc]initWithContentsOfFile:filename];
    return array;
}
@end
