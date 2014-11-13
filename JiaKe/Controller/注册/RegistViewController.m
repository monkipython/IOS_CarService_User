//
//  RegistViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-3.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "RegistViewController.h"
#import "LoginViewController.h"
#import "RegistSuccessViewController.h"
#import "RootViewController.h"

@interface RegistViewController ()
//手机号
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
//输入密码
@property (weak, nonatomic) IBOutlet UITextField *password;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *checkNumber;
//获得验证码
@property (weak, nonatomic) IBOutlet UIButton *getCheckNum;
//同意协议
@property (weak, nonatomic) IBOutlet UIButton *agreeCheck;
//下一步
@property (weak, nonatomic) IBOutlet UIButton *nextStep;
@property (strong ,nonatomic) NSString *session_id;
@end

@implementation RegistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"注册";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}
#pragma mark - 创建视图
-(void)createView
{
    [[UIApplication sharedApplication]setStatusBarStyle:1];
    self.getCheckNum.layer.cornerRadius = 4;
    self.agreeCheck.layer.borderWidth = .5;
    self.nextStep.layer.cornerRadius = 4;
    //取消按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backToLogin:)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
}
#pragma mark -返回登陆
-(void)backToLogin:(UIBarButtonItem *)sender
{
    [[UIApplication sharedApplication]setStatusBarStyle:0];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark- 点击屏幕
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.phoneNumber endEditing:YES];
    [self.password endEditing:YES];
    [self.checkNumber endEditing:YES];
}
//获取验证码
- (IBAction)getCode:(UIButton *)sender {
    NSString *userNameString = [NSString stringWithFormat:@"mobile=%@",self.phoneNumber.text];
    NSData *postData = [userNameString dataUsingEncoding:4];
    NSDictionary *returnDic = [NetWorking send:REGISTER postBody:postData];
    NSString *str = returnDic[@"data"];
    self.session_id = [[NSString alloc]initWithString:str];
    NSLog(@"%@",returnDic);
}

//注册按钮
- (IBAction)nextAction:(UIButton *)sender
{
    NSString *str = [NSString stringWithFormat:@"username=%@&mobile=%@&password=%@&code_verify=%@&session_id=%@",self.phoneNumber.text,self.phoneNumber.text,self.password.text,self.checkNumber.text,self.session_id];
    NSData *data = [str dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:REGISTER postBody:data];
    NSLog(@"%@",dic);
    int result = [dic[@"code"]intValue];
    if(!result)
    {
        NSString *str = [NSString stringWithFormat:@"username=%@&password=%@",self.phoneNumber.text,self.password.text];
        NSData *data = [str dataUsingEncoding:4];
        //注册成功后登陆
        NSDictionary *dic = [NetWorking send:LOGIN postBody:data];
        NSLog(@"%@",dic);
        int result = [dic[@"code"]intValue];
        if(!result)
        {
            NSString *member_id = dic[@"data"][@"member_session_id"];
            [[NSUserDefaults standardUserDefaults]setObject:member_id forKey:@"member_id"];
            
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isLogin"];
            [self presentViewController:[RootViewController rootViewController] animated:YES completion:nil];
        }
    }
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
