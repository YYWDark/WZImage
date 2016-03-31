//
//  UIImage+XWAdd.h
//  XWFunny
//
//  Created by wyy on 16/3/30.
//  Copyright © 2016年 wyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XWAdd)
- (nullable UIImage *)imageByResizeToSize:(CGSize)size;

- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(nullable UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin;
@end
