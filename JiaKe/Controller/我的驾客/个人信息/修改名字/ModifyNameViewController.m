//
//  ModifyNameViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-29.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "ModifyNameViewController.h"
#import "HeadViewController.h"

@interface ModifyNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property(strong,nonatomic)UIBarButtonItem *rightItem;

@end

@implementation ModifyNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}

#pragma mark -加载视图
-(void)createView
{
    self.nameTextField.text = self.infomation[@"data"][@"nick_name"];
    self.nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameTextField.allowsEditingTextAttributes = YES;
    [self.nameTextField becomeFirstResponder];
    
    self.rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(completeAction:)];
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    
}

-(void)completeAction:(UIBarButtonItem *)sender
{
    NSString *member = [[NSUserDefaults standardUserDefaults] objectForKey:@"member_id"];
    NSString *email = self.infomation[@"data"][@"email"];
    NSString *str = [NSString stringWithFormat:@"member_session_id=%@&nick_name=%@&email=%@",member,self.nameTextField.text,email];
    NSData *data = [str dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:MOD_MENBER postBody:data];
    int result = [dic[@"code"] intValue];
    if(!result)
    {
        [self.delegate changStatus];
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.nameTextField endEditing:NO];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.nameTextField endEditing:YES];
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
