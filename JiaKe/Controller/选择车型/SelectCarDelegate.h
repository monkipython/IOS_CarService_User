//
//  SelectCar.h
//  JiaKe
//
//  Created by fuzhaorui on 14-9-3.
//  Copyright (c) 2014年 HgsZehong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SelectCarDelegate <NSObject>
-(void)sendCarBrand:(NSString *)brandName
        andCarModel:(NSString *)modelName
       andDetails:(NSString *)detailsName
            andCarName:(NSString *)carName;
@end
