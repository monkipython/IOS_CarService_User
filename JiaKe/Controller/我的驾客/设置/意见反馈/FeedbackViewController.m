//
//  FeedbackViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-29.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()
@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}
-(void)createView
{
    self.view.backgroundColor = GRAYCOLOR;
    self.feedbackTextView.layer.cornerRadius = 5;
    self.feedbackTextView.textColor=COLOR(100.0, 100.0, 100.0, 1);
    //微调 内容位置 解决渲染
    self.feedbackTextView.contentInset=UIEdgeInsetsMake(15.0,0.0,0,0.0);
    
    //    //设置文字提示颜色
    self.feedbackLabel.textColor=COLOR(200.0, 200.0, 200.0, 1);

    
    self.submitButton.layer.cornerRadius = 5;
    
}
#pragma mark -用代理限制输入字数的个数
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //设置个数不超过500字符
    if (range.location>=500)
    {
        //控制输入文本的长度
        return  NO;
    }
    //设置不允许换行
    if ([text isEqualToString:@"\n"]) {
        //禁止输入换行
        return NO;
    }
    //设置不允许换行
    if ([text isEqualToString:@" "]) {
        //禁止输入空格
        return NO;
    }
    
    else
    {
        return YES;
    }
}
#pragma mark -设置代理将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //清除提示开始输入
    if ([textView.text isEqualToString:@"请留下您的宝贵意见!"])
    {
        //设置内容在输入框的位置
        textView.contentInset=UIEdgeInsetsMake(-7.0,0.0,0,0.0);
        //改变输入框内容文字的颜色
        textView.textColor=COLOR(0.0, 0.0, 0.0, 1);
        //清除提示
        textView.text=@"";
        
        self.feedbackLabel.alpha = 1;
    }
    
    return YES;
}
#pragma mark -设置代理将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    //当无输入内容是显示提示
    if(textView.text.length==0)
    {
        //改变输入框框位置
        textView.contentInset=UIEdgeInsetsMake(80.0,0.0,0,0.0);
        //显示提示
        textView.text=@"请留下您的宝贵意见!";
        //改变内容文字内容
        textView.textColor=COLOR(100.0, 100.0, 100.0, 1);
        self.feedbackLabel.alpha = 0;
    }
    return YES;
}

#pragma mark -设置代理正在编辑
-(void) textViewDidChange:(UITextView *)textView
{
    //设置文字提示的颜色
    self.feedbackLabel.text=[NSString stringWithFormat:@"%d",500-textView.text.length];
}


#pragma mark -点击屏幕响应事件 回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //回收键盘
   
    [self.feedbackTextView endEditing:YES];
}

- (IBAction)submitAction:(UIButton *)sender {
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
