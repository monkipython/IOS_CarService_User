//
//  NecessaryViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-9-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//
/*
 alert.tag = 3000
 alert.tag = 3001
 alert.tag = 3002
 actionSheet.tag==1001
 actionSheet.tag==1002
 
 图片tag为4000-4003
 */
#import "NecessaryViewController.h"
#import "SelectCarViewController.h"
#import "HGSTapGestureRecognizer.h"
#import "ConfirmViewController.h"
#import "DeleteProjectViewController.h"
#import "ChooseCarViewController.h"

@interface NecessaryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *projectItem;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITextView *biezhuTextView;
@property (weak, nonatomic) IBOutlet UIButton *beautyBtn;
@property (weak, nonatomic) IBOutlet UIButton *decorBtn;
@property (weak, nonatomic) IBOutlet UIButton *repairBtn;
@property (weak, nonatomic) IBOutlet UIButton *refitBtn;
@property (weak, nonatomic) IBOutlet UILabel *carType;
@property (weak, nonatomic) IBOutlet UILabel *area;
@property (strong, nonatomic) NSDictionary *areaDictionary;
@property (weak, nonatomic) IBOutlet UILabel *timeArrive;
@property (weak, nonatomic) IBOutlet UIButton *sendNecessary;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (strong,nonatomic) NSString *carDetails;
@property (strong, nonatomic) UIImageView *firstImage;
@property (assign) NSInteger imageTag;
@property (assign) CGRect rect;
@property (assign) CGRect addBtnRect;
@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property(strong,nonatomic)NSMutableArray *imageDocumentUrl;
@property(strong,nonatomic)NSMutableArray *imageDocumentName;
@property (strong, nonatomic) NSMutableArray *serviceList;
@property (strong, nonatomic) NSMutableString *serviceListString;
@property (assign) BOOL isChange;
@property (strong,nonatomic)NSString *category_ids;
@end

@implementation NecessaryViewController
NSString *CCX_UPLOAD_IMG_PATHS=@"";
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"发布需求";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.car_dic = [[NSDictionary alloc]init];
    [self creatView];
    [self addAction];
    self.imageDocumentName = [NSMutableArray array];
    self.imageDocumentUrl = [NSMutableArray array];
    self.imageArray = [NSMutableArray array];
    self.areaDictionary = [NSDictionary dictionary];
}

-(void)creatView
{
    self.projectItem.layer.borderWidth = .3;
    self.projectItem.backgroundColor = [UIColor whiteColor];
    self.projectItem.layer.cornerRadius = 4;
    self.carType.layer.borderWidth = .3;
    self.carType.backgroundColor = [UIColor whiteColor];
    self.carType.layer.cornerRadius = 4;
    self.area.layer.borderWidth = .3;
    self.area.backgroundColor = [UIColor whiteColor];
    self.area.layer.cornerRadius = 4;
    self.timeArrive.layer.borderWidth = .3;
    self.timeArrive.backgroundColor = [UIColor whiteColor];
    self.timeArrive.layer.cornerRadius = 4;
    self.beautyBtn.layer.cornerRadius = 4;
    self.decorBtn.layer.cornerRadius = 4;
    self.repairBtn.layer.cornerRadius = 4;
    self.refitBtn.layer.cornerRadius = 4;
    self.sendNecessary.layer.cornerRadius = 4;
    self.biezhuTextView.layer.borderWidth = .3;
    self.biezhuTextView.layer.cornerRadius = 4;
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.layer.borderWidth = .6;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 4005;
    btn.frame = CGRectMake(15, 433, 60, 60);
    UIImage *image = [UIImage imageNamed:@"添加2"];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getNewImage:) forControlEvents:UIControlEventTouchUpInside];
    self.addButton = btn;
    [self.mainView insertSubview:self.addButton belowSubview:self.pickView];

}
- (IBAction)addImageAction:(UIButton *)sender {
//    [self getNewImage:sender];
}

