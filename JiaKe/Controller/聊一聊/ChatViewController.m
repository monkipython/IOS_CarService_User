//
//  ChatViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-2.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatTableViewCell.h"
#import "ConnectViewController.h"

@interface ChatViewController ()
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"聊聊";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellIdentifier";
    UINib *nib = [UINib nibWithNibName:@"ChatViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:cellID];
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell createCell];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CREATEVIEW(ConnectViewController, connectVC, @"ConnectView4_0", @"ConnectView3_5");
//    [self.navigationController pushViewController:connectVC animated:YES];
    [self.navigationController pushViewController:connectVC animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    //右侧按钮置空
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.titleView = nil;
    self.tabBarController.title = @"聊聊";
    for(UIButton *btnview in self.tabBarController.tabBar.subviews)
    {
        
        if(btnview.tag==1001)
        {
            [btnview setImage:[UIImage imageNamed:@"消息h@2x"] forState:UIControlStateNormal];
            btnview.alpha = .65;
        }
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    for(UIButton *btnview in self.tabBarController.tabBar.subviews)
    {
        
        if(btnview.tag==1001)
        {
            [btnview setImage:[UIImage imageNamed:@"消息n@2x"] forState:UIControlStateNormal];
            btnview.alpha = 1;
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
