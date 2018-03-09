//
//  KYProgramTimeView.h
//  CRM
//
//  Created by Frank on 17/1/6.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYProgramTimeView : UIView
/// 背景色值
@property (nonatomic, strong)  UIColor *bgViewColor;
/// 进度条色值
@property (nonatomic, strong)  UIColor *programColor;
/// 计时栏色值
@property (nonatomic, strong)  UIColor *presentColor;
/// 峰值
@property (nonatomic, assign)  float maxValue;
/// 计时间隔  默认为0.1
@property (nonatomic, assign)  CGFloat  timeInterval;
///默认值
@property (nonatomic, assign)  float defuleValue;
///计时栏 字体大小  默认为 15
@property (nonatomic, assign)  CGFloat presentLabFont;

/// 开始执行动画
- (void)programTimeStart;
// 停止计时执行动画
-(void)programTimerEnd;
@end
