//
//  DataBase.h
//  Search_Map
//
//  Created by 贝庆 on 16/10/27.
//  Copyright © 2016年 贝庆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class locModel;




@interface DataBase : NSObject

@property(nonatomic,strong) locModel *location;


+ (instancetype)sharedDataBase;


#pragma mark - Person
/**
 *  添加person
 *
 */
- (void)addLocationModel:(locModel *)locationModel;
/**
 *  删除person
 *
 */
//- (void)deleteLocationModel:(locModel *)locationModel;
///**
// *  更新person
// *
// */
//- (void)updateLocationModel:(locModel *)locationModel;

/**
 *  获取所有数据
 *
 */
- (NSMutableArray *)getAllLocationModel;

/**
 *
 * 删除所有数据
 */

- (void)deleteAllLocationModel;

@end