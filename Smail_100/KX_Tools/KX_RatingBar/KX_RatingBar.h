//
//  KX_RatingBar.h
//  KX_Service
//
//  Created by ac on 16/8/9.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KX_RatingBar;

/**
 *  星级评分条代理
 */
@protocol RatingBarDelegate <NSObject>

/**
 *  评分改变
 *
 *  @param ratingBar 评分控件
 *  @param newRating 评分值
 */
- (void)ratingBar:(KX_RatingBar *)ratingBar ratingChanged:(int)newRating;
@end



@interface KX_RatingBar : UIView
/**
 *  初始化设置未选中图片、半选中图片、全选中图片，以及评分值改变的代理（可以用
 *  Block）实现
 *
 *  @param deselectedName   未选中图片名称
 *  @param halfSelectedName 半选中图片名称
 *  @param fullSelectedName 全选中图片名称
 *  @param delegate          代理
 */
- (void)setImageDeselected:(NSString *)deselectedName halfSelected:(NSString *)halfSelectedName fullSelected:(NSString *)fullSelectedName andDelegate:(id<RatingBarDelegate>)delegate;

/**
 *  设置评分值
 *
 *  @param rating 评分值
 */
- (void)displayRating:(int)rating;

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
