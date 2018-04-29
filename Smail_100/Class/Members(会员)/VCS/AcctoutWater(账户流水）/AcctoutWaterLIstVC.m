//
//  AcctoutWaterLIstVC.m
//  Smail_100
//
//  Created by ap on 2018/3/15.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AcctoutWaterLIstVC.h"
#import "AcctoutWaterCell.h"
#import "AcctoutWaterModel.h"
#import "SmileForHeadView.h"

@interface AcctoutWaterLIstVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)NSUInteger page;
@property (nonatomic, strong) SmileForHeadView *headView;


@end

@implementation AcctoutWaterLIstVC
 static NSString* cellID = @"AcctoutWaterCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
    [self setRefresh];
    [self requestListNetWork];


}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


// 配置基础设置
- (void)setConfiguration
{
    _page = 1;
    self.view.backgroundColor = BACKGROUND_COLOR;
    
}

/// 初始化视图
- (void)setup
{
    [self.view addSubview:self.tableView];
    if (!KX_NULLString(_shopID)) {
        SmileForHeadView *headView = [[SmileForHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        headView.backgroundColor = [UIColor whiteColor];
        [headView layerForViewWith:0 AndLineWidth:0.5];
         headView.shopID = _shopID;

        self.tableView.tableHeaderView = headView;
        self.headView = headView;
    }

}


-(void)loadNewDate
{
    self.page = 1;
    [self requestListNetWork];
}

-(void)loadMoreData{
    
    self.page++;
    [self requestListNetWork];
}


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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64  - 45) style:UITableViewStylePlain];
        if (!KX_NULLString(_shopID)) {
            _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 );
        }
        _tableView.tableFooterView = [UIView new];//默认设置为空
        [_tableView setSeparatorInset:UIEdgeInsetsZero];//默认设置下划线左边移动 15.0f
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUND_COLOR;
        [_tableView registerNib:[UINib nibWithNibName:@"AcctoutWaterCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}


#pragma mark - 得到网络数据
-(void)requestListNetWork
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageno"];
    [param setObject:@"20" forKey:@"page_size"];
    if (!KX_NULLString(_shopID)) {
        [param setObject:_shopID?_shopID:@"" forKey:@"shop_id"];
        [param setObject:@"Shop" forKey:@"trans_type"];


    }
    else if (!KX_NULLString(_trans_type)){
        [param setObject:_trans_type forKey:@"trans_type"];
        [param setObject:_directions?_directions:@"" forKey:@"direction"];
        [param setObject:_type?_type:@"" forKey:@"type"];


    }
    else{
        [param setObject:_type?_type:@"" forKey:@"type"];
        if ([_type isEqualToString:@"Withdraw"]) {
            [param setObject:_type forKey:@"trans_type"];
        }
        [param setObject:_directions?_directions:@"" forKey:@"direction"];

    }

    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    
    [BaseHttpRequest postWithUrl:@"/ucenter/wealth_history" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单列表 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        NSString *msg = [result valueForKey:@"msg"];

        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            NSArray *dataArr = [result valueForKey:@"data"];
            NSArray *listArray  = [[NSArray alloc] init];
            if ([dataArr isKindOfClass:[NSArray class]]) {
                if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                    listArray = [AcctoutWaterModel mj_objectArrayWithKeyValuesArray:dataArr];
                    if (weakSelf.page == 1) {
                        [weakSelf.resorceArray removeAllObjects];
                    }
                    [weakSelf.resorceArray addObjectsFromArray:listArray];
                    
                    weakSelf.headView.dataDic = result;

                    [weakSelf.tableView reloadData];
                    [weakSelf stopRefresh];
                }
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
    AcctoutWaterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath] ;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AcctoutWaterModel * model = self.resorceArray[indexPath.section];
    if (!KX_NULLString(_shopID)) {
        model.shopId = _shopID;
    }
    cell.model = self.resorceArray[indexPath.section];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 65;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    OrderModel  *model = self.resorceArray[indexPath.section];
//    //    _waitSendVC.orderTypeTitle = @"4";
//    if ([_orderTypeTitle isEqualToString:@"4"]) {
//        SaleAfterVC *VC = [[SaleAfterVC alloc] init];
//        VC.model = model;
//        [self.navigationController pushViewController:VC animated:YES];
//    }else{
//        OrderDetailVC *VC = [[OrderDetailVC alloc] init];
//        VC.model = model;
//        [self.navigationController pushViewController:VC animated:YES];
//    }
    
    
}


@end
