//
//  BNaviTTSManager.h
//  BNaviTTSManager
//
//  Created by Baidu on 14-2-25.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  TTS播报类
 */

@interface BNaviTTSManager : NSObject

/*
 * 获取单体
 */
+ (BNaviTTSManager*)GetInstance;

/*
 * 释放单体
 */
+ (void)ReleaseInstance;

/*
 * 设置AudioSession属性
 * @param sessionCategory 设置音频属性
 * @note 不设置默认是 AVAudioSessionCategoryPlayback
 */
-(void)SetNaviAudioSession:(NSString*)sessionCategory;

/*
 * 初始化TTS播报模块接口 
 * @note  在使用之前必须初始化，否则无法使用
 */
-(BOOL)InitTTSPlayer;

/*
 * 反初始化TTS播报模块接口
 * @note  释放单例的时候也必须调用本借口，否则会存在内存泄漏
 */
-(BOOL)UnInitTTSPlayer;

/*
 * 播报文本接口
 */
-(BOOL)PlayTTSText:(NSString*)text;

/*
 * 停止语音播报
 */
-(BOOL)StopTTSPlayer;

/*
 * 是否正在播报
 */
- (BOOL)IsTTSPlaying;

/*
 * 是否正在打电话
 */
- (BOOL)IsCalling;

@end
