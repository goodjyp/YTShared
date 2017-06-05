//
//  LocationBikeVM.h
//  BeiQingBike
//
//  Created by 贝庆 on 2016/12/31.
//  Copyright © 2016年 贝庆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LocationBikeM;
@interface LocationBikeVM : NSObject

+ (void)getBikeLocationInfoBy:(NSString *)lon andLat:(NSString *)lat :(void(^)(NSMutableArray<LocationBikeM *>  *dict))success :(void(^)())error;

@end
