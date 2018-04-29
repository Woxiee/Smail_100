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

@interface OrderManagementVC ()<UITableViewDelegate,UITableViewDataSource,JHCoverViewDelegate>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)NSUInteger page;

@property(nonatomic,strong) NSString *orderStatus;
@property (nonatomic, strong)    PayOrderView *payOrderView;            //
@property (nonatomic, strong)    GoodsOrderModel *orderModel;            //

@property (nonatomic, strong)    PayModels *payModel;            //

@property (nonatomic, strong) JHCoverView *coverView;


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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPayTypeRelute:) name:NOTICEMEPAYMSG object:nil];
    
    [self.view addSubview:self.tableView];
    
    JHCoverView *coverView = [[JHCoverView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    coverView.delegate = self;
    self.coverView = coverView;
    coverView.hidden = YES;
    coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.view addSubview:coverView];
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
    
    view = [[PayOrderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withPayType:PayTypeNoaml];
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


- (void)getPayPwdYZRequest
{
    
//    view.didChangeJFValueBlock = ^(GoodsOrderModel *orderModel) {
//        
//        if ([orderModel.payIndexStr isEqualToString:@"微信支付"] || [orderModel.payIndexStr isEqualToString:@"支付宝支付"]) {
//            [weakSelf getPayKeyInfoRequest:orderModel.orderno];
//        }
//        else{
//            [weakSelf getPayPwdYZRequest];
//        }
//        //        [weakSelf submitOrderInfoRequest];
//    };

    WEAKSELF;
    if (KX_NULLString([KX_UserInfo sharedKX_UserInfo].pay_password)) {
        [self systemAlertWithTitle:nil andMsg:@"您还未设置支付密码" cancel:@"取消" sure:@"去设置" withOkBlock:^(BOOL isOk) {
            SetPayPwdVC  *vc = [[SetPayPwdVC alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }else{
        self.coverView.hidden = NO;
        [self.coverView.payTextField becomeFirstResponder];
        
    }
    
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
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (isSuccess) {
            if (weakSelf.page == 1) {
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
        if (isSuccess) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [weakSelf showPayView:pay_method  OrderModel:model];
            
        }else{
            [weakSelf.view makeToast:@"获取支付方式失败，请联系客服"];
        }
    }];
   
}


- (void)getPayKeyInfoRequest:(NSString *)orderID
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:orderID forKey:@"orderno"];
    
    if ([_orderModel.jfValue intValue] >0) {
        [param setObject:_orderModel.jfValue forKey:@"type_value[point]"];
    }
    
    if ([_orderModel.payIndexStr isEqualToString:@"微信支付"]) {
        [param setObject:@"auto" forKey:@"type_value[wxpay]"];
    }
    
    if ([_orderModel.payIndexStr isEqualToString:@"支付宝支付"]) {
        [param setObject:@"auto" forKey:@"type_value[alipay]"];
    }
    
    if ([_orderModel.payIndexStr isEqualToString:@"激励笑脸支付"]) {
        [param setObject:@"auto" forKey:@"type_value[coins_money]"];
    }
    
    if ([_orderModel.payIndexStr isEqualToString:@"空充笑脸支付"]) {
        [param setObject:@"auto"  forKey:@"type_value[coins_air_money]"];
    }
    
    if ([_orderModel.payIndexStr isEqualToString:@"话费支付"]) {
        [param setObject:@"auto"  forKey:@"type_value[phone_money]"];
    }
    
    if (_orderModel.jfValue.intValue >0) {
        [param setObject:_orderModel.jfValue  forKey:@"type_value[point]"];
    }
    
    
    [GoodsOrderVModel getPayInfoKryParam:param successBlock:^(PayModels *model, BOOL isSuccess,NSString *msg) {
        if (isSuccess ) {
            weakSelf.payModel = model;
            if (isSuccess) {
                if ([_orderModel.payIndexStr isEqualToString:@"微信支付"]) {
                    [weakSelf doWxPay];
                    
                }
                else if ([_orderModel.payIndexStr isEqualToString:@"支付宝支付"]) {
                    [weakSelf doAPPay];
                }
                else{
                    OrderCommitSuccessVC *vc = [[OrderCommitSuccessVC alloc] init];
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                    
                }
                
            }
            
            
        }
        else{
            [weakSelf showHint:msg];
        }
    }];
    
    
}

- (void)doAPPay
{
    NSString *appID = _payModel.sellerId;
    NSString *rsa2PrivateKey = _payModel.privatekey;
    
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    order.notify_url = _payModel.callback;
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = @"微笑100商品";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = _payModel.orderid; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = _payModel.amount; //商品价格
    //
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:rsa2PrivateKey];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}


- (void)doWxPay
{
    
    
    PayReq *req   = [[PayReq alloc] init];
    req.openID = _payModel.appid;
    req.partnerId = _payModel.acctId;
    req.prepayId  =  _payModel.prepay_id;
    req.sign = _payModel.sign;
    req.package = @"Sign=WXPay";
    req.nonceStr  = _payModel.nonce_str;
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    UInt32 timeStamp =[timeSp intValue];
    req.timeStamp =timeStamp;
    
    
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject:_payModel.appid forKey:@"appid"];//微信appid 例如wxfb132134e5342
    [signParams setObject:_payModel.nonce_str forKey:@"noncestr"];//随机字符串
    [signParams setObject:@"Sign=WXPay" forKey:@"package"];//扩展字段  参数为 Sign=WXPay
    [signParams setObject:_payModel.acctId forKey:@"partnerid"];//商户账号
    [signParams setObject:_payModel.prepay_id forKey:@"prepayid"];//此处为统一下单接口返回的预支付订单号
    [signParams setObject:_payModel.timestamp forKey:@"timestamp"];
    //进行第二次签名
    NSString *appKey = _payModel.privateKey;
    //进行md5加密
    NSString *sign = [NSString createMd5Sign:signParams withAppKey:appKey];
    req.sign= sign;
    
    if ([WXApi sendReq:req]) { //发送请求到微信，等待微信返回onResp
        NSLog(@"吊起微信成功...");
    }else{
        NSLog(@"吊起微信失败...");
    }
    
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
    OrderDetailVC *VC = [[OrderDetailVC alloc] init];
    VC.model = model;
    [self.navigationController pushViewController:VC animated:YES];

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
    return 55;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (!KX_NULLString(_shop_id)) {
        return 5;
    }
    return 90;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    OrderModel  *model = self.resorceArray[section];
    OrderSectionHeadView *headView =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OrderSectionHeadView class]) owner:self options:nil].lastObject;
    headView.model  = model;
    return headView;
}



- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    WEAKSELF;
    if (!KX_NULLString(_shop_id)) {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    }else{
        OrderModel  *model = self.resorceArray[section];
        if (KX_NULLString(_type)) {
            model.comm_nums =  @"$";
        }
        OrderSectionFootView *footView =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OrderSectionFootView class]) owner:self options:nil].lastObject;
        
        footView.model = model;
        footView.didClickItemBlock = ^(NSString *title) {
            [weakSelf operationOrderWithTitle:title OrderModel:model];
        };
        return footView;
    }
    return nil;
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
    else if ([title isEqualToString:@"待评论"])
    {
        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"该功能暂未开放，请稍等" clickDex:^(NSInteger clickDex) {
//            if (clickDex == 1) {
//                [weakSelf operationRequestUrl:@"/order/confirmOrder" Param:param];
//            }
            
          }];
        [successV showSuccess];
//        OrderDetailVC *VC = [[OrderDetailVC alloc] init];
//        VC.model = model;
//        [self.navigationController pushViewController:VC animated:YES];
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
//    else if ([title isEqualToString:@"提醒发货"] )
//    {
//        [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id  forKey:@"user_id"];
//        [param setObject:model.orderno forKey:@"orderno"];
//
//        NSString *titleStr;
////        if (!_isLease) {
////            titleStr = @"确认收货并商家同意后，订单将自动完成";
////        }else{
////            titleStr = @"确认收货后，订单将进入在租状态，\n请确认是否收到商品?";
////        }
//        titleStr = @"请确认是否收货？";
//        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:titleStr clickDex:^(NSInteger clickDex) {
//            if (clickDex == 1) {
//                [weakSelf  operationRequestUrl:@"/order/callOrder" Param:param];
//            }}];
//            [successV showSuccess];
//    }
//
//
//    else if ([title isEqualToString:@"删除订单"])
//    {
//        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
//        [param setObject:model.orderId forKey:@"orderId"];
//        [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];
//
//        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"删除订单后将自动关闭\n  是否确认取消订单" clickDex:^(NSInteger clickDex) {
//            if (clickDex == 1) {
//                [weakSelf operationRequestUrl:@"/o/o_092" Param:param];
//            }}];
//        [successV showSuccess];
//
//    }
//    else if ([title isEqualToString:@"合同详情"])
//    {
//
////        ContractDetailVC *VC = [[ContractDetailVC alloc] init];
////        VC.contractId = model.contractId;
////        VC.model = model;
////        [self.navigationController pushViewController:VC animated:YES];
//
//    }
//    else if ([title isEqualToString:@"发表评价"])
//    {
//        SendCommentsVC *VC = [[SendCommentsVC alloc] init];
//        VC.model = model;
//        [self.navigationController pushViewController:VC animated:YES];
//    }
//    else if ([title isEqualToString:@"评价详情"])
//    {
//        SendCommentsVC *VC = [[SendCommentsVC alloc] init];
//        VC.model = model;
//        VC.commeType = ShowTypeType;
//        [self.navigationController pushViewController:VC animated:YES];
//    }
//    else if ([title isEqualToString:@"申请撤单"])
//    {
//        CloseReasonView *closeReasonView = [[CloseReasonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) Title:@"撤单理由" andTitle1:@"买家审核通过后，订单将会自动关闭"];
//        closeReasonView.didClickReasonBlock = ^(NSString *str){
//            [param setObject:str forKey:@"closeReason"];
//             [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
//                 [param setObject:model.orderId forKey:@"orderId"];
//            [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];
//
//            [weakSelf operationRequestUrl:@"/o/o_091" Param:param];
//        };
//        [closeReasonView show];
//    }
//
//    else if ([title isEqualToString:@"申请退租"])
//    {
//        CloseReasonView *closeReasonView = [[CloseReasonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) Title:@"退租理由" andTitle1:@"租赁方结束租赁后，订单将会自动关闭"];
//        closeReasonView.didClickReasonBlock = ^(NSString *str){
//            [param setObject:str forKey:@"closeReason"];
//            [param setObject:model.orderId forKey:@"orderId"];
//            [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];
//
//            [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
//
//            [weakSelf operationRequestUrl:@"/o/o_090" Param:param];
//        };
//        [closeReasonView show];
//    }
//    else if ([title isEqualToString:@"同意合同"])
//    {
//        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
//        [param setObject:model.contractId forKey:@"contractId"];
//             [param setObject:model.orderId forKey:@"orderId"];
//        [param setObject:[KX_UserInfo sharedKX_UserInfo].aid  forKey:@"aid"];
//
//        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"同意后，将按照合同约定执行，请\n确认是否同意" clickDex:^(NSInteger clickDex) {
//            if (clickDex == 1) {
//                [weakSelf operationRequestUrl:@"/o/o_088" Param:param];
//            }}];
//        [successV showSuccess];
//    }
  
  
}

/**
 JHCoverViewDelegate的代理方法，密码输入正确
 */
- (void)inputCorrectCoverView:(JHCoverView *)control
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].pay_password forKey:@"pay_password"];
    
    [GoodsOrderVModel  getVerify_paypwdParam:param successBlock:^(BOOL isSuccess, NSString *msg) {
        if (isSuccess) {
            
            
            [weakSelf getPayKeyInfoRequest:weakSelf.orderModel.orderno];
            
        }
        else{
            [weakSelf showHint:msg];
        }
    }];
    
    
}

/**
 密码错误
 */
- (void)coverView:(JHCoverView *)control
{
    [self showHint:@"支付密码输入错误" yOffset:-200];
}

/**
 忘记密码
 */
- (void)forgetPassWordCoverView:(JHCoverView *)control
{
    FindPaypwdVC *vc = [[FindPaypwdVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/// 支付成功
- (void)getPayTypeRelute:(NSNotification *)notification
{
    OrderCommitSuccessVC *vc = [[OrderCommitSuccessVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
