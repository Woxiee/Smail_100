//
//  SuccessView.h
//  ShiShi
//
//  Created by mac_KY on 17/2/27.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewExt.h"

typedef NS_ENUM(NSInteger, SuccessStyle) {
    SuccessStyleDef = 0,
    SuccessStyleBottomWhite,
    SuccessStyleTrueCancle,//一个标题 右下角是确定 左下角是取消
};


@interface SuccessView : UIView<UITableViewDelegate>

@property(nonatomic,strong)NSString *imageStr;//可更换 头部图片
@property(nonatomic,strong)NSString *message;//中间提示
@property(nonatomic,strong)NSString *bottomStr;//底部的提示

@property(nonatomic,copy)void (^clickTrue)();
@property(nonatomic,copy)void (^clickCancle)();

+(id)success;


/**
 一个主题 一个对勾的图像 下面一个描述

 @param style 注意：请使用SuccessStyleDef
 @param title 主题
 @param subTitle 下面描述
 @return 返回一个alert
 */
-(id)initWithStyle:(SuccessStyle)style title:(NSString *)title subTitle:(NSString *)subTitle;


/**
 一个主题  下面左右两个按钮／确定、取消

 @param title 书体
 @param clickBlock 确定的回调  clickDex==1表示确定
 @return 一个alert的对象
 */
-(id)initWithTrueCancleTitle:(NSString *)title clickDex:(void(^)(NSInteger clickDex))clickBlock;


///是否显示取消按钮
-(id)initWithTrueCancleTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle clickDex:(void(^)(NSInteger clickDex))clickBlock;
-(void)showSuccess;
-(void)hideSuccess;//不做收回内存


@end
