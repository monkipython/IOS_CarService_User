//
//  RegistSuccessViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-3.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "RegistSuccessViewController.h"
#import "RootViewController.h"

@interface RegistSuccessViewController ()

@end

@implementation RegistSuccessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"注册成功";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}
- (IBAction)beginAction:(UIButton *)sender
{
    [self presentViewController:[RootViewController rootViewController] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
