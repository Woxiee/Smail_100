//
//  UIView+LayerExtension.m
//  KX_Service
//
//  Created by ac on 16/8/1.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import "UIView+LayerExtension.h"

@implementation UIView (LayerExtension)

-(void)layerForViewWith:(CGFloat)radius AndLineWidth:(CGFloat)width
{
    //画边框
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
    [self.layer setBorderWidth:width];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 200/255.0, 200/255.0, 200/255.0, 0.5 });
    [self.layer setBorderColor:colorref];
}

-(void)layerForViewWithRadius:(CGFloat)radius AndLineWidth:(CGFloat)width AndColor:(UIColor *)color
{
    //画边框
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
    [self.layer setBorderWidth:width];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 246/255.0, 58/255.0, 66/255.0, 0.5 });
    [self.layer setBorderColor:colorref];
}

-(void)layerForViewWith:(CGFloat)radius AndLineWidth:(CGFloat)width withR:(CGFloat)r withG:(CGFloat)g withB:(CGFloat)b
{
    //画边框
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
    [self.layer setBorderWidth:width];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ r/255.0, g/255.0, b/255.0, 0.5 });
    [self.layer setBorderColor:colorref];
}

-(void)layerWithRadius:(CGFloat)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)color
{
    //画边框
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
    [self.layer setBorderWidth:lineWidth];
    [self.layer setBorderColor:color.CGColor];
}

@end
