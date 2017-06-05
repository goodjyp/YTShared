//
//  LORequestManger.m
//  PlanB
//
//  Created by young on 15/5/6.
//  Copyright (c) 2015年 young. All rights reserved.
//

#import "LORequestManger.h"
#define serverUrl @"http://192.168.1.1:8080/jiekou"

@implementation LORequestManger
//登录超时重新登录
+ (BOOL)retrievesTheSession{
    //重新执行下登陆操作 -- 当接收到session超时时候,执行此方法,并且获取到新的session赋值属性.并且根据requestDataType,再去请求一次.
    //1.准备网址
    NSURL *url = [NSURL URLWithString:@"123"];
    //2.准备请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //2.1设置请求方式
    [request setHTTPMethod:@"POST"];
    //2.2设置请求参数
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:@"accounts"];
    NSString *password = [[NSUserDefaults standardUserDefaults]objectForKey:@"encryption"];
    NSString *postStr = [[NSString alloc] initWithFormat:@"accounts=%@&password=%@",user, password];
    NSData *param = [postStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:param];
    //3.创建链接对象,并发送请求,获取结果
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //4.解析
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    //5.显示结果
//    NSLog(@"dict = %@", dict);
    NSString *code = dict[@"codeMsg"];
    if (![@"" isEqualToString:code]) {
        return YES;
    } else {
        return NO;
    }
}

//post登录请求
+ (void)POSTLogin:(NSString *)URL params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))Error
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"text/json",@"text/javascript",@"application/json", nil];
    // 请求超时时间
    manager.requestSerializer.timeoutInterval = 30;
    NSString *postStr = URL;
    if (![URL hasPrefix:@"http"]) {
        postStr = [NSString stringWithFormat:@"%@%@", serverUrl,URL] ;
    }
    NSMutableDictionary *dict = [params mutableCopy];
    __weak typeof(self) weakSelf = self;
    // 发送post请求
    [manager POST:postStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self deleteProgress];
        //系统自带JSON解析
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        NSString *code = responseObject[@"codeMsg"];
        if (![@"" isEqualToString:code]) {
            if ([@"invalidSession" isEqualToString:code]) {
                if ([self retrievesTheSession]) {
                    //继续执行
                    [weakSelf afreshRequestPostWithUrl:URL params:params success:^(id response) {
                        //                    NSLog(@"成功");
                        NSDictionary *myDic = (NSDictionary *)response;
                        success(myDic);
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        //                    NSLog(@"失败");
                    }];
                } else {
                    UIAlertView *alert = MyAlertView(@"请求超时请重新登录");
                    [alert show];
                }
            } else {
//                UIAlertView *alert = MyAlertView(code);
//                [alert show];
                success(responseDict);
            }
        } else {
            success(responseDict);
            NSString *sessionId = responseDict[@"jsessionid"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:sessionId forKey:@"cookie"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {// 请求失败
        [self deleteProgress];
        Error( operation,error);
        NSLog(@"%@",Error);
        
    }];

}



