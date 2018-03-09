//
//  KCWebView.h
//  KCJSTOOCDemo
//
//  Created by mac_JP on 17/1/6.
//  Copyright © 2017年 mac_JP. All rights reserved.
//


typedef enum {
    KCWebViewStateTypeStartLoad = 0,
    KCWebViewStateTypeLoadSuccess,
    KCWebViewStateTypeLoadFail,
}KCWebViewStateType;

typedef void(^KCWebViewStateBlock)(KCWebViewStateType stateType);
#import <UIKit/UIKit.h>


@protocol KCWebViewDelegate <NSObject>
/**
 点击js按钮的事件
 
 @param classString 通过js传递的类名称
 @param transmit 通过js传递的相关数据（目前暂时支持一条）
 */
-(void)jsActionToClass:(NSString*)classString transmit:(NSString*)transmit;
@end


@interface KCWebView : UIWebView


/**引入代理 由于和父类重名 故改之*/
@property(nonatomic,weak)id <KCWebViewDelegate>kcDelegate;
/**
 初始化控件

 @param frame 控件frame
 @param urlString 植入的h5
 @param KCWebViewStateBlock 状态监听－可以处理动画事件
 @return we吧控件
 */
-(id)initWithFrame:(CGRect)frame
           loadUrl:(NSString *)urlString
        StateBlock:(KCWebViewStateBlock)KCWebViewStateBlock;


/**
 设置进度条的颜色

 @param viewController 在哪一个controller上面设置
 @param color 进度条的颜色  （默认 orangeColor 的）
 */
-(void)setProgressByController:(UIViewController *)viewController color:(UIColor *)color;


@end
