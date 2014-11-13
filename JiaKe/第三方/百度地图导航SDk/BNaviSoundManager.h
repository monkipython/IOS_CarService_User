//
//  BNaviSoundManager.h
//  OfflineNavi
//
//  Created by Baidu on 14-2-25.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNSoundManagerProtocol.h"

/**
 *  TTS默认使用对象，开发者如果需要自定义TTS，可以重写该类或自定义一个符合BNSoundManagerProtocol类对象
 */

@interface BNaviSoundManager : NSObject<BNSoundManagerProtocol>

/*
 * 获取单体
 */
+ (id)getInstance;

/*
 * 释放单体
 */
+ (void)releaseInstance;

@end
