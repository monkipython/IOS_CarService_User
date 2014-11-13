//
//  BDRRViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-4.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "BDRRViewController.h"

@interface BDRRViewController ()
@property (strong, nonatomic) IBOutlet UIView *smallView;
@property (weak, nonatomic) IBOutlet UITableView *ProjectTable;
@property (weak, nonatomic) IBOutlet UITableView *listTable;
@property (strong, nonatomic) NSMutableArray *superList;
@property (strong, nonatomic) NSMutableArray *beautyList;
@property (strong, nonatomic) NSMutableArray *decorList;
@property (strong, nonatomic) NSMutableArray *repairList;
@property (strong, nonatomic) NSMutableArray *refitList;
@property (strong, nonatomic) NSArray *subList;
@end
/**
 projectTable.tag = 1000;
 listTable.tag = 1001;
 */
@implementation BDRRViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark -
#pragma mark -视图界面
- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSLog(@"%@",self.projectList);
    [self serviceList];
    self.smallView.backgroundColor = GRAYCOLOR;
//    self.ProjectTable
    [self.smallView setHidden:YES];
    self.smallView.alpha = .1;
    self.smallView.frame = CGRectMake(0, 99, 320, RECT.size.height-80);
    self.ProjectTable.frame = CGRectMake(0, -200, 140, 200);
    self.listTable.frame = CGRectMake(140, -200, 180, 200);
    [self.view addSubview:self.smallView];
}
-(void)serviceList
{
    self.superList = [[NSMutableArray alloc]init];
    self.beautyList = [NSMutableArray array];
    self.decorList = [NSMutableArray array];
    self.repairList = [NSMutableArray array];
    self.refitList = [NSMutableArray array];
    NSArray *list = self.projectList[@"data"][@"list"];
    self.subList = [NSArray array];
    for(NSDictionary *dic in list)
    {
        if([dic[@"pid"] intValue]==0)
        {
            [self.superList addObject:dic];
        }
        if([dic[@"pid"] intValue]==1)
        {
            [self.beautyList addObject:dic];
        }
        if([dic[@"pid"] intValue]==2)
        {
            [self.decorList addObject:dic];
        }
        if([dic[@"pid"] intValue]==3)
        {
            [self.repairList addObject:dic];
        }
        if([dic[@"pid"] intValue]==4)
        {
            //改装
            [self.refitList addObject:dic];
        }
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellIdentifire";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    if(tableView.tag==1000)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.superList[indexPath.row][@"name"];
        NSLog(@"%@",self.superList[indexPath.row]);
    }else
    if(tableView.tag==1001)
    {
        cell.textLabel.text = self.subList[indexPath.row][@"name"];
//        cell.backgroundColor = [UIColor blueColor];
        cell.backgroundColor = WHITEGRAYCOLOR;
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==1000)
    {
        return self.superList.count;
    }else if(tableView.tag==1001)
    {
        return self.subList.count;
    }
    return 3;
}
-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
#pragma mark -功能区
//选择项目
- (IBAction)projectAction:(UIButton *)sender
{
    [self.smallView setHidden:NO];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
//    self.smallView.frame = CGRectMake(0, 99, 320, RECT.size.height-99);
    self.ProjectTable.frame = CGRectMake(0, 0, 140, 160);
    self.listTable.frame = CGRectMake(140, 0, 180, 160);
    self.smallView.alpha = .9;
//    [self.ProjectTable reloadData];
//    [self.listTable reloadData];
    [UIView commitAnimations];
}
- (IBAction)areaAction:(UIButton *)sender
{
    
}

- (IBAction)nearbyAction:(id)sender
{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.smallView setHidden:YES];
    self.smallView.alpha = .1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==1000)
    {
        if(indexPath.row==0)
        {
            self.subList = self.beautyList;
            [self.listTable reloadData];
        }
        if(indexPath.row==1)
        {
            self.subList = self.decorList;
            [self.listTable reloadData];
        }
        if(indexPath.row==2)
        {
            self.subList = self.repairList;
            [self.listTable reloadData];
        }
        if(indexPath.row==3)
        {
            self.subList = self.refitList;
            [self.listTable reloadData];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
