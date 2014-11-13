//
//  QuoteUndoneViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-10-2.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "QuoteUndoneViewController.h"
#import "ChangePosition.h"

@interface QuoteUndoneViewController ()
@property (weak, nonatomic) IBOutlet UILabel *projectLabel;
@property (weak, nonatomic) IBOutlet UILabel *carModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timrLabel;
@property (weak, nonatomic) IBOutlet UITextView *remarksTextView;
@property (weak, nonatomic) IBOutlet UIButton *imageButton1;
@property (weak, nonatomic) IBOutlet UIButton *imageButton2;
@property (weak, nonatomic) IBOutlet UIButton *imageButton3;
@property (weak, nonatomic) IBOutlet UIButton *imageButton4;

//设置创建UIScrollView  查看相片
@property (strong,nonatomic)UIScrollView    *scrollView;
//存储相片
@property (strong,nonatomic)NSMutableArray *imageArray;
//显示张数
@property(strong,nonatomic)UILabel *numberLabel;

@end
//识别相片的位置
static NSInteger isNumber;
//识别是否放大
static BOOL isSwitch;

CGFloat offset;

//存储起始位置高度  用于回收
CGFloat origin_y;



@implementation QuoteUndoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}
-(void)viewDidAppear:(BOOL)animated
{
    NSString *postString = [NSString stringWithFormat:@"id=%@",self.necessaryId];
    NSData *data = [postString dataUsingEncoding:4];
    NSDictionary *dic = [NetWorking send:DEMAND_DETAIL postBody:data];
    if([dic[@"code"]intValue]==0)
    {
        NSDictionary *info = dic[@"data"];
        self.projectLabel.text = info[@"title"];
        NSString *carmodel = info[@"cart_model"];
        NSArray *car = [carmodel componentsSeparatedByString:@","];
        NSString *carStr = [NSString stringWithFormat:@"%@%@",car[1],car[2]];
        self.carModelLabel.text = carStr;
        self.regionLabel.text = info[@"area_id"];
        self.timrLabel.text = info[@"reach_time"];
        self.remarksTextView.text = info[@"desc"];
    }
}
#pragma mark -加载视图
-(void)createView
{
    self.title = @"需求详情";
    self.projectLabel.layer.cornerRadius = 5;
    self.projectLabel.layer.borderWidth = 1;
    self.carModelLabel.layer.cornerRadius = 5;
    self.carModelLabel.layer.borderWidth = 1;
    self.regionLabel.layer.cornerRadius = 5;
    self.regionLabel.layer.borderWidth = 1;
    self.timrLabel.layer.cornerRadius = 5;
    self.timrLabel.layer.borderWidth = 1;
    self.remarksTextView.layer.cornerRadius = 5;
    self.remarksTextView.layer.borderWidth = 1;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_login"]]];
    
    //将相片放入数组
    self.imageArray = [[NSMutableArray alloc]init];
    UIImage *image1 =[UIImage imageNamed:@"mm2.jpg"];
    UIImage *image2 =[UIImage imageNamed:@"mm1.jpg"];
    UIImage *image3 =[UIImage imageNamed:@"mm3.jpg"];
    [self.imageArray addObject:image1];
    [self.imageArray addObject:image2];
    [self.imageArray addObject:image3];
    [self.imageArray addObject:image1];
}
- (IBAction)imageButton:(UIButton *)sender
{
    //存储高度
    origin_y = sender.frame.origin.y;
    //存储位置识别
    isNumber = sender.tag-1000;
    //设置显示当前图片号
    self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(110.0/320*RECT.size.width, RECT.size.height-40, 100.0/320*RECT.size.width, 30)];
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.textAlignment = 1;
    self.numberLabel.text =[NSString stringWithFormat:@"%ld/%ld",(long)isNumber+1,(unsigned long)self.imageArray.count];
   
    
    //创建主UIScrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:sender.frame];
    //初始化主主UIScrollView
    [self creation];
    //移至所选中的图片位置
    [self.scrollView setContentOffset:CGPointMake(RECT.size.width*isNumber,0) animated:NO];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.numberLabel];
    //放大到
    [ChangePosition addAnimation:self.scrollView andDuration:0.5 andDelay:0 andRect:CGRectMake(0, 0 ,RECT.size.width,RECT.size.height)];
    //设置延迟删除视图
    [self performSelector:@selector(hideNavigationController) withObject:self afterDelay:0.4];
    
}
-(void)hideNavigationController
{
    [self.navigationController.navigationBar setHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
}
#pragma mark -初始化 UIScrollView
-(void)creation
{
    offset = 0.0;
    //创建UIScrollView  在主UIScrollView中创建子UIScrollView  并在子UIScrollView中添加imageView 同时添加方法
    for ( int i=0; i<self.imageArray.count; i++) {
        //创建子UIScrollView
        UIScrollView *screllView =[[UIScrollView alloc]initWithFrame:CGRectMake(RECT.size.width*i, 64, RECT.size.width, RECT.size.height-124)];
        screllView.tag =2000+i;
        screllView.backgroundColor = [UIColor clearColor];
        
        screllView.contentSize = CGSizeMake(RECT.size.width, RECT.size.height-124);
        screllView.showsHorizontalScrollIndicator = NO;
        screllView.showsVerticalScrollIndicator = NO;
        screllView.delegate = self;
        //最小比例缩放
        screllView.minimumZoomScale = 1.0;
        //最大比例缩放
        screllView.maximumZoomScale = 2.0;
        //当前缩放
        [screllView setZoomScale:1.0];
        [self.scrollView addSubview:screllView];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 0, RECT.size.width-10, RECT.size.height-124)];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        imageView.userInteractionEnabled = YES;
        imageView.image=self.imageArray[i];
        imageView.tag = 1000+i;
        [screllView addSubview:imageView];
        
        
        //添加单击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch:)];
        tap.numberOfTapsRequired=1;
        tap.numberOfTouchesRequired=1;
        [imageView addGestureRecognizer:tap];
        
        //添加双击手势
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTouch:)];
        doubleTap.numberOfTapsRequired = 2;
        doubleTap.numberOfTouchesRequired = 1;
        [imageView addGestureRecognizer:doubleTap];
        
        //用于识别单击 和 双击
        [tap requireGestureRecognizerToFail:doubleTap];
        
    }
    
    //给滚动视图设置个范围
    self.scrollView.contentSize = CGSizeMake(RECT.size.width*(self.imageArray.count),0);
    //告诉滚动视图不仅仅只有一张图片  实现滚动  分页式滚动
    self.scrollView.pagingEnabled = YES;
    self.scrollView.backgroundColor=[UIColor blackColor];
    //开启
    [self.scrollView setMultipleTouchEnabled:YES];
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    
    //设置第一次是  点击放大开关开
    isSwitch = YES;
    
}

