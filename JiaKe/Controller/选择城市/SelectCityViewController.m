//
//  SelectCityViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-3.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "SelectCityViewController.h"
#import "SelectCityModel.h"
#import "ChangePosition.h"
@interface SelectCityViewController ()
//所拖拽的控件
@property (weak, nonatomic) IBOutlet UITableView *tableVC;
//存放省份
@property (strong,nonatomic)NSArray *provinceArray;
//存放城市
@property (strong,nonatomic)NSArray *cityArray;
//存放省名
@property (strong,nonatomic)NSString *provinceName;
//存放城市名
@property (strong,nonatomic)NSString *cityName;
//用于识别重新创建的UItableView
@property (assign,nonatomic)NSInteger isTableVC;
@property (assign) NSInteger isRefresh;
@end

@implementation SelectCityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isRefresh = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //创建视图
    [self createView];
    [self getInfo];
    
}
-(void)getInfo
{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSString *postString = @"pid=0";
        NSData *postData = [postString dataUsingEncoding:4];
        NSDictionary *dic = [NetWorking send:CITY_LIST postBody:postData];
        if([dic[@"code"]integerValue]==0)
        {
            NSArray *arr = dic[@"data"][@"list"];
            self.provinceArray = [[NSArray alloc]initWithArray:arr];
            //获得数据，进行刷新
            self.isRefresh = 1;
            NSLog(@"%@",dic);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableVC reloadData];
        });
    });
    
}
#pragma mark -创建视图
-(void)createView
{
    self.title = @"选择城市";
    
    //重写两个导航按钮
    UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    self.navigationItem.rightBarButtonItem = item1;
    self.navigationItem.leftBarButtonItem =item2;
    
}
#pragma mark -视图将要加载时
-(void)viewWillAppear:(BOOL)animated
{
    //从Model中获取省市的数据源
//    self.provinceArray=[SelectCityModel provinceArray];
    //开始识别为UITableView为1
//    self.isTableVC=1;
}
#pragma mark -UITabelView的代理
//返回分区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //表示正在加载中
    if(self.isRefresh==0)
    {
        return 1;
    }
    if(self.isRefresh==1)
    {
        return self.provinceArray.count;
    }
    if(self.isRefresh==2)
    {
        return self.cityArray.count;
    }
    return 1;
    
}

//返回单元格的信息
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //单元格重用于
    //用于识别单元格
    static NSString *CellIdentifier=@"CellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(self.isRefresh==0)
    {
        cell.textLabel.text = @"正在加载中";
    }
    if(self.isRefresh==1)
    {
        cell.textLabel.text = self.provinceArray[indexPath.row][@"name"];
    }
    if(self.isRefresh==2)
    {
        cell.textLabel.text = self.cityArray[indexPath.row][@"name"];
    }
    return cell;
}

#pragma mark -点击单元格相应方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选择省份 将省份中城市的数据传给self.cityArray 创建新的UITableView加载城市数据
    if (self.isRefresh==1)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.isRefresh = 0;
            NSInteger pid = [self.provinceArray[indexPath.row][@"id"] integerValue];
            self.provinceName = self.provinceArray[indexPath.row][@"name"];
            NSString *postString = [NSString stringWithFormat:@"pid=%d",pid];
            NSData *postData = [postString dataUsingEncoding:4];
            NSDictionary *dic = [NetWorking send:CITY_LIST postBody:postData];
            NSLog(@"%@",dic);
            if([dic[@"code"]integerValue]==0)
            {
                self.cityArray = dic[@"data"][@"list"];
                UITableView *tableView = (UITableView *)[self.view viewWithTag:1002];
                [tableView reloadData];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self createTableView];
            });
        });
    
    }
    //选择完毕  检查你所选的城市
    else
    {
        NSDictionary *dic=self.cityArray[indexPath.row];
        //获取城市名
        self.cityName = dic[@"name"];
        NSString *cityId = dic[@"id"];
        NSLog(@"%@",cityId);
        [[NSUserDefaults standardUserDefaults]setObject:cityId forKey:@"pid"];
        NSString *str=[NSString stringWithFormat:@"省份:%@\n城市:%@",self.provinceName,self.cityName];
        
        UIAlertView *ale=[[UIAlertView alloc]initWithTitle:@"您的位置是" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: @"取消",nil];
        ale.tag=2000;
        [ale show];
    }
    
}

#pragma mark -警告代理实现选择
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==2000)
    {
        switch(buttonIndex)
        {
            case 0:
            {
                //委托传值
                [[NSUserDefaults standardUserDefaults]setObject:self.cityName forKey:@"cityName"];
                [self.delegate selectProvinceName:self.provinceName andCity:self.cityName];
                [self cancelAction:nil];
            }
                break;
            case 1:
            {
                
            }
                break;
        }
    }
}
#pragma mark -创建新的UITableView
-(void)createTableView
{
    self.isRefresh = 2;
    UITableView *tableVC=[[UITableView alloc]initWithFrame:CGRectMake(0, RECT.size.height, RECT.size.width, RECT.size.height)];
    tableVC.dataSource=self;
    tableVC.delegate=self;
    //设置其tag来后期获取该UITableView 进行操作
    tableVC.tag=1000+self.isRefresh;
    [self.view addSubview:tableVC];
    //添加移动动画
    
    [ChangePosition addAnimation:tableVC  andDuration:0.3 andDelay:0 andRect:CGRectMake(0, 64, RECT.size.width, RECT.size.height-64)];
}

#pragma mark -添加移动动画

#pragma mark -返回按钮的 返回上一步
-(void)backAction:(UIBarButtonItem *)sender
{
    //当选择省份时返回上已个界面
    if (self.isRefresh==1) {
        [self cancelAction:nil];
    }
    //当选择城市时返回选择省份
    else if (self.isRefresh==2)
    {
        UITableView *tableVC = (UITableView *)[self.view viewWithTag:1002];
        self.isRefresh = 1;
        //设置动画将其移出界面
        
        [ChangePosition addAnimation:tableVC andDuration:0.3 andDelay:0 andRect:CGRectMake(0, RECT.size.height, RECT.size.width, RECT.size.height)];
        //设置延迟删除视图
        [self performSelector:@selector(remove) withObject:self afterDelay:0.4];
        
    }
}

#pragma mark -删除所添加的视图 识别当前显示的UITableView
-(void)remove
{
    UITableView *tableVC = (UITableView *)[self.view viewWithTag:1000+self.isTableVC];
    [tableVC removeFromSuperview];
    self.isTableVC--;
    
}
#pragma mark -取消按钮的方法
-(void)cancelAction:(UIBarButtonItem *)sender

{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
