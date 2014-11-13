//
//  HeadViewController.h
//  JiaKe
//
//  Created by fuzhaorui on 14-9-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeStasus.h"

@interface HeadViewController : UIViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ChangeStasus>
//@property (strong, nonatomic) NSString *nick_name;
//@property (strong, nonatomic) NSString *mobile;
@property (strong, nonatomic) NSDictionary *infomation;
@end
