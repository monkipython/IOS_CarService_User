//
//  NecessaryViewController.h
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectCarDelegate.h"
#import "ChooseCity.h"
#import "SelectProgramDelegate.h"
#import "SelectProgramViewController.h"

@interface NecessaryViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SelectProgramDelegate,ChooseCity>
@property (strong, nonatomic) NSDictionary *car_dic;
@property (strong, nonatomic) NSDictionary *projectList;
@property (strong, nonatomic) NSDictionary *serviceDic;
@end

#import <UIKit/UIKit.h>
#import "ChooseCity.h"

@interface CityViewController:UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (assign) id<ChooseCity> delegateChoose;

@end


//#impor>
@interface ShowImage : UIViewController

@property (strong, nonatomic) NSMutableArray *imageArray;
@property (assign) NSInteger index;
@end

