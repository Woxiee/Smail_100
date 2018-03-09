//
//  UIView+LayerExtension.h
//  KX_Service
//
//  Created by ac on 16/8/1.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayerExtension)

/**
 *  正常调用
 *  @param radius    弧度大小
 *  @param width     边框的高度
 *
 */
-(void)layerForViewWith:(CGFloat)radius AndLineWidth:(CGFloat)width;


/**
 *  带颜色调用
 *  @param radius    弧度大小
 *  @param width     边框的高度
 *  @param color     自定义颜色
 */
-(void)layerForViewWithRadius:(CGFloat)radius AndLineWidth:(CGFloat)width AndColor:(UIColor *)color;

-(void)layerForViewWith:(CGFloat)radius AndLineWidth:(CGFloat)width withR:(CGFloat)r withG:(CGFloat)g withB:(CGFloat)b;

-(void)layerWithRadius:(CGFloat)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)color;


@end
