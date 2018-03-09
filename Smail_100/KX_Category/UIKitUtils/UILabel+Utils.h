//
//  UILabel+Utils.h
//  KYCategoryDemo
//
//  Created by mac_KY on 17/1/16.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Utils)


/**
 *  富文
 *
 *  @param Attributed      需改变的字符串
 *  @param AttributedColor 需改变字符串的颜色
 *  @param AttributedFont  <#AttributedFont description#>
 */
- (void)setAttributedWithString:(NSString*)Attributed andAttributedColor:(UIColor*)AttributedColor andAttributedFont:(UIFont*)AttributedFont;

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                    textColor:(UIColor *)color
                         font:(UIFont*)font;


- (UILabel *(^)(CGRect frame))ky_frame;
- (UILabel *(^)(UIColor *color))ky_color;
- (UILabel *(^)(NSString *title))ky_title;

- (UILabel *(^)(UIFont *font))ky_font;
- (UILabel *(^)(NSTextAlignment alignment))ky_alignment;
- (UILabel *(^)(NSUInteger  numberOfLines))ky_numberOfLines;
//
@end
