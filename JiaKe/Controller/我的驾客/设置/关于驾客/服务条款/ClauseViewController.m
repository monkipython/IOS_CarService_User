//
//  ClauseViewController.m
//  JiaKe
//
//  Created by fuzhaorui on 14-9-5.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "ClauseViewController.h"
#import "ClauseModel.h"
@interface ClauseViewController ()
//获取条款内容
@property (weak, nonatomic) IBOutlet UITextView *clauseText;
@end
@implementation ClauseViewController

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
-(void)createView
{
    
}
#pragma mark -将要进入视图时获取条款内容
-(void)viewWillAppear:(BOOL)animated
{
    self.clauseText.text=[ClauseModel clauseText];
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
