//
//  OrderAlreadyViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14/11/1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "OrderAlreadyViewController.h"
#import "BusinessInfoViewController.h"

@interface OrderAlreadyViewController ()
@property (strong, nonatomic) IBOutlet UIView *footView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) NSDictionary *merchant_info;
@property (strong, nonatomic) NSDictionary *order_info;
@property (strong, nonatomic) NSDictionary *comment_info;
@property (weak, nonatomic) IBOutlet UILabel *merchantName;
@property (weak, nonatomic) IBOutlet UILabel *merchantIntroduce;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *merchantInfo;
@property (assign) int numOne;
@property (assign) int numTwo;
@property (assign) int numThree;
@end

@implementation OrderAlreadyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    [self getInfo];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyboard:)];
    [self.tableView addGestureRecognizer:tap];
    [self createView];
}
-(void)createView
{
    self.merchantInfo.layer.borderWidth = 1;
    self.merchantInfo.layer.borderColor = BLUECOLOR.CGColor;
    self.merchantInfo.layer.cornerRadius = 5;
}
-(void)getInfo
{
    NSString *member_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"];
    NSString *postString = [NSString stringWithFormat:@"member_session_id=%@&id=%@",member_id,self.order_id];
    NSData *postData = [postString dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:ORDER_DETAIL postBody:postData];
    if([dic[@"code"]integerValue]==0)
    {
        //获取商户信息
        self.merchant_info = [[NSDictionary alloc]initWithDictionary:dic[@"data"][@"merchant_info"]];
        //获取订单信息
        self.order_info = [[NSDictionary alloc]initWithDictionary:dic[@"data"][@"order_info"]];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *objectArr = self.order_info[@"servcie_list"];
    return objectArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"OrdersDetailsTableViewCellID";
    UINib *nib=[UINib nibWithNibName:@"OrdersDetailsTableViewCell" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:cellID];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSDictionary *dic = [[NSDictionary alloc]initWithDictionary:  self.order_info[@"servcie_list"][indexPath.row]];
    
    UITextField *project=(UITextField *)[cell viewWithTag:1000];
    project.text = dic[@"name"];
    
    UITextField *time=(UITextField *)[cell viewWithTag:1001];
    time.text = dic[@"timeout"];
    
    UITextField *price=(UITextField *)[cell viewWithTag:1002];
    price.text = dic[@"price"];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if([self.alreadyOrNot isEqualToString:@"YES"])
    {
        return 705;
    }else if([self.alreadyOrNot isEqualToString:@"NO"])
    {
        return 420;
    }
    return 500;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //总价格
    UITextField *price=(UITextField *)[self.footView viewWithTag:1002];
    price.text = self.order_info[@"total_price"];
    //总时间
    UITextField *time=(UITextField *)[self.footView viewWithTag:1001];
    time.text = self.order_info[@"total_time"];
    //用户备注
    UITextView *merchant_desc = (UITextView *)[self.footView viewWithTag:2000];
    merchant_desc.layer.cornerRadius = 5;
    merchant_desc.layer.borderWidth = .8;
    merchant_desc.text = self.order_info[@"member_remark"];
    //商户备注
    UITextView *user_desc = (UITextView *)[self.footView viewWithTag:3000];
    user_desc.layer.borderWidth = .8;
    user_desc.layer.cornerRadius = 5;
    user_desc.text = self.order_info[@"merchant_remark"];
    self.merchantName.text = self.merchant_info[@"merchant_name"];
    self.merchantIntroduce.text = self.merchant_info[@"intro"];
    //商家头像
    EGOImageView *header = (EGOImageView *)[self.footView viewWithTag:2345];
    header.placeholderImage = [UIImage imageNamed:@"头像"];
    header.layer.cornerRadius = 5;
    header.clipsToBounds = YES;
    header.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.merchant_info[@"header"]]];
    self.distance.text = @"ni cai ba ~";
    //判断是否已经完成（已完成就添加控件）
    if([self.alreadyOrNot isEqualToString:@"YES"])
    {
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 420, RECT.size.width, 30)];
        title.backgroundColor = BLUECOLOR;
        title.text = @"评价信息";
        title.textAlignment = NSTextAlignmentCenter;
        [self.footView addSubview:title];
        [self createStart];
        UITextView *commentView = [[UITextView alloc]initWithFrame:CGRectMake(10, 555, 300, 60)];
        commentView.delegate = self;
        commentView.tag = 9886;
        commentView.layer.cornerRadius = 5;
        commentView.layer.borderWidth = 1;
        //已经有评论了，显示评论内容
        if([self.order_info[@"member_comment"]integerValue]==1)
        {
            [commentView setEditable:NO];
            commentView.text= [NSString stringWithFormat:@"评论内容:%@", self.order_info[@"member_comment_info"][@"desc"]];
            commentView.textColor = [UIColor blackColor];
        }else
        {
            commentView.text = @"请输入评价内容";
            commentView.textColor = [UIColor grayColor];
        }
        
        [self.footView addSubview:commentView];
        
        UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        submit.frame = CGRectMake(90, 623, 140, 20);
        submit.backgroundColor = BLUECOLOR;
        submit.layer.cornerRadius = 3;
        [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [submit setTitle:@"提交评论" forState:UIControlStateNormal];
        [submit addTarget:self action:@selector(submitComment:) forControlEvents:UIControlEventTouchUpInside];
        //商家评论内容
        UITextView *merchant_comment = [[UITextView alloc]init];
        [merchant_comment setEditable:NO];
        [self.footView addSubview:merchant_comment];
        merchant_comment.layer.cornerRadius = 5;
        merchant_comment.layer.borderWidth = .8;
        if([self.order_info[@"member_comment"]integerValue]==0)
        {
            [self.footView addSubview:submit];
            merchant_comment.frame = CGRectMake(10, 650, 300, 50);
        }else
        {
            [submit setHidden:YES];
            merchant_comment.frame = CGRectMake(10, 628, 300, 50);
        }
        
        //商家有评论
        if([self.order_info[@"merchant_comment"]integerValue]==1)
        {
            merchant_comment.text = [NSString stringWithFormat:@"商户评价:%@",self.order_info[@"merchant_comment_info"][@"desc"]];
        }else
        {
            merchant_comment.textColor = [UIColor grayColor];
            merchant_comment.text = @"商户还没评论哦~亲!";
        }
    }
    return self.footView;
}
-(void)submitComment:(UIButton *)sender
{
    
    UITextView *content = (UITextView *)[self.footView viewWithTag:9886];
    if((self.numOne==0)|(self.numTwo==0)|(self.numThree==0))
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请给评个星呗~喵!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    else if([content.text isEqualToString:@"请输入评价内容"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入评价内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }else
    {
        NSString *member = [[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"];
        NSString *order_id = self.order_info[@"order_no"];
        NSString *merchant_id = self.merchant_info[@"id"];
        NSString *postString = [NSString stringWithFormat:@"member_session_id=%@&merchant_id=%@&order_no=%@&service_quality=%d&service_attitude=%d&merchant_setting=%d&content=%@",member,merchant_id,order_id,self.numTwo,self.numOne,self.numThree,content.text];
        NSData *postData = [postString dataUsingEncoding:4];
        NSDictionary *dic = [NetWorking send:COMMENT postBody:postData];
        if([dic[@"code"]intValue]==0)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"评论提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"请输入评价内容"])
    {
        textView.textColor = [UIColor blackColor];
        textView.text = @"";
    }

    [self viewAnimation:CGRectMake(0, -150, 320, 568)];
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@""])
    {
        textView.textColor = [UIColor grayColor];
        textView.text = @"请输入评价内容" ;
    }
}
-(void)chooseStartOne:(UITapGestureRecognizer *)sender
{
    UIView *view = (UIView *)[self.footView viewWithTag:1234];
    CGPoint point = [sender locationInView:view];
    UIScrollView *scroller = (UIScrollView *)[self.footView viewWithTag:1235];
    double a =  ((double)point.x/(double)view.frame.origin.x)*100/78;
    int num = a*100;
    if(num>=0&&num<=40)
    {
        self.numOne = 1;
    }else if(num>40&&num<=60)
    {
        self.numOne = 2;
    }else if(num>60&&num<=80)
    {
        self.numOne = 3;
    }else if (num>80&&num<=90)
    {
        self.numOne = 4;
    }else if(num>90&&num<=100)
    {
        self.numOne = 5;
    }
    scroller.frame = CGRectMake(140, 458, point.x, 20);
}
-(void)chooseStartTwo:(UITapGestureRecognizer *)sender
{
    UIView *view = (UIView *)[self.footView viewWithTag:1236];
    CGPoint point = [sender locationInView:view];
    UIScrollView *scroller = (UIScrollView *)[self.footView viewWithTag:1237];
    scroller.frame = CGRectMake(140, 490, point.x, 20);
    double a =  ((double)point.x/(double)view.frame.origin.x)*100/78;
    int num = a*100;
    if(num>=0&&num<=40)
    {
        self.numTwo = 1;
    }else if(num>40&&num<=60)
    {
        self.numTwo = 2;
    }else if(num>60&&num<=80)
    {
        self.numTwo = 3;
    }else if (num>80&&num<=90)
    {
        self.numTwo = 4;
    }else if(num>90&&num<=100)
    {
        self.numTwo = 5;
    }
}
-(void)chooseStartThree:(UITapGestureRecognizer *)sender
{
    UIView *view = (UIView *)[self.footView viewWithTag:1238];
    CGPoint point = [sender locationInView:view];
    UIScrollView *scroller = (UIScrollView *)[self.footView viewWithTag:1239];
    scroller.frame = CGRectMake(140, 522, point.x, 20);
    double a =  ((double)point.x/(double)view.frame.origin.x)*100/78;
    int num = a*100;
    if(num>=0&&num<=40)
    {
        self.numThree = 1;
    }else if(num>40&&num<=60)
    {
        self.numThree = 2;
    }else if(num>60&&num<=80)
    {
        self.numThree = 3;
    }else if (num>80&&num<=90)
    {
        self.numThree = 4;
    }else if(num>90&&num<=100)
    {
        self.numThree = 5;
    }
}
//星级评价内容
-(void)createStart
{
    UILabel *attitude = [[UILabel alloc]initWithFrame:CGRectMake(60, 460, 80, 15)];
    attitude.text = @"服务态度";
    [self.footView addSubview:attitude];
    //底层图片01
    UIImageView *bottomImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 20)];
    bottomImage.image = [UIImage imageNamed:@"五角星-实心"];
    UIScrollView *buttomView = [[UIScrollView alloc]initWithFrame:CGRectMake(140, 458, 0, 20)];
    buttomView.tag = 1235;
    buttomView.backgroundColor = [UIColor clearColor];
    [buttomView addSubview:bottomImage];
    [self.footView addSubview:buttomView];
    //上层图片01
    UIImageView *belowImage = [[UIImageView alloc]initWithFrame:CGRectMake(140, 458, 110, 20)];
    belowImage.image = [UIImage imageNamed:@"五角星-边框"];
    [self.footView addSubview:belowImage];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseStartOne:)];
    UIView *touchView= [[UIView alloc]initWithFrame:CGRectMake(140, 458, 110, 20)];
    touchView.tag = 1234;
    [touchView addGestureRecognizer:tap];
    [self.footView addSubview:touchView];
    //++++++++++-============-=========-=========+++++++++
    UILabel *quality = [[UILabel alloc]initWithFrame:CGRectMake(60, 492, 80, 15)];
    quality.text = @"服务质量";
    [self.footView addSubview:quality];
    //底层图片02
    UIImageView *bottomImage_2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 20)];
    bottomImage_2.image = [UIImage imageNamed:@"五角星-实心"];
    UIScrollView *buttomView_2 = [[UIScrollView alloc]initWithFrame:CGRectMake(140, 490, 0, 20)];
    buttomView_2.tag = 1237;
    buttomView_2.backgroundColor = [UIColor clearColor];
    [buttomView_2 addSubview:bottomImage_2];
    [self.footView addSubview:buttomView_2];
    //上层图片02
    UIImageView *belowImage_2 = [[UIImageView alloc]initWithFrame:CGRectMake(140, 490, 110, 20)];
    belowImage_2.image = [UIImage imageNamed:@"五角星-边框"];
    [self.footView addSubview:belowImage_2];
    UITapGestureRecognizer *tap_2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseStartTwo:)];
    UIView *touchView_2= [[UIView alloc]initWithFrame:CGRectMake(140, 490, 110, 20)];
    touchView_2.tag = 1236;
    [touchView_2 addGestureRecognizer:tap_2];
    [self.footView addSubview:touchView_2];
    //++++++++++-============-=========-=========+++++++++
    UILabel *setting = [[UILabel alloc]initWithFrame:CGRectMake(60, 524, 80, 15)];
    setting.text = @"设施设备";
    [self.footView addSubview:setting];
    //底层图片02
    UIImageView *bottomImage_3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 20)];
    bottomImage_3.image = [UIImage imageNamed:@"五角星-实心"];
    UIScrollView *buttomView_3 = [[UIScrollView alloc]initWithFrame:CGRectMake(140, 522, 0, 20)];
    buttomView_3.tag = 1239;
    buttomView_3.backgroundColor = [UIColor clearColor];
    [buttomView_3 addSubview:bottomImage_3];
    [self.footView addSubview:buttomView_3];
    //上层图片02
    UIImageView *belowImage_3 = [[UIImageView alloc]initWithFrame:CGRectMake(140, 522, 110, 20)];
    belowImage_3.image = [UIImage imageNamed:@"五角星-边框"];
    [self.footView addSubview:belowImage_3];
    UITapGestureRecognizer *tap_3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseStartThree:)];
    UIView *touchView_3= [[UIView alloc]initWithFrame:CGRectMake(140, 522, 110, 20)];
    touchView_3.tag = 1238;
    [touchView_3 addGestureRecognizer:tap_3];
    [self.footView addSubview:touchView_3];
    if([self.order_info[@"member_comment"]integerValue]==1)
    {
        [touchView setUserInteractionEnabled:NO];
        [touchView_2 setUserInteractionEnabled:NO];
        [touchView_3 setUserInteractionEnabled:NO];
        NSInteger quality = [self.order_info[@"member_comment_info"][@"service_quality"] integerValue];
        NSInteger attitude = [self.order_info[@"member_comment_info"][@"service_attitude"] integerValue];
        NSInteger setting = [self.order_info[@"member_comment_info"][@"merchant_setting"] integerValue];
        //显示星级
        buttomView.frame = CGRectMake(buttomView.frame.origin.x, buttomView.frame.origin.y, 140/5*attitude, buttomView.frame.size.height);
        buttomView_2.frame = CGRectMake(buttomView_2.frame.origin.x, buttomView_2.frame.origin.y, 140/5*quality, buttomView_2.frame.size.height);
        buttomView_3.frame = CGRectMake(buttomView_3.frame.origin.x, buttomView_3.frame.origin.y, 140/5*setting, buttomView_3.frame.size.height);
    }
}
-(IBAction)merchantDetail:(UIButton *)sender
{
    NSString *str = [NSString stringWithFormat:@"%@", self.merchant_info[@"id"]];
    CREATEVIEW(BusinessInfoViewController, infoVC, @"BusinessInfoView4_0", @"BusinessInfoView3_5");
    infoVC.merchantId = [[NSString alloc]initWithString:str];
    [self.navigationController pushViewController:infoVC animated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.tableView touchesBegan:touches withEvent:event];
    
}
-(void)hiddenKeyboard:(UITapGestureRecognizer *)sender
{
    UITextView *textView = (UITextView *)[self.footView viewWithTag:9886];
    [textView endEditing:YES];
    [self viewAnimation:CGRectMake(0, 0, 320, 568)];
}
-(void)viewAnimation:(CGRect)rect
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    self.view.frame = rect;
    [UIView commitAnimations];
}
@end
