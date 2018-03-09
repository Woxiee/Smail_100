//
//  KCWebProgress.h
//  KCJSTOOCDemo
//
//  Created by mac_JP on 17/1/6.
//  Copyright © 2017年 mac_JP. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface KCWebProgress : CAShapeLayer

- (instancetype)initWithColor:(UIColor *)color;

/** 开始加载 */
- (void)startLoad;
/** 完成加载 */
- (void)finishedLoadWithError:(NSError *)error;
/** 关闭时间 */
- (void)closeTimer;

/**
 修改进度的方法

 @param estimatedProgress 进度多少
 */
- (void)KCWebViewPathChanged:(CGFloat)estimatedProgress;

@end
