//
//  UIColor+Utils.h
//  MyCityProject
//
//  Created by mac_KY on 17/6/2.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, J_Color) {
    white = 0,
    red,
    blue,
    orange,
    lineColor,
    mainColor,
    viewBackColor,
    black,//
    titleColor,//53 53 53
    subColor,//153 153 153
    
};

@interface UIColor (Utils)



UIColor *JColor(J_Color color);
+ (UIColor *)j_white;
+ (UIColor *)j_red;
+ (UIColor *)j_blue;
+ (UIColor *)j_orange;
+ (UIColor *)j_black;
+ (UIColor *)j_mainColor;
@end
