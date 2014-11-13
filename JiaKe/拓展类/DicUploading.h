//
//  DicUploading.h
//  XtuanMoive
//
//  Created by X团 on 14-9-11.
//  Copyright (c) 2014年 X团. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DicUploadingDelegate <NSObject>

-(void) getDicUploadingData:(NSDictionary *)data;

@end

@interface DicUploading : NSObject<NSURLConnectionDataDelegate>
{
    NSMutableData * _data;    //上传数据
}

@property(nonatomic,strong) id<DicUploadingDelegate>delegate;
-(void)postRequestWithURL: (NSString *)url  // IN
                      postParems: (NSMutableDictionary *)postParems // IN
                     picFilePath: (NSMutableArray *)picFilePath  // IN
                     picFileName: (NSMutableArray *)picFileName ;

@end
