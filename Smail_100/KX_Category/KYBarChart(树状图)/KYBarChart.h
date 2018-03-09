//
//  KYBarChart.h
//  TestCell
//
//  Created by Frank on 17/1/5.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYBarChart : UIView
///数据源
@property (nonatomic) NSArray *data;
///底部标题
@property (nonatomic) NSArray *xLabels;
/// 最大值
@property (nonatomic) IBInspectable CGFloat max;
/// 是否需要设 最大值 默认为NO 开启之后制动识别 已传入数据 最大值为峰值
@property (nonatomic) IBInspectable BOOL autoMax;
/// 树状 颜色
@property (nonatomic) IBInspectable UIColor *barColor;
/// 树状 颜色 数据源
@property (nonatomic) NSArray *barColors;

@property (nonatomic) IBInspectable NSInteger barSpacing;

@property (nonatomic) IBInspectable UIColor *backgroundColor;
/// 字体大小
@property (nonatomic, assign) float fontSize;
// 高清  默认有
@property (nonatomic) IBInspectable BOOL roundToPixel;
@end
