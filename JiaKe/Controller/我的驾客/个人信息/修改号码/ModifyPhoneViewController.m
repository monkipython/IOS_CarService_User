//
//  ModifyPhoneViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-29.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "ModifyPhoneViewController.h"

@interface ModifyPhoneViewController ()

@property (weak, nonatomic) IBOutlet UITextField *originallyPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *nowPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *originallyVerification;
@property (weak, nonatomic) IBOutlet UITextField *nowVerification;
@property (weak, nonatomic) IBOutlet UIButton *originallyVerificationButton;
@property (weak, nonatomic) IBOutlet UIButton *nowVerificationButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation ModifyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}

#pragma mark -加载视图
-(void)createView
{
    self.view.backgroundColor = GRAYCOLOR;
    self.originallyVerificationButton.layer.cornerRadius = 5;
    self.nowVerificationButton.layer.cornerRadius = 5;
    self.nextButton.layer.cornerRadius = 5;
    self.originallyPhoneTextField.text = self.phone;
    
    self.originallyPhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.originallyVerification.keyboardType = UIKeyboardTypeNumberPad;
    self.nowPhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.nowVerification.keyboardType = UIKeyboardTypeNumberPad;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //回收键盘
    [self.originallyPhoneTextField endEditing:YES];
    [self.originallyVerification endEditing:YES];
    [self.nowPhoneTextField endEditing:YES];
    [self.nowVerification endEditing:YES];
}

- (IBAction)originallyVerificationAction:(UIButton *)sender {
}
- (IBAction)nowVerificationAction:(UIButton *)sender {
}
- (IBAction)nextAction:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
