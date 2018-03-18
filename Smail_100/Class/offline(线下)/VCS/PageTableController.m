//
//  PageTableController.m
//  ScrollViewAndTableView
//
//  Created by fantasy on 16/5/14.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "PageTableController.h"
#import "GoodsDetailVC.h"
#import "LineOffGoodsCell.h"
#import "OffLineModel.h"
#import "GoodsClassModel.h"

@interface PageTableController ()

@property (strong, nonatomic) NSArray * titleArray;
@property(nonatomic,assign)NSUInteger page;

@end

@implementation PageTableController
static NSString * const llineOffGoodsCell = @"LineOffGoodsCellID";


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;

    [self.tableView registerNib:[UINib nibWithNibName:@"LineOffGoodsCell" bundle:nil] forCellReuseIdentifier:llineOffGoodsCell];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self requestListNetWork];
}



- (void)requestListNetWork
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageno"];
    [param setObject:@"20" forKey:@"page_size"];
    [param setObject:@"" forKey:@"type"];
    [param setObject:_category_id?_category_id:@"" forKey:@"category_id"];
    [param setObject:_xy?_xy:@"" forKey:@"xy"];
    [param setObject:_order?_order:@"" forKey:@"order"];
//    [param setObject:@"" forKey:@"sort"];
    [param setObject:_q?_q:@"" forKey:@"q"];

//    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    
    [BaseHttpRequest postWithUrl:@"/shop/shop_list" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单列表 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dic = result[@"data"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            NSArray *listArray  = [[NSArray alloc] init];
                if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                    listArray = [OffLineModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
                    NSArray *banner = [Banners mj_objectArrayWithKeyValuesArray:dic[@"banners"]];
                    if (weakSelf.page == 0) {
                        [weakSelf.resorceArray removeAllObjects];
                    }
                    [weakSelf.resorceArray addObjectsFromArray:listArray];
                    [weakSelf.tableView reloadData];
                    [weakSelf setRefreshs];
                }
        }else{
            [weakSelf showHint:msg];
            
        }
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resorceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    OffLineModel *model = self.resorceArray[indexPath.row];
    LineOffGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:llineOffGoodsCell];
    if (cell == nil) {
        cell = [[LineOffGoodsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:llineOffGoodsCell];
    }
    cell.model = model;
    return cell;
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                 navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    //    vc.productID = model.mainResult.mainId;
    //    vc.typeStr = model.productType;
    vc.hidesBottomBarWhenPushed = YES;
    [self.superVC.navigationController pushViewController: vc animated:YES];
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
  if (scrollView == self.tableView && self.tableViewDidScroll) {
    
    self.tableViewDidScroll(self.tableView.contentOffset.y);
    
  }
  
}




-(void)loadNewDate
{
    self.page = 0;
    [self requestListNetWork];
}

-(void)loadMoreData{
    
    self.page++;
    [self requestListNetWork];
}

-(void)setRefreshs
{
    [self.tableView stopFresh:self.resorceArray.count pageIndex:self.page];
    if (self.resorceArray.count == 0) {
        [self.tableView addSubview:[KX_LoginHintView notDataView]];
    }else{
        [KX_LoginHintView removeFromSupView:self.tableView];
    }
    
}

     
@end
