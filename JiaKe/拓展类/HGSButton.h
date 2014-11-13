//
//  HGSButton.h
//  JiaKe
//
//  Created by hgs泽泓 on 14/11/10.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 用来传值使用。cell的使用！
 */
@interface HGSButton : UIButton
@property (copy, nonatomic) NSString *projectId;
@property (copy, nonatomic) NSString *whichClass;
@property (assign) int num;
@end
