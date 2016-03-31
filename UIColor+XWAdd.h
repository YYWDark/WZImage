//
//  UIColor+XWAdd.h
//  XWFunny
//
//  Created by wyy on 16/3/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XWAdd)
+ (UIColor *)colorWithRGBString:(NSString *)szRGB;

+ (UIColor *)colorWithRGBAString:(NSString *)szRGBA;

+(UIColor*)colorWithR:(CGFloat)nR G:(CGFloat)nG B:(CGFloat)nB A:(CGFloat)nA;

+ (UIColor *)colorWithHex:(NSUInteger)color;

+(UIColor*)colorWithHex:(NSUInteger)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)flatBlueColor;
+ (UIColor *)flatLightBlueColor;
+ (UIColor *)flatDarkBlueColor;
+ (UIColor *)flatRedColor;
+ (UIColor *)flatDarkRedColor;
+ (UIColor *)flatGreenColor;
+ (UIColor *)flatBlackColor;
+ (UIColor *)flatGrayColor;
+ (UIColor *)flatLightGrayColor;

+ (UIColor *)brighterColorWithColor:(UIColor *)color;

+ (UIColor *)lighterColorWithColor:(UIColor *)color;
@end
