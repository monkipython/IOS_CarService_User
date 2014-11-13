//
//  SelectProgramViewController.h
//  JiaKe
//
//  Created by fuzhaorui on 14-9-17.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectProgramDelegate.h"


@interface SelectProgramViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
//用于委托传值
@property (assign, nonatomic) id<SelectProgramDelegate>delegate;
@property(assign,nonatomic)BOOL isMultiselect;
//存放项目子类id
@property (strong,nonatomic)NSString *sub_id;
@end
