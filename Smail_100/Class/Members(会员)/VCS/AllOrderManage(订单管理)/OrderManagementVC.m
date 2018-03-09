//
//  OrderManagementVC.m
//  MyCityProject
//
//  Created by Faker on 17/6/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderManagementVC.h"
//#import "ManagementCell.h"
//#import "ManagementFooter.h"
//#import "NewmanagementVC.h"
//#import "ManagementModel.h"
#import "OrderVModel.h"
#import "OrderCell.h"
#import "CloseReasonView.h"
#import "OrderCollectCell.h"
#import "OrderAutionCell.h"
#import "OrderDetailVC.h"
#import "SendCommentsVC.h"
//#import "ContractDetailVC.h"
//#import "GoodsAuctionDetailVC.h"
@interface OrderManagementVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)NSUInteger page;

@property(nonatomic,strong) NSString *orderStatus;


@end

@implementation OrderManagementVC




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

/// 配置基础设置
- (void)setConfiguration
{
//    AllOrderType,                   /// 所有
//    WaitOrderType,                  ///待审核
//    WaitSendOrderType,              ///待发货
//    DidSendOrderType,               /// 已发货
//    ComplteOrderType,               ///  已完成
//    DownOrderType,                  ///  已关闭
    _page = 0;
    _quickSearch = @"";
    self.view.backgroundColor = BACKGROUND_COLOR;
    if (_orderType == AllOrderType) {
        _orderStatus = @"";
    }
    else if (_orderType == WaitOrderType || _orderType == JoinOrderType)
    {
        _orderStatus = @"1";

    }
    else if (_orderType == SigningOrderType || _orderType == ComplteAuctionType)
    {
        _orderStatus = @"2";
        
    }
    
    else if (_orderType == WaitSendOrderType ||  _orderType == WaitServiceOrderType)
    {
        _orderStatus = @"3";

    }
    
    else if (_orderType == DidSendOrderType || _orderType == HasServiceOrderType)
    {
        _orderStatus = @"4";

    }
    
    else if (_orderType == DidClosedOrderType || _orderType == RentingOrderType || _orderType ==HasSureOrderType)
    {
        _orderStatus = @"5";
    }
        
    else if (_orderType == ComplteOrderType)
    {
        _orderStatus = @"6";
    }
    
    else if (_orderType == DownOrderType)
    {
        _orderStatus = @"0";
    }
    
    
    else{
        _orderStatus = @"0";
    }
    
//    if (self.orderType == AllOrderType || self.orderType == JoinOrderType) {
//        [self requestListNetWork];
//    }
}

/// 初始化视图
- (void)setup
{
    [self.view addSubview:self.tableView];
}




#pragma mark - 得到网络数据
-(void)requestListNetWork
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageIndex"];
    [param setObject:@"10" forKey:@"pageSize"];
    [param setObject:_orderTypeTitle forKey:@"orderType"];
    [param setObject:_quickSearch forKey:@"quickSearch"];
    
    if (_supplListRoleType == sellingSupplListRoleType) {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].bid forKey:@"bid"];
      
    }else{
        [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
    }
    
//    if (_orderType == JoinOrderType) {
//        [param setObject:@"6" forKey:@"orderStatus"];
//    }else{
//    }
    [param setObject:_orderStatus forKey:@"orderStatus"];

    
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [OrderVModel getOrderListParam:param successBlock:^(NSArray<OrderModel *> *dataArray, BOOL isSuccess){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (isSuccess) {
            if (weakSelf.page == 0) {
                [weakSelf.resorceArray removeAllObjects];
            }
            [weakSelf.resorceArray addObjectsFromArray:dataArray];
            [weakSelf.tableView reloadData];
            
        }else{
        
        }
        [weakSelf stopRefresh];
        
    }];
}

