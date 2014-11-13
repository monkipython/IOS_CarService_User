//
//  BNCommonDef.h
//  baiduNaviSDK
//
//  Created by Baidu on 11/12/13.
//  Copyright (c) 2013 baidu. All rights reserved.
//

#ifndef baiduNaviSDK_BNCommonDef_h
#define baiduNaviSDK_BNCommonDef_h


/**
 *  路线规划结果枚举
 */
typedef enum
{
	BNRoutePlanError_LocationFailed           = 100, //获取地理位置失败
	BNRoutePlanError_RoutePlanFailed          = 101, //无法发起算路
    BNRoutePlanError_LocationServiceClosed    = 102, //定位服务未开启
    BNRoutePlanError_NodesTooNear             = 103, //节点之间距离太近
    BNRoutePlanError_NodesInputError          = 104, //节点输入有误
    BNRoutePlanError_WaitAMoment              = 105, //上次算路取消了，需要等一会
}BNRoutePlanError;


/**
 *  路线计算类型
 */
typedef enum
{
	BNRoutePlanMode_Invalid 			= 0X00000000 ,  /**<  无效值 */
	BNRoutePlanMode_Recommend			= 0X00000001 ,	/**<  推荐 */
	BNRoutePlanMode_MinTime 			= 0X00000002 ,	/**<  最短时间 */
	BNRoutePlanMode_MinDist 			= 0X00000004 ,	/**<  最短距离 */
	BNRoutePlanMode_MinToll 			= 0X00000008 ,	/**<  最少收费 */
	BNRoutePlanMode_MaxRoadWidth		= 0X00000010 ,	/**<  最大道宽 */
	BNRoutePlanMode_AvoidTrafficJam     = 0X00000020 	/**<  躲避拥堵 */
}BNRoutePlanMode;

/**
 *  导航类型
 */
typedef enum
{
    BN_NaviTypeReal,      // 真实导航
    BN_NaviTypeSimulator  // 默认模拟导航
} BN_NaviType;

#endif
