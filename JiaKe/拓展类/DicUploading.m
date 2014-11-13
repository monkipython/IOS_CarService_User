//
//  DicUploading.m
//  XtuanMoive
//
//  Created by X团 on 14-9-11.
//  Copyright (c) 2014年 X团. All rights reserved.
//

#import "DicUploading.h"

@implementation DicUploading

static NSString * const FORM_FLE_INPUT = @"file1";

-(void)postRequestWithURL: (NSString *)url
                      postParems: (NSMutableDictionary *)postParems
                     picFilePath: (NSMutableArray *)picFilePath
                     picFileName: (NSMutableArray *)picFileName
{
    
    NSString *hyphens = @"--";
    NSString *boundary = @"*****";
    NSString *end = @"\r\n";
    
    NSMutableData *myRequestData1=[NSMutableData data];
    //遍历数组，添加多张图片
    for (int i = 0; i < picFilePath.count; i ++) {
        NSData* data;
        UIImage *image=[UIImage imageWithContentsOfFile:[picFilePath objectAtIndex:i]];
        //判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(image)) {
            //返回为png图像。
            data = UIImagePNGRepresentation(image);
        }else {
            //返回为JPEG图像。
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        
        //所有字段的拼接都不能缺少，要保证格式正确
        [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSMutableString *fileTitle=[[NSMutableString alloc]init];
        //要上传的文件名和key，服务器端用file接收
        [fileTitle appendFormat:@"Content-Disposition:form-data;name=\"%@\";filename=\"%@\"",[NSString stringWithFormat:@"pic%d",i],picFileName[i]];
        
        [fileTitle appendString:end];
        
        [fileTitle appendString:[NSString stringWithFormat:@"Content-Type:application/octet-stream%@",end]];
        [fileTitle appendString:end];
        
        [myRequestData1 appendData:[fileTitle dataUsingEncoding:NSUTF8StringEncoding]];
        
        [myRequestData1 appendData:data];
        
        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //参数的集合的所有key的集合
    NSArray *keys= [postParems allKeys];
    
    //添加其他参数
    for(int i=0;i<[keys count];i++)
    {
        
        NSMutableString *body=[[NSMutableString alloc]init];
        [body appendString:hyphens];
        [body appendString:boundary];
        [body appendString:end];
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //添加字段名称
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"",key];
        
        [body appendString:end];
        
        [body appendString:end];
        //添加字段的值
        [body appendFormat:@"%@",[postParems objectForKey:key]];
        
        [body appendString:end];
        
        [myRequestData1 appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:20];
    
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",boundary];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%ld", (long)[myRequestData1 length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData1];
    //http method
    [request setHTTPMethod:@"POST"];
    
    NSURLResponse *respon = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respon error:&error];
    NSLog(@"%@",respon);
    if(error)
    {
        NSLog(@"%@",error);
    }else
    {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers error:&error];
        
        if(error)
        {
            NSLog(@"%@",error);
        }
        else
        {
            NSLog(@"%@",dic);
        }
    }
}

/*
 * 接口返回数据时调用
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    _data = [[NSMutableData alloc] initWithCapacity:10];
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"%@",dic);
    if (error == nil) {
        
    }else
    {
        NSLog(@"%@",error);
    }
    //判断是否被关注过
//    [self.delegate getDicUploadingData:dic];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

@end
