//
//  BNaviSoundManager.m
//  OfflineNavi
//
//  Created by Baidu on 14-2-25.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import "BNaviSoundManager.h"
#import "BNaviTTSManager.h"

static BNaviSoundManager* SoundManager = nil;

@interface BNaviSoundManager()

@property(nonatomic , retain)BNaviTTSManager *TTSManager;

@end

@implementation BNaviSoundManager

+ (id)getInstance
{
    if (SoundManager == nil)
    {
        SoundManager = [[BNaviSoundManager alloc] init];
    }
    return SoundManager;
}

+ (void)releaseInstance
{
#if !__has_feature(objc_arc)
     [SoundManager release];
#endif
    SoundManager = nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        _TTSManager = [BNaviTTSManager GetInstance];
        [_TTSManager InitTTSPlayer];
    }
    return self;
}

- (void)dealloc
{
    [_TTSManager UnInitTTSPlayer];
    [BNaviTTSManager ReleaseInstance];
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

/**
 *  播报文本
 *
 *  @param text 需要播报的文本
 *
 *  @return 播报成功则返回YES，否则返回NO
 */
-(BOOL)playTTSText:(NSString*)text
{
    BOOL ret = NO;
    if (text && text.length > 0) {
        ret = [_TTSManager PlayTTSText:text];
    }
    return ret;
}

/**
 *  停止语音播报
 *
 *  @return 成功停止则返回YES，否则返回NO
 */
-(BOOL)stopTTSPlayer
{
    return [_TTSManager StopTTSPlayer];
}

/**
 *  tts是否正在播报
 *
 *  @return 正在播报则返回YES，否则返回NO
 */
- (BOOL)isTTSPlaying
{
    return [_TTSManager IsTTSPlaying];
}

/*
 * 是否正在打电话
 */
- (BOOL)isCalling
{
    return [_TTSManager IsCalling];
}
@end
