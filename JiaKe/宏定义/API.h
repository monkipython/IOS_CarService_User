//
//  API.h
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-9.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#ifndef JiaKe_API_h
#define JiaKe_API_h

#define indexPATH @"http://121.40.92.53/ycbb/index.php/App/"
/**
 *注册
 *@param NSString   username  用户名
 *@param NSString   password  密码md5加密
 *@param NSString   mobile    电话号码
 *@param NSString   email     邮箱     （非必填）
 *@param NSString   code_verify   验证码 
 1
 */
#define REGISTER [NSString stringWithFormat:@"%@Member/register",indexPATH]

/**
 *用户登入
 *@param NSString   mobile  用户名 或 电话号码
 *@param NSString   password  密码md5加密

 2
 *@return NSString member_session_id   会话ID
 *@return NSString member_id           用户ID
 */
#define LOGIN [NSString stringWithFormat:@"%@Member/login",indexPATH]


 /**
 *登出
 *@param NSString member_session_id   会话ID
 3
 */
#define LOGINOUT [NSString stringWithFormat:@"%@Member/loginout",indexPATH]


/**
 *用户详情
 *@param NSString member_session_id    会话ID
 4
 *@return NSString id                  城市ID
 *@return NSString nick_name           用户昵称
 *@return NSString header              头像
 *@return NSString mobile              手机号码
 *@return NSString email               邮箱
 */
#define GET_MEMBER [NSString stringWithFormat:@"%@Member/get_member",indexPATH]

/**
 *用户上传头像
 *@param NSString member_session_id 会话ID
 5
 */

#define UPLOADHEADER [NSString stringWithFormat:@"%@Member/uploadHeader",indexPATH]


/**
 *用户修改
 *
 *@param NSString member_session_id    会话ID
 *@param NSString nick_name            用户昵称
 *@param NSString email                邮箱      （非必填）
 6
 */
#define MOD_MENBER [NSString stringWithFormat:@"%@Member/mod_member",indexPATH]


/**
 *城市列表
 7
 pid = 0 查询所有省份 如福建省为1310
 pid = 1310 查询省份下的城市 如厦门为1326
 pid = 1326 查询对应城市的区域 如思明区 1328
 最后得到的1328 就是区域id (area_id)
 *@return NSArray   list
 *@return NSString  id         城市ID
 *@return NSString  name       城市名称
 *@return NSString  city_pid   区域所属城市ID
 */
#define CITY_LIST [NSString stringWithFormat:@"%@City/city_list",indexPATH]


/**
 *服务项目-栏目列表
 8
 *@return NSArray   list
 *@return NSString  id         项目ID
 *@return NSString  name       项目名称
 */
#define CATEGORY_LIST [NSString stringWithFormat:@"%@Category/category_list",indexPATH]

/**
 *首页服务项目列表
 *@param NSString  classid    栏目ID
 *@param NSString  keywords   关键字   （非必填）
 *@param NSString  latitude   经度
 *@param NSString  longitude  纬度
 *@param NSString  cityid     城市ID
 *@param NSString  cityname   城市名称
 *@param NSString  pagenum    页码，不传默认首页 ，一页20条  （非必要）
 9
 *@return NSArray   list
 *@return NSString  latitude         经度
 *@return NSString  longitude        纬度
 *@return NSString  id               商家ID
 *@return NSString  merchant_name    商家名称
 *@return NSString  pics             商家图片
 *@return NSString  distance         距离
 */
#define INDEX_LIST [NSString stringWithFormat:@"%@Home/index_list",indexPATH]


/**
 *附近商家
 *@param NSString  cat_id    栏目ID
 *@param NSString  latitude   经度
 *@param NSString  longitude  纬度
 *@param NSString  pagenum    页码
 *@param NSString  num        分页个数
 *@param NSString  km         公里数  不穿默认 3(公里)   （非必填）
 10
 *@return NSArray   list
 *@return NSString  latitude         经度
 *@return NSString  longitude        纬度
 *@return NSString  id               商家ID
 *@return NSString  merchant_name    商家名称
 *@return NSString  area_name        区名
 *@return NSArray   service_name     服务父项目名称
 *@return NSString  pics             商家图片
 *@return NSString  distance         距离
 */
#define AROUND_MERCHANT [NSString stringWithFormat:@"%@Home/around_merchant",indexPATH]


/**
 *地图模式
 *@param NSString  classid    栏目ID
 *@param NSString  latitude   经度
 *@param NSString  longitude  纬度
 *@param NSString  pagenum    页码
 *@param NSString  km         公里数  不穿默认 3(公里)   （非必填）
 11
 *@return NSArray   list
 *@return NSString  latitude         经度
 *@return NSString  longitude        纬度
 *@return NSString  id               商家ID
 *@return NSString  merchant_name    商家名称
 */
