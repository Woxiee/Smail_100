//
//  UICollectionView+KYRefresh.h
//  Smail_100
//
//  Created by ap on 2018/4/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (KYRefresh)

/**
 头部刷新
 
 @param headerBlock 调用bock
 */
-(void)headerWithRefreshingBlock:(void(^)())headerBlock;



/**
 尾部刷新
 
 @param footerBlock 调用block
 */
-(void)footerWithRefreshingBlock:(void(^)())footerBlock;


/**
 第一次更新
 */
-(void)headerFirstRefresh;

/**
 停止刷新 并控制上拉加载特性
 
 @param souceCount 数据源的个数
 @param pageIndex 页数
 */
-(void)stopFresh:(NSUInteger)souceCount pageIndex:(NSUInteger)pageIndex;
@end
