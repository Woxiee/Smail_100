//
//  UICollectionView+KYRefresh.m
//  Smail_100
//
//  Created by ap on 2018/4/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "UICollectionView+KYRefresh.h"

@implementation UICollectionView (KYRefresh)
/**头部刷新*/
-(void)headerWithRefreshingBlock:(void(^)())headerBlock
{
    
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        headerBlock();
    }];
    
}



/**尾部刷新 */
-(void)footerWithRefreshingBlock:(void(^)())footerBlock
{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        footerBlock();
    }];
    
}

/** tableView           当前tableView  结束刷新
 **/
- (void)endRefreshTableView
{
    [self.mj_footer endRefreshing];
    [self.mj_header endRefreshing];
}


/**tableView           当前tableView  结束刷新 并有提示**/
- (void)endRefreshingWithNoMoreData
{
    [self.mj_footer endRefreshingWithNoMoreData];
    [self.mj_header endRefreshing];
}


/**第一次更新 */
-(void)headerFirstRefresh
{
    [self.mj_header beginRefreshing];
    
}

/**停止刷新 并控制上拉加载特性 */

-(void)stopFresh:(NSUInteger)souceCount pageIndex:(NSUInteger)pageIndex{
    if (souceCount == 0) {
        [KX_LoginHintView notDataView:self];
    }else{
        [KX_LoginHintView removeFromSupView:self];
    }
    if (souceCount<(pageIndex+1)*(KYPageSize.integerValue)) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.mj_footer endRefreshing];
    }
    [self.mj_header endRefreshing];
    
}
@end
