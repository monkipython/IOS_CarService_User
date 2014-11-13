
/**
 * @header BNCoreServices.h
 * @abstract baiduNaviSDK
 * @author - Copyright (c) 2013 baidu. All rights reserved.
 * @version
 */

#ifndef baiduNaviSDK_BNCoreServices_h
#define baiduNaviSDK_BNCoreServices_h

#import <Foundation/Foundation.h>

#import "BNSoundManagerProtocol.h"
#import "BNUIManagerProtocol.h"
#import "BNRoutePlanManagerProtocol.h"


#define BNCoreServices_Instance ([BNCoreServices GetInstance])
#define BNCoreServices_Sound ([BNCoreServices SoundService])

#define BNCoreServices_UI ([BNCoreServices UIService])
#define BNCoreServices_RoutePlan ([BNCoreServices RoutePlanService])



/**
 *  核心服务类
 */
@interface BNCoreServices : NSObject

/**
 *  获取单体
 *
 *  @return BNCoreService单体
 */
+ (BNCoreServices*)GetInstance;

/**
 *  释放单体
 */
+ (void)ReleaseInstance;



/**
 *  初始化服务，需要在AppDelegate的 application:didFinishLaunchingWithOptions: 
 *  中调用
 *
 *  @param ak AppKey
 */
- (void)initServices:(NSString *)ak;


/**
 *  启动服务,同步方法,会导致阻塞
 *  @param SoundDelete  ［in］传入遵守BNSoundManagerProtocol的实例
 *  @return  启动结果
 */
- (BOOL)startServices:(id<BNSoundManagerProtocol>)SoundDelete;;

/**
 *  启动服务,异步方法
 *
 *  @param success       启动成功后回调 success block
 *  @param fail          启动失败后回调 fail block
 *  @param SoundDelegate 所使用的TTS Delegate，默认使用BNaviSoundManager
 */
-(void)startServicesAsyn:(void (^)(void))success  fail:(void (^)(void))fail SoundService:(id<BNSoundManagerProtocol>)SoundDelegate;


/**
 *  查询引擎是否初始化完成
 *
 *  @return 是否初始化完成
 */
-(BOOL)isServicesInited;

/**
 *  停止所有服务
 */
- (void)stopServices;

/**
 *  获取声音管理器，用于语音播放(默认实现为TTS)
 *
 *  @return 语音服务
 */
+ (id<BNSoundManagerProtocol>)SoundService;

/**
 *  获取到导航过程页管理器，用于进入退出导航过程页
 *
 *  @return 导航过程页管理器
 */
+ (id<BNUIManagerProtocol>)UIService;

/**
 *  获取路径规划管理器，用于路径规划
 *
 *  @return 路径规划管理器
 */
+ (id<BNRoutePlanManagerProtocol>)RoutePlanService;

@end

#endif