-(void)addAction
{
    //设置label为可交互
    [self.projectItem setUserInteractionEnabled:YES];
    [self.carType setUserInteractionEnabled:YES];
    [self.area setUserInteractionEnabled:YES];
    [self.timeArrive setUserInteractionEnabled:YES];
    
    //添加轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showitems:)];
    [self.projectItem addGestureRecognizer:tap];
    UITapGestureRecognizer *carTypeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(carType:)];
    [self.carType addGestureRecognizer:carTypeTap];
    UITapGestureRecognizer *areaTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(area:)];
    [self.area addGestureRecognizer:areaTap];
    UITapGestureRecognizer *timeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(time:)];
    [self.timeArrive addGestureRecognizer:timeTap];
}
#pragma mark - 
#pragma mark -显示所选项目
-(void)showitems:(UITapGestureRecognizer *)tapGes
{
    if([self.projectItem.text isEqualToString:@"请选择服务项目"])
    {
        CREATEVIEW(SelectProgramViewController, selectVC, @"SelectProgramView4_0", @"SelectProgramView3_5");
        selectVC.delegate = self;
        selectVC.isMultiselect = YES;
        selectVC.sub_id = self.category_ids;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:selectVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:self.projectItem.text delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"修改", nil];
        alert.tag = 3002;
        [alert show];
    }
}
#pragma mark -显示所选车型
-(void)carType:(UITapGestureRecognizer *)tapGes
{
    if([self.carType.text isEqualToString:@"请选择服务车型"])
    {
        //选择车型
        [self chooseCar];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您的爱车" message:self.carDetails delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"修改", nil];
        alert.tag = 3000;
        [alert show];
    }
}

