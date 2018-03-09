//
//  KX_FKPopMeumView.h
//  KX_Service
//
//  Created by Faker on 16/11/10.
//
//



#import <UIKit/UIKit.h>


#ifndef UIColorFromRGB
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((CGFloat)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]
#endif

#ifndef UIColorFromRGBA
#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((CGFloat)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]
#endif

typedef NS_ENUM(NSUInteger, FKPopupMenuArrowPosition) {
    FKPopupMenuArrowPositionTopLeft,
    FKPopupMenuArrowPositionTopRight,
    FKPopupMenuArrowPositionTopCenter,
    
    FKPopupMenuArrowPositionBottomLeft,
    FKPopupMenuArrowPositionBottomRight,
    FKPopupMenuArrowPositionBottomCenter,
    
    FKPopupMenuArrowPositionLeftTop,
    FKPopupMenuArrowPositionLeftBottom,
    FKPopupMenuArrowPositionLeftCenter,
    
    FKPopupMenuArrowPositionRightTop,
    FKPopupMenuArrowPositionRightBottom,
    FKPopupMenuArrowPositionRightCenter,
};

@interface FKPopupMenuItem : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imageName;

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName;

@end


@class KX_FKPopMeumView;
typedef void(^FKPopupMenuActionHandler)(KX_FKPopMeumView *view, NSUInteger index);

@interface KX_FKPopMeumView : UIView
@property (nonatomic, copy) NSArray *itemArray; //array of ICDPopupMenuItem

@property (nonatomic, strong) UIColor *tintColor;

@property (nonatomic, copy) FKPopupMenuActionHandler actionHandlerBlock;


//初始化方法，size为Menu大小，包括箭头
- (instancetype)initWithMenuSize:(CGSize)size;

//从导航栏左按钮或右按钮下方弹出
- (void)showFromNavigationBarButtonItem:(UIBarButtonItem *)barButtonItem;

//从某个控件（startView）对应位置弹出
- (void)showFromStartView:(UIView *)startView arrowPositon:(FKPopupMenuArrowPosition)position;

//从某个点弹出，inView为此点所在View
- (void)showFromStartPoint:(CGPoint)startPoint inView:(UIView *)inView arrowPositon:(FKPopupMenuArrowPosition)position;
@end
