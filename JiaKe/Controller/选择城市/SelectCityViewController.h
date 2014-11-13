//
//  SelectCityViewController.h
//  JiaKe
//
//  Created by fuzhaorui on 14-9-3.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectCityDelegate.h"


@interface SelectCityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
//用于委托传值
@property (assign, nonatomic) id<SelectCityDelegate>delegate;

@end
