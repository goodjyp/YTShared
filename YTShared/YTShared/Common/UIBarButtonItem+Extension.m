//
//  UIBarButtonItem+Extension.m
//  Dibaibike
//
//  Created by 陈成 on 2016/10/17.
//  Copyright © 2016年 cn.chengbai.item. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)

+(instancetype)itemWithTarget:(id)target andAction:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    
    
    if (highImage!=nil) {
        [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];

    }
//    button.size = button.currentBackgroundImage.size;
    //当前btn大小
    CGRect btnBounds =button.bounds;
    //扩大点击区域，想缩小就将-10设为正值
    btnBounds = CGRectInset(btnBounds, -10, -10);
    
    //若点击的点在新的bounds里，就返回YES
    button.bounds = btnBounds;
    
    
    
    
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
    
}

+(instancetype)itemWithTarget:(id)target andAction:(SEL)action titleName:(NSString *)title
{
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailBtn setTitle:title forState:UIControlStateNormal];
    [detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    detailBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [detailBtn sizeToFit];
    [detailBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:detailBtn];
    return [[self alloc] initWithCustomView:detailBtn];
}

@end
