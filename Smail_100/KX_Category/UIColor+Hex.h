//
//  UIColor+Hex.h
//  lamada
//
//  Created by mac on 16/8/8.
//  Copyright © 2016年 Frank. All rights reserved.
//  十六进制颜色转换分类

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor *)colorWithHexString:(NSString *)color;//默认透明度为1.0f
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
