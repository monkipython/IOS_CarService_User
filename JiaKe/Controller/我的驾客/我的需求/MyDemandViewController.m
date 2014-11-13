//
//  MyDemandViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-10-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "MyDemandViewController.h"
#import "OrdersDetailsViewController.h"
#import "QuoteUndoneViewController.h"

@interface MyDemandViewController ()
@property (weak, nonatomic) IBOutlet UIButton *quoteAlready;
@property (weak, nonatomic) IBOutlet UIButton *quoteUndone;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *quoteUnDoneTableView;

@property (strong,nonatomic) NSMutableArray *isSectionArray;
@property (assign,nonatomic) BOOL isQuoteUndone;
@property (strong,nonatomic) NSString *titleSting;
//已报价
@property (strong, nonatomic) NSArray *quotation;
//未报价
@property (strong, nonatomic) NSArray *quotation_no;
@end
BOOL isRegister;
//static NSInteger isSection;
//static BOOL isNumberOne;
static NSIndexPath *isIndexPath;
//static NSInteger toTheNextView;
@implementation MyDemandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self getInfo];
}
-(void)getInfo
{
    //已报价
    NSString *member = [[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"];
    NSString *str_al = [NSString stringWithFormat:@"member_session_id=%@&type=1&latitude=24.0913&longitude=116.3232",member];
    NSData *data = [str_al dataUsingEncoding:4];
    NSDictionary *dic_alredy = [NetWorking send:NECESSARY_LIST postBody:data];
    if([dic_alredy[@"code"] integerValue]==1)
    {
        self.quotation = [[NSArray alloc]init];
    }else
    {
        NSArray *arr = dic_alredy[@"data"][@"list"];
        self.quotation = arr;
    }
    //未报价
    NSString *str_no = [NSString stringWithFormat:@"member_session_id=%@&type=2&latitude=24.0913&longitude=116.3232",member];
    NSData *data_no = [str_no dataUsingEncoding:4];
    NSDictionary *dic_no = [NetWorking send:NECESSARY_LIST postBody:data_no];
    if([dic_no[@"code"]integerValue]==1)
    {
        self.quotation_no = [[NSArray alloc]init];
    }else
    {
        NSArray *arr_no = dic_no[@"data"][@"list"];
        self.quotation_no = [[NSArray alloc]initWithArray:arr_no];
    }
}
#pragma mark -加载视图
-(void)createView
{
    self.view.backgroundColor = GRAYCOLOR;
    
    self.quoteAlready.layer.cornerRadius = 5;
    self.quoteUndone.layer.cornerRadius = 5;
    self.quoteAlready.backgroundColor = BLUECOLOR;
    self.quoteUndone.backgroundColor =  [UIColor clearColor];
    self.quoteAlready.tintColor = [UIColor whiteColor];
    self.quoteUndone.tintColor = [UIColor blackColor];

}
-(void)viewWillAppear:(BOOL)animated
{
    
}
- (IBAction)quoteAlreadyAction:(UIButton *)sender
{
    [self.tableView setHidden:NO];
    [self.quoteUnDoneTableView setHidden:YES];
    self.quoteAlready.backgroundColor = BLUECOLOR;
    self.quoteUndone.backgroundColor =  [UIColor clearColor];
    self.quoteAlready.tintColor = [UIColor whiteColor];
    self.quoteUndone.tintColor = [UIColor blackColor];
    
}
- (IBAction)quoteUndoneAction:(UIButton *)sender
{
    [self.tableView setHidden:YES];
    [self.quoteUnDoneTableView setHidden:NO];
    self.quoteUndone.backgroundColor = BLUECOLOR;
    self.quoteAlready.backgroundColor =  [UIColor clearColor];
    self.quoteUndone.tintColor = [UIColor whiteColor];
    self.quoteAlready.tintColor = [UIColor blackColor];
}
#pragma mark -tabieView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView.tag==3333)
    {
//        if(self.quotation.count==0)
//        {
//            return 0;
//        }else
//        {
            return self.quotation.count;
//        }
    }else if(tableView.tag==4444)
    {
        return 1;
    }
    return 1;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //已报价
    if(tableView.tag==3333)
    {
        NSDictionary *dic = self.quotation[section];
        NSArray *array = dic[@"child"];
        return array.count;
    }
    //未报价
    else if(tableView.tag==4444)
    {
        return self.quotation_no.count;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==3333)
    {
        NSString *cellId = @"cellIdentifire";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell)
        {
            NSDictionary *dic = self.quotation[indexPath.section];
            NSArray *merchantInfo = dic[@"child"];
            //商户信息
            NSDictionary *infoDetail = merchantInfo[indexPath.row];
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            //头像
            EGOImageView *headImage = [[EGOImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 60)];
            headImage.layer.cornerRadius = 5;
            headImage.placeholderImage = [UIImage imageNamed:@"头像"];
            headImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",infoDetail[@"header"]]];
            [cell.contentView addSubview:headImage];
            //商家名
            UILabel *merchantName = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 150, 20)];
            merchantName.font = [UIFont systemFontOfSize:14.f];
            merchantName.text = infoDetail[@"merchant_name"];
            [cell.contentView addSubview:merchantName];
            //距离
            UILabel *distance = [[UILabel alloc]initWithFrame:CGRectMake(70, 45, 150, 20)];
            distance.font = [UIFont systemFontOfSize:14.f];
            NSString *str = [NSString stringWithFormat:@"%@m",infoDetail[@"distance"]];
            distance.text = str;
            [cell.contentView addSubview:distance];
            //总计
            UILabel *total_price = [[UILabel alloc]initWithFrame:CGRectMake(190, cell.frame.size.height/2, 90, 20)];
            total_price.font = [UIFont systemFontOfSize:13.5f];
            total_price.textColor = [UIColor redColor];
            total_price.text = infoDetail[@"total_price"];
            [cell.contentView addSubview:total_price];
            
        }
        return cell;
    }else
    {
        NSString *cell_ID = @"cellIDEN";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_ID];
        if(!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_ID];
            
            NSDictionary *userDic = self.quotation_no[indexPath.row];
            NSString *title = userDic[@"title"];
            NSString *addTime = userDic[@"addtime"];
            
            UILabel *title_lab = [[UILabel alloc]initWithFrame:CGRectMake(5, 15, 150, 25)];
            title_lab.text = title;
            [cell.contentView addSubview:title_lab];
            
            UILabel *addTime_lab = [[UILabel alloc]initWithFrame:CGRectMake(200, 15, 100, 25)];
            addTime_lab.text = addTime;
            [cell.contentView addSubview:addTime_lab];
        }
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==3333)
    {
        CREATEVIEW(OrdersDetailsViewController, ordersDetailsVC, @"OrdersDetailsView4_0", @"OrdersDetailsView3_5")
        ordersDetailsVC.iscompleted = NO;
        ordersDetailsVC.isOrders = NO;
        NSDictionary *dic = self.quotation[indexPath.section];
        NSArray *merchantInfo = dic[@"child"];
        //商户信息
        NSDictionary *infoDetail = merchantInfo[indexPath.row];
        NSString *id_str = [NSString stringWithFormat:@"%@", dic[@"id"]];
        NSString *id_merchant = [NSString stringWithFormat:@"%@",infoDetail[@"id"]];
        NSString *member = [[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"];
        NSString *postString = [NSString stringWithFormat:@"member_session_id=%@&id=%@&latitude=24.0913&longitude=116.3232&merchant_id=%@",member,id_str,id_merchant];
        NSData *postData = [postString dataUsingEncoding:4];
        NSDictionary *dic_return = [NetWorking send:DEMAND_DETAIL postBody:postData];
        //数据返回成功进入视图u
        if([dic_return[@"code"]intValue]==0)
        {
            ordersDetailsVC.merchantID = [[NSString alloc]initWithString:id_merchant];
            ordersDetailsVC.necessaryID = [[NSString alloc]initWithString:id_str];
            ordersDetailsVC.projectInfo = [[NSDictionary alloc]initWithDictionary:dic_return];
            [self.navigationController pushViewController:ordersDetailsVC animated:YES];
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }else if(tableView.tag==4444)
    {
        CREATEVIEW(QuoteUndoneViewController, quoteUndoneVC, @"QuoteUndoneView4_0", @"QuoteUndoneView3_5");
        quoteUndoneVC.title = self.titleSting;
        NSDictionary *dic = self.quotation_no[indexPath.row];
        NSLog(@"%@",dic);
        NSString *necessary_id = dic[@"id"];
        quoteUndoneVC.necessaryId = [NSString stringWithString:necessary_id];
        [self.navigationController pushViewController:quoteUndoneVC animated:YES];
    }
        
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView.tag==3333)
    {
        return 44;
    }
    if(tableView.tag==4444)
    {
        return 1;
    }
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView.tag==3333)
    {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        UILabel *project = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 150, 34)];
        //获取数据
        NSDictionary *dic = self.quotation[section];
        NSString *title = dic[@"title"];
        project.text = [NSString stringWithFormat:@"项目:%@",title];
        project.textColor = BLUECOLOR;
        project.font = [UIFont systemFontOfSize:14];
        UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(165, 5, 150, 34)];
        NSString *addtime = dic[@"addtime"];
        
        NSRange range = {5,11};
        addtime = [addtime substringWithRange:range];
        time.text = [NSString stringWithFormat:@"添加时间:%@",addtime];
        time.font = [UIFont systemFontOfSize:14];
        UIButton *headerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        headerButton.tag = 5000+section;
        [headerButton addTarget:self action:@selector(headerAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:project];
        [headerView addSubview:time];
        [headerView addSubview:headerButton];
        headerView.backgroundColor =[UIColor whiteColor];
        return headerView;
    }
        return nil;
    
}
-(void)headerAction:(UIButton *)sender
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
