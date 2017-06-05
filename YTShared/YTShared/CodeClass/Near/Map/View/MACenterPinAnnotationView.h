//
//  MACenterPinAnnotationView.h
//  BeiQingBike
//
//  Created by 贝庆 on 2016/12/30.
//  Copyright © 2016年 贝庆. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface MACenterPinAnnotationView : MAPinAnnotationView


@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIImage *portrait;

@property (nonatomic, strong) UIView *calloutView;

@end
