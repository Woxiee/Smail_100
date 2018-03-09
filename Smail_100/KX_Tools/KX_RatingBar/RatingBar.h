//
//  RatingBar.h
//  星星评价控件
//
//  Created by user on 15/7/2.
//  Copyright (c) 2015年 user. All rights reserved.
//问题 1中间的edge ＝ 5 为计算在frame中导致摸到第四个后面 第五个会显示  而第五个可能失灵  2.精度太大 灵活性能降低－最好使用颜色来处理－jp

#import <UIKit/UIKit.h>
@class RatingBar;
/**
 *  星级评分条代理
 */
@protocol RatingBarDelegate <NSObject>

/**
 *  评分改变
 *
 *  @param newRating 新的值
 */
- (void)ratingChanged:(float)newRating withRating:(RatingBar *)ratingBar;

@end

@interface RatingBar : UIView
/**
 *  初始化设置未选中图片、半选中图片、全选中图片，以及评分值改变的代理（可以用
 *  Block）实现
 *
 *  @param deselectedName   未选中图片名称
 *  @param halfSelectedName 半选中图片名称
 *  @param fullSelectedName 全选中图片名称
 *  @param delegate          代理
 */
- (void)setImageDeselected:(NSString *)deselectedName
              halfSelected:(NSString *)halfSelectedName
              fullSelected:(NSString *)fullSelectedName
               andDelegate:(id<RatingBarDelegate>)delegate;

/**
 *  设置评分值
 *
 *  @param rating 评分值
 */
- (void)displayRating:(float)rating;

/**
 *  获取当前的评分值
 *
 *  @return 评分值
 */
- (float)rating;

/**
 *  是否是指示器，如果是指示器，就不能滑动了，只显示结果，不是指示器的话就能滑动修改值
 *  默认为NO
 */
@property (nonatomic,assign) BOOL isIndicator;

@end
