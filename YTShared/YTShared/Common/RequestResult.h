//
//  RequestResult.h
//  Dibaibike
//
//  Created by 贝庆 on 16/11/9.
//  Copyright © 2016年 cn.chengbai.item. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestResult : NSObject
@property (copy , nonatomic) NSString *resultCode;         // 请求代码
@property (copy , nonatomic) NSString *resultMsg;          // 请求代码信息
@property (strong , nonatomic) NSMutableDictionary *data;  // 请求结果
@property (strong , nonatomic) NSString *status;           // 状态码
@property (copy , nonatomic) NSDictionary *alipay_trade_app_pay_response; // 支付宝返回结果集
@property (copy , nonatomic) NSString *out_trade_no;       // 支付宝订单号
@end
