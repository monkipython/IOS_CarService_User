//
//  MapViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-3.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "MapViewController.h"
#import "BussinessDetailViewController.h"
#import "HGSPointAnntation.h"
#import "HGSPaopaoView.h"

@interface MapViewController ()
{
    BMKAnnotationView* newAnnotation;
}
//地图视图
@property (strong, nonatomic) BMKMapView *mapView;
//定点服务
@property (strong, nonatomic)BMKLocationService *locService;
//坐标
@property (assign)BMKCoordinateRegion region;
@property (assign) int i ;
@property (strong, nonatomic) NSArray *pointList;
@property (strong, nonatomic) BMKPointAnnotation *myLocation;
@property (assign) NSInteger isSelf;
@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.modalPresentationStyle = 2;
        
    }
    return self;
}

- (void)viewDidLoad
{
    //super方法
    [super viewDidLoad];
    //定位服务
    [self openLocationService];
    [self createMapView];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    NSString *postString = [NSString stringWithFormat:@"latitude=118.164252&longitude=24.486815"];
    NSData *postData = [postString dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:MAP_LIST postBody:postData];
    self.pointList = [[NSArray alloc]initWithArray:dic[@"data"][@"list"]];
    NSLog(@"%@",self.pointList);
    [self addcoordinate];
}
#pragma mark- 定位服务
-(void)openLocationService
{
    //初始化定位服务
    self.locService = [[BMKLocationService alloc]init];
    //定位服务代理
    self.locService.delegate = self;
    //开启定位服务
    [self.locService startUserLocationService];
}

//更新位置信息（方向）
-(void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"方向改变");
}
//更新位置信息（坐标）
-(void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"%f",userLocation.location.coordinate.latitude);
//    NSLog(@"%f",userLocation.location.coordinate.longitude);
    [self.mapView removeAnnotation:self.myLocation];
    _mapView.showsUserLocation = YES;
    BMKCoordinateRegion region;
    region.center.latitude = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    
    //获取实时位置
    self.region = region;
    //用于判断是否是自己的位置
    self.isSelf=2;
    //添加定位标记
    self.myLocation = [[BMKPointAnnotation alloc]init];
    self.myLocation.coordinate = region.center;
    self.myLocation.title = @"我的位子~";
    [_mapView addAnnotation:self.myLocation];
}
-(void)addcoordinate
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    for (int i=0; i<self.pointList.count; i++) {
        NSDictionary *dic=self.pointList[i];
        HGSPointAnntation *annotation = [[HGSPointAnntation alloc]init];
        annotation.pointInfo = dic;
        CLLocationCoordinate2D coor;
        double abc = [dic[@"latitude"] doubleValue];
        NSLog(@"%f",abc);
        coor.latitude=[dic[@"latitude"] doubleValue];
        coor.longitude=[dic[@"longitude"] doubleValue];
        annotation.coordinate=coor;
    
        [_mapView addAnnotation:annotation];
        if (i==0&&self.pointList!=nil) {
            _mapView.centerCoordinate = annotation.coordinate;
            
        }
    }
}
#pragma mark -设置每个点的颜色
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    
    //初始化annotation
    newAnnotation = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    if(self.isSelf==1)
    {
        // 从天上掉下效果
        ((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;
        HGSPointAnntation *point = (HGSPointAnntation *)annotation;
        NSDictionary *info = [[NSDictionary alloc]initWithDictionary: point.pointInfo];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 155)];
        view.alpha = .8;
        view.layer.cornerRadius = 5;
        view.layer.borderWidth = 1;
        view.backgroundColor = [UIColor colorWithRed:246./255 green:248./255 blue:249./255 alpha:1.];
    
        UILabel *phoneNum = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 240, 25)];
        phoneNum.backgroundColor = [UIColor grayColor];
        [phoneNum setTextColor:[UIColor whiteColor]];
        NSString *str = [NSString stringWithFormat:@" 商户手机:%@", info[@"mobile"]];
        phoneNum.text = str;
        
        //商家地址
        UITextView *merchantAdd = [[UITextView alloc]initWithFrame:CGRectMake(5, 5+25, 240, 50)];
        merchantAdd.userInteractionEnabled = NO;
        merchantAdd.font = [UIFont systemFontOfSize:16.f];
        merchantAdd.backgroundColor = [UIColor grayColor];
        [merchantAdd setTextColor:[UIColor whiteColor]];
        merchantAdd.text = [NSString stringWithFormat:@"详细地址:%@", info[@"address"]];
        
        //店名
        UITextView *merchantName = [[UITextView alloc]initWithFrame:CGRectMake(5, 55+25, 240, 50)];
        merchantName.userInteractionEnabled = NO;
        merchantName.font = [UIFont systemFontOfSize:16.f];
        [merchantName setTextColor:[UIColor whiteColor]];
        merchantName.backgroundColor = [UIColor grayColor];
        merchantName.text = [NSString stringWithFormat:@"店名:%@", info[@"merchant_name"]];
    
        NSInteger merchantId = [info[@"id"]integerValue];
        UIButton * scheduledBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        scheduledBtn.frame = CGRectMake(100, 130, 50, 20);
        scheduledBtn.tag = merchantId;
        [scheduledBtn setTitle:@"预约" forState:UIControlStateNormal];
        [scheduledBtn addTarget:self action:@selector(scheduledAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:scheduledBtn];
        [view addSubview:merchantAdd];
        [view addSubview:phoneNum];
        [view addSubview:merchantName];
        
        HGSPaopaoView *pao = [[HGSPaopaoView alloc]initWithCustomView:view];
        pao.paopaoInfo = [[NSDictionary alloc]initWithDictionary:info];
        newAnnotation.paopaoView = pao;
    
        return newAnnotation;
    }else
    {
        self.isSelf = 1;
        return newAnnotation;
    }
    return nil;
    
}
//点击泡泡
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
}
#pragma mark - 创建地图视图
-(void)createMapView
{
    //标题
    self.title = @"地图";
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化地图视图
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, RECT.size.width, RECT.size.height-64)];
    [self.mapView setMapType:BMKMapTypeStandard];
    //添加代理
