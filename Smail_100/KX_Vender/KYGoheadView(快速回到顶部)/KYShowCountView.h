//
//  KYShowCountView.h
//  ShiShi
//
//  Created by Faker on 17/3/24.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KYShowCountView;

@protocol ShowCountViewDelegate <NSObject>

@optional
- (void)showCountViewDidClick:(KYShowCountView *)view;

@end

@interface KYShowCountView : UIView
@property (nonatomic,assign) id <ShowCountViewDelegate> delegate;
/// 初始化
- (instancetype) initWithFrame:(CGRect)frame withSuperView:(UIView *)superView;

/*
 *     显示数目按钮
 *    @param cCount  当前数量
 *    @param mCount  当前总数量
 *    @param show  是否显示数目
 */
- (void)showCountViewWithCurrentCount:(NSInteger)cCount withMaxCount:(NSInteger)mCount show:(BOOL)show;
@end
