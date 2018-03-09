//
//  KX_ActionSheet.h
//  KX_SheetView
//
//  Created by Faker on 16/12/1.
//  Copyright © 2016年 Faker. All rights reserved.
//
/// 获取RGB颜色
#define RGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)  RGBA(r,g,b,1.0f)
#import <UIKit/UIKit.h>
@class KX_ActionSheet;
/**
 *  Handle click button.
 */
typedef void(^FKActionSheetClickedHandle)(KX_ActionSheet *actionSheet, NSInteger buttonIndex);
/**
 *  Handle action sheet will present.
 */
typedef void(^FKActionSheetWillPresentHandle)(KX_ActionSheet *actionSheet);
/**
 *  Handle action sheet did present.
 */
typedef void(^FKActionSheetDidPresentHandle)(KX_ActionSheet *actionSheet);

/**
 *  Handle action sheet will dismiss.
 */
typedef void(^FKActionSheetWillDismissHandle)(KX_ActionSheet *actionSheet, NSInteger buttonIndex);
/**
 *  Handle action sheet did dismiss.
 */
typedef void(^FKActionSheetDidDismissHandle)(KX_ActionSheet *actionSheet, NSInteger buttonIndex);


@interface KX_ActionSheet : UIView
/**
 *  Title.
 */
@property (nonatomic, copy) NSString *title;
/**
 *  cancelButtonTitle
 */
@property (nonatomic, copy) NSString *cancelButtonTitle;
/**
 *  Cancel button's index.
 */
@property (nonatomic, assign, readonly) NSInteger cancelButtonIndex;

/**
 *  titleColor
 */
@property (nonatomic, strong) UIColor *titleColor;
/**
 *  buttonColor  默认为block
 */
@property (nonatomic, strong) UIColor *buttonColor;
/**
 *  titleFont  默认为14
 */
@property (nonatomic, strong) UIFont *titleFont;
/**
 *  buttonFont  默认为18
 */
@property (nonatomic, strong) UIFont *buttonFont;
/**
 * buttonHeight  默认为 49.0f;
 */
@property (nonatomic, assign) CGFloat buttonHeight;
/**
 * scrolling  默认为 NO
 */
@property (nonatomic, assign, getter=canScrolling) BOOL scrolling;
/**
 * visibleButtonCount
 */
@property (nonatomic, assign) CGFloat visibleButtonCount;
/**
 *  默认 0.3 seconds.
 */
@property (nonatomic, assign) CGFloat animationDuration;
/**
 *  背景黑色 默认透明度为 0.3f.
 */
@property (nonatomic, assign) CGFloat darkOpacity;

/**
 *  UIBlurEffectStyle
 */
@property (nonatomic, assign) UIBlurEffectStyle blurEffectStyle;

/**
 *  If you can tap darkView to dismiss. Defalut is NO, you can tap dardView to dismiss.
 */
@property (nonatomic, assign) BOOL darkViewNoTaped;
/**
 *  文字偏移量   默认为(15.0f, 15.0f, 15.0f, 15.0f)`.
 */
@property (nonatomic, assign) UIEdgeInsets titleEdgeInsets;

/**
 *  destructiveButtonIndexSet 控制cell 的title的颜色区间
 */
@property (nonatomic, strong) NSSet *destructiveButtonIndexSet;

/**
 *  destructiveButtonColor  默认 RGB(255, 10, 10) 控制 自定义颜色
 */
@property (nonatomic, strong) UIColor *destructiveButtonColor;

/**
 *  KX_ActionSheet clicked handle. 点击 Block
 */
@property (nonatomic, copy) FKActionSheetClickedHandle     clickedHandle;
/**
 *  KX_ActionSheet clicked handle. 将要点击 Block
 */
@property (nonatomic, copy) FKActionSheetWillPresentHandle willPresentHandle;
/**
 *  KX_ActionSheet clicked handle. 已经点击Block
 */
@property (nonatomic, copy) FKActionSheetDidPresentHandle  didPresentHandle;
/**
 *  KX_ActionSheet clicked handle. 将要Dismiss Block
 */
@property (nonatomic, copy) FKActionSheetWillDismissHandle willDismissHandle;
/**
 *  KX_ActionSheet clicked handle. Dismiss Block
 */
@property (nonatomic, copy) FKActionSheetDidDismissHandle  didDismissHandle;



#pragma mark Block

/**
 *  @param title             title
 *  @param cancelButtonTitle cancelButtonTitle
 *  @param clickedHandle      clickedHandle
 *  @param otherButtonTitles otherButtonTitles
 *
 *  @return An instance of KX_ActionSheet.
 */
+ (instancetype)sheetWithTitle:(NSString *)title
             cancelButtonTitle:(NSString *)cancelButtonTitle
                       clicked:(FKActionSheetClickedHandle)clickedHandle
             otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *  @param title                 title
 *  @param clickedHandle          clickedHandle
 *  @param otherButtonTitleArray otherButtonTitleArray
 *
 *  @return An instance of KX_ActionSheet.
 */
+ (instancetype)sheetWithTitle:(NSString *)title
             cancelButtonTitle:(NSString *)cancelButtonTitle
                       clicked:(FKActionSheetClickedHandle)clickedHandle
         otherButtonTitleArray:(NSArray *)otherButtonTitleArray;



#pragma mark Show

/**
 *  Show the instance of KX_ActionSheet.
 */
- (void)show;


@end
