//
//  NearVC.h
//  YTShared
//
//  Created by ypj on 2017/6/1.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
@interface NearVC : BaseViewController
@property (nonatomic , strong) AMapLocationManager *locationManager;


@property (assign , nonatomic)BOOL isScanLuck;  // 是否开锁页面跳转的

@property (nonatomic, strong) MAMapView *mapView;
@property (strong , nonatomic)NSMutableDictionary *searchDict;


- (void)appointmentViewAnimated_up;

- (void)locTap:(UIGestureRecognizer *)tap;

- (void)clear;
@end
