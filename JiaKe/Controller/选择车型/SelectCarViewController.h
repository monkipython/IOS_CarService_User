//
//  SelectCarViewController.h
//  JiaKe
//
//  Created by fuzhaorui on 14-9-2.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectCarDelegate.h"

@interface SelectCarViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
//设置委托传值
@property (assign, nonatomic) id<SelectCarDelegate>delegate;
@end
