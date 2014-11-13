//
//  OrderAlreadyViewController.h
//  JiaKe
//
//  Created by hgs泽泓 on 14/11/1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderAlreadyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) NSString *order_id;
@property (strong, nonatomic) NSString *alreadyOrNot;
@end
