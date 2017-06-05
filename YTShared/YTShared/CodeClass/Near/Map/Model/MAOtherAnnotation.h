//
//  MAOtherAnnotation.h
//  YTShared
//
//  Created by ypj on 2017/6/4.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface MAOtherAnnotation : MAPointAnnotation
@property (copy , nonatomic)NSString *bikeNo;

@property (copy , nonatomic)NSString *zuijin;   // 是否离我最近
@end
