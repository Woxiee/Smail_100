//
//  KX_FKDatePickView.h
//  KX_Service
//
//  Created by kechao wu on 16/8/31.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MyBlockType)(NSString *selectDate);

@interface KX_FKDatePickView : UIView

/** 距离当前日期最大年份差（>0小于当前日期，<0 当前日期） */
@property(assign, nonatomic) NSInteger maxYear;

/** 距离当前日期最小年份差 */
@property(assign, nonatomic) NSInteger minYear;

/** 默认显示日期 */
@property (strong, nonatomic) NSDate *date;

/** 日期回调 */
@property(copy, nonatomic) MyBlockType completeBlock;

/** 设置确认/取消字体颜色(默认为黑色) */

@property (strong, nonatomic) UIColor *fontColor;
@property (strong, nonatomic) NSString *title;

//配置
- (void)configuration;

@end
