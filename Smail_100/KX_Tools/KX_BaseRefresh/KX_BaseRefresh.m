//
//  KX_BaseRefresh.m
//  KX_Service
//
//  Created by Faker on 16/12/20.
//
//

#import "KX_BaseRefresh.h"

@interface KX_BaseRefresh ()
//上拉时候触发的block
@property (nonatomic, copy) void(^DropDownRefreshBlock)();
//上拉时候触发的block
@property (nonatomic, copy) void(^UpDropRefreshBlock)();

@end

@implementation KX_BaseRefresh
/** 初始化*/
+(instancetype)sharedFKBestRefresh
{
    static KX_BaseRefresh *baseRefresh = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseRefresh = [[KX_BaseRefresh alloc] init];
    });
    return baseRefresh;
}


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
- (void)nomalModelRefresh:(UITableView *)tableView kxRefreshType:(KX_RefreshType)refreshType firstRefresh:(BOOL)firstRefresh timeLabHidden:(BOOL)timeLabHidden stateLabHidden:(BOOL)stateLabHidden dropDownBlock:(void(^)(void))downBlock dropUpBlock:(void(^)(void))upBlock
{
    /// 下来刷新
    if (refreshType == KXRefreshhTypeDropDown) {
        self.DropDownRefreshBlock = downBlock;
        /// 初始化
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
            if (self.DropDownRefreshBlock) {
                self.DropDownRefreshBlock();
            }
        }];
        ///是否隐藏上次更新的时间
        header.lastUpdatedTimeLabel.hidden = timeLabHidden;
        ///是否隐藏刷新状态
        header.stateLabel.hidden = stateLabHidden;
        tableView.mj_header = header;
        /// 是否首次进来自动刷新
        if (firstRefresh) {
            [tableView.mj_header beginRefreshing];
        }
        ///透明度渐变
        tableView.mj_header.automaticallyChangeAlpha = YES;
    }
    
    /// 上拉加载
    else if (refreshType == KXRefreshTypeDropUp) {
        self.UpDropRefreshBlock = upBlock;
       tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
           if (self.UpDropRefreshBlock) {
               self.UpDropRefreshBlock();
           }
       }];
    }
    /// 上下拉都支持
    else if (refreshType == KXRefreshTypeDouble){
        ///支持上拉和下拉加载
        self.DropDownRefreshBlock = downBlock;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
            if (self.DropDownRefreshBlock) {
                self.DropDownRefreshBlock();
            }
        }];
        header.lastUpdatedTimeLabel.hidden = timeLabHidden;
        ///是否隐藏刷新状态label
        header.stateLabel.hidden = stateLabHidden;
        ///tableView.mj_header接收header
        tableView.mj_header = header;
        ///首次进来是否需要刷新
        if (firstRefresh) {
            [tableView.mj_header beginRefreshing];
        }
        ///透明度渐变
        tableView.mj_header.automaticallyChangeAlpha = YES;
        
        self.UpDropRefreshBlock = upBlock;
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (self.UpDropRefreshBlock) {
                self.UpDropRefreshBlock();
            }
        }];
    }
   
}

/**
 *  tableView           当前tableView
 *  结束刷新
 **/
- (void)endRefreshTableView:(UITableView *)tableView{
    [tableView.mj_header endRefreshing];
    [tableView.mj_footer endRefreshing];
}

/**
 *  tableView           当前tableView
 *  结束刷新 并有提示
 **/
- (void)endRefreshingWithNoMoreDataTheTabelView:(UITableView *)tableView
{
    [tableView.mj_header endRefreshing];
    [tableView.mj_footer endRefreshingWithNoMoreData];
}

@end
