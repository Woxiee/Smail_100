//
//  UIButton+Utils.h
//  MyCityProject
//
//  Created by mac_KY on 17/6/2.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Utils)

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                    textColor:(UIColor *)color
                         font:(UIFont*)font;


- (UIButton *(^)(CGRect frame))ky_frame;
- (UIButton *(^)(UIColor *color))ky_color;
- (UIButton *(^)(NSString *title))ky_title;
- (UIButton *(^)(UIFont *font))ky_font;
- (UIButton *(^)(UIColor *backColor))ky_backColor;
- (UIButton *(^)(NSString *title ,UIControlState state))ky_titleAndState;
- (UIButton *(^)(UIColor *titleColor))ky_titleColor;



@end
