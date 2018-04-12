//
//  OrderDetailVC.m
//  MyCityProject
//
//  Created by Faker on 17/6/8.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderDetailVC.h"
#import "OrderVModel.h"
#import "CloseReasonView.h"
#import "DefaultAdressCell.h"
#import "OrderGoodDetailCell.h"
#import "KX_ApprovalContentCell.h"
#import "GoodsCombinedCell.h"
#import "GoodSOrderCommonCell.h"
#import "OrderPayTypeCell.h"
#import "orderOtherInfo.h"
#import "OrderFootView.h"
#import "OrderServiewInfoCell.h"
#import "OrderWeekInfoCell.h"
#import "AttributeCell.h"
#import "GoodSOrderNomalCell.h"

#import "SendCommentsVC.h"
#import "MailTypeCell.h"
#import "DeductionCell.h"
#import "GoodsCommonCell.h"

#import "OrderSectionFooterView.h"
#import "PayOrderView.h"
#import "PayDetailModel.h"

#import "PayModels.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"
#import "JHCoverView.h"
#import "SetPayPwdVC.h"
#import "OrderSectionFootView.h"

@interface OrderDetailVC ()<UITableViewDelegate,UITableViewDataSource,JHCoverViewDelegate>
@property (nonatomic, weak)  OrderFootView *footView;
@property (nonatomic, strong)  OrderDetailModel *detailModel;

@property (nonatomic, strong) GoodsOrderModel *orderModel;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong)   NSString *invoiceTy;            ///发票选定

@property (nonatomic, strong)    PayOrderView *payOrderView;            //

@property (nonatomic, strong)    PayModels *payModel;            //

@property (nonatomic, strong)    NSAttributedString *allCountStr;            //
@property (nonatomic, strong) JHCoverView *coverView;
@end

@implementation OrderDetailVC
static NSString *const defaultAdressCellID = @"DefaultAdressCellID";
static NSString *const orderGoodDetailCellID = @"OrderGoodDetailCellID";
static NSString * const ContenGeneralCellID = @"ContenGeneralCellID";
static NSString * const goodsCombinedCellID = @"goodsCombinedCellID";
static NSString *const goodSOrderCommonCell = @"GoodSOrderCommonCellID";
static NSString *const orderPayTypeCellID = @"OrderPayTypeCellID";
static NSString *const orderOtherInfoID = @"orderOtherInfoID";
static NSString *const orderServiewInfoCellID = @"orderServiewInfoCellID";
static NSString *const OrderWeekInfoCellID = @"OrderWeekInfoCellID";
static NSString * const cellID = @"cellID";

static NSString * const MailTypeCellCellID = @"MailTypeCellCellID";
static NSString * const DeductionCellID = @"DeductionCellID";
static NSString *const goodSOrderNomalCellID = @"goodSOrderNomalCell";

static NSString *const goodsCommonCellID = @"GoodsCommonCellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
    [self requestNetWork];
}





#pragma mark - 得到网络数据
-(void)requestNetWork
{
    WEAKSELF;
    if (KX_NULLString(_orderID)) {
        _orderID = @"";
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_model.orderno forKey:@"orderno"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [OrderVModel getOrderDetailParam:param successBlock:^(NSArray <GoodsOrderModel *>*dataArray, BOOL isSuccess) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isSuccess) {
            if (weakSelf.resorceArray.count >0) {
                [weakSelf.resorceArray removeAllObjects];
            }
            if (dataArray.count > 0) {
                GoodsOrderModel *model = dataArray[0];
                weakSelf.orderModel = model;
                weakSelf.orderModel.isDetail = YES;
                [weakSelf.resorceArray addObject:@"新增收货地址"];
                [weakSelf.resorceArray addObject:model];
                weakSelf.footView.model = model;
                if (model.point.floatValue >0) {
                    [weakSelf.resorceArray addObject:@"积分抵扣"];

                }
                [weakSelf.resorceArray addObject:@"订单信息"];

            }


        
            [weakSelf.tableView reloadData];

        }else{
            
        }

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
            [weakSelf.view toastShow:message];
            [weakSelf requestNetWork];

        }else{
            [weakSelf.view toastShow:message];
        }
        
    }];
    
}


- (void)OperationPaymethoedRequestUrl:(NSString *)url Param:(id)param
{
    WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [OrderVModel getOrderPayTypeUrl:url Param:param successBlock:^(Pay_method *pay_method, BOOL isSuccess) {
        if (isSuccess) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [weakSelf showPayView:pay_method];
            
        }else{
            [weakSelf.view toastShow:@"获取支付方式失败，请联系客服"];
        }
    }];
    
}


