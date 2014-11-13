//
//  HeadViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "HeadViewController.h"
#import "ModifyNameViewController.h"
#import "ModifyPhoneViewController.h"
#import "DicUploading.h"
#import "EGOImageButton.h"

@interface HeadViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet EGOImageButton *headButton;
@property (weak, nonatomic) IBOutlet UIButton *quitButton;
@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
//调用相册
@property(nonatomic,strong)UIImagePickerController *picker;
@property(strong,nonatomic)NSMutableArray *imageDocumentUrl;
@property(strong,nonatomic)NSMutableArray *imageDocumentName;
@property(strong,nonatomic)NSMutableArray *imageArray;
@end
static BOOL nextView = NO;
@implementation HeadViewController
NSString *CCX_UPLOAD_IMG_PATH=@"";
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
    [self createView];
    
}

#pragma mark -加载视图
-(void)createView
{
    self.imageArray = [[NSMutableArray alloc]init];
    self.imageDocumentName = [[NSMutableArray alloc]init];
    self.imageDocumentUrl  = [[NSMutableArray alloc]init];
    self.view.backgroundColor = GRAYCOLOR;
    //设置圆角
    self.quitButton.layer.cornerRadius = 5;
    self.headButton.layer.cornerRadius = (RECT.size.width/4-20)/2;
    //取出倒角
    self.headButton.clipsToBounds = YES;
    [self setButtonValue];
}
-(void)setButtonValue
{
    [self.nameButton setTitle:self.infomation[@"data"][@"nick_name"] forState:UIControlStateNormal];
    
    [self.phoneButton setTitle:self.infomation[@"data"][@"mobile"] forState:UIControlStateNormal];
    
    [self.headButton setImageURL:[NSURL URLWithString:self.infomation[@"data"][@"header"]]];
}
- (IBAction)headAction:(UIButton *)sender {
    //初始化 UIActionSheet类
    UIActionSheet *actVC=[[UIActionSheet alloc]initWithTitle:@"请选则操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"照相机" otherButtonTitles:@"手机相册", nil];
    actVC.tag = 2000;
    //显示UIActionSheet框
    [actVC showInView:self.view];
}
#pragma mark UIActionSheet 代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==2000)
    {
        //创建相册类
        self.picker = [[UIImagePickerController alloc] init];
        //添加代理
        self.picker.delegate = self;
        //设置可编辑的开关
        self.picker.allowsEditing = YES;
        //判断点击选项进行对应的操作
        switch (buttonIndex) {
            case 0:
            {
                NSLog(@"照相机");
                //实现保护 单没有相机或者相机不可以时弹出警告
                if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                    //创建警告
                    UIAlertView *aleVC=[[UIAlertView alloc]initWithTitle:@"警告" message:@"无法调用相机，请检查你的设备" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    //开启警告
                    [aleVC show];
                }
                else
                {
                    //设置要调用的sourceType为相机模式
                    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    //调用相机
                    [self presentViewController:self.picker animated:YES completion:nil];
                };
            }
                
                break;
            case 1:
            {
                NSLog(@"手机相册");
                //设置要调用的sourceType为相机胶卷模式
                self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                
                
                //调用相机
                [self presentViewController:self.picker animated:YES completion:nil];
            }
                break;
        }
        
    }
}

#pragma mark 调用相册的delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo
{
    
    [self.headButton setImage:aImage forState:UIControlStateNormal];
    [picker dismissModalViewControllerAnimated:YES];
}

- (IBAction)quitAction:(UIButton *)sender {
    UIAlertView *aleVC = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你确定要退出当前账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    aleVC.tag=1000;
    [aleVC show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1000)
    {
        if (buttonIndex==1) {
            
            NSString *member = [[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"];
            NSString *postString = [NSString stringWithFormat: @"member_session_id=%@",member];
            NSData *postData = [postString dataUsingEncoding:4];
            NSDictionary *dic = [NetWorking send:LOGINOUT postBody:postData];
            NSLog(@"%@",dic);
            int result = [dic[@"code"]intValue];
            if(!result)
            {
                [[UIApplication sharedApplication] setStatusBarStyle:0];
                [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isLogin"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"tohome" object:self];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
        
    }
    
}
- (IBAction)nameAction:(UIButton *)sender {
    
    CREATEVIEW(ModifyNameViewController, modifyNameVC, @"ModifyNameView4_0", @"ModifyNameView3_5")
    modifyNameVC.title = @"修改名字";
    modifyNameVC.infomation = self.infomation;
//    nextView = YES;
    modifyNameVC.delegate = self;
    [self.navigationController pushViewController:modifyNameVC animated:YES];
}
- (IBAction)phoneAction:(UIButton *)sender {
    CREATEVIEW(ModifyPhoneViewController, modifyPhoneView, @"ModifyPhoneView4_0", @"ModifyPhoneView3_5")
    modifyPhoneView.title = @"更换电话号码";
    modifyPhoneView.phone = self.infomation[@"data"][@"nick_name"];
    [self.navigationController pushViewController:modifyPhoneView animated:YES];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)changStatus
{
    nextView=YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    if(nextView)
    {
        NSString *member_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"];
        NSString *postString = [NSString stringWithFormat:@"member_session_id=%@",member_id];
        NSData *postData = [postString dataUsingEncoding:4];
        NSDictionary *dic = [NetWorking send:GET_MEMBER postBody:postData];
        NSLog(@"%@",dic);
        self.infomation = [[NSDictionary alloc]initWithDictionary:dic];
        [self setButtonValue];
        nextView=NO;
    }
}

#pragma mark - 选择照片发送
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    //从箱册里拿到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *newImg=[self imageWithImageSimple:image scaledToSize:CGSizeMake(300, 300)];
    [self saveImage:newImg WithName:[NSString stringWithFormat:@"%@%@",[self generateUuidString],@".png"]];//generateUuidString生成随机图片名
    
    [self.imageArray addObject:image];//添加照片
    [self.headButton setImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    for (int i=0; i<self.imageArray.count; i++)
    {
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:1000+i];
        imageView.image = self.imageArray[i];
        UITextView *textView = (UITextView *)[self.view viewWithTag:2000+i];
        textView.text = self.imageDocumentUrl[i];
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
    CCX_UPLOAD_IMG_PATH=fullPathToFile;
    NSArray *nameAry=[CCX_UPLOAD_IMG_PATH componentsSeparatedByString:@"/"];
    [self.imageDocumentName addObject:[nameAry objectAtIndex:[nameAry count]-1]];//存放沙盒图片名称
    [imageData writeToFile:fullPathToFile atomically:NO];
    
    
    NSString *member_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"member_id"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:member_id,nil] forKeys:[NSArray arrayWithObjects:@"member_session_id",nil]];
    
    
    [[DicUploading alloc]postRequestWithURL:UPLOADHEADER postParems:dic picFilePath:self.imageDocumentUrl picFileName:self.imageDocumentName];
}

/*
 * 获取随机图片名称
 */
- (NSString *)generateUuidString
{
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    CFRelease(uuid);
    
    return uuidString;
}
@end
