//
//  KYDatePickView.h
//  TestCell
//
//  Created by Frank on 17/1/7.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^DidClickCompleteBlock)(NSString *selectDate);

typedef  NS_ENUM(NSInteger ,KYDatePickViewType)
{
    KYDatePickViewTypeAscending,                /// 不能选择小于今天的时间
    KYDatePickViewTypeNomal,                    /// 正常状态  时间随意选择
    KYDatePickViewTypeDescending,              /// 不能选择大于今天的时间
};

@interface KYDatePickView : UIView
/** 距离当前日期最小年份差 */
@property(assign, nonatomic) NSInteger minYear;
/** 距离当前日期最大年份差（>0小于当前日期，<0 当前日期） */
@property(assign, nonatomic) NSInteger maxYear;
/** 默认显示日期 */
@property (strong, nonatomic) NSDate *date;
/** 日期回调 */
@property(copy, nonatomic) DidClickCompleteBlock completeBlock;
/** 设置确认/取消字体颜色(默认为黑色) */
@property (strong, nonatomic) UIColor *fontColor;
/** 顶部栏标题 */
@property (strong, nonatomic) NSString *title;

/** 时间选择类型 */
@property (assign, nonatomic) KYDatePickViewType  datePickViewType;

/**时间格式*/
@property (nonatomic, assign) UIDatePickerMode datePickerMode;


/** show */
- (void)showDataPicKView;

@end