//    [self.mapView setShowsUserLocation:YES];
    self.mapView.delegate = self;
    //添加到视图中
    [self.view addSubview:self.mapView];
    //美容按钮
    UIButton *beautyBtn = [self createButton:CGRectMake(RECT.size.width-50, RECT.size.height/16*2.3, 38, 38) andImageName:@"美容@2x"];
    [beautyBtn addTarget:self action:@selector(beautyAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beautyBtn];
    //装饰按钮
    UIButton *decorateBtn = [self createButton:CGRectMake(RECT.size.width-50, RECT.size.height/16*3.8, 38, 38) andImageName:@"装饰@2x"];
    [decorateBtn addTarget:self action:@selector(decorateAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:decorateBtn];
    //维修按钮
    UIButton *repairBtn = [self createButton:CGRectMake(RECT.size.width-50, RECT.size.height/16*5.3, 38, 38) andImageName:@"维修@2x"];
    [repairBtn addTarget:self action:@selector(repairAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:repairBtn];
    //改装按钮
    UIButton *refitBtn = [self createButton:CGRectMake(RECT.size.width-50, RECT.size.height/16*6.8, 38, 38) andImageName:@"改装@2x"];
    [refitBtn addTarget:self action:@selector(refitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refitBtn];
    //定位按钮
    UIButton *locationBtn = [self createButton:CGRectMake(RECT.size.width/3, RECT.size.height-40, RECT.size.width/3, 40) andImageName:@"定位@2x"];
    locationBtn.layer.cornerRadius = 0;
    [locationBtn addTarget:self action:@selector(bussinessDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationBtn];
}
-(void)scheduledAction:(UIButton *)sender
{
    CREATEVIEW(BussinessDetailViewController, businessVC, @"BussinessDetail4_0", @"BussinessDetail3_5");

    NSString *postString = [NSString stringWithFormat:@"merchant_id=%d",sender.tag];
    NSData *postData = [postString dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:MERCHANT_SERVICE_LIST postBody:postData];
    if([dic[@"code"]integerValue]!=0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该商家无服务项目" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else
    {
        NSString *memberId = [[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"];
        NSString *merchant_info = [NSString stringWithFormat:@"merchant_id=%d&member_session_id=%@",sender.tag,memberId];
        NSData *merchantData = [merchant_info dataUsingEncoding:4];
        NSDictionary *merchant_info_dic = [NetWorking send:MERCHANT_INFO postBody:merchantData];
        businessVC.merchant_info = [[NSDictionary alloc]initWithDictionary:merchant_info_dic];
        businessVC.merchant_list = [[NSDictionary alloc]initWithDictionary:dic];
        [self.navigationController pushViewController:businessVC animated:YES];
        
        NSLog(@"%@",dic);
        NSLog(@"%@",merchant_info_dic);
    }
}
-(void)beautyAction:(UIButton *)sender
{
    NSString *postString = [NSString stringWithFormat:@"latitude=118.164252&longitude=24.486815&type=1"];
    NSData *postData = [postString dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:MAP_LIST postBody:postData];
    self.pointList = [[NSArray alloc]initWithArray:dic[@"data"][@"list"]];
    NSLog(@"%@",self.pointList);
    [self addcoordinate];
}
-(void)decorateAction:(UIButton *)sender
{
    NSString *postString = [NSString stringWithFormat:@"latitude=118.164252&longitude=24.486815&type=2"];
    NSData *postData = [postString dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:MAP_LIST postBody:postData];
    self.pointList = [[NSArray alloc]initWithArray:dic[@"data"][@"list"]];
    NSLog(@"%@",self.pointList);
    [self addcoordinate];
}
-(void)repairAction:(UIButton *)sender
{
    NSString *postString = [NSString stringWithFormat:@"latitude=118.164252&longitude=24.486815&type=3"];
    NSData *postData = [postString dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:MAP_LIST postBody:postData];
    self.pointList = [[NSArray alloc]initWithArray:dic[@"data"][@"list"]];
    NSLog(@"%@",self.pointList);
    [self addcoordinate];
}
-(void)refitAction:(UIButton *)sender
{
    NSString *postString = [NSString stringWithFormat:@"latitude=118.164252&longitude=24.486815&type=4"];
    NSData *postData = [postString dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:MAP_LIST postBody:postData];
    self.pointList = [[NSArray alloc]initWithArray:dic[@"data"][@"list"]];
    NSLog(@"%@",self.pointList);
    [self addcoordinate];
}

#pragma mark -商家详情
-(void)bussinessDetail:(UIButton *)sender
{
}
#pragma mark -创建按钮
-(UIButton *)createButton:(CGRect)rect andImageName:(NSString *)imageName
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = *(&rect);
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 19;
    btn.layer.borderColor = [UIColor colorWithRed:28./255 green:171./255 blue:231./255 alpha:1].CGColor;
    btn.layer.borderWidth = 1.5;
    return btn;
}
#pragma mark -内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark -视图将要消失
-(void)viewWillDisappear:(BOOL)animated
{
    
}
#pragma mark -视图将要出现
-(void)viewWillAppear:(BOOL)animated
{
    
}

@end