/// 处理订单操作
- (void)operationRequestUrl:(NSString *)url Param:(id)param
{
    WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [OrderVModel getOrderOperationUrl:url Param:param successBlock:^( BOOL isSuccess,NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isSuccess) {
            [weakSelf.view toastShow:@"操作成功~"];
            [weakSelf requestListNetWork];
        }else{
            [weakSelf.view toastShow:message];
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
//    if (_isCollect ) {
//        if(_orderType == JoinOrderType)
//        {
//            OrderCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//            if (!cell ) {
//                cell = [[OrderCollectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//            }
//
//            cell.model = self.resorceArray[indexPath.section];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.DidClickOrderCellBlock  = ^(NSString *title){
//                LOG(@"title = %@",title);
//                [weakSelf operationOrderWithTitle:title OrderModel:self.resorceArray[indexPath.section]];
//            };
//            return cell;
//        }else{
//            OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//            if (!cell ) {
//                cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//            }
//            cell.cellType = BuyOrderCellType;
//
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.model = self.resorceArray[indexPath.section];
//            cell.DidClickOrderCellBlock  = ^(NSString *title){
//                LOG(@"title = %@",title);
//                [weakSelf operationOrderWithTitle:title OrderModel:self.resorceArray[indexPath.section]];
//            };
//            return cell;
//        }
//
//    }
//    else if (_isAuction)
//    {
//        if (_orderType == ComplteOrderType) {
//
//            OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//            if (!cell ) {
//                cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            cell.model = self.resorceArray[indexPath.section];
//            cell.DidClickOrderCellBlock  = ^(NSString *title){
//                LOG(@"title = %@",title);
//                [weakSelf operationOrderWithTitle:title OrderModel:self.resorceArray[indexPath.section]];
//            };
//            return cell;
//
//
//        }else{
//            OrderAutionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//            if (!cell ) {
//                cell = [[OrderAutionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            if(_orderType == ComplteAuctionType)
//            {
//                cell.cellType = AutionCellOfferType;
//            }else{
//                cell.cellType = AutionCelljoinType;
//            }
//
//            cell.model = self.resorceArray[indexPath.section];
//            cell.DidClickOrderCellBlock  = ^(NSString *title){
//                LOG(@"title = %@",title);
//                [weakSelf operationOrderWithTitle:title OrderModel:self.resorceArray[indexPath.section]];
//            };
//            return cell;
//
//        }
//
//    }
//    else{
//        OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        if (!cell ) {
//            cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        }
//        if (_isDetection) {
//            cell.cellType = CheckOrderCellType;
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.model = self.resorceArray[indexPath.section];
//        cell.DidClickOrderCellBlock  = ^(NSString *title){
//            LOG(@"title = %@",title);
//            [weakSelf operationOrderWithTitle:title OrderModel:self.resorceArray[indexPath.section]];
//        };
//        return cell;
//
//    }
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell ) {
        cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.resorceArray[indexPath.section];
    cell.DidClickOrderCellBlock  = ^(NSString *title){
        LOG(@"title = %@",title);
        [weakSelf operationOrderWithTitle:title OrderModel:self.resorceArray[indexPath.section]];
    };
    return cell;

    

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderModel  *model = self.resorceArray[indexPath.section];
    if (_isCollect ) {
        if (_orderType == JoinOrderType) {
             return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderCollectCell class] contentViewWidth:SCREEN_WIDTH];
        }
   
        LOG(@"%f",[self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderCell class] contentViewWidth:SCREEN_WIDTH]);
        return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderCell class] contentViewWidth:SCREEN_WIDTH];

    }
    else if (_isAuction ) {
       
        if (_orderType == ComplteAuctionType) {
            return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderAutionCell class] contentViewWidth:SCREEN_WIDTH] -21;
        }

        else if (_orderType == JoinOrderType)
        {
            return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderAutionCell class] contentViewWidth:SCREEN_WIDTH];

        }
        return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderCell class] contentViewWidth:SCREEN_WIDTH];

    }
    else{
        return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderCell class] contentViewWidth:SCREEN_WIDTH];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderModel  *model = self.resorceArray[indexPath.section];
    OrderDetailVC *VC = [[OrderDetailVC alloc] init];
    VC.isLease = _isLease;
    VC.isCollect = _isCollect;
    VC.isAuction = _isAuction;
    VC.isDetection = _isDetection;

    VC.model = model;
    if (_isCollect ) {
        VC.orderID = model.orderId;
        if (_orderType == JoinOrderType) {
            
        }
        else{
            [self.navigationController pushViewController:VC animated:YES];
        }

    }
    else if (_isAuction ) {
        VC.orderID = model.orderId;
        if (_orderType == ComplteAuctionType || _orderType == JoinOrderType) {
//             GoodsAuctionDetailVC *VC = [[GoodsAuctionDetailVC alloc] init];
//            VC.productID = model.auctionId;
//            VC.typeStr =@"10";
//            [self.navigationController pushViewController: VC animated:YES];
            
        }else{
            [self.navigationController pushViewController:VC animated:YES];

        }

    }
    else{
        VC.orderID = model.orderId;
        [self.navigationController pushViewController:VC animated:YES];

    }
    
    

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
}


#pragma mark - public 共有方法



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
    _quickSearch = @"";
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
    }
    return _tableView;
}

