//
//  SelectProgramViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-17.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "SelectProgramViewController.h"
#import "SelectProgramModel.h"
#import "ChangePosition.h"

@interface SelectProgramViewController ()
//所拖拽的控件
@property (weak, nonatomic) IBOutlet UITableView *tableVC;
//存放类别
@property (strong,nonatomic)NSArray *categoryArray;
//存放类别名
@property (strong,nonatomic)NSString *categoryName;
//存放项目
@property (strong,nonatomic)NSMutableArray *programArray;
//存放项目名
@property (strong,nonatomic)NSString *programName;
//存放项目父类id
@property (strong,nonatomic)NSString *classid;
//用于识别重新创建的UItableView
@property (assign,nonatomic)NSInteger isTableVC;
//存放已选中的项目
@property(strong,nonatomic)NSMutableArray *array;
@property(strong,nonatomic)NSMutableArray *countArray;
@end
@implementation SelectProgramViewController
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
   
    //重写两个导航按钮
    if (self.isMultiselect==YES) {
        UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirmAction:)];
        self.navigationItem.leftBarButtonItem = item1;
        self.navigationItem.rightBarButtonItem =item2;
    }
    else
    {
        UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
        self.navigationItem.rightBarButtonItem = item1;
        self.navigationItem.leftBarButtonItem =item2;    }

    
}
#pragma mark -视图将要加载时
-(void)viewWillAppear:(BOOL)animated
{
    //重Model中获取项目的数据源
    self.categoryArray=[SelectProgramModel programArray];
    //开始识别为UITableView为1
    self.isTableVC=1;
    NSLog(@"%@",self.categoryArray);
    //给存储项目名称开辟储存地址
    self.programName = [[NSMutableString alloc]init];
    
    self.classid=nil;
 
    if (self.isMultiselect) {
        NSArray *array;
           int x=0;
           array =[self.sub_id componentsSeparatedByString:@","];
  
        self.programArray =[[NSMutableArray alloc]init];
        self.array =[[NSMutableArray alloc]init];
        self.countArray = [[NSMutableArray alloc]init];
        for (int i= 0; i<self.categoryArray.count; i++) {
            NSDictionary *dic =self.categoryArray[i];
            NSArray *arr = dic[@"Program"];
            [self.countArray addObject:[NSString stringWithFormat:@"%d",(int)arr.count]];
            for (int j=0; j<arr.count; j++) {
                NSDictionary *dic = arr[j];
                [self.programArray addObject:dic];
            
                    if ([dic[@"id"] intValue]== [array[x] intValue] )
                    {
                        [self.array addObject:dic];
                        x++;
                        if (x==array.count) {
                            x--;
                        }
                    }
                    else
                    {
                        NSDictionary *dic =[[NSDictionary alloc]initWithObjectsAndKeys:@"is",@"name",nil];
                        [self.array addObject:dic];
                    }
               

            }
        }

    }


    
}
#pragma mark -UITabelView的代理
//返回分区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isMultiselect) {
        return 4;
    }
    return 1;
}
//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isMultiselect) {
        NSDictionary *dic =self.categoryArray[section];
        NSArray *array = dic[@"Program"];
        return array.count;
    }
    else{
    if (self.isTableVC==1) {
        //返回类别的个数
        return  self.categoryArray.count;
    }
    //返回项目的个数
        return self.programArray.count;
    }
    return 0;
}

