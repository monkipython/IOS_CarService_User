//
//  CityTableViewCell.h
//  MyApp
//
//  Created by hgs泽泓 on 14-8-29.
//  Copyright (c) 2014年 HongZehong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityTableViewCell : UITableViewCell

//创建单元格
-(void)createCell:(NSDictionary *)info;
- (void)createNearby:(NSDictionary *)info;
@end
