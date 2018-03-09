//
//  FK_SheetCoupsView.h
//  MyCityProject
//
//  Created by Macx on 2018/1/30.
//  Copyright © 2018年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^FKActionSheetCoupsClickedHandle)(NSInteger buttonIndex);

@interface FK_SheetCoupsView : UIView
@property (nonatomic, assign)  BOOL isCustom;
/**
 *  buttonColor  默认为block
 */
@property (nonatomic, strong) UIColor *buttonColor;
/**
 * buttonHeight  默认为 49.0f;
 */
@property (nonatomic, assign) CGFloat buttonHeight;
/**
 *  默认 0.3 seconds.
 */
@property (nonatomic, assign) CGFloat animationDuration;
/**
 *  buttonFont  默认为18
 */
@property (nonatomic, strong) UIFont *buttonFont;
/**
 * scrolling  默认为 NO
 */
@property (nonatomic, assign, getter=canScrolling) BOOL scrolling;
/**
 *  KX_ActionSheet clicked handle. 点击 Block
 */
@property (nonatomic, copy) KYActionSheetClickedHandle     clickedHandle;



/**
 *  TableViewCellTitleStateType. 默认居中
 */
@property (nonatomic, assign) TableViewCellTitleStateType  titleStateType;
/**
 *  oldSelectIndex. 记录上一次选择状态  默认为0
 */
@property (nonatomic, assign) NSInteger  oldSelectIndex;

/**
 *  otherButtonTitleArray.  自定义数据源  默认为nil
 */
@property (nonatomic, strong) NSArray *otherButtonTitleArray;

+ (instancetype)sheetWithFrame:(CGRect)rect
                       clicked:(KYActionSheetClickedHandle)clickedHandle
         otherButtonTitleArray:(NSArray *)otherButtonTitleArray;

- (void)show;
@end
