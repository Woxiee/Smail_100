//
//  KYGotoHeaderAndShowCountView.h
//  ShiShi
//
//  Created by Faker on 17/3/24.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^KYGotoHeaderAndShowCountViewBlock)();

@interface KYGotoHeaderAndShowCountView : UIView

+ (instancetype)shareFKHeaderAndShowCountViewWithFrame:(CGRect)frame view:(UIView*) view block:(KYGotoHeaderAndShowCountViewBlock)block;

/*
 *
 *    @param cCount  当前数量
 *    @param mCount  当前总数量
 */
- (void)fkGotoHeaderAndShowCountViewWhitCurrentCout:(NSInteger)cCount max:(NSInteger)mCount;


- (void)fkGotoHeaderAndShowCountViewWithScrollView:(UIScrollView *)scrollView;
///删除
- (void)removeGotoHeaderAndShowCountView;
/// 添加
- (void)addGotoHeaderAndShowCountView;
@end