#pragma mark -显示区域
-(void)area:(UITapGestureRecognizer *)tapGes
{
    NSString *pidString = [[NSUserDefaults standardUserDefaults]objectForKey:@"pid"];
    if(pidString.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先选择城市" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
    }else if([self.area.text isEqualToString:@"请选择服务区域"])
    {
        CityViewController *city = [[CityViewController alloc]init];
        city.delegateChoose = self;
        self.serviceDic = nil;
        [self.navigationController pushViewController:city animated:YES];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"更改区域" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag=3003;
        [alert show];
    }
}
-(void)ChooseCity:(NSDictionary *)dic
{
    //获得城市的字典，包含id
    self.areaDictionary = dic;
    self.area.text = dic[@"name"];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //车型
    if(alertView.tag==3000)
    {
        if(buttonIndex==1)
        {
            //选择修改按钮
            [self chooseCar];
        }
        
    }
    else if (alertView.tag==3001)
    {
        if(buttonIndex==1)
        {
            [self.pickView setHidden:NO];
            [self.sureBtn setHidden:NO];
        }
    }
    else if (alertView.tag == 3002)
    {
        if(buttonIndex==1)
        {
            CREATEVIEW(SelectProgramViewController, selectVC, @"SelectProgramView4_0", @"SelectProgramView3_5");
            selectVC.delegate = self;
            selectVC.isMultiselect = YES;
            selectVC.sub_id = self.category_ids;
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:selectVC];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
    else if(alertView.tag==3003)
    {
        
        if(buttonIndex==1)
        {
            CityViewController *city = [[CityViewController alloc]init];
            city.delegateChoose = self;
            [self.navigationController pushViewController:city animated:YES];
        }
    }
}
-(void)SelectCategoryName:(NSString *)categoryName andProgramNane:(NSString *)programName andSub_id:(NSString *)sub_id andClassid:(NSString *)classid
{
    self.category_ids = sub_id;
    self.projectItem.text = programName;
}
-(void)chooseProject:(NSString *)project
{
    NSLog(@"%@+__+++_",project);
    self.serviceListString = [[NSMutableString alloc]initWithString:project];
    self.projectItem.text = project;
}
#pragma mark -显示到店时间
-(void)time:(UITapGestureRecognizer *)tapGes
{
    if([self.timeArrive.text isEqualToString:@"请选择到店日期"])
    {
        [self.pickView setHidden:NO];
        [self.sureBtn setHidden:NO];
    }else
    {
        UIAlertView *alert = [self getNewAlert:@"提示" andMessage:self.timeArrive.text andCancle:@"确认" andOther:@"修改"];
        alert.tag = 3001;
        [alert show];
    }
}
#pragma mark -确认时间
- (IBAction)sureAction:(UIButton *)sender
{
    [self.pickView setHidden:YES];
    [sender setHidden:YES];
    NSDate *date = [[NSDate alloc]initWithTimeInterval:+28800 sinceDate:self.pickView.date];
    NSString *arriveString = [NSString stringWithFormat:@"%@",date];
    NSRange rang = {5,11};
    NSString *subString = [arriveString substringWithRange:rang];
    NSInteger arriveTime = [self getWeekly:date];
    NSString *sunday = @"  星期天";
    NSString *monday = @"  星期一";
    NSString *Tuesday = @"  星期二";
    NSString *Wednesday = @"  星期三";
    NSString *Thursday = @"  星期四";
    NSString *Friday = @"  星期五";
    NSString *Saturday = @"  星期六";
    switch (arriveTime) {
        case 1:
            self.timeArrive.text = [subString stringByAppendingString:sunday];
            break;
        case 2:
            self.timeArrive.text = [subString stringByAppendingString:monday];
            break;
        case 3:
            self.timeArrive.text = [subString stringByAppendingString:Tuesday];
            break;
        case 4:
            self.timeArrive.text = [subString stringByAppendingString:Wednesday];
            break;
        case 5:
            self.timeArrive.text = [subString stringByAppendingString:Thursday];
            break;
        case 6:
            self.timeArrive.text = [subString stringByAppendingString:Friday];
            break;
        case 7:
            self.timeArrive.text = [subString stringByAppendingString:Saturday];
            break;
        default:
            break;
    }
}
-(void)sendCarName:(NSString *)carName andDetails:(NSString *)carDetails
{
    NSLog(@"%@",carDetails);
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    self.mainView.frame = CGRectMake(0, -110, 320, RECT.size.height);
    [UIView commitAnimations];
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    self.mainView.frame = CGRectMake(0, 0, 320, RECT.size.height);
    [UIView commitAnimations];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.biezhuTextView endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -美容方法
- (IBAction)beautyBtn:(UIButton *)sender
{
    
}
#pragma mark -选择车型
-(void)chooseCar
{
    ChooseCarViewController *chooseVC = [[ChooseCarViewController alloc]init];
    chooseVC.necessary = self;
    self.serviceDic = nil;
    [self.navigationController pushViewController:chooseVC animated:YES];
    
    
}
#pragma mark -actionSheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //改，查，删
    if(actionSheet.tag==1001)
    {
        if(buttonIndex==0)
        {
            [self getNewImage:nil];
            self.isChange = YES;
        }else if(buttonIndex==1)
        {
            [self showImage];
        }else if (buttonIndex==2)
        {
            [self removeImage:self.imageTag];
        }
    }//添加图片按钮
    else if (actionSheet.tag==1002)
    {
        
//        self.addBtnRect =
        if(buttonIndex==0)
        {
            [self getImageByalbum];
        }else if (buttonIndex==1)
        {
            //实现保护 单没有相机或者相机不可以时弹出警告
            if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
            {
                //创建警告
                UIAlertView *aleVC=[[UIAlertView alloc]initWithTitle:@"警告" message:@"无法调用相机，请检查你的设备" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                //开启警告
                [aleVC show];
            }else
            {
                [self getIMageByCamera];
            }
        }else if (buttonIndex==2)
        {
            [actionSheet setHidden:YES];
        }
    }
}
#pragma mark -改变图片
-(void)changeImageF:(UIButton *)sender
{
    ShowImage *show = [[ShowImage alloc]init];
    show.imageArray = self.imageArray;
    show.index = sender.tag%4000;
    [self presentViewController:show animated:YES completion:nil];
}
#pragma mark -移除照片
-(void)removeImage:(NSInteger)index
{

}
#pragma mark -选择获取照片的方式
-(void)getNewImage:(UIButton *)sender
{
    self.addBtnRect = sender.frame;
    UIActionSheet *changeImage = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"摄像机", nil];
        changeImage.tag = 1002;
    [changeImage showInView:self.view];
}
-(void)getImageByalbum
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)getIMageByCamera
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    //开启可编辑模式
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)showImage
{

}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *original = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.imageArray addObject:original];
    UIImage *newImg=[self imageWithImageSimple:original scaledToSize:CGSizeMake(300, 300)];
    
    [self saveImage:newImg WithName:[NSString stringWithFormat:@"%d",abs(arc4random())]];
    if(picker.sourceType==UIImagePickerControllerSourceTypeCamera)
    {
        //保存图片
        UIImageWriteToSavedPhotosAlbum(original, self, nil, nil);
//        self
    }
    //模态方式退出uiimagepickercontroller
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)addImage:(NSMutableArray *)array
{
    for(UIView *obj in self.mainView.subviews)
    {
        if(obj.tag>=4000&&obj.tag<4004)
        {
            [obj removeFromSuperview];
        }
    }
    if(array.count==0)
    {
        self.addButton.frame = CGRectMake(15, 430, 65, 65);
    }else
    {
        float temp = 0;
    
        for(int i = 0;i<array.count;i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(15+i*75, 433, 60, 60);
            UIImage *image = array[i];
            btn.tag = 4000 + i;
            [btn setImage:image forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(changeImageF:) forControlEvents:UIControlEventTouchUpInside];
            [self.mainView insertSubview:btn belowSubview:self.pickView];
            temp = btn.frame.origin.x;
        }
        //每次都右移一格
        self.addButton.frame = CGRectMake(temp+80, self.addBtnRect.origin.y, self.addBtnRect.size.width, self.addBtnRect.size.height);
    }
}
/*
 * 压缩图片
 */
