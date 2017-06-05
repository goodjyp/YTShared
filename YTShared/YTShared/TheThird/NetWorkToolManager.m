//
//  NetWorkToolManager.m
//  Dibaibike
//
//  Created by 贝庆 on 16/11/9.
//  Copyright © 2016年 cn.chengbai.item. All rights reserved.
//

#import "NetWorkToolManager.h"
#import "MJExtension.h"
//#import "UserUseBikeManager.h"
//#import "NSString+Extension.h"

@implementation NetWorkToolManager
Singleton_m(NetWorkToolManager)

+ (AFHTTPSessionManager *)manager
{
       AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
      [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
       manager.requestSerializer.timeoutInterval = 10.f;
      [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}




#pragma mark --- 获取H5页面
+ (void)getH5urlWithStr:(NSString *)str :(void(^)(NSString *url))success :(void(^)())errors
{
//    [[self manager] POST:HTML5_URL parameters:@{@"str":str} success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        RequestResult *result = [RequestResult mj_objectWithKeyValues:responseObject];
//        
//        success([NSString stringWithFormat:@"%@",result.data[@"url"]]);
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        errors();
//    }];
}


/** 通用请求 **/
+ (void)commonNetWork:(NSString *)urlString :(NSDictionary *)dict :(void (^)(NSURLSessionDataTask *, id))success :(void (^)(NSURLSessionDataTask *, NSError *))error
{
    // 首页寻车不过滤
    if ([urlString isEqualToString:@"https://www.bqbike.com/findBike.action"]) {
        
        [[self manager] POST:urlString parameters:dict success:success failure:error];
        return;
    }
    
//    if([UserCommonModel sharedUserCommonModel].memberID != nil && urlString != nil)   // 登录了
//    {
//        XXLog(@"%@==%@==%@",ONLY_LOGIN,[UserCommonModel sharedUserCommonModel].memberID , [NSString getDeviceId]);
//        [[self manager] POST:ONLY_LOGIN parameters:@{@"memberID":[UserCommonModel sharedUserCommonModel].memberID,@"mark":[NSString getDeviceId]} success:^(NSURLSessionDataTask *task, id responseObject) {
//            
//            RequestResult *result =  [RequestResult mj_objectWithKeyValues:responseObject];
//            NSLog(@"%@",result.resultCode);
//            
//            if ([result.data[@"status"] isEqualToString:@"1"]) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"succ" object:nil  userInfo:@{@"urlString":urlString , @"dict" : dict==nil ? @"":dict ,@"success" : success , @"error" : error}];
//                
//                
//            } else {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"error" object:nil];
//
//            }
//            
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"netError" object:nil];
//            
//            
//        }];
//    }else {
//        
//        [[self manager] POST:urlString parameters:dict success:success failure:error];
//        
//    }
 
}




//#pragma mark --- 根据memberID得到预约剩余时间
+ (void)getRunLoopTimer_TimeByMemberID:(NSString *)memberID :(void (^)(NSInteger))block
{
    
//    __block UserUseBikeManager *useBikeManager = [UserUseBikeManager sharedUserUseBikeManager];
//    [[self manager] POST:@"https://www.bqbike.com/findBikeNO.action" parameters:@{@"memberID" : memberID} success:^(NSURLSessionDataTask *task, id responseObject) {
//        RequestResult *result = [RequestResult mj_objectWithKeyValues:responseObject];
//        
//        useBikeManager = [UserUseBikeManager mj_objectWithKeyValues:result.data]; // 得到单车编号
//        if (useBikeManager.bikeNo == nil) {  // 没有单车
//            block(0);
//        }else                                // 有单车
//        {
//            [[self manager] POST:@"https://www.bqbike.com/Appointment.action" parameters:@{@"memberID":memberID , @"bikeNO":useBikeManager.bikeNo} success:^(NSURLSessionDataTask *task, id responseObject) {
//                RequestResult *result = [RequestResult mj_objectWithKeyValues:responseObject];
//                useBikeManager = [UserUseBikeManager mj_objectWithKeyValues:result.data];
//                block(useBikeManager.time);
//            } failure:nil];
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        XXLog(@"请求错误");
//    }];
//    
}

@end
