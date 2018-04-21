//
//  AgentPlatfoemListVC.m
//  Smail_100
//
//  Created by ap on 2018/3/22.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AgentPlatfoemListVC.h"
#import "AgentPlatfoemListCell.h"
#import "AgentPlatformModel.h"
#import "AgentPlatfoemListCell.h"

@interface AgentPlatfoemListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)NSUInteger page;

@end

@implementation AgentPlatfoemListVC
static NSString* cellID = @"AgentPlatfoemListCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
    [self setRefresh];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestListNetWork];
    
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64  - 45) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];//默认设置为空
        [_tableView setSeparatorInset:UIEdgeInsetsZero];//默认设置下划线左边移动 15.0f
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUND_COLOR;
        [_tableView registerNib:[UINib nibWithNibName:@"AgentPlatfoemListCell" bundle:nil] forCellReuseIdentifier:cellID];
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
    [param setObject:_orderState forKey:@"status"];
//    [param setObject:_direction forKey:@"direction"];
//    [param setObject:_trans_type forKey:@"trans_type"];
    //    [param setObject:_quickSearch forKey:@"quickSearch"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/shop/examine_shop_list" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单列表 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            NSArray *dataArr = [result valueForKey:@"data"];
            NSArray *listArray  = [[NSArray alloc] init];
            if ([dataArr isKindOfClass:[NSArray class]]) {
                if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                    listArray = [AgentPlatformModel mj_objectArrayWithKeyValuesArray:dataArr];
                    if (weakSelf.page == 1) {
                        [weakSelf.resorceArray removeAllObjects];
                    }
                    [weakSelf.resorceArray addObjectsFromArray:listArray];
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
    AgentPlatfoemListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath] ;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.resorceArray[indexPath.section];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 175;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
}


@end
