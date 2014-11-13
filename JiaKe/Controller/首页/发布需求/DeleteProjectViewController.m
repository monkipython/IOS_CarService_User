//
//  DeleteProjectViewController.m
//  JiaKe
//
//  Created by hgs泽泓 on 14-10-1.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import "DeleteProjectViewController.h"

@interface DeleteProjectViewController ()

@end

@implementation DeleteProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, RECT.size.height) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource =self;
    [self.view addSubview:table];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [NSArray arrayWithObjects:indexPath, nil];
    [self.projectArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"cellIdentifire";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.projectArray[indexPath.row];
    return cell;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.projectArray.count;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeView)];
    self.navigationItem.leftBarButtonItem = item;
}
-(void)closeView
{
    NSMutableString *string = [NSMutableString new];
    NSInteger num = self.projectArray.count;
    int i = 0;
    for(NSString *str in self.projectArray)
    {
        if(i<num-1)
        {
            i++;
            NSString *projectStr = [NSString stringWithFormat:@"%@,",str];
            [string appendString:projectStr];
        }else
        {
            NSString *projectStr = [NSString stringWithFormat:@"%@",str];
            [string appendString:projectStr];
        }
    }
    NSLog(@"%@",string);
    [self.delegate chooseProject:string];
    [self.navigationController popViewControllerAnimated:YES];
//  [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
