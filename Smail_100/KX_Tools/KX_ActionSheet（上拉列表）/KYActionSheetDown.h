//
//  KYActionSheetDown.h
//  CRM
//
//  Created by Frank on 17/1/7.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  NS_ENUM(NSInteger, TableViewCellTitleStateType)
{
    TableViewCellTitleStateTypeCenter,          /// 文字居中
    TableViewCellTitleStateTypeLeft,            /// 文字居左
    TableViewCellTitleStateTypeRight,           ///  文字居右
    TableViewCellTitleStateTypeOther,           /// 其他
};
@class KYActionSheetDown;
/**
 *  Handle click button.
 */
typedef void(^KYActionSheetClickedHandle)( NSInteger buttonIndex , NSInteger buttonTag);



@interface KYActionSheetDown : UIView
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
/**
 *  @param rect                 rect
 *  @param clickedHandle          clickedHandle
 *  @param otherButtonTitleArray otherButtonTitleArray
 *
 *  @return An instance of KX_ActionSheet.
 */
//+ (instancetype)sheetWithTitle:(NSString *)title
//             cancelButtonTitle:(NSString *)cancelButtonTitle
//                       clicked:(KYActionSheetClickedHandle)clickedHandle
//         otherButtonTitleArray:(NSArray *)otherButtonTitleArray;

+ (instancetype)sheetWithFrame:(CGRect)rect
                       clicked:(KYActionSheetClickedHandle)clickedHandle
         otherButtonTitleArray:(NSArray *)otherButtonTitleArray;
#pragma mark Show

/**
 *  Show the instance of KX_ActionSheet.
 */
- (void)show;

/**
 *  hidden the instance of KX_ActionSheet.
 */
- (void)hiddenSheetView;

@end
