//
//  RegardingViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-5.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "RegardingViewController.h"
#import "RegardingModel.h"
#import "ClauseViewController.h"
#import "ContactViewController.h"
#import "WebViewController.h"
@interface RegardingViewController ()
//设置选项
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UIButton *webButton;
//获取选项名
@property(nonatomic,strong)NSArray *optionArray;
@end

@implementation RegardingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)webAction:(UIButton *)sender {
    CREATEVIEW(WebViewController, webVC, @"WebView4_0", @"WebView3_5");
    webVC.webAddress = @"http://121.40.92.53";
    [self.navigationController pushViewController:webVC animated:YES];
  
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


    
}
#pragma mark -将要进入视图时获取选项名
-(void)viewWillAppear:(BOOL)animated
{
    self.optionArray = [RegardingModel optionName];
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
    //单元格重运用
    static NSString *CellIdentifier=@"CellIdentifier";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //添加箭头
    if(indexPath.row!=0){
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        //版本更新
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        UILabel *details = [[UILabel alloc]initWithFrame:CGRectMake(215, 7,120, 30)];
        details.text = @"已是最新版本";
        details.font = [UIFont systemFontOfSize:14.5f];
        [cell.contentView addSubview:details];
      }
    cell.textLabel.text = self.optionArray[indexPath.row];
    return cell;
}
#pragma mark -点击单元格响应方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
            
        case 0:{
        }
            break;
        case 1:{
            CREATEVIEW(ClauseViewController, clanseVC, @"ClauseView4_0", @"ClauseView3_5")
            clanseVC.title = @"服务条款";
            
            [self.navigationController pushViewController:clanseVC animated:YES];
            
        }
            break;

        case 2:{
            CREATEVIEW(ContactViewController, contactVC, @"ContactView4_0", @"ContactView3_5")
            contactVC.title = @"联系我们";
            [self.navigationController pushViewController:contactVC animated:YES];
            
        }
            break;
            
            
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headerView.backgroundColor = [UIColor clearColor];
    return self.headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    self.footerView.backgroundColor = [UIColor clearColor];
    return self.footerView;
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 160;
}

-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (RECT.size.height==568) {
        return 212;
    }
    return 124;
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
