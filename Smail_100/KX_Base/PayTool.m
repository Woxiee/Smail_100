//
//  PayTool.m
//  Smail_100
//
//  Created by Faker on 2018/4/26.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "PayTool.h"
#import "PayModels.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"
#import "JHCoverView.h"
#import "SetPayPwdVC.h"
#import "PayOrderView.h"
#import "PayDetailModel.h"
#import "GoodsOrderVModel.h"
#import "OrderCommitSuccessVC.h"

@interface PayTool()<JHCoverViewDelegate>
@property (nonatomic, strong) NSArray *payInfoArr;

@property (nonatomic, strong) UIViewController *subVC;
@property (nonatomic, strong) PayOrderView *payOrderView;
@property (nonatomic, strong) GoodsOrderModel *orderModel;
@property (nonatomic, strong) JHCoverView *coverView;
@property (nonatomic, strong)    PayModels *payModel;            //

@end

@implementation PayTool
singleton_implementation(PayTool)

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
    
}
- (void)getPayInfoOrderModle:(GoodsOrderModel*)orderModel payVC:(UIViewController *)VC reluteBlock:(void(^)(NSString *msg,BOOL success))compleBlock
{
    _orderModel = orderModel;
    _subVC = VC;
    [self setup];
    _didClicCompltBlock = compleBlock;
}


- (void)setup
{
    WEAKSELF;
    
    JHCoverView *coverView = [[JHCoverView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    coverView.delegate = self;
    self.coverView = coverView;
    coverView.hidden = YES;
    coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [coverView show];
    
    if ([_orderModel.payIndexStr isEqualToString:@"微信支付"] || [_orderModel.payIndexStr isEqualToString:@"支付宝支付"]) {
        [self getPayKeyInfoRequest:_orderModel.orderno];
    }
    else{
        [self getPayPwdYZRequest];
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
                    if (_didClicCompltBlock) {
                        _didClicCompltBlock(@"支付成功",YES);
                    }
                    OrderCommitSuccessVC *vc = [[OrderCommitSuccessVC alloc] init];
                    if (self.isType.integerValue == 1 ) {
                        vc.successType = CommitSuccessAutiocnType;
                    }
                    if (self.isType.integerValue == 2 ) {
                        vc.successType = CommitSuccessSupplyType;
                    }

                    [weakSelf.subVC.navigationController pushViewController:vc animated:YES];
                }
                
            }
            
        }
        else{
            [weakSelf.subVC showHint:msg];
        }
    }];
    
    
}

- (void)getPayPwdYZRequest
{
    WEAKSELF;
    if (KX_NULLString([KX_UserInfo sharedKX_UserInfo].pay_password)) {
       
        SuccessView *successV = [[SuccessView alloc] initWithTrueCancleTitle:@"您还未设置支付密码"  sureTitle:@"去设置" cancelTitle:@"取消" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                SetPayPwdVC  *vc = [[SetPayPwdVC alloc] init];
                [weakSelf.subVC.navigationController pushViewController:vc animated:YES];
                
            }}];
        [successV showSuccess];

    }else{
        self.coverView.hidden = NO;
        [self.coverView.payTextField becomeFirstResponder];
        
    }
    
}


- (void)doAPPay
{
    NSString *appID = _payModel.sellerId;
    NSString *rsa2PrivateKey = _payModel.privatekey;
    
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称`
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


// 支付成功
- (void)getPayTypeRelute:(NSNotification *)notification
{
    if (_didClicCompltBlock) {
        _didClicCompltBlock(@"支付成功",YES);
    }
    OrderCommitSuccessVC *vc = [[OrderCommitSuccessVC alloc] init];
    if (self.isType.integerValue == 1 ) {
        vc.successType = CommitSuccessAutiocnType;
    }
    if (self.isType.integerValue == 2 ) {
        vc.successType = CommitSuccessSupplyType;
    }
    [_subVC.navigationController pushViewController:vc animated:YES];
    
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
            [weakSelf.subVC showHint:msg];
        }
    }];
    
    
}


/**
 密码错误
 */
- (void)coverView:(JHCoverView *)control
{
    [self.subVC showHint:@"支付密码输入错误" yOffset:-200];
}

/**
 忘记密码
 */
- (void)forgetPassWordCoverView:(JHCoverView *)control
{
    FindPaypwdVC *vc = [[FindPaypwdVC alloc] init];
    [self.subVC.navigationController pushViewController:vc animated:YES];
}
- (void)dealloc
{
    
}


@end
