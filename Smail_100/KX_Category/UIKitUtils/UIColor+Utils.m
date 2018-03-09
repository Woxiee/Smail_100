//
//  UIColor+Utils.m
//  MyCityProject
//
//  Created by mac_KY on 17/6/2.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)

UIColor *JColor(J_Color color)
{
    UIColor *jColor = nil;
    switch (color) {
        case white:{jColor = [UIColor whiteColor];}break;
            case red:{jColor = [UIColor redColor];}break;
            case blue:{jColor = [UIColor blueColor];}break;
            case orange:{jColor = [UIColor orangeColor];}break;
            case lineColor:{jColor = RGBA(240, 240, 240, 1.0);}break;
            case mainColor:{jColor = MainColor;}break;
            case viewBackColor:{jColor = BACKGROUND_COLOR;}break;
            case black:{jColor = [UIColor blackColor];}break;
            case titleColor:{jColor = RGB(53, 53, 53);}break;
            case subColor:{jColor = RGB(153, 153, 153);}break;
            
        default:
            break;
    }
    return jColor;
}
+ (UIColor *)j_white
{
    return [UIColor whiteColor];
}
+ (UIColor *)j_red
{
     return [UIColor redColor];
}
+ (UIColor *)j_blue
{
     return [UIColor blueColor];
}
+ (UIColor *)j_orange
{
     return [UIColor orangeColor];
}
+ (UIColor *)j_black
{
    return [UIColor blackColor];
}

+ (UIColor *)j_mainColor
{
    return MainColor;
}
@end
