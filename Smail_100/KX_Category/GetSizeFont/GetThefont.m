//
//  GetThefont.m
//  Sinllia_iPhone2.0
//
//  Created by Faker on 16/3/16.
//  Copyright © 2016年 Sinliia. All rights reserved.
//

#import "GetThefont.h"

@implementation GetThefont
/**
*获取文字size
*7.0之后的方法
*/
+ (CGSize)heightForString:(NSString *)value  fontSize:(UIFont *)font WithSize:(CGSize)size
{
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [value boundingRectWithSize:size
                                         options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                      attributes:attribute
                                         context:nil].size;
    
    return retSize;
}

@end