-(UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize{
    newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}
/*
 * 获取本地图片
 */
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // 获得图片路径
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [self.imageDocumentUrl addObject:fullPathToFile];//存放沙盒图片路径。。。。
    // 读取路径中的图片
    CCX_UPLOAD_IMG_PATHS=fullPathToFile;
    NSArray *nameAry=[CCX_UPLOAD_IMG_PATHS componentsSeparatedByString:@"/"];
    [self.imageDocumentName addObject:[nameAry objectAtIndex:[nameAry count]-1]];//存放沙盒图片名称
    [imageData writeToFile:fullPathToFile atomically:NO];
//    
//    NSString *member_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"];
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:member_id,nil] forKeys:[NSArray arrayWithObjects:@"member_session_id",nil]];
//    
//    
//    [[DicUploading alloc]postRequestWithURL:UPLOADHEADER postParems:dic picFilePath:self.imageDocumentUrl picFileName:self.imageDocumentName];
}
-(void)hidenView:(UIButton *)sender
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:self.imageTag];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    btn.frame = self.rect;
    [UIView commitAnimations];
    [sender removeFromSuperview];
}
#pragma mark -获取星期几
-(NSInteger)getWeekly:(NSDate *)date
{
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents* components = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitWeekday |NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
    components = [calendar components:unitFlags fromDate:date];
    NSUInteger weekday = [components weekday];
    
    return weekday;
}
-(void)viewWillAppear:(BOOL)animated
{
    //车辆数据
    NSString *str = self.car_dic[@"brandName"];
    self.carDetails = [NSString stringWithFormat:@"%@%@",self.car_dic[@"modelName"],self.car_dic[@"detailsName"]];
    if(str.length>0)
    {
        self.carType.text = str;
    }
    [self addImage:self.imageArray];
    //判断是否有重复的项目标示
    NSInteger have = 0;
    NSString *service = self.serviceDic[@"name"];
    //选择项目回传数据
    if(service.length==0)
    {
        
    }else if(service.length>0)
    {
        if([self.projectItem.text isEqualToString:@"请选择服务项目"])
        {
            //表示无项目
            self.projectItem.text = service;
        }
        else
        {
            //表示有项目
            NSArray *arr = [self.projectItem.text componentsSeparatedByString:@","];
            NSLog(@"%@",arr);
            if(arr.count==0)
            {
                if([self.projectItem.text isEqualToString:service])
                {
                }
                else
                {
                    self.serviceListString = [[NSMutableString alloc]initWithFormat:@"%@,%@",self.projectItem.text,service];
                    self.projectItem.text = self.serviceListString;
                }
            }else
            {
            for(NSString *project in arr)
            {
                if([project isEqualToString:service])
                {
                    have++;
                }
            }
                if(have==0)
                {
                    self.serviceListString = [[NSMutableString alloc]initWithFormat:@"%@,%@",self.projectItem.text,service];
                    self.projectItem.text = self.serviceListString;
                }
            }
        }
    }
    else if(self.serviceListString.length==0)
    {
        self.projectItem.text=@"请选择服务项目";
    }
    else
    {
        self.projectItem.text = self.serviceListString;
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    
}
-(UIAlertView *)getNewAlert:(NSString *)title andMessage:(NSString *)message andCancle:(NSString *)cancle andOther:(NSString *)other
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:cancle otherButtonTitles:other, nil];
    return alert;
}
- (IBAction)submitAction:(UIButton *)sender {
    if(([self.carType.text isEqualToString:@"请选择服务车型"])||([self.projectItem.text isEqualToString:@"请选择服务项目"])||([self.area.text isEqualToString:@"请选择服务区域"])||([self.timeArrive.text isEqualToString:@"请选择到店日期"]))
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请认真填写信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else
    {
        CREATEVIEW(ConfirmViewController, confirmVC, @"ConfirmView4_0", @"ConfirmView3_5");
        confirmVC.areaDic = self.areaDictionary;
        confirmVC.carTypeDic = self.car_dic;
        confirmVC.projectString = self.projectItem.text;
        confirmVC.projectDic = self.projectList;
        confirmVC.arriveString = self.timeArrive.text;
        confirmVC.detailString = self.biezhuTextView.text;
        confirmVC.imageArray = self.imageArray;
        confirmVC.imageFullPath = self.imageDocumentUrl;
        confirmVC.imageNames = self.imageDocumentName;
        NSLog(@"%@",self.imageArray);
        [self.navigationController pushViewController:confirmVC animated:YES];
    }
}
@end

