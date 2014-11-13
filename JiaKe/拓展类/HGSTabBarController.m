//
//  HGSTabBarController.m
//  MyApp
//
//  Created by hgs泽泓 on 14-8-16.
//  Copyright (c) 2014年 HongZehong. All rights reserved.
//

#import "HGSTabBarController.h"

@interface HGSTabBarController ()

@end

@implementation HGSTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //图片数组
    NSArray *imageArray = [NSArray arrayWithObjects:@"首页n@2x",@"消息n@2x",@"个人中心n@2x", nil];
    //循环添加到tabbar中
    for(int i = 0;i<imageArray.count;i++)
    {
        NSString *str = [imageArray objectAtIndex:i];
        UIButton *btnOne = [UIButton buttonWithType:UIButtonTypeCustom];
        btnOne.frame = CGRectMake([[UIScreen mainScreen]bounds].size.width/imageArray.count*i+40, 7, 25, 25);
        btnOne.tag = 1000+i;
        [btnOne setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
        [self.tabBar addSubview:btnOne];
    }
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    tabBarController.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem;
    tabBarController.title = viewController.title;
    tabBarController.navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem;
    tabBarController.navigationItem.titleView = viewController.navigationItem.titleView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
