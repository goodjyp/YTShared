//
//  UIBarButtonItem+Extension.h
//  Dibaibike
//
//  Created by 陈成 on 2016/10/17.
//  Copyright © 2016年 cn.chengbai.item. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+(instancetype)itemWithTarget:(id)target andAction:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

// 带文字的item
+(instancetype)itemWithTarget:(id)target andAction:(SEL)action titleName:(NSString *)title;
@end
