//
//  SelectProgramDelegate.h
//  JiaKe
//
//  Created by fuzhaorui on 14-9-17.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SelectProgramDelegate <NSObject>

//委托实现的方法
-(void)SelectCategoryName:(NSString *)categoryName
           andProgramNane:(NSString *)programName
                andSub_id:(NSString *)sub_id
               andClassid:(NSString *)classid;
@end
