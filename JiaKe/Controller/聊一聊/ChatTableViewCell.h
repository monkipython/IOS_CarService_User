//
//  ChatTableViewCell.h
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-4.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
-(void)createCell;
@end
