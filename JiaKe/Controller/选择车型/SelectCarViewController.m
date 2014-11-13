//
//  SelectCarViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-2.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "SelectCarViewController.h"
#import "SelectCarModel.h"
#import "ChangePosition.h"


@interface SelectCarViewController ()
//拖拽的UITableView
@property (weak, nonatomic) IBOutlet UITableView *tableVC;
//获取汽车品牌
@property(nonatomic,strong)NSArray *CarBrand;
//获取汽车的部分详情
@property(nonatomic,strong)NSArray *CarDetails;
//获取汽车的型号
@property(nonatomic,strong)NSArray *CarModel;
//获取汽车的款式
@property(nonatomic,strong)NSArray *CarStyle;
//用于识别创建的UITableView
@property(nonatomic,assign)NSInteger isTableVC;

//储存品牌名
@property(nonatomic,strong)NSString *brandName;
//存储型号ID
@property(nonatomic,strong)NSString *model_id;

//储存型号名
@property(nonatomic,strong)NSString *modelName;
//储存款式ID
@property(nonatomic,strong)NSString *style_id;

//储存款式名
@property(nonatomic,strong)NSString *styleName;
//储存详情ID
@property(nonatomic,strong)NSString *details_id;
//储存详情信息
@property(nonatomic,strong)NSString *detailsName;

//储存型号数组
@property(nonatomic,strong)NSArray  *modelArray;
//储存款式数组
@property(nonatomic,strong)NSArray  *styleArray;
//储存详情数组
@property(nonatomic,strong)NSArray  *detailsArray;
//储存你的选项
@property(nonatomic,strong)NSString *CarName;



@end


@implementation SelectCarViewController

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
    //创建视图
    [self createView];
    
}
#pragma mark -创建视图
-(void)createView

{
    //添加连个导航栏按钮
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];

    self.navigationItem.rightBarButtonItem = item1;
    self.navigationItem.leftBarButtonItem = item2;

}
#pragma mark -视图将要创建时
-(void)viewWillAppear:(BOOL)animated
{
    self.CarBrand = [SelectCarModel CarBrandArray];
    self.CarModel = [SelectCarModel CarModelArray];
    self.CarStyle = [SelectCarModel CarStyleArray];
    self.CarDetails = [SelectCarModel CarDetailsArray];
    self.isTableVC=1;
    
}
#pragma mark -UITableView的代理
//返回分区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isTableVC==1) {
        return self.CarBrand.count;
    }
    return 1;
}

//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isTableVC==1)
    {
        
        
        NSDictionary *dic=self.CarBrand[section];
        NSArray *arr=dic[@"brand"];
        return arr.count;
    }
    
    else if (self.isTableVC==2)
    {
        //返回并储存型号
        for (int i=0; i<self.CarModel.count; i++)
        {
            NSDictionary *dic=self.CarModel[i];
            if ([self.model_id isEqualToString:dic[@"id"]]) {
                self.modelArray=dic[@"model"];
                return self.modelArray.count;
            }
            
        }
    }
    else if (self.isTableVC==3)
    {
        //返回并储存款式
        for (int i=0; i<self.CarStyle.count; i++)
        {
            NSDictionary *dic=self.CarStyle[i];
            if ([self.style_id isEqualToString:dic[@"id"]]) {
                self.styleArray=dic[@"style"];
                return self.styleArray.count;
            }
            
        }
        
    }
    else if (self.isTableVC==4)
    {
        //返回并储存详情
        for (int i=0; i<self.CarDetails.count; i++)
        {
            NSDictionary *dic=self.CarDetails[i];
            if ([self.details_id isEqualToString:dic[@"id"]]) {
                self.detailsArray=dic[@"details"];
                return self.detailsArray.count;
            }
            
        }
        
    }
    
    return 0;

    
}