#pragma mark -设置单击方法  退出查看图片
-(void)tapTouch:(UITapGestureRecognizer *)touche
{
    //点击次数
    NSInteger num = [touche numberOfTapsRequired];
    if(num==1)
    {
        [self.numberLabel removeFromSuperview];
        [self.scrollView becomeFirstResponder];
        [ChangePosition addAnimation:self.scrollView andDuration:0.5 andDelay:0 andRect:CGRectMake(25.0/320*RECT.size.width+70.0/320*RECT.size.width*(isNumber), origin_y ,60.0/320*RECT.size.width, 60.0/320*RECT.size.width)];
        [self.navigationController.navigationBar setHidden:NO];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        //设置延迟删除视图
        [self performSelector:@selector(remove) withObject:self afterDelay:0.5];
    }
    
}

#pragma mark -设置双击方法 放大 或者删除
-(void)doubleTouch:(UITapGestureRecognizer *)touche
{
    //获取点击点 在屏幕的位置
    //CGPoint onsetPoint= [touche locationInView:touche.view.superview];
    //点击次数
    NSInteger num = [touche numberOfTapsRequired];
    if(num==2)
    {
        //放大方法
        if (isSwitch)
        {
            //获取比例
            float newScale = [(UIScrollView*)touche.view.superview zoomScale] * 2;
            //获取改变后的CGRect
            CGRect zoomRect = [self zoomRectForScale:newScale  inView:(UIScrollView*)touche.view.superview withCenter:[touche locationInView:touche.view]];
            //移至改变后的位置
            [(UIScrollView*)touche.view.superview zoomToRect:zoomRect animated:YES];
            //放大关
            isSwitch = NO;
        }
        //缩小方法
        else
        {
            
            //获取比例
            float newScale = [(UIScrollView*)touche.view.superview zoomScale]/2;
            //获取改变后的CGRect
            CGRect zoomRect = [self zoomRectForScale:newScale  inView:(UIScrollView*)touche.view.superview withCenter:[touche locationInView:touche.view]];
            //移至改变后的位置
            [(UIScrollView*)touche.view.superview zoomToRect:zoomRect animated:YES];
            //放大开
            isSwitch = YES;
            
        }
        
    }
}
#pragma mark - ScrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.scrollView){
        CGFloat x = scrollView.contentOffset.x;
        if (x==offset){
            
        }
        else {
            offset = x;
            for (UIScrollView *s in scrollView.subviews){
                if ([s isKindOfClass:[UIScrollView class]]){
                    [s setZoomScale:1.0];
                    
                }
            }
        }
    }
}

#pragma mark - Utility methods
- (CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center
{
    
    CGRect zoomRect;
    
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width = [scrollView frame].size.width  / scale;
    
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}



#pragma mark -UIScrollView代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==self.scrollView)
    {
        
        //存储上个 选择的位置
        NSInteger number = isNumber;
        double proportion = scrollView.contentOffset.x/RECT.size.width;
        int proportion2=proportion*100000;
        int remainder = proportion2%100000;
        
        if (remainder==0)
        {
            isNumber = scrollView.contentOffset.x/RECT.size.width;
            self.numberLabel.text =[NSString stringWithFormat:@"%ld/%ld",(long)isNumber+1,(unsigned long)self.imageArray.count];
            if (isSwitch==NO&&isNumber!=number) {
                isSwitch = YES;
                
            }
        }
    }
    
}

#pragma mark  -延迟删除创建的 UIScrollView
-(void)remove
{
    [self.scrollView removeFromSuperview];
}


#pragma mack -离开视图时  不可缺
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
