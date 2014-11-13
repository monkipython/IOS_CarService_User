//
//  MyCollectViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "MyCollectViewController.h"
#import "MyCollectModel.h"
@interface MyCollectViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableVC;
@property(strong,nonatomic)NSArray *myColletArray;

@end
BOOL isRegister;
@implementation MyCollectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.myColletArray = [MyCollectModel mycollectArray];
    isRegister=NO;
}
#pragma mark -加载视图
-(void)createView
{
    
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
    return self.myColletArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"MyCollectCell";
    //    static BOOL isRegister=NO;
    if (!isRegister) {
        UINib *nib=[UINib nibWithNibName:@"MyCollectCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:cellID];
        isRegister=YES;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UILabel *shopName = (UILabel *)[cell viewWithTag:1000];
    shopName.text = @"xxx美容店";
    UILabel *region = (UILabel *)[cell viewWithTag:1001];
    region.text = @"思明区";
    UILabel *project = (UILabel *)[cell viewWithTag:1002];
    project.text = @"洗车，洗车，洗车，洗车";
    UILabel *distance = (UILabel *)[cell viewWithTag:1003];
    distance.text = [NSString stringWithFormat:@"13km"];
    UIImageView *head = (UIImageView *)[cell viewWithTag:2000];
    head.image = [UIImage imageNamed:@"人像"];
    head.layer.cornerRadius = 5;
    head.clipsToBounds = YES;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
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
