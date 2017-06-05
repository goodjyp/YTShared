//
//  CustomMapVC.h
//  YTShared
//
//  Created by ypj on 2017/6/4.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAOtherAnnotation.h"

typedef void(^huaXianMapBlock)(MAOtherAnnotation *start,MAOtherAnnotation *end);

@interface CustomMapVC : UIViewController

@property (strong , nonatomic) MAMapView *mapView;


@property (copy , nonatomic) huaXianMapBlock mapBlock;

@end
