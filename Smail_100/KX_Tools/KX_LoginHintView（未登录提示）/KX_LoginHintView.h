//
//  KX_LoginHintView.h
//  KX_Service
//
//  Created by Faker on 16/10/13.
//
//

#import <UIKit/UIKit.h>


@protocol LoginHidtViewDelegate <NSObject>
@optional
/// 点击 无数据按钮 
- (void)didClickNoDataBtnInHintView;
@end

@interface KX_LoginHintView : UIView
@property (nonatomic, weak) id<LoginHidtViewDelegate> delegate;
+ (instancetype) loginHintViewWithImage:(NSString *)image andMsg:(NSString *)msg andBtnTitle:(NSString *)title andFrame:(CGRect)frame;

+(instancetype) notDataView;

//JP
+(void) notDataView:(UIView *)superView;
+(void)removeFromSupView:(UIView *)supView;
@end
