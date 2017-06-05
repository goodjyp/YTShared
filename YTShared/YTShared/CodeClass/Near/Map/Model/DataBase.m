//
//  DataBase.m
//  Search_Map
//
//  Created by 贝庆 on 16/10/27.
//  Copyright © 2016年 贝庆. All rights reserved.
//

#import "DataBase.h"
#import "locModel.h"
#import <FMDB.h>

static DataBase *_DBCtl = nil;

@interface DataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
    
}
@end
@implementation DataBase

+(instancetype)sharedDataBase{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [[DataBase alloc] init];
        
        [_DBCtl initDataBase];
        
    }
    
    return _DBCtl;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [super allocWithZone:zone];
        
    }
    
    return _DBCtl;
    
}

-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}


-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    if (![self isTableOK:@"location"]) {
        // 初始化数据表
        NSString *locationSql = @"CREATE TABLE 'location' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'location_name' VARCHAR(255),'location_district' VARCHAR(255),'location_latitude' VARCHAR(255),'location_longitude'VARCHAR(255)) ";
        
        
        [_db executeUpdate:locationSql];
    }
    
   
    
    
    [_db close];
    
}

// 判断是否存在表
- (BOOL) isTableOK:(NSString *)tableName
{
    FMResultSet *rs = [_db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        XXLog(@"isTableOK %ld", count);
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
}

- (void)addLocationModel:(locModel *)locationModel
{
    [_db open];
    
    [_db executeUpdate:@"INSERT INTO location(location_name,location_district,location_latitude,location_longitude)VALUES(?,?,?,?)",locationModel.name,locationModel.district,@(locationModel.latitude),@(locationModel.longitude)];
    [_db close];
}


- (void)deleteAllLocationModel
{
    [_db open];
    
    [_db executeUpdate:@"DELETE  FROM location"];
    
    [_db close];

}

- (NSMutableArray *)getAllLocationModel
{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM location"];
    
    while ([res next]) {
        locModel * location = [[locModel alloc] init];
        location.name = [res stringForColumn:@"location_name"];
        location.district = [res stringForColumn:@"location_district"];
        location.latitude = [[res stringForColumn:@"location_latitude"] floatValue];
        location.longitude = [[res stringForColumn:@"location_longitude"] floatValue];
        
        [dataArray addObject:location];
        
    }

    return dataArray;
}


@end
