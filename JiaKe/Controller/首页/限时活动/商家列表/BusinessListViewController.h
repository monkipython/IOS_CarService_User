//
//  BusinessListViewController.h
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-2.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSArray *activityList;
@end
