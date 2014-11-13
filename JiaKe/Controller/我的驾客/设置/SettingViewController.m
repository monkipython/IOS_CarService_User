//
//  SettingViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-2.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "SettingViewController.h"
#import "settingModel.h"
#import "FeedbackViewController.h"
#import "RegardingViewController.h"
@interface SettingViewController ()

//设置选项
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//设置数组存放选项

@property(nonatomic,strong)NSArray *optionArray;
@end
static BOOL isNumberOne;
static NSIndexPath *isIndexPath;
@implementation SettingViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}
#pragma mark -加载视图
-(void)createView
{
    isNumberOne = YES;
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    self.tableView.backgroundColor = [UIColor clearColor];
}
#pragma mark -将要进入视图时获取选项名
-(void)viewWillAppear:(BOOL)animated
{
    self.optionArray = [SettingModel optionName];
    [self cancelSelected];
}
-(void)cancelSelected
{
    if (isNumberOne==NO) {
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:isIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1000)
    {
        if (buttonIndex==0) {
            //设置状态栏文字颜色
            [[UIApplication sharedApplication] setStatusBarStyle:0];
                [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
            }

    }
        
}

#pragma mark -tabieView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //返回组数
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //返回行数
    return self.optionArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellID=@"SettingTableViewCellID";
         BOOL isRegister=NO;
    if (!isRegister) {
        UINib *nib=[UINib nibWithNibName:@"SettingTableViewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:cellID];
        isRegister=YES;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    UILabel *option = (UILabel *)[cell viewWithTag:1000];
    option.backgroundColor = [UIColor whiteColor];
    option.layer.cornerRadius = 10;
    option.clipsToBounds = YES;
    option.layer.borderWidth = 1;
    option.layer.borderColor = [UIColor blackColor].CGColor;
    //添加箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    option.text = self.optionArray[indexPath.row];
    return cell;
    
}
#pragma mark -点击单元格响应方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isNumberOne==YES) {
        isNumberOne=NO;
    }
    isIndexPath = indexPath;
    switch (indexPath.row) {
        case 0:{

            UIActionSheet * act = [[UIActionSheet alloc]initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微信朋友圈",@"QQ空间",@"新浪微博", nil];
           
            act.tag = 3000;
            [act showInView:self.view];
            //设置延迟0.01秒执行方法 imageView
            [self performSelector:@selector(cancelSelected) withObject:self afterDelay:.01];
            
        }

            break;
        case 1:{
            CREATEVIEW(FeedbackViewController, feedbackVC, @"FeedbackView4_0", @"FeedbackView3_5")
            feedbackVC.title = @"意见反馈";
            [self.navigationController pushViewController:feedbackVC animated:YES];
         }
            break;
        case 2:{
            CREATEVIEW(RegardingViewController, regardingVC, @"RegardingView4_0", @"RegardingView3_5");
            regardingVC.title = @"关于驾客";
            [self.navigationController pushViewController:regardingVC animated:YES];


        }
            break;
            
            
    }
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==3000) {
        switch (buttonIndex) {
            case 0:
            {
                NSLog(@"微信朋友圈");
            }
                break;
            case 1:
            {
                NSLog(@"QQ空间");
            }
                break;
            case 2:
            {
                NSLog(@"新浪微博");
            }
                break;
            case 3:
            {
                NSLog(@"取消");
                
            }
                break;
                

        }
    }
}
-(void)willPresentActionSheet:(UIActionSheet *)actionSheet
{

    if (actionSheet.tag==3000) {

    }
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
