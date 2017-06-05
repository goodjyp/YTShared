//
//  UIView+YYHFrame.h
//  lesson UIView
//
//  Created by 元虎的mac on 15/7/27.
//  Copyright (c) 2015年 元虎的mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YYHFrame)
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat Y;
@property (nonatomic,assign)CGFloat X;
@property (nonatomic,assign)CGFloat X_width;//返回视图的x坐标加上宽度;
@property (nonatomic,assign)CGFloat Y_height;//返回视图的y坐标加上高度;
@end