#pragma mark - private
///处理订单所有状态
- (void)operationOrderWithTitle:(NSString *)title OrderModel:(OrderModel *)model
{
    if (model.bidKey) {
//        ContractDetailVC *VC = [[ContractDetailVC alloc] init];
//        VC.contractId = model.contractId;
//        VC.model = model;
//        VC.isHidden = YES;
//        [self.navigationController pushViewController:VC animated:YES];
//        SuccessView *successV = [[SuccessView alloc] initWithTrueCancleTitle:@"前往机汇网电脑端订单管理界面进行操作\n网址www.myjihui.com" cancelTitle:@"" clickDex:^(NSInteger clickDex) {
//            if (clickDex == 1) {
//
//            }}];
//        [successV showSuccess];
                return;
    }
    else if([model.isFronzen integerValue] == 1){
        SuccessView *successV = [[SuccessView alloc] initWithTrueCancleTitle:@"该订单已冻结~" cancelTitle:@"" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                
            }}];
        [successV showSuccess];
        return;

    }
    WEAKSELF;
    __block NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
    if (KX_NULLString(model.orderId)) {
        model.orderId = @"";
    }
    if ([title isEqualToString:@"取消订单"]) {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
        [param setObject:model.orderId forKey:@"orderId"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].uid forKey:@"uid"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].bid forKey:@"bid"];


        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"取消订单后将自动关闭\n  是否确认取消订单" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [weakSelf operationRequestUrl:@"/o/o_087" Param:param];
            }}];
            [successV showSuccess];
    }
    else if ([title isEqualToString:@"取消参与"])
    {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
        [param setObject:model.groupId forKey:@"groupId"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];

        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"取消参与后将自动关闭\n  是否确认取消参与" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [weakSelf operationRequestUrl:@"/o/o_116" Param:param];
            }}];
        [successV showSuccess];
    }
    else if ([title isEqualToString:@"付款"])
    {
        SuccessView *successV = [[SuccessView alloc] initWithTrueCancleTitle:@"前往机汇网电脑端订单管理界面付款\n网址www.myjihui.com" cancelTitle:@"" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                
            }}];
        [successV showSuccess];
       
    }
    else if ([title isEqualToString:@"确认收货"] )
    {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
             [param setObject:model.orderId forKey:@"orderId"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].aid  forKey:@"aid"];

        NSString *titleStr;
//        if (!_isLease) {
//            titleStr = @"确认收货并商家同意后，订单将自动完成";
//        }else{
//            titleStr = @"确认收货后，订单将进入在租状态，\n请确认是否收到商品?";
//        }
        titleStr = @"请确认是否收货？";
        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:titleStr clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [weakSelf  operationRequestUrl:@"/o/o_089" Param:param];
            }}];
            [successV showSuccess];
    }
    
    else if ([title isEqualToString:@"确认服务"] )
    {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
        [param setObject:model.orderId forKey:@"orderId"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].aid  forKey:@"aid"];
        
        NSString *titleStr;
        titleStr = @"确认服务并商家同意后，订单将自动完成";

        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:titleStr clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [weakSelf  operationRequestUrl:@"/o/o_089" Param:param];
            }}];
        [successV showSuccess];
    }

    else if ([title isEqualToString:@"删除订单"])
    {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
        [param setObject:model.orderId forKey:@"orderId"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];

        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"删除订单后将自动关闭\n  是否确认取消订单" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [weakSelf operationRequestUrl:@"/o/o_092" Param:param];
            }}];
        [successV showSuccess];

    }
    else if ([title isEqualToString:@"合同详情"])
    {
     
//        ContractDetailVC *VC = [[ContractDetailVC alloc] init];
//        VC.contractId = model.contractId;
//        VC.model = model;
//        [self.navigationController pushViewController:VC animated:YES];

    }
    else if ([title isEqualToString:@"发表评价"])
    {
        SendCommentsVC *VC = [[SendCommentsVC alloc] init];
        VC.model = model;
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if ([title isEqualToString:@"评价详情"])
    {
        SendCommentsVC *VC = [[SendCommentsVC alloc] init];
        VC.model = model;
        VC.commeType = ShowTypeType;
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if ([title isEqualToString:@"申请撤单"])
    {
        CloseReasonView *closeReasonView = [[CloseReasonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) Title:@"撤单理由" andTitle1:@"卖家审核通过后，订单将会自动关闭"];
        closeReasonView.didClickReasonBlock = ^(NSString *str){
            [param setObject:str forKey:@"closeReason"];
             [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
                 [param setObject:model.orderId forKey:@"orderId"];
            [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];

            [weakSelf operationRequestUrl:@"/o/o_091" Param:param];
        };
        [closeReasonView show];
    }
    
    else if ([title isEqualToString:@"申请退租"])
    {
        CloseReasonView *closeReasonView = [[CloseReasonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) Title:@"退租理由" andTitle1:@"租赁方结束租赁后，订单将会自动关闭"];
        closeReasonView.didClickReasonBlock = ^(NSString *str){
            [param setObject:str forKey:@"closeReason"];
            [param setObject:model.orderId forKey:@"orderId"];
            [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];

            [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];

            [weakSelf operationRequestUrl:@"/o/o_090" Param:param];
        };
        [closeReasonView show];
    }
    else if ([title isEqualToString:@"同意合同"])
    {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
        [param setObject:model.contractId forKey:@"contractId"];
             [param setObject:model.orderId forKey:@"orderId"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].aid  forKey:@"aid"];

        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"同意后，将按照合同约定执行，请\n确认是否同意" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [weakSelf operationRequestUrl:@"/o/o_088" Param:param];
            }}];
        [successV showSuccess];
    }
  
  
}




@end