#pragma mark -
#pragma mark -城市列表
#import "NecessaryModel.h"
@interface CityViewController()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *cityArray;

@end

@implementation CityViewController
-(void)viewDidLoad
{
    [self createView];
    self.cityArray = [[NecessaryModel alloc]chooseArea];
}
-(void)createView
{
    self.title = @"选择区域";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, RECT.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSDictionary *dic = self.cityArray[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cityArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegateChoose ChooseCity:self.cityArray[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}
@end

#pragma mark -
#pragma mark -显示图片

@interface ShowImage ()
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation ShowImage

-(void)viewDidLoad
{
    [self createView];
}
-(void)createView
{
    self.view.backgroundColor = [UIColor blackColor];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 120, RECT.size.width, RECT.size.width)];
    self.scrollView.contentSize = CGSizeMake(320*self.imageArray.count, RECT.size.width);
    for(int i = 0;i<self.imageArray.count;i++)
    {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, RECT.size.width, RECT.size.width)];
        imageV.tag = 700+i;
        imageV.image = self.imageArray[i];
        [self.scrollView addSubview:imageV];
    }
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    self.scrollView.contentOffset = CGPointMake(320*self.index, 0);
    
    UIButton *deleeteBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [deleeteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleeteBtn.layer.borderColor = [UIColor redColor].CGColor;
    deleeteBtn.layer.borderWidth = .7;
    deleeteBtn.layer.cornerRadius = 4;
    [deleeteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    deleeteBtn.frame = CGRectMake(30, RECT.size.height-60, 100, 30);
    [deleeteBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleeteBtn];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = 4;
    backBtn.layer.borderWidth = .7;
    backBtn.layer.borderColor = BLUECOLOR.CGColor;
    backBtn.frame = CGRectMake(190, RECT.size.height-60, 100, 30);
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:backBtn];
    
}
-(void)deleteImage:(UIButton *)sender
{
    if(self.imageArray.count==1)
    {
        [self.imageArray removeAllObjects];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        int i = (int)self.scrollView.contentOffset.x;
        int temp = i/320;
        [self.imageArray removeObjectAtIndex:temp];
        //将原来的全部删除
        for(UIView *obj in self.scrollView.subviews)
        {
            int x = 0;
            if(obj.tag==600+x)
            {
                [obj removeFromSuperview];
            }
        }
        self.scrollView.contentSize = CGSizeMake(320*self.imageArray.count, RECT.size.width);
        //添加新的数组
        for(int i = 0;i<self.imageArray.count;i++)
        {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, RECT.size.width)];
            imageV.image = self.imageArray[i];
            [self.scrollView addSubview:imageV];
        }
        //移动视图
        if(temp>0)
        {
        self.scrollView.contentOffset = CGPointMake(temp-1*320, 0);
        }else
        {
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }
    }
}
-(void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}
@end