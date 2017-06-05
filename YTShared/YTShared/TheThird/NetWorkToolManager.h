//
//  NetWorkToolManager.h
//  Dibaibike
//
//  Created by 贝庆 on 16/11/9.
//  Copyright © 2016年 cn.chengbai.item. All rights reserved.
//

// 网络请求単例
#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "AFNetworking.h"
@interface NetWorkToolManager : NSObject
Singleton_h(NetWorkToolManager)

#pragma mark --- 预约单车
/** 根据memberID得到预约剩余时间 **/
+ (void)getRunLoopTimer_TimeByMemberID: (NSString *)memberID :(void (^)(NSInteger time))block;

/** 没参数的通用请求 **/
+ (void)commonNetWork:(NSString *)urlString :(NSDictionary *)dict :(void(^)(NSURLSessionDataTask *task, id responseObject))success :(void(^)(NSURLSessionDataTask *task, NSError *error)) error;



+ (void)getH5urlWithStr:(NSString *)str :(void(^)(NSString *url))success :(void(^)())errors;
@end
