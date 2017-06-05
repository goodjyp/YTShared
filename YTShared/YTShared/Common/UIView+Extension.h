//
//  UIView+Extension.h
//  Dibaibike
//
//  Created by 陈成 on 2016/10/17.
//  Copyright © 2016年 cn.chengbai.item. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic ,assign) CGFloat  width;
@property (nonatomic , assign) CGFloat height;
@property (nonatomic , assign) CGFloat x;
@property (nonatomic , assign) CGFloat y;
@property (nonatomic , assign) CGPoint center;
@property (nonatomic ,assign) CGSize  size;
@property (nonatomic,assign)CGFloat centerX ;
@property (nonatomic,assign)CGFloat centerY;


//Method
- (void)setLayerWithCr:(CGFloat)cornerRadius;
- (void)setBorderWithColor: (UIColor *)color width: (CGFloat)width;
@end
