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

#import "OrderSectionFootView.h"

#import "OrderSectionHeadView.h"

#import "SaleAfterVC.h"

#import "GoodsAuctionXYVC.h"
#import "PayModels.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"
#import "JHCoverView.h"
#import "SetPayPwdVC.h"
#import "PayOrderView.h"
#import "PayDetailModel.h"

#import "OrderCommitSuccessVC.h"
#import "OffLineHeadSectionView.h"

#import "CommentsVC.h"
@interface OrderManagementVC ()<UITableViewDelegate,UITableViewDataSource,JHCoverViewDelegate>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)NSUInteger page;

@property(nonatomic,strong) NSString *orderStatus;
@property (nonatomic, strong)    PayOrderView *payOrderView;            //
@property (nonatomic, strong)    GoodsOrderModel *orderModel;            //

@property (nonatomic, strong)    PayModels *payModel;            //


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
    _page = 1;
    _quickSearch = @"";
    self.view.backgroundColor = BACKGROUND_COLOR;
 
}

/// 初始化视图
- (void)setup
{
    _orderModel = [[GoodsOrderModel alloc] init];
    [self.view addSubview:self.tableView];

    
}


/// 展示 付款方式
- (void)showPayView:(Pay_method *)pay_method OrderModel:(OrderModel *)model
{
    WEAKSELF;
    NSMutableArray *titleArr = [[NSMutableArray alloc] init];
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];

    
    
    if ([ pay_method.wxpay isEqualToString:@"Y"]) {
        [titleArr addObject:@"微信支付"];
        [imageArr addObject:@"wxzf@3x.png"];
    }
    
    if ([pay_method.alipay isEqualToString:@"Y"]) {
        [titleArr addObject:@"支付宝支付"];
        [imageArr addObject:@"zfb@3x.png"];
    }
    
    if ([pay_method.coins_money isEqualToString:@"Y"]) {
        [titleArr addObject:@"激励笑脸支付"];
        [imageArr addObject:@"jlxl@3x.png"];
    }
    
    if ([pay_method.coins_air_money isEqualToString:@"Y"]) {
        [titleArr addObject:@"空充笑脸支付"];
        [imageArr addObject:@"kcxl@3x.png"];
    }
    
    if ([pay_method.phone_money isEqualToString:@"Y"]) {
        [titleArr addObject:@"话费支付"];
        [imageArr addObject:@"hfdh@3x.png"];
    }
    
    if ([pay_method.point isEqualToString:@"Y"]) {
        [titleArr addObject:@"兑换积分支付"];
        [imageArr addObject:@"jfzf@3x.png"];
        //
    }
    
    PayOrderView *view;
    
    view = [[PayOrderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withPayType:PayTypeOther];
    if (titleArr.count== 1) {
        NSString *str =titleArr.firstObject;
        
        if ([str isEqualToString:@"话费支付"]) {
            
        }else{
            if ( _orderModel.allPrices <= 0  ) {
                if (_orderModel.express_type.integerValue == 2) {
                    [titleArr removeAllObjects];
                    [imageArr removeAllObjects];
                    [titleArr addObject:@"兑换积分支付"];
                    [imageArr addObject:@"jfzf@3x.png"];
                }
                view = [[PayOrderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withPayType:PayTypeOther];
            }
        }
    }else{
        if ( _orderModel.allPrices <= 0  ) {
            if (_orderModel.express_type.integerValue == 2) {
                [titleArr removeAllObjects];
                [imageArr removeAllObjects];
                
                [titleArr addObject:@"兑换积分支付"];
                [imageArr addObject:@"jfzf@3x.png"];
                
            }
            view = [[PayOrderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withPayType:PayTypeOther];
        }
        
    }
    
    _orderModel.allFreight = model.freight.floatValue;
    _orderModel.allPoint = model.point.floatValue;
    _orderModel.allPrices = model.price.floatValue;

    for (int i = 0; i<titleArr.count; i++) {
        PayDetailModel *model = [PayDetailModel new];
        model.mark = @"";
        model.icon = imageArr[i];
        model.isSelect = NO;
        model.title = titleArr[i];
        if ( [model.title isEqualToString:@"兑换积分支付"]) {
            model.isSelect = YES;
            _orderModel.payIndexStr = @"兑换积分支付";
        }
        [dataArray addObject:model];
    }
    
    view.didChangeJFValueBlock = ^(GoodsOrderModel *orderModel) {
        
        
        weakSelf.orderModel.orderno = orderModel.orderno;
        
        [PayTool sharedPayTool].isType = @"2";
        [[PayTool sharedPayTool] getPayInfoOrderModle:weakSelf.orderModel payVC:weakSelf reluteBlock:^(NSString *msg, BOOL success) {
            [self requestListNetWork];
        }];
        

    };
    
    view.dataArr = dataArray;
    view.orderModel = _orderModel;
    [view show];
    self.payOrderView = view;
}




#pragma mark - 得到网络数据
-(void)requestListNetWork
{
    
 //   http://39.108.4.18:6803/api/order/order_list  page_size=10&paystatus=Pendding%2CPreview%2CFail&type=Shop&pageno=1&user_id=84561
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageno"];
    [param setObject:@"10" forKey:@"page_size"];
//    [param setObject:_quickSearch forKey:@"quickSearch"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    if (!KX_NULLString(_type)) {
        [param setObject:@"Shop" forKey:@"type"];
        [param setObject:_paystatus forKey:@"paystatus"];
        [param setObject:_comm_nums forKey:@"comm_nums"];
        if (!KX_NULLString(_shop_id)) {
            [param setObject:_shop_id forKey:@"shop_id"];
        }
    }
    else{
        [param setObject:_paystatus?_paystatus:@"" forKey:@"paystatus"];

        [param setObject:_shipstatus forKey:@"shipstatus"];
        if (!KX_NULLString(_shop_id)) {
            [param setObject:_shop_id forKey:@"shop_id"];
        }
    }
   
    
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [OrderVModel getOrderListParam:param successBlock:^(NSArray<OrderModel *> *dataArray, BOOL isSuccess){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        if (isSuccess) {
            if (weakSelf.page == 1) {
                [weakSelf.resorceArray removeAllObjects];
            }
            for (OrderModel *model in dataArray) {
                if (!KX_NULLString(_shop_id) || _orderType == HasSureOrderType) {
                    model.isShowBottow = YES;
                }
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
            [weakSelf requestListNetWork];
            [weakSelf.view makeToast:message];

        }else{
            [weakSelf.view makeToast:message];
        }

    }];

}


- (void)OperationPaymethoedRequestUrl:(NSString *)url Param:(id)param OrderModel:(OrderModel *)model
{
    WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [OrderVModel getOrderPayTypeUrl:url Param:param successBlock:^(Pay_method *pay_method, BOOL isSuccess) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (isSuccess) {
            [weakSelf showPayView:pay_method  OrderModel:model];

        }else{
            [weakSelf.view makeToast:@"获取支付方式失败，请联系客服"];
        }
    }];

}



#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OrderModel *model =  self.resorceArray[section];
    return model.seller.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resorceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    static NSString* cellID = @"ManagementCellID";
    OrderModel *model =  self.resorceArray[indexPath.section];
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell ) {
        cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.seller = model.seller[indexPath.row];
    cell.DidClickOrderCellBlock  = ^(NSString *title){
        LOG(@"title = %@",title);
        [weakSelf operationOrderWithTitle:title OrderModel:self.resorceArray[indexPath.section]];
    };
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderModel  *model = self.resorceArray[indexPath.section];
//    _waitSendVC.orderTypeTitle = @"4";
//    if ([_orderTypeTitle isEqualToString:@"4"]) {
//        SaleAfterVC *VC = [[SaleAfterVC alloc] init];
//        VC.model = model;
//        [self.navigationController pushViewController:VC animated:YES];
//    }else{
//        OrderDetailVC *VC = [[OrderDetailVC alloc] init];
//        VC.model = model;
//        [self.navigationController pushViewController:VC animated:YES];
//    }
    if (KX_NULLString(_type)) {
        OrderDetailVC *VC = [[OrderDetailVC alloc] init];
        VC.model = model;
        [self.navigationController pushViewController:VC animated:YES];
    }
  

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!KX_NULLString(_type)) {
       return  95;
    }
    return 55;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (!KX_NULLString(_shop_id) || _orderType == HasSureOrderType) {
       return 41;
    }
    
  
    return 90;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OrderModel  *model = self.resorceArray[section];

    if (!KX_NULLString(_type)) {
        OffLineHeadSectionView *headView =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OffLineHeadSectionView class]) owner:self options:nil].lastObject;
        headView.model  = model;
          return headView;
    }else{
        OrderSectionHeadView *headView =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OrderSectionHeadView class]) owner:self options:nil].lastObject;
        headView.model  = model;
        return headView;
    }
    return nil;
   
}



- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    WEAKSELF;
//    if (!KX_NULLString(_shop_id)) {
//        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
//
//    }else{
        OrderModel  *model = self.resorceArray[section];
        if (KX_NULLString(_type)) {
            model.comm_nums =  @"$";
            
        }else{
            if (_comm_nums.integerValue == 1) {
                model.type =  @"Shop"; ///评价
            }
        }
        OrderSectionFootView *footView =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OrderSectionFootView class]) owner:self options:nil].lastObject;
        footView.model = model;
        footView.didClickItemBlock = ^(NSString *title) {
            [weakSelf operationOrderWithTitle:title OrderModel:model];
        };
        return footView;
//    }
//    return nil;
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
    self.page = 1;
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64  - 45) style:UITableViewStyleGrouped];
        _tableView.tableFooterView = [UIView new];//默认设置为空
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
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

    if (KX_NULLString(model.orderId)) {
        model.orderId = @"";
    }
    if ([title isEqualToString:@"取消订单"]) {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id  forKey:@"user_id"];
        [param setObject:model.orderno forKey:@"orderno"];
      

        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"取消订单后将自动关闭\n  是否确认取消订单" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [weakSelf operationRequestUrl:@"/order/cancelOrder" Param:param];
            }}];
            [successV showSuccess];
    }
    else if ([title isEqualToString:@"确认收货"])
    {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id  forKey:@"user_id"];
        [param setObject:model.orderno forKey:@"orderno"];
        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"确认收货后订单将自动完成\n  是否确认收货" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [weakSelf operationRequestUrl:@"/order/confirmOrder" Param:param];
            }}];
        [successV showSuccess];
    }
    else if ([title isEqualToString:@"付款"])
    {
        weakSelf.orderModel.orderno = model.orderno;
        [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id  forKey:@"user_id"];
        [param setObject:model.orderno forKey:@"orderno"];
        [weakSelf OperationPaymethoedRequestUrl:@"/order/getOrderPayMethod" Param:param OrderModel:model];
        
    }
    else if ([title isEqualToString:@"提醒发货"] )
    {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id  forKey:@"user_id"];
        [param setObject:model.orderno forKey:@"orderno"];
        [weakSelf  operationRequestUrl:@"/order/callOrder" Param:param];

    }
    
    else if ([title isEqualToString:@"查看详情"])
    {
      
        OrderDetailVC *VC = [[OrderDetailVC alloc] init];
        VC.model = model;
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if ([title isEqualToString:@"待评价"])
    {
//        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"该功能暂未开放，请稍等" clickDex:^(NSInteger clickDex) {
//            if (clickDex == 1) {
//                [weakSelf operationRequestUrl:@"/order/confirmOrder" Param:param];
//            }
            
//          }];
//        [successV showSuccess];
        CommentsVC *VC = [[CommentsVC alloc] init];
        VC.model = model;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    else if ([title isEqualToString:@"查看物流"])
    {
        GoodsAuctionXYVC *VC = [GoodsAuctionXYVC new];
        VC.clickUrl = [NSString stringWithFormat:@"%@",model.express_url] ;
        VC.hidesBottomBarWhenPushed = YES;
        VC.title = @"物流信息";
        [self.navigationController pushViewController:VC animated:YES];
//        OrderDetailVC *VC = [[OrderDetailVC alloc] init];
//        VC.model = model;
//        [self.navigationController pushViewController:VC animated:YES];
    }

}



@end