//post请求
+ (void)POST:(NSString *)URL params:(NSDictionary * )params success:(void (^)(id response))success
     failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))Error
{
//    [self addProgress];
    // 创建请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"text/json",@"text/javascript",@"application/json", nil];
    // 请求超时时间
    manager.requestSerializer.timeoutInterval = 30;
    NSString *postStr = URL;
    if (![URL hasPrefix:@"http"]) {
        postStr = [NSString stringWithFormat:@"%@%@", serverUrl,URL] ;
    }
    NSMutableDictionary *dict = [params mutableCopy];
    __weak typeof(self) weakSelf = self;
    // 发送post请求
    [manager POST:postStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [self deleteProgress];
        //系统自带JSON解析
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        NSString *code = responseObject[@"errorMsg"];
        if (![@"" isEqualToString:code]) {
            if ([@"invalidSession" isEqualToString:code]) {
                if ([weakSelf retrievesTheSession]) {
                    //继续执行
                    [self afreshRequestPostWithUrl:URL params:params success:^(id response) {
                        //                    NSLog(@"成功");
                        NSDictionary *myDic = (NSDictionary *)response;
                        success(myDic);
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        //                    NSLog(@"失败");
                    }];
                } else {
                    UIAlertView *alert = MyAlertView(@"请求超时请重新登录");
                    [alert show];
                }
            } else {
//                UIAlertView *alert = MyAlertView(code);
//                [alert show];
                NSLog(@"失败");
                success(responseDict);
            }
        } else {
            success(responseDict);
            NSString *sessionId = responseDict[@"jsessionid"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:sessionId forKey:@"cookie"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {// 请求失败
//        [self deleteProgress];
        Error( operation,error);
        NSLog(@"%@",Error);
        NSLog(@"失22败");
    }];
}

//get请求
+ (void)GET:(NSString *)URL success:(void (^)(id response))success
    failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))Error
{
    // 获得请求管理者
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"text/json",@"text/javascript",@"application/json", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setHTTPShouldHandleCookies:NO];
    manager.requestSerializer.timeoutInterval = 30;
    NSString *getStr = URL;
//    NSLog(@"getStr======%@",getStr);
    /*
    if (![URL hasPrefix:@"http"]) {
        
        getStr = [NSString stringWithFormat:@"%@%@", serverUrl,URL] ;
    }
     */
    __weak typeof(self) weakSelf = self;
    // 发送GET请求
    [manager GET:getStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        NSString *code = responseObject[@"resultCode"];
        if (![@"01001" isEqualToString:code]) {
//            BOOL isLogin = [weakSelf retrievesTheSession];
//            if (isLogin) {
                //继续执行
                [weakSelf afreshRequestGetWithUrl:URL success:^(id response) {
//                    NSLog(@"成功");
                    NSDictionary *myDic = (NSDictionary *)response;
                    success(myDic);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                    NSLog(@"失败");
                }];
//            }
        } else {
            success(responseDict);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (!operation.responseObject) {
            NSLog(@"网络错误");
        }
        Error( operation,error);
    }];
}

//post请求---重新请求
+ (void)afreshRequestPostWithUrl:(NSString *)URL params:(NSDictionary * )params success:(void (^)(id response))success
    failure:(void (^)(id response, NSError *error))myBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        myBlock(operation.responseString, nil);
    }];
}

//get请求--重新请求
+ (void)afreshRequestGetWithUrl:(NSString *)Url success:(void(^)(id response))sucess failure:(void(^)(id response, NSError *error))getBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:Url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        sucess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        getBlock(operation.responseString,nil);
    }];
}


+ (void)UPLOADIMAGE:(NSString *)URL
             params:(NSDictionary *)params
        uploadImage:(UIImage *)image
            success:(void (^)(id response))success
            failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))Error
{
    // 创建请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSString *postStr = [NSString stringWithFormat:@"%@%@", serverUrl,URL] ;
    NSMutableDictionary *dict = [params mutableCopy];

    [manager POST:postStr parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
        [formData appendPartWithFileData:imageData name:@"img" fileName:@"head.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *responseDict = (NSDictionary *)responseObject;
                success(responseDict);
 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        Error( operation,error);
        
    }];
}

+ (void)addProgress {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"加载中...";
}
+ (void)deleteProgress {
    //删除风火轮
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
+(void)Post1:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id))success
    failure:(void (^)(NSError *))failure
{
    
    // 创建请求管理者
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil]];
    [mgr POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
    
}
+(void)GET1:(NSString *)URLString parameters:(id)parameters
   success:(void (^)(id))success
   failure:(void (^)(NSError *))failure
{
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer.timeoutInterval=30;
    //    [SVProgressHUD reveal];
    [mgr.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil]];
    
    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
        if (success) {
            NSLog(@"多少");
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            NSLog(@"123");
            failure(error);
        }
    }];
}
@end