//返回单元格的信息
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //单元格重运用
    static NSString *CellIdentifier=@"CellIdentifier";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    if(self.isTableVC==1)
    {
        NSDictionary *dic=self.CarBrand[indexPath.section];
        NSArray *arr=dic[@"brand"];
        
        NSDictionary *dic1=arr[indexPath.row];
        
        cell.textLabel.text=dic1[@"name"];
        
        
    }
    else if(self.isTableVC==2)
    {
        
        NSDictionary *dic1=self.modelArray[indexPath.row];
        cell.textLabel.text=dic1[@"model"];
        
    }
    else if(self.isTableVC==3)
    {
        
        NSDictionary *dic1=self.styleArray[indexPath.row];
        cell.textLabel.text=dic1[@"style"];
        
    }
    else if(self.isTableVC==4)
    {
        
        NSDictionary *dic1=self.detailsArray[indexPath.row];
        cell.textLabel.text=dic1[@"details"];
        
    }
    return cell;

}
#pragma mark -索引栏
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.isTableVC==1) {
        NSMutableArray *array=[NSMutableArray new];
        for (int i=0; i<self.CarBrand.count; i++) {
            NSDictionary  *dic=self.CarBrand[i];
            NSArray *arr = dic[@"brand"];
            if (arr.count!=0) {
                [array addObject:dic[@"Letter"]];
            }
        }
        
        return array;
    }
    return nil;
}
#pragma mark -设置单元格的组开头
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.isTableVC==1) {
        NSDictionary  *dic=self.CarBrand[section];
        NSArray *arr = dic[@"brand"];
        if (arr.count!=0) {
            return dic[@"Letter"];
        }
        
        
    }
    if (self.isTableVC==2) {
        return self.brandName;
    }
    if (self.isTableVC==3) {
        NSString *str=[NSString stringWithFormat:@"%@,%@",self.brandName,self.modelName];
        return str;
    }
    if (self.isTableVC==4) {
        NSString *str=[NSString stringWithFormat:@"%@,%@",self.brandName,self.modelName];
        return str;
        
    }
    return nil;
}
#pragma mark -设置点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.isTableVC==1)
    {
        self.isTableVC=2;
        NSDictionary *dic=self.CarBrand[indexPath.section];
        NSArray *arr=dic[@"brand"];
        NSDictionary *dic1=arr[indexPath.row];
        self.model_id=dic1[@"model_id"];
        self.brandName=dic1[@"name"];
        [self createTableView];
        
    }
    else if(self.isTableVC==2)
    {
        self.isTableVC=3;
        NSDictionary *dic1=self.modelArray[indexPath.row];
        self.style_id=dic1[@"style_id"];
        self.modelName=dic1[@"model"];
        [self createTableView];
    }
    else if(self.isTableVC==3)
    {
        self.isTableVC=4;
        NSDictionary *dic1=self.styleArray[indexPath.row];
        self.details_id=dic1[@"details_id"];
        self.styleName=dic1[@"style"];
        [self createTableView];
    }
    else if(self.isTableVC==4)
    {
        
        NSDictionary *dic1=self.detailsArray[indexPath.row];
        self.detailsName = dic1[@"details"];
        self.CarName=[NSString stringWithFormat:@"品牌:%@\n型号:%@\n款式:%@",self.brandName,self.modelName,self.detailsName ];

        UIAlertView *ale=[[UIAlertView alloc]initWithTitle:@"您的爱车是" message:self.CarName delegate:self cancelButtonTitle:@"确定" otherButtonTitles: @"取消",nil];
        ale.tag=2000;
        [ale show];
       
    }
    
}
#pragma mark -警告代理实现选择
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==2000)
    {
        switch (buttonIndex)
        {
                case 0:
            {
                //委托传值
                [self.delegate sendCarBrand:self.brandName andCarModel:self.modelName andDetails:self.detailsName andCarName:self.CarName];
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
    UITableView *tableVC=[[UITableView alloc]initWithFrame:CGRectMake(0, RECT.size.height, RECT.size.width, RECT.size.height)];
    tableVC.dataSource=self;
    tableVC.delegate=self;
    tableVC.tag=1000+self.isTableVC;
    [self.view addSubview:tableVC];
    
    [ChangePosition addAnimation:tableVC andDuration:0.3 andDelay:0 andRect:CGRectMake(0, 64, RECT.size.width, RECT.size.height-64)];
}

#pragma mark -取消按钮
-(void)backAction:(UIBarButtonItem *)sender
{
    //识别为底层UITableView退出当前界面
    if (self.isTableVC==1) {
        [self cancelAction:nil];
    }
    else
    {
        UITableView *tableVC = (UITableView *)[self.view viewWithTag:1000+self.isTableVC];
        //移出界面
    
        [ChangePosition addAnimation:tableVC andDuration:0.3 andDelay:0 andRect:CGRectMake(0, RECT.size.height, RECT.size.width, RECT.size.height)];
        //设置延迟删除当前UITableView
        [self performSelector:@selector(remove) withObject:self afterDelay:0.4];
        
    }
}
#pragma mark -删除UITableView
-(void)remove
{
    UITableView *tableVC = (UITableView *)[self.view viewWithTag:1000+self.isTableVC];
    [tableVC removeFromSuperview];
    //识别上一个UITableView
    self.isTableVC--;
    
}
#pragma mark -返回按钮
-(void)cancelAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
