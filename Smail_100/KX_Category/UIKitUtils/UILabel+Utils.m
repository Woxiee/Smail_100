//
//  UILabel+Utils.m
//  KYCategoryDemo
//
//  Created by mac_KY on 17/1/16.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)

//ios6 later
- (CGSize)autoSize{
    return [self.text boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
}
/**
 *  富文
 *
 *  @param Attributed      需改变的字符串
 *  @param AttributedColor 需改变字符串的颜色
 *  @param AttributedFont  <#AttributedFont description#>
 */

- (void)setAttributedWithString:(NSString *)Attributed andAttributedColor:(UIColor *)AttributedColor andAttributedFont:(UIFont *)AttributedFont{
    
    NSRange rang=[self.text rangeOfString:Attributed];
    
    UIColor * cuttentColor=AttributedColor?AttributedColor:self.textColor;
    
    NSMutableAttributedString * string=[[NSMutableAttributedString alloc] initWithString:self.text];
    [string addAttribute:NSForegroundColorAttributeName value:cuttentColor range:rang];
    
    if (AttributedFont) {
        [string addAttribute:NSFontAttributeName value:AttributedFont range:rang];
        
    }
    self.attributedText=string;
}

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                    textColor:(UIColor *)color
                         font:(UIFont*)font
{
    if (self = [super initWithFrame:frame]) {
        self.text = title;
        self.textColor = color;
        self.font = font;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}



- (UILabel *(^)(CGRect frame))ky_frame
{
    return ^(CGRect frame){
        [self setFrame:frame];
        return self;
    };
}
- (UILabel *(^)(UIColor *color))ky_color
{
    return ^(UIColor *color){
        self.textColor = color;
        return self;
    };
}
- (UILabel *(^)(NSString *title))ky_title
{
    return ^(NSString *title){
        self.text = title;
        return self;
    };
}
 
- (UILabel *(^)(UIFont *font))ky_font
{
    return ^(UIFont *font){
        self.font = font;
        return self;
    };
}
- (UILabel *(^)(NSTextAlignment alignment))ky_alignment
{
    return ^(NSTextAlignment alignment){
        self.textAlignment = alignment;
        return self;
    };
}
- (UILabel *(^)(NSUInteger  numberOfLines))ky_numberOfLines
{
    return ^(NSUInteger  numberOfLines){
        self.numberOfLines = numberOfLines;
        return self;
    };
}

@end
