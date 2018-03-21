//
//  GoodsManagersListVC.m
//  Smile_100
//
//  Created by ap on 2018/2/28.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "GoodsManagersListVC.h"
#import "GoodsManagerView.h"
#import "GoodsManageView.h"
#import "MeChantOrderModel.h"
#import "AddOrEidtGoodVC.h"

@interface GoodsManagersListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)NSUInteger page;

@end

@implementation GoodsManagersListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
    [self setRefresh];
    [self requestListNetWork];

}

/// 配置基础设置
- (void)setConfiguration
{
    
}


/// 初始化视图
- (void)setup
{
    [self.view addSubview:self.tableView];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, 50);
    [btn setTitle:@"发布商品" forState:UIControlStateNormal];
    btn.backgroundColor = MainColor;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBottomAction) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = Font15;
    [self.view addSubview:btn];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsManagerView" bundle:nil] forCellReuseIdentifier:@"ManagementCellID"];
}



#pragma mark - 得到网络数据
-(void)requestListNetWork
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageno"];
    [param setObject:@"20" forKey:@"page_size"];
    [param setObject:_orderTypeTitle forKey:@"status"];
    //    [param setObject:_quickSearch forKey:@"quickSearch"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/shop/goods_list" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"商品订单 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = [result valueForKey:@"msg"];
//        NSDictionary *dic = result[@"data"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            NSArray *listArray  = [[NSArray alloc] init];
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                listArray = [MeChantOrderModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
                if (weakSelf.page == 0) {
                    [weakSelf.resorceArray removeAllObjects];
                }
                [weakSelf.resorceArray addObjectsFromArray:listArray];
                [weakSelf.tableView reloadData];
                [weakSelf stopRefresh];
            }
        }else{
            [weakSelf showHint:msg];
            
        }
    }];

}


- (void)editGoodList:(MeChantOrderModel *)model andUrl:(NSString *)url
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:model.goods_id forKey:@"goods_id"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];

    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:url andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"商品订单 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = [result valueForKey:@"msg"];
        //        NSDictionary *dic = result[@"data"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            
            NSArray *listArray  = [[NSArray alloc] init];
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
//                listArray = [MeChantOrderModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
//                if (weakSelf.page == 0) {
//                    [weakSelf.resorceArray removeAllObjects];
//                }
//                [weakSelf.resorceArray addObjectsFromArray:listArray];
//                [weakSelf.tableView reloadData];
//                [weakSelf stopRefresh];
                [weakSelf showHint:msg];
                [weakSelf requestListNetWork];

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    static NSString* cellID = @"ManagementCellID";
    GoodsManagerView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell ) {
        cell = [[GoodsManagerView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    MeChantOrderModel *model = self.resorceArray[indexPath.section];
    cell.model = model;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    WEAKSELF;
    GoodsManageView *footView = [[NSBundle mainBundle] loadNibNamed:@"GoodsManageView" owner:nil options:nil].lastObject;
    MeChantOrderModel *model = self.resorceArray[section];

    footView.didClickChangBtnBlock = ^(NSInteger index) {
        /// 0上架 1 编辑  2 删除
        if (index == 0) {
//            AddOrEidtGoodVC *VC =  [[AddOrEidtGoodVC alloc] init];
//            VC.model  = model;
//            [weakSelf.navigationController pushViewController:VC animated:YES];
        }
        if (index == 1) {
            AddOrEidtGoodVC *VC =  [[AddOrEidtGoodVC alloc] init];
            VC.model  = model;
            [weakSelf.navigationController pushViewController:VC animated:YES];
//            [weakSelf editGoodList:model andUrl:@"/shop/goods_delete"];

        }
        if (index == 2) {
            [weakSelf editGoodList:model andUrl:@"/shop/goods_delete"];

        }
    };
    return footView;
}

#pragma mark - refresh 添加刷新方法
-(void)setRefresh
{
    WEAKSELF;
    [self.tableView headerWithRefreshingBlock:^{
        [weakSelf loadNewDate];
    }];
    
    [self.tableView footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}

-(void)loadNewDate
{
    self.page = 0;
//    _quickSearch = @"";
    [self requestListNetWork];
}

-(void)loadMoreData{
    
    self.page++;
    [self requestListNetWork];
}

-(void)stopRefresh
{
    [self.tableView stopFresh:self.resorceArray.count pageIndex:self.page];
    if (self.resorceArray.count == 0) {
        [self.tableView addSubview:[KX_LoginHintView notDataView]];
    }else{
        [KX_LoginHintView removeFromSupView:self.tableView];
    }
    
}

#pragma mark - set懒加载
/*懒加载*/
-(UITableView *)tableView
{
    if (!_tableView) {
        //初始化数据
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 50 - 45) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];//默认设置为空
        [_tableView setSeparatorInset:UIEdgeInsetsZero];//默认设置下划线左边移动 15.0f
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUND_COLOR;
    }
    return _tableView;
}


- (void)didClickBottomAction
{
    AddOrEidtGoodVC *VC =  [[AddOrEidtGoodVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}


@end
