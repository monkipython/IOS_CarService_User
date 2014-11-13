//
//  BDRRViewController.h
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-4.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDRRViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSDictionary *projectList;
@end
