//
//  BussinessDetailViewController.h
//  JiaKe
//
//  Created by hgs泽泓 on 14-10-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BussinessDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSDictionary *merchant_info;
@property (strong, nonatomic) NSDictionary *merchant_list;
@end
