//
//  EnterNewPassworViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-3.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "EnterNewPassworViewController.h"
#import "RootViewController.h"

@interface EnterNewPassworViewController ()
@property (weak, nonatomic) IBOutlet UIButton *curtainAction;
@property (weak, nonatomic) IBOutlet UITextField *aNewPassword;

@property (weak, nonatomic) IBOutlet UITextField *curtainPassword;

@end

@implementation EnterNewPassworViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"输入新密码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.curtainAction.layer.cornerRadius = 4;
}
- (IBAction)confirmAction:(UIButton *)sender
{
    UINavigationController *nav = [RootViewController rootViewController];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark- 点击屏幕
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.curtainPassword endEditing:YES];
    [self.aNewPassword endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
