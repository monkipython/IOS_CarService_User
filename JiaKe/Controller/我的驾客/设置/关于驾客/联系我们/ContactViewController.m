//
//  ContactViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-5.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactModel.h"
@interface ContactViewController ()
//获取公司名
@property (weak, nonatomic) IBOutlet UILabel *corporationName;
//获取公司客服QQ
@property (weak, nonatomic) IBOutlet UILabel *QQ;
//获取公司电话
@property (weak, nonatomic) IBOutlet UILabel *call;
//获取邮箱
@property (weak, nonatomic) IBOutlet UILabel *email;
//获取地址
@property (weak, nonatomic) IBOutlet UILabel *address;
//获取网址
@property (weak, nonatomic) IBOutlet UILabel *URL;
//获取合作邮箱
@property (weak, nonatomic) IBOutlet UILabel *cooperationEmail;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;


@end

@implementation ContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)chatAction:(UIButton *)sender {
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}
-(void)createView
{
    self.chatButton.layer.cornerRadius = 5;
}
#pragma mark -将要进入视图时加载数据
-(void)viewWillAppear:(BOOL)animated
{
    self.corporationName.text = [ContactModel corporationName];
    self.call.text = [ContactModel call];
    self.QQ.text = [ContactModel QQ];
    self.email.text = [ContactModel email];
    self.URL.text = [ContactModel URL];
    self.address.text = [ContactModel address];
    self.cooperationEmail.text = [ContactModel cooperationEmail];

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
