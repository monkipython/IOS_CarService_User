//
//  ConfirmViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-10-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "ConfirmViewController.h"
#import "DicUploading.h"

@interface ConfirmViewController ()
@property (weak, nonatomic) IBOutlet UILabel *projectLabel;
@property (weak, nonatomic) IBOutlet UILabel *carType;
@property (weak, nonatomic) IBOutlet UILabel *area;
@property (weak, nonatomic) IBOutlet UILabel *arriveTime;
@property (weak, nonatomic) IBOutlet UITextView *detail;
@property (weak, nonatomic) IBOutlet UIButton *submit;

@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"需求详情";
    [self createView];
}
-(void)createView
{
    self.projectLabel.layer.cornerRadius = 4;
    self.carType.layer.cornerRadius = 4;
    self.area.layer.cornerRadius = 4;
    self.arriveTime.layer.cornerRadius = 4;
    self.detail.layer.cornerRadius = 5;
    self.submit.layer.cornerRadius = 4;
    
    self.projectLabel.text = [NSString stringWithFormat:@"项目:%@",self.projectString];
    self.carType.text = [NSString stringWithFormat:@"车型:%@", self.carTypeDic[@"brandName"]];
    self.area.text = [NSString stringWithFormat:@"区域:%@", self.areaDic[@"name"]];
    self.arriveTime.text = [NSString stringWithFormat:@"到店时间:%@", self.arriveString];
    self.detail.text = [NSString stringWithFormat:@"备注:%@", self.detailString];
    for(int i = 0;i<self.imageArray.count;i++)
    {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(15+i*75, 435, 60, 60)];
        image.image = self.imageArray[i];
        [self.view addSubview:image];
    }
}
- (IBAction)confirmAction:(id)sender {
    NSArray *list = [self.projectString componentsSeparatedByString:@","];
    NSArray *projectList = self.projectDic[@"data"][@"list"];
    NSMutableArray *serviceList=[[NSMutableArray alloc]init];
    for(NSString *string in list)
    {
        for(NSDictionary *dic in projectList)
        {
            NSString *simple = dic[@"name"];
            if([string isEqualToString:simple])
            {
                [serviceList addObject:dic[@"id"]];
            }
        }
    }
    //车辆ID
    NSString *carId = self.carTypeDic[@"car_id"];
    //区域ID
    NSString *areaId = self.areaDic[@"id"];
    NSString *member = [[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"];
    NSString *serviceString = [NSString string];
    for(int i = 0;i<=serviceList.count-1;i++)
    {
        if(i==0)
        {
            serviceString = serviceList[i];
        }
        if(i!=0)
        {
            NSString *sss = serviceList[i];
            serviceString = [NSString stringWithFormat:@"%@,%@",serviceString,sss];
            NSLog(@"服务%@",serviceString);
        }
        
    }
//    NSString *postStr = [NSString stringWithFormat:@"member_session_id=%@&title=%@&area_id=%@&reach_time=%@&latitude=24.0913&longitude=116.3232&category_ids=%@&desc=%@&cart_id=%@",member,self.projectString,areaId,self.arriveString,serviceString,self.detailString,carId];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:member forKey:@"member_session_id"];
    [dic setValue:self.projectString forKey:@"title"];
    [dic setValue:areaId forKey:@"area_id"];
    [dic setValue:self.arriveString forKey:@"reach_time"];
    [dic setValue:serviceString forKey:@"category_ids"];
    [dic setValue:self.detailString forKey:@"desc"];
    [dic setValue:carId forKey:@"cart_id"];
    [dic setValue:@"24.0913" forKey:@"latitude"];
    [dic setValue:@"116.3232" forKey:@"longitude"];
//    NSData *postData = [postStr dataUsingEncoding:4];
//    NSDictionary *dic = [NetWorking send:NECESSARY postBody:postData];
//    NSLog(@"%@",dic);
    [[DicUploading alloc]postRequestWithURL:NECESSARY postParems:dic picFilePath:(NSMutableArray *)self.imageFullPath picFileName:(NSMutableArray *)self.imageNames];
//    NSInteger i = [dic[@"code"] integerValue];
//    if(i==0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发布成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        alert.tag = 1000;
//        [alert show];
//    }else
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发布失败，请重新发布" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1000)
    {
        //发布成功
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
