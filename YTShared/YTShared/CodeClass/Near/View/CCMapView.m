//
//  CCMapView.m
//  BeiQingBike
//
//  Created by 贝庆 on 16/11/25.
//  Copyright © 2016年 贝庆. All rights reserved.
//

#import "CCMapView.h"

@implementation CCMapView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (point.x <= 10) {
        return nil;
    }
    
    UIView *view = [super hitTest:point withEvent:event];
    return view;
}

@end