#define MAP_LIST [NSString stringWithFormat:@"%@Home/map_list",indexPATH]

/**
 *活动列表
 *@param int  pagenum    页码 不传默认第一页
 12
 *@return NSArray   list
 *@return NSString  id               活动ID
 *@return NSString  name             活动名称
 *@return NSString  second_price     秒杀价
 *@return NSString  market_price     市场价
 *@return NSString  merchant_name    商家名称
 *@return NSString  merchant_id      商家ID
 *@return NSString  is_overdue       是否过期 0活动进行中 1活动已过期
 */
#define ACTIVITY_LIST [NSString stringWithFormat:@"%@Activity/activity_list",indexPATH]


/**
 *活动详情
 *@param NSString  id               活动ID
 13
 *@return NSString  id               活动ID
 *@return NSString  name             活动名称
 *@return NSString  second_price     秒杀价
 *@return NSString  market_price     市场价
 *@return NSString  merchant_name    商家名称
 *@return NSString  merchant_id      商家ID
 *@return NSString  detail           详情
 *@return NSString  valid_time       有效日期 2014-09-30到2014-10-04
 *@return NSString  pics             多张图片
 *@return NSString  remain           剩余量
 *@return NSString  remain_days      剩余天数 已开始 为0
 *@return NSString  service_attitude   服务态度星级
 *@return NSString  service_quality    服务质量星级
 *@return NSString  merchant_setting   商家设施星级
 */
#define GET_ACTIVITY [NSString stringWithFormat:@"%@Activity/get_activity",indexPATH]


/**
 *商家详情
 *@param NSString  merchant_id      商家ID
 14
 *@return NSString  merichant_id     商家ID
 *@return NSString  merchant_name    商家名称
 *@return NSString  header           头像
 *@return NSString  contact          联系电话
 *@return NSString  tel              电话
 *@return NSString  address          地址
 *@return NSString  intro            商家简介
 *@return NSString  longitude        经度
 *@return NSString  lattitude        纬度
 *@return NSString  pics             多张图片
 *@return NSString  business_time    营业时间
 *@return NSString  service_attitude   服务态度星级
 *@return NSString  service_quality    服务质量星级
 *@return NSString  merchant_setting   商家设施星级
 */
#define GETMERCHANT [NSString stringWithFormat:@"%@Home/getMerchant",indexPATH]



/**
 *商家详情
 *@param  NSString  merchant_id      商家ID
 *@param  NSString  member_session_id   会话ID
 15
 *@return  NSString  merichant_id     商家ID
 *@return  NSString  merchant_name    商家名称
 *@return  NSString  header           头像
 *@return  NSString  address          地址
 *@return  NSString  intro            商家简介
 *@return  NSString  business_time    营业时间

 */
#define MERCHANT_INFO [NSString stringWithFormat:@"%@Home/merchant_info",indexPATH]


/**
 *商家详情-商家服务项目列表
 *@param NSString  merchant_id      商家ID
 *@param NSString  classid          栏目ID (非必填)
 16
 *@return NSArray   list
 *@return NSString  id               项目ID
 *@return NSString  name             项目名称
 *@return NSString  classid          栏目ID
 *@return NSString  time_out         服务时长
 *@return NSString  price            价格
 */
#define MERCHANT_SERVICE_LIST [NSString stringWithFormat:@"%@Home/merchant_service_list",indexPATH]

/**
 *商家详情-商家服务项目列表
 *@param NSString  merchant_id      商家ID
 *@param NSString  pagenum          页码 (非必填)
 17
 *@return NSString  count            总评价数
 *@return NSArray   list
 *@return NSString  id               评论ID
 *@return NSString  desc             评论内容
 *@return NSString  comment_time     评论时间 2014-09-30
 *@return NSString  header           用户头像
 *@return NSString  member_name      会员名称
 
 
 */
#define COMMENT_LIST [NSString stringWithFormat:@"%@MemberComment/comment_list",indexPATH]


/**
 *评论
 *@param NSString  merchant_id         商家ID
 *@param NSString  mer_session_id      会员会话ID
 *@param NSString  order_no            订单号
 *@param NSString  service_quality     服务质量
 *@param NSString  service_attitude    服务质量
 *@param NSString  merchant_setting    商家设备
 *@param NSString  content             评论内容
 18

 */
#define COMMENT [NSString stringWithFormat:@"%@MemberComment/comment",indexPATH]

