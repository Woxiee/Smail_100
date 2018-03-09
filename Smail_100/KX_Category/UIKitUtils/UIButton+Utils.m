//
//  UIButton+Utils.m
//  MyCityProject
//
//  Created by mac_KY on 17/6/2.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "UIButton+Utils.h"

@implementation UIButton (Utils)
- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                    textColor:(UIColor *)color
                         font:(UIFont*)font
{
    if (self = [super initWithFrame:frame]) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:color forState:UIControlStateNormal];
        self.titleLabel.font = font;
    }
    return self;
}


- (UIButton *(^)(CGRect frame))ky_frame
{
    return ^(CGRect frame){
        [self setFrame:frame];
        return self;
    };
}
- (UIButton *(^)(UIColor *color))ky_color
{
    return ^(UIColor *color){
        [self setTitleColor:color forState:UIControlStateNormal];
        return self;
    };
}
- (UIButton *(^)(NSString *title))ky_title
{
    return ^(NSString *title){
        [self setTitle:title forState:UIControlStateNormal];
        return self;
    };
}
- (UIButton *(^)(UIFont *font))ky_font
{
    return ^(UIFont *font){
        self.titleLabel.font = font;
        return self;
    };
}
- (UIButton *(^)(UIColor *backColor))ky_backColor
{
    return ^(UIColor *backColor){
        self.backgroundColor = backColor;
        return self;
    };
}
- (UIButton *(^)(UIColor *titleColor))ky_titleColor
{
    return ^(UIColor *titleColor){
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        return self;
    };
}
- (UIButton *(^)(NSString *title ,UIControlState state))ky_titleAndState
{
    return ^(NSString *title ,UIControlState state){
        [self setTitle:title forState:state];
        return self;
    };
}
@end
