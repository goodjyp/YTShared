//
//  UIColor+Utils.h
//  Merchant
//
//  Created by PeaksLee on 16/5/5.
//  Copyright © 2016年 YiLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)

/*!
 *  通过十六进制获取颜色对象
 *
 *  @param hexColor 十六进行值，例如"ff0011"
 *
 *  @return 颜色对象
 */
+ (UIColor *)colorForHex:(NSString *)hexColor;
@end
