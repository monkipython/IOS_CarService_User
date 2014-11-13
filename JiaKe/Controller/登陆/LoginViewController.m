//
//  LoginViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-2.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "LoginViewController.h"
#import "RootViewController.h"
#import "RegistViewController.h"
#import "GetBackPassworkViewController.h"
#import "NecessaryViewController.h"
#import "LoginModel.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //自定义初始化内容
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
}
#pragma mark-构建视图
-(void)createView
{
    //状态栏风格
//    [[UIApplication sharedApplication]setStatusBarStyle:0];
    self.userName.frame = CGRectMake(5, 174, 310, 40);
    self.passWord.frame = CGRectMake(5, 218, 310, 40);
    self.LoginButton.backgroundColor = BLUECOLOR;
    self.LoginButton.layer.cornerRadius = 4;
}
#pragma mark -方法库
#pragma mark -登陆按钮
- (IBAction)loginAction:(UIButton *)sender
{
    NSString *postString = [NSString stringWithFormat:@"mobile=%@&password=%@",self.userName.text,self.passWord.text];
    NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NetWorking send:LOGIN postBody:data];
    NSLog(@"%@",dic);
    
    if([self.whichView isEqualToString:@"event"]&&[[dic objectForKey:@"code"]intValue]==0)
    {
        //将member_id写入本地plist
        NSString *member_id = dic[@"data"][@"member_session_id"];
        [[NSUserDefaults standardUserDefaults]setObject:member_id forKey:@"member_id"];
        [LoginModel loadProjectInfo];
        //修改登陆状态
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isLogin"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)writeToDatabase:(NSDictionary *)info
{
    
}
#pragma mark -新用户按钮
- (IBAction)newUser:(UIButton *)sender
{
    CREATEVIEW(RegistViewController, registVC, @"RegistView4_0", @"RegistView3_5");
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:registVC];
    //改变导航栏文背景颜色
    [[UINavigationBar appearance]setBarTintColor:BLUECOLOR];
    //改变导航栏文字颜色
    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil ]];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark -忘记密码
- (IBAction)forgetPassword:(UIButton *)sender
{
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"找回密码" otherButtonTitles:nil, nil];
    [action showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"找回密码");
    CREATEVIEW(GetBackPassworkViewController, getBackVC, @"GetBack4_0", @"GetBack3_5");
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:getBackVC];
    //改变导航栏文字颜色
    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil ]];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setBarTintColor:BLUECOLOR];
    [self presentViewController:nav animated:YES completion:nil];
        
}
#pragma mark -点击屏幕
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userName endEditing:YES];
    [self.passWord endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
