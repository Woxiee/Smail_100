//
//  KX_BaseRefresh.h
//  KX_Service
//
//  Created by Faker on 16/12/20.
//
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, KX_RefreshType){
    KXRefreshhTypeDropDown = 0,    //  只支持下拉刷新
    KXRefreshTypeDropUp = 1,       // 只支持上拉刷新
    KXRefreshTypeDouble = 2,       // 支持上下拉刷新
};

@interface KX_BaseRefresh : NSObject
/** 初始化*/
+(instancetype)sharedFKBestRefresh;

/**
 *
 *  tableView           当前tableView
 *  refreshType         需要刷新状态
 *  firstRefresh        是否第一次进页面
 *  timeLabHidden       时间label
 *  stateLabHidden      刷新状态Label
 *  downBlock           下拉刷新block
 *  upBlock             下拉刷新block
 *
 **/
- (void)nomalModelRefresh:(UITableView *)tableView
            kxRefreshType:(KX_RefreshType)refreshType
             firstRefresh:(BOOL)firstRefresh
            timeLabHidden:(BOOL)timeLabHidden
           stateLabHidden:(BOOL)stateLabHidden
            dropDownBlock:(void(^)(void))downBlock
              dropUpBlock:(void(^)(void))upBlock;

/**
 *  tableView           当前tableView
 *  结束刷新
 **/
- (void)endRefreshTableView:(UITableView *)tableView;

/**
 *  tableView           当前tableView
 *  结束刷新 并有提示
 **/
- (void)endRefreshingWithNoMoreDataTheTabelView:(UITableView *)tableView;


@end
