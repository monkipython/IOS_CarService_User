//
//  BNUIManagerProtocol.h
//  baiduNaviSDK
//
//  Created by Baidu on 11/10/13.
//  Copyright (c) 2013 baidu. All rights reserved.
//

#ifndef baiduNaviSDK_BNUIManagerProtocol_h
#define baiduNaviSDK_BNUIManagerProtocol_h

#import "BNCommonDef.h"

@protocol BNNaviUIManagerDelegate;

/**
 *  UI管理协议，进入导航入口
 */

@protocol BNUIManagerProtocol

@required

/**
 *  进入导航页面
 *
 *  @param eType           导航类型：真实导航或者模拟导航
 *  @param delegate        Deleagte
 *  @param isNeedLandscape 是否需要横竖屏切换，默认竖屏
 *
 *  @return YES：进入成功，NO：进入失败
 */
- (BOOL)showNaviUI:(BN_NaviType)eType delegete:(id<BNNaviUIManagerDelegate>)delegate isNeedLandscape:(BOOL)isNeedLandscape;

@end


/**
 *  导航UI管理器回调
 */
@protocol BNNaviUIManagerDelegate <NSObject>

@optional

/**
 *  退出导航页面回调
 *
 *  @param extraInfo 退出导航页面相关信息
 */
-(void)onExitNaviUI:(NSDictionary*)extraInfo;


/**
 *  退出免责声明页面的回调
 *
 *  @param extraInfo 提出免责声明页面相关信息
 */
- (void)onExitexitDeclarationUI:(NSDictionary*)extraInfo;


@end

#endif

