//
//  ConfirmViewController.h
//  JiaKe
//
//  Created by hgs泽泓 on 14-10-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmViewController : UIViewController<UIAlertViewDelegate>
@property (strong, nonatomic) NSString *projectString;
@property (strong, nonatomic) NSDictionary *projectDic;
//@property (strong, nonatomic) NSString *carTypeString;
@property (strong, nonatomic) NSDictionary *carTypeDic;
//@property (strong, nonatomic) NSString *areaString;
@property (strong, nonatomic) NSDictionary *areaDic;
@property (strong, nonatomic) NSString *arriveString;
@property (strong, nonatomic) NSString *detailString;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSArray *imageFullPath;
@property (strong, nonatomic) NSArray *imageNames;
@end
