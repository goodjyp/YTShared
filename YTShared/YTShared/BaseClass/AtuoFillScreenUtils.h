//
//  AtuoFillScreenUtils.h
//  YTShared
//
//  Created by 周江 on 2017/6/4.
//  Copyright © 2017年 ypj. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface AtuoFillScreenUtils : NSObject
+ (void)autoLayoutFillScreen:(UIView *)view;
+ (CGRect)updateViewsFrame:(CGFloat) x withY:(CGFloat) y AndWidth:(CGFloat) width AndHeight:(CGFloat) height;
@end
