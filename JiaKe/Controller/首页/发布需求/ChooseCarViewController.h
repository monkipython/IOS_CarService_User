//
//  ChooseCarViewController.h
//  JiaKe
//
//  Created by hgs泽泓 on 14/10/20.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NecessaryViewController;
@interface ChooseCarViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) NecessaryViewController *necessary;
@end
