//
//  ZHDatePickerView.h
//  ZHDatePickView
//
//  Created by 曾浩 on 2016/12/8.
//  Copyright © 2016年 曾浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHDatePickerView;

@protocol ZHDatePickerViewDelegate <NSObject>

- (void)didSelectDateResult:(NSString *)resultDate;

@end

@interface ZHDatePickerView : UIView

@property (nonatomic ,weak) id<ZHDatePickerViewDelegate> delegate;

/**
 显示PickerView
 */
- (void)show;

/**
 移除PickerView
 */
- (void)remove;

@end
