//
//  UIBarButtonItem+Utils.h
//  KYCategoryDemo
//
//  Created by mac_KY on 17/1/16.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Utils)

/**
 创建Item

 @param image normol状态的图片名称
 @param highImage 高粱状态的图片
 @param target 操作对象
 @param action 操作方法
 @return 返回UIbarButtonItem
 */
+ (instancetype) itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;


/**
 创建Item
 @param size 大小
 @param image normol状态的图片名称
 @param highImage 高粱状态的图片
 @param target 操作对象
 @param action 操作方法
 @return 返回UIbarButtonItem
 */
+ (instancetype) itemWithSize:(CGSize)size image:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
/**
  创建Item

 @param title item的标题
 @param target 操作对象
 @param action 操作方法
 @return 返回UIbarButtonItem
 */
+ (instancetype) itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;




+(instancetype )setBackBtnTarget:(id)target action:(SEL)action;
//+ (instancetype) itemWithSize:(CGSize)size image:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
