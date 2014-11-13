//
//  EvaluateTableViewCell.h
//  JiaKe
//
//  Created by hgs泽泓 on 14/11/13.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluateTableViewCell : UITableViewCell
/**
 创建商户单元格
 */
-(void)createMerchantCell:(NSDictionary *)info;
/**
 创建用户单元格
 */
-(void)createMemberCell:(NSDictionary *)info;
@end
