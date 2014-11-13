//
//  OrdersDetailsViewController.h
//  JiaKeB
//
//  Created by fuzhaorui on 14-9-23.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdersDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
//是否完成订单
@property(assign,nonatomic)BOOL iscompleted;
//是否为订单信息
@property(assign,nonatomic)BOOL isOrders;
@property (strong,nonatomic)NSDictionary *projectInfo;
@property (strong, nonatomic) NSString *necessaryID;
@property (strong, nonatomic) NSString *merchantID;
@end