//返回单元格的信息
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //单元格重用于
    //用于识别单元格
     NSString *CellIdentifier=[NSString stringWithFormat:@"Cell%d%d", (int)[indexPath section], (int)[indexPath row]];
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    if (self.isMultiselect) {
        int i=0;
        if (indexPath.section == 0) {
            i = (int)indexPath.row;
        }
        else{
            for (int j=(int)(indexPath.section-1); j>=0; j--) {
                i=i+[self.countArray[j] intValue];
            }
            i=i+(int)indexPath.row;
        }
        NSDictionary *dic =self.programArray[i];
        cell.textLabel.text = dic[@"name"];
        dic = self.array[i];
        if ([dic[@"name"] isEqualToString:@"is"]) {
            cell.accessoryType =UITableViewCellAccessoryNone;
        }
        else{
            cell.accessoryType= UITableViewCellAccessoryCheckmark;
        }
        
    }
    else{
        //当选择类别时
        if (self.isTableVC==1) {
            NSDictionary *dic=self.categoryArray[indexPath.row];
            cell.textLabel.text=dic[@"Category"];
        }
        //当选择项目时
        else
        {
            NSDictionary *dic = self.programArray[indexPath.row];
            cell.textLabel.text = dic[@"name"] ;
        }

    }
    return cell;
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.categoryArray[section][@"Category"];
}
#pragma mark -点击单元格相应方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选择类别 将类别中项目的数据传给self.programArray 创建新的UITableView加载城市数据
    if (self.isTableVC==1)
    {

        if (self.isMultiselect==YES) {
            
            int i=0;
            if (indexPath.section == 0) {
                i = (int)indexPath.row;
            }
            else{
                for (int j=(int)(indexPath.section-1); j>=0; j--) {
                    i=i+[self.countArray[j] intValue];
                }
                i=i+(int)indexPath.row;
            }
            
            //获的当前选择项
            UITableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath ];
            //显示复选框
            if (cell.accessoryType == UITableViewCellAccessoryNone)
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;

                [self.array replaceObjectAtIndex:i withObject:self.programArray[i]];

            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
                NSDictionary *dic =[[NSDictionary alloc]initWithObjectsAndKeys:@"is",@"name",nil];
                [self.array replaceObjectAtIndex:i withObject:dic];
            }
        }
        else
        {
            self.isTableVC++;
            NSDictionary *dic=self.categoryArray[indexPath.row];
            self.categoryName = dic[@"Category"];
            self.programArray = dic[@"Program"];
            self.classid = dic[@"id"];
            self.array = [[NSMutableArray alloc]init];
            for (int i=0; i<self.programArray.count; i++) {
                NSDictionary *dic =[[NSDictionary alloc]initWithObjectsAndKeys:@"is",@"name",nil];
                [self.array addObject:dic];
            }
            [self createTableView];
        }
    }
    //选择你要选择的项目
    else
    {


            NSDictionary *dic = self.programArray[indexPath.row];
            self.programName = dic[@"name"];
            self.sub_id = dic[@"id"];
            NSMutableString * str = [NSMutableString stringWithFormat:@"%@\n%@",self.categoryName,self.programName];
            UIAlertView *ale=[[UIAlertView alloc]initWithTitle:@"您的选项是" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: @"取消",nil];
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
                [self.delegate SelectCategoryName:self.categoryName andProgramNane:self.programName andSub_id:self.sub_id andClassid:self.classid];
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
    //设置其tag来后期获取该UITableView 进行操作
    tableVC.tag=1000+self.isTableVC;
    [self.view addSubview:tableVC];
    //添加移动动画
    [ChangePosition addAnimation:tableVC andDuration:0.3 andDelay:0 andRect:CGRectMake(0, 64, RECT.size.width, RECT.size.height-64)];
}


#pragma mark -返回按钮的 返回上一步
-(void)backAction:(UIBarButtonItem *)sender
{
    //当选择省份时返回上已个界面
    if (self.isTableVC==1) {
        [self cancelAction:nil];
    }
    //当选择城市时返回选择省份
    else if (self.isTableVC==2)
        
    {
        self.programName = @"";
        self.array =nil;
        UITableView *tableVC = (UITableView *)[self.view viewWithTag:1000+self.isTableVC];
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
#pragma mark -确定按钮的方法
-(void)confirmAction:(UIBarButtonItem *)sender

{
    NSMutableString *str=[[NSMutableString alloc]init];
    //检查是否第一次添加
    BOOL is=NO;
    //选择项目的个数
    int i=0;
    //获取已选择选择成功的项目名称
    
    for (NSDictionary *dic in self.array) {
        NSString *programName = [NSString stringWithFormat:@"%@",dic[@"name"]];
        if (![programName isEqualToString:@"is"]) {
            i++;
            if (!is) {
                str = [NSMutableString stringWithFormat: @"%d.%@",i,dic[@"name"]];
                self.programName =[NSMutableString stringWithFormat:@"%@",dic[@"name"]];
                self.sub_id =[NSMutableString stringWithFormat:@"%@",dic[@"id"]];

                is=YES;
            }
            else
            {
                str =[NSMutableString stringWithFormat: @"%@\n%d.%@",str,i,dic[@"name"]];
                self.programName =[NSMutableString stringWithFormat:@"%@,%@",self.programName,dic[@"name"]];
                self.sub_id =[NSMutableString stringWithFormat:@"%@,%@",self.sub_id,dic[@"id"]];
                
            }
        }
        
    }
    if ([self.programName isEqualToString:@""]) {
        UIAlertView *ale=[[UIAlertView alloc]initWithTitle:@"您暂无选项" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        ale.tag=2001;
        [ale show];
    }
    else {
            UIAlertView *ale=[[UIAlertView alloc]initWithTitle:@"您的选中的项目是" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: @"取消",nil];
           ale.tag=2000;
            [ale show];
    }
    
}
-(void)cancelAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
