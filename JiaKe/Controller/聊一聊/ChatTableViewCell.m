//
//  ChatTableViewCell.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-4.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}
-(void)createCell
{
    self.headImage.clipsToBounds = YES;
    self.headImage.layer.cornerRadius = 30;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
