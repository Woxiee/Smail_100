//
//  UITableView+KYRefresh.m
//  KYRefreshDemo
//
//  Created by mac_KY on 17/1/15.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import "UITableView+KYRefresh.h"

#import "KYRefreshGifHeader.h"

#import "MJRefresh.h"

@implementation UITableView (KYRefresh)


/**头部有动画刷新 */
-(void)gifHeaderWithRefreshingTarget:(id)target Action:(SEL)action
{
    self.mj_header = [KYRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:action];
    [self.mj_header beginRefreshing];
}



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

#pragma mark - 针对cell和section的刷新

/**刷新具体的cell*/
-(void)reloadDataFormRow:(int)row inSection:(int)section
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row?row:0 inSection:section?section:0];
    [self reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

/**刷新具体的section*/
-(void)reloadDataFormSection:(int)section
{
    
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:section];
    [self reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
@end
