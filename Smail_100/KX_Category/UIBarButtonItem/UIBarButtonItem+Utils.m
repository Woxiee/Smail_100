//
//  UIBarButtonItem+Utils.m
//  KYCategoryDemo
//
//  Created by mac_KY on 17/1/16.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import "UIBarButtonItem+Utils.h"
 

@implementation UIBarButtonItem (Utils)

/**
 *  快速创建一个UIBarButtonItem
 *
 *  @param image     普通状态下的图片
 *  @param highImage 高亮状态下的图片
 *  @param target    目标
 *  @param action    方法
 */
+ (instancetype) itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
    
}


+ (instancetype) itemWithSize:(CGSize)size image:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setSize:size];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    CGSize imageSize = button.currentImage.size;
    button.contentMode = UIViewContentModeCenter;
    if (size.width <imageSize.width || size.height< imageSize.height) {
        button.contentMode = UIViewContentModeScaleAspectFit;
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
    
}


+ (instancetype) itemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    return item;
    
}

+(instancetype )setBackBtnTarget:(id)target action:(SEL)action;
{
    
    UIButton * leftNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftNaviBtn.frame=CGRectMake(0, 0, 44, 44);
    [leftNaviBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftNaviBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
    [leftNaviBtn setTitle:@"返回" forState:UIControlStateNormal];
    leftNaviBtn.titleLabel.font=[UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    [leftNaviBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    leftNaviBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    leftNaviBtn.backgroundColor=[UIColor clearColor];
    [leftNaviBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return   [[UIBarButtonItem alloc]initWithCustomView:leftNaviBtn];
   
    
}

 
@end
