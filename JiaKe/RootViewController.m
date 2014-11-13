//
//  RootViewController.m
//  MyApp
//
//  Created by hgs泽泓 on 14-8-27.
//  Copyright (c) 2014年 HongZehong. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "ChatViewController.h"
#import "ForMeViewController.h"
#import "HGSTabBarController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(UINavigationController *)rootViewController
{
    //创建首页视图
    CREATEVIEW(HomeViewController, homeVC, @"HomeView4_0", @"HomeView3_5");
    //创建聊一聊页面
    CREATEVIEW(ChatViewController, chatVC, @"ChatView4_0", @"ChatView3_5");
    //创建我的驾客界面
    CREATEVIEW(ForMeViewController, myVC, @"ForMeView4_0", @"ForMeView3_5");
    
    //将背景颜色设置为白色
    homeVC.view.backgroundColor=[UIColor whiteColor];
    chatVC.view.backgroundColor=[UIColor whiteColor];
    myVC.view.backgroundColor=[UIColor whiteColor];
    
    HGSTabBarController *hgsTab = [[HGSTabBarController alloc]init];
    hgsTab.viewControllers = [NSArray arrayWithObjects:homeVC,chatVC,myVC, nil];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:hgsTab];
    //设置导航栏文字颜色
    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil ]];
    //设置导航栏背景颜色
    [[UINavigationBar appearance]setBarTintColor:BLUECOLOR];
    //文字颜色，返回
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    //设置状态栏文字颜色
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    hgsTab.title = homeVC.title;
    [hgsTab.tabBar setTintColor:BLUECOLOR];
    return  nav;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
