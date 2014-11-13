//
//  ModifyNameViewController.h
//  JiaKe
//
//  Created by fuzhaorui on 14-9-29.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeStasus.h"

@interface ModifyNameViewController : UIViewController
//@property(strong,nonatomic)NSString *name;
//@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSDictionary *infomation;
@property (assign) id<ChangeStasus> delegate;
@end
