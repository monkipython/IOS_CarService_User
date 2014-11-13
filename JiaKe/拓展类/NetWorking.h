//
//  NetWorking.h
//  JiaKe
//
//  Created by hgs泽泓 on 14-10-13.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorking : NSObject
+(NSDictionary *)send:(NSString *)url postBody:(NSData *)postData;
//+(void *)sendPath:(NSString *)path;
@end