/// 展示 付款方式
- (void)showPayView:(Pay_method *)pay_method
{
    WEAKSELF;
    NSMutableArray *titleArr = [[NSMutableArray alloc] init];
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    PayOrderView *view;
    if ([pay_method.wxpay isEqualToString:@"Y"]) {
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
        [titleArr addObject:@"积分兑换"];
        [imageArr addObject:@"jfzf@3x.png"];
    }
    
    view = [[PayOrderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withPayType:PayTypeNoaml];
    if (titleArr.count == 1 && [titleArr.firstObject isEqualToString:@"积分兑换"]) {
        view = [[PayOrderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withPayType:PayTypeOther];
    }
    
    view.didChangeJFValueBlock = ^(GoodsOrderModel *orderModel) {
        
        if ([orderModel.payIndexStr isEqualToString:@"微信支付"] || [orderModel.payIndexStr isEqualToString:@"支付宝支付"]) {
            [weakSelf getPayKeyInfoRequest:orderModel.orderno];
        }
        else{
            [weakSelf getPayPwdYZRequest];
        }
        //        [weakSelf submitOrderInfoRequest];
    };
    
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<titleArr.count; i++) {
        PayDetailModel *model = [PayDetailModel new];
        model.mark = @"";
        model.icon = imageArr[i];
        model.isSelect = NO;
        if (titleArr.count == 1 && [titleArr.firstObject isEqualToString:@"积分兑换"]) {
            model.isSelect = YES;
        }
        model.title = titleArr[i];
        
        [dataArray addObject:model];
    }
    view.dataArr = dataArray;
    view.orderModel = _orderModel;
    [view show];
    self.payOrderView = view;
}


- (void)getPayPwdYZRequest
{
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
//
                      [weakSelf requestNetWork];
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
    //    order.notifyUR = _payModel.callback;
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


/// 初始化视图
- (void)setup
{
    self.title = @"订单详情";
    WEAKSELF;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPayTypeRelute:) name:NOTICEMEPAYMSG object:nil];
    


    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 40) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 44.f;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    OrderFootView *footView = [[OrderFootView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 45 - 64, SCREEN_WIDTH, 45)];
    [self.view  addSubview:footView];
    self.footView = footView;
    
    self.footView.didClickOrderItemBlock = ^(NSString *title){
        [weakSelf operationOrderWithTitle:title OrderModel:_model];
    };
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DefaultAdressCell" bundle:nil] forCellReuseIdentifier:defaultAdressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderGoodDetailCell" bundle:nil]
    forCellReuseIdentifier:orderGoodDetailCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"KX_ApprovalContentCell" bundle:nil] forCellReuseIdentifier:ContenGeneralCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsCombinedCell" bundle:nil] forCellReuseIdentifier:goodsCombinedCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodSOrderCommonCell" bundle:nil] forCellReuseIdentifier:goodSOrderCommonCell];

    
    [self.tableView registerNib:[UINib nibWithNibName:@"orderOtherInfo" bundle:nil] forCellReuseIdentifier:orderOtherInfoID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderServiewInfoCell" bundle:nil] forCellReuseIdentifier:orderServiewInfoCellID];

    [self.tableView registerNib:[UINib nibWithNibName:@"OrderWeekInfoCell" bundle:nil] forCellReuseIdentifier:OrderWeekInfoCellID];

    [ self.tableView  registerNib:[UINib nibWithNibName:@"AttributeCell" bundle:nil] forCellReuseIdentifier:cellID];

    JHCoverView *coverView = [[JHCoverView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    coverView.delegate = self;
        coverView.hidden = YES;
    coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.view addSubview:coverView];
//    self.coverView.backgroundColor = [UIColor redColor];
    
    self.coverView = coverView;
}

/// 配置基础设置
- (void)setConfiguration
{
    [self.tableView registerNib:[UINib nibWithNibName:@"DefaultAdressCell" bundle:nil] forCellReuseIdentifier:defaultAdressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodSOrderCommonCell" bundle:nil] forCellReuseIdentifier:goodSOrderCommonCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodSOrderNomalCell" bundle:nil] forCellReuseIdentifier:goodSOrderNomalCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"KX_ApprovalContentCell" bundle:nil] forCellReuseIdentifier:ContenGeneralCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsCombinedCell" bundle:nil] forCellReuseIdentifier:goodsCombinedCellID];
    
    [self.tableView registerClass:[MailTypeCell class] forCellReuseIdentifier:MailTypeCellCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DeductionCell" bundle:nil] forCellReuseIdentifier:DeductionCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderPayTypeCell" bundle:nil] forCellReuseIdentifier:orderPayTypeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsCommonCell" bundle:nil] forCellReuseIdentifier:goodsCommonCellID];

}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resorceArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.resorceArray[section] isKindOfClass:[NSString class]]) {
        return 1;
    }else{
        return _orderModel.seller.count;
        
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WEAKSELF;
    if ([self.resorceArray[indexPath.section] isKindOfClass:[NSString class]]) {
        NSString *str = self.resorceArray[indexPath.section];
        if ([str isEqualToString:@"新增收货地址"]) {
            DefaultAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultAdressCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.addressModel = _orderModel.address;
            return cell;
        }
        
        else if ([str isEqualToString:@"积分抵扣"])
        {
            GoodsCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCommonCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //        cell.titleLabel.text = str;
            cell.orderModel = _orderModel;
            cell.titleLabel.textColor = TITLETEXTLOWCOLOR;
            cell.markImgeView.hidden = YES;
            return cell;
        }
        else if ([str isEqualToString:@"订单信息"])
        {
            OrderPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:orderPayTypeCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //        cell.didChageJFNumberBlock = ^(NSString *buyNumber) {
            //        };
            //        cell.userInfo = _orderModel.userinfo;
            cell.model = _orderModel;
            return cell;
            
        }
        
    }else{
        GoodSOrderNomalCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderNomalCellID forIndexPath:indexPath];
        cell.didChangeNumberBlock = ^(NSString *buyNumber){

        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Seller *seller = _orderModel.seller[indexPath.row];
        cell.seller = seller;
        
        return cell;
        
    }


    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str = self.resorceArray[indexPath.section];
    if ([self.resorceArray[indexPath.section] isKindOfClass:[NSString class]]) {
        if ([str isEqualToString:@"新增收货地址"])
        {

            return 82;
        }
        
        else if([str isEqualToString:@"积分抵扣"]){
            return 40;
        }
        
        else if([str isEqualToString:@"订单信息"]){
            return 55;
        }
        
    }
    return 100;
    

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (![self.resorceArray[section] isKindOfClass:[NSString class]]) {
        return 50;
    }
    return 5;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    if (![self.resorceArray[section] isKindOfClass:[NSString class]]) {
        Seller *seller = _orderModel.seller[section-1];
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH -10, 50)];
        headView.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = BACKGROUND_COLOR;
        [headView addSubview:lineView];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 25, 44)];
        titleLB.textColor = TITLETEXTLOWCOLOR;
        titleLB.font = Font15;
        titleLB.textAlignment = NSTextAlignmentLeft;
        
        titleLB.text = seller.seller_name;
        [headView addSubview:titleLB];
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 1)];
        lineView1.backgroundColor = LINECOLOR;
        [headView addSubview:lineView1];
        
        return headView;
    }
    return nil;
   
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    WEAKSELF;
    if (![self.resorceArray[section] isKindOfClass:[NSString class]]) {
        OrderSectionFooterView *footView=  [[OrderSectionFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 145)];
        footView.model = _orderModel;
        
        footView.didChangeEmailTypeBlock = ^(NSInteger type) {

            // type  0 邮寄  1门店
            weakSelf.orderModel.express_type = [NSString stringWithFormat:@"%ld",type+1];
        };
        footView.backgroundColor = [UIColor whiteColor];
        footView.titleLB3.attributedText = _allCountStr;
        return footView;


    }
    else{
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        headView.backgroundColor = BACKGROUND_COLOR;
        return headView;
        //        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (![self.resorceArray[section] isKindOfClass:[NSString class]]) {
        return 145;
    }
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

 
}



//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
//    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
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
        [weakSelf OperationPaymethoedRequestUrl:@"/order/getOrderPayMethod" Param:param];
        
    }
    else if ([title isEqualToString:@"提醒发货"] )
    {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id  forKey:@"user_id"];
        [param setObject:model.orderno forKey:@"orderno"];
        [weakSelf  operationRequestUrl:@"/order/callOrder" Param:param];
        
    }
    
    

    
}

/// 支付成功
- (void)getPayTypeRelute:(NSNotification *)notification
{
    [self requestNetWork];
    
}


@end
