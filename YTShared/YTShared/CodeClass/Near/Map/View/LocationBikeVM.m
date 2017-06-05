//
//  LocationBikeVM.m
//  BeiQingBike
//
//  Created by 贝庆 on 2016/12/31.
//  Copyright © 2016年 贝庆. All rights reserved.
//

#import "LocationBikeVM.h"
#import "LocationBikeM.h"
@implementation LocationBikeVM


// 寻车
+ (void)getBikeLocationInfoBy:(NSString *)lon andLat:(NSString *)lat :(void(^)(NSMutableArray<LocationBikeM *>  *dict))success :(void(^)())errors
{
    
    //@"https://www.bqbike.com/findBike.action"
    [NetWorkToolManager commonNetWork:@"http://192.168.0.252:8080/findBike.action" :@{@"lng":lon , @"lat":lat} :^(NSURLSessionDataTask *task, id responseObject) {
        
        RequestResult *result = [RequestResult mj_objectWithKeyValues:responseObject];
        
        
        if ([result.resultCode isEqualToString:SUCCESS_CODE]) {
            
            
            NSMutableArray<LocationBikeM *> * arr = [LocationBikeM mj_objectArrayWithKeyValuesArray:result.data[@"bike"]];
            
            success(arr);
            
        }else
        {
            errors();
            
        }
        
    } :^(NSURLSessionDataTask *task, NSError *error) {
        
        errors();
        
    }];
}

@end
