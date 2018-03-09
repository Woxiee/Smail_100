//
//  UITableView+KYRefresh.h
//  KYRefreshDemo
//
//  Created by mac_KY on 17/1/15.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 
 ⚠️：
 //设置动画图片 stringWithFormat:@"dropdown_anim__000%zd",i]]; 最低30张30+
 // 设置即将刷新状态的动画图片（一松开就会刷新的状态） stringWithFormat:@"dropdown_loading_0%zd", i]];  3+最低三张
 */

@interface UITableView (KYRefresh)

/**
 头部有动画刷新

 @param target 触发动作对象
 @param action 触发动作
 */
-(void)gifHeaderWithRefreshingTarget:(id)target Action:(SEL)action;



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
 *  tableView           当前tableView
 *  结束刷新
 **/
- (void)endRefreshTableView;


/**
 *  tableView           当前tableView
 *  结束刷新 并有提示
 **/
- (void)endRefreshingWithNoMoreData;


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


#pragma mark - 针对cell和section的刷新

/**
 刷新具体的cell

 @param row row
 @param section section
 */
-(void)reloadDataFormRow:(int)row inSection:(int)section;

/**
 刷新具体的section

 @param section section
 */
-(void)reloadDataFormSection:(int)section;




@end
