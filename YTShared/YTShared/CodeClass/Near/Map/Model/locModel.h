//
//  locModel.h
//  Search_Map
//
//  Created by 贝庆 on 16/10/27.
//  Copyright © 2016年 贝庆. All rights reserved.
//






#import <Foundation/Foundation.h>

   #import <UIKit/UIKit.h>
@interface locModel : NSObject
@property (nonatomic , strong) NSString *name; // 名称
//@property (nonatomic , strong) NSString *city; // 城市
@property (nonatomic , strong) NSString *district; //地区
@property (nonatomic , assign) CGFloat latitude; //纬度
@property (nonatomic , assign) CGFloat longitude; // 经度
@end
