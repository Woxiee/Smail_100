//
//  UILabel+Extension.m
//  Smail_100
//
//  Created by 家朋 on 2018/5/16.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
- (instancetype)initWithTitle:(NSString *)title
                         font:(UIFont *)font
                        color:(UIColor *)color
{
    if (self = [super init]) {
        
        self.text = title;
        self.textColor = color;
        self.font = font;
    }
    return self;
}
@end