/**
 *收藏列表
 *@param NSString  member_session_id      会话ID
 *@param NSString  longitude              经度
 *@param NSString  latitude               纬度
 *@param NSString  pagenum                页码（非必填）
 19
 *@return NSArray   list
 *@return NSString  id                     收藏ID
 *@return NSString  obj_id                 收藏对象ID  如商家ID
 *@return NSString  merchant_name          商家名称
 *@return NSString  header                 用户头像
 *@return NSString  member_name            会员名称
 *@return NSString  longitude              经度
 *@return NSString  latitude               纬度
 *@return NSString  distance               距离
 *@return NSString  area_name              区域名
 *@return NSArray   service_name           服务父项目名称 数组
 */
#define COLLECT_LIST [NSString stringWithFormat:@"%@Member/collect_list",indexPATH]


/**
 *收藏
 *@param NSString  member_session_id      会话ID
 *@param NSString  obj_id                 收藏对象ID
 20
 */
#define COLLECT [NSString stringWithFormat:@"%@Member/collect",indexPATH]


/**
 *取消收藏
 *@param NSString  member_session_id      会话ID
 *@param NSString  id                     收藏ID
 21
 */
#define CANCELCOLLECT [NSString stringWithFormat:@"%@Member/cancelCollect",indexPATH]



/**
 *意见反馈
 *@param NSString  member_session_id      会话ID
 *@param NSString  content                内容
 22
 */
#define FEEDBACK [NSString stringWithFormat:@"%@Member/feedback",indexPATH]

/**
 *预约订单
 *@param NSString member_session_id        会话ID
 *@param merchant_id                       商家ID
 *@param order_time                        预约时间
 *@param cart_model                        车型
 *@param service_ids                       服务项目IDs
 *@param type                              1未完成  2已完成
 
 *@return code                      0为成功
 */

#define ORDER_SUBMIT [NSString stringWithFormat:@"%@MemberOrder/submit_order",indexPATH]
/**
 *发布需求
 *@param NSString  member_session_id      会话ID
 *@param NSString  title                  标题
 *@param NSString  cart_id                车牌
 *@param NSString  area_id                区域ID
 *@param NSString  reach_time             到店时间
 *@param NSString  desc                   备注（选填）
 *@param NSString  range_km               范围（选填）
 *@param NSString  file                   多张图片(选填)
 *
 *@return void
 */
#define NECESSARY [NSString stringWithFormat:@"%@MemberDemand/add_demand",indexPATH]


/**
 用户需求列表
 用户member_id member_session_id
 type=1(2为未报价，1为已报价)
 纬度 latitude=24.0913
 经度 longitude=116.3232
 */
#define NECESSARY_LIST [NSString stringWithFormat:@"%@MemberDemand/demand_list",indexPATH]

/**
 报价详情
 member_session_id  sessionID
 id                 需求ID
 merchant_id        商户ID
 longitude          经度
 latitude           纬度
 */
#define DEMAND_DETAIL [NSString stringWithFormat:@"%@MemberDemand/get_demand",indexPATH]

/**
 确认需求
 member_session_id      用户memberID
 id                     需求ID
 merchant_id            商家ID
 */
#define CONFIRM_NECESSARY [NSString stringWithFormat:@"%@MemberDemand/confirm_demand",indexPATH]
/**
 删除需求
 member_session_id      用户memberID
 demand_id              id
 */
#define DELETE_NECESSARY  [NSString stringWithFormat:@"%@MemberDemand/del_demand",indexPATH]

/**
 1未完成，2完成
 订单列表
 member_session_id      用户memberID
 type                   订单类型
 num                    订单数量
 */

#define ORDER_LIST [NSString stringWithFormat:@"%@MemberOrder/order_list",indexPATH]

/**
 MemberOrder/get_order
 id                 订单号
 member_session_id  用户memberID
 */
#define ORDER_DETAIL [NSString stringWithFormat:@"%@MemberOrder/get_order",indexPATH]
/**
 添加汽车
 cart_model  车型
 member_session_id   id
 
 */
#define ADDCAR  [NSString stringWithFormat:@"%@Cart/addCar",indexPATH]

/**
 member_session_id   id
 获取车辆列表
 */
#define GETCAR_LIST  [NSString stringWithFormat:@"%@Cart/myCar",indexPATH]

/**
 获取车辆详情信息
 */
#define GETCAR_INFO  [NSString stringWithFormat:@"%@Cart/getCar",indexPATH]

/**
 删除车辆信息
 car_id         车辆ID
 */
#define DEL_CAR  [NSString stringWithFormat:@"%@Cart/del_car",indexPATH]

/**
 评论列表
 MemberComment/member_comment_list
 member_session_id          memberId
 */
#define COMMENT_LIST_MEMBER [NSString stringWithFormat:@"%@MemberComment/member_comment_list",indexPATH]
#endif
