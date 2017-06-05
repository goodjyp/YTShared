//
//  UIColor+Tools.h
//  BeiQingBike
//
//  Created by 贝庆 on 16/12/15.
//  Copyright © 2016年 贝庆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Tools)
/**
 *  RGB Color
 *
 *  @param red   redColor
 *  @param green greenColor
 *  @param blue  blueColor
 *  @param alpha alpha
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithRGBAColorRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
/**
 *  十六进制color
 *
 *  @param hexString 十六进制
 *  @param alpha     alpha
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
/**
 *  十六进制color
 *
 *  @param hexString 十六进制
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;
/**
 *  通用蓝(1B88EE)
 *
 *  @return 0x1B88EE
 */
+ (UIColor *)normalBlue;
/**
 *  通用黑色(333333)
 *
 *  @return 0x333333
 */
+ (UIColor *)normalBlack;
/**
 *  通用淡黑色(999999)
 *
 *  @return 0x999999
 */
+ (UIColor *)normalGrayBlack;
/**
 *  通用灰色(666666)
 *
 *  @return 0x666666
 */
+ (UIColor *)normalGray;
/**
 *  通用背景色(EFEFF4)
 *
 *  @return 
 */
+ (UIColor *)normalBackgroundColor;
/**
 *  通用Cell分割线(E5E5E5)
 *
 *  @return 0xEE5E5
 */

+ (UIColor *)normalDividerColor;
/**
 *  通用分割线(E1E1E1)
 *
 *  @return 0xE1E1E1
 */
+ (UIColor *)normalLineColor;
/**
 *  按钮通用红色(d22828)
 *
 *  @return
 */
+ (UIColor *)normalRedColor;
/**
 *  按钮通用橙色(F05A27)
 *
 *  @return
 */
+ (UIColor *)normalBtnOrangeColor;

//获取图片主色调
+ (UIColor*)mostColor:(UIImage*)image;



@end
