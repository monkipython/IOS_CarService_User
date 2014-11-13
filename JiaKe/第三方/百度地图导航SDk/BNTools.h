//
//  BNTools.h
//  baiduNaviSDK
//
//  Created by Baidu on 14-3-20.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BNRoutePlanModel.h"

@interface BNTools : NSObject


typedef struct BMapPoint
{
	double	x;		/**< 百度地图sdk x坐标 */
	double	y;		/**< 百度地图sdk y坐标*/
}BMapPoint;


/**
 *  百度地图坐标系的点转换成百度导航坐标系的点
 *
 *  @param mapPoint ,输入参数,百度地图SDK坐标系的点
 *  @param naviPoint,输出参数，百度导航sdk坐标系的点（也就是原始经纬度坐标系,同系统CLLocationManager坐标系）
 *
 *  @return 转换成功则返回YES，否则返回NO
 */
+(BOOL)ConvertBaiduMapPoint:(const BMapPoint*)mapPoint ToBaiduNaviPoint:(BNPosition*)naviPoint;

/**
 *  百度导航坐标系的点转换成百度地图坐标系的点
 *
 *  @param naviPoint ,输入参数,百度导航SDK坐标系的点（也就是原始经纬度坐标系,同系统CLLocationManager坐标系）
 *  @param mapPoint,输出参数，百度地图sdk坐标系的点
 *
 *  @return 播报成功则返回YES，否则返回NO
 */
+(BOOL)ConvertBaiduNaviPoint:(const BNPosition*)naviPoint ToBaiduMapPoint:(BMapPoint*)mapPoint;

@end
