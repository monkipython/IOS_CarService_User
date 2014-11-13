//
//  BNSoundManagerProtocol.h
//  baiduNaviSDK
//
//  Created by Baidu on 11/10/13.
//  Copyright (c) 2013 baidu. All rights reserved.
//

#ifndef baiduNaviSDK_BNSoundManagerProtocol_h
#define baiduNaviSDK_BNSoundManagerProtocol_h

/**
 *  声音管理协议
 */

@protocol BNSoundManagerProtocol

@required


/**
 *  播报文本
 *
 *  @param text 需要播报的文本
 *
 *  @return 播报成功则返回YES，否则返回NO
 */
-(BOOL)playTTSText:(NSString*)text;

/**
 *  停止语音播报
 *
 *  @return 成功停止则返回YES，否则返回NO
 */
-(BOOL)stopTTSPlayer;

/**
 *  tts是否正在播报
 *
 *  @return 正在播报则返回YES，否则返回NO
 */
- (BOOL)isTTSPlaying;

/*
 * 是否正在打电话
 *
 * @return YES/NO
 */
- (BOOL)isCalling;

@optional

@end

#endif
