     //
//  GoodsOrderNomalVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/22.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsOrderNomalVC.h"
#import "DefaultAdressCell.h"
#import "GoodSOrderCommonCell.h"
#import "GoodSOrderNomalCell.h"
#import "GoodsOrderVModel.h"
#import "KX_ApprovalContentCell.h"
#import "GoodsCombinedCell.h"
#import "AddressManageVC.h"
#import "SQActionSheetView.h"
#import "OrderCommitSuccessVC.h"
//#import "GoodsSelectTimeVC.h"
#import "OrdersPayTypeCell.h"
#import "OrderLinkTypeCell.h"
#import "CouponsVModel.h"


#import "MailTypeCell.h"
#import "DeductionCell.h"

#import "PayOrderView.h"
#import "PayDetailModel.h"

#import "PayModels.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"
#import "JHCoverView.h"
#import "SetPayPwdVC.h"

#import "OrderSectionFooterView.h"

#import "KYTextView.h"

@interface GoodsOrderNomalVC ()<UITableViewDelegate,UITextViewDelegate,JHCoverViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *orderPiceLB;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign)   NSInteger sectionCount;         /// 返回section数目
@property (nonatomic, strong)   NSMutableArray *addressArr;            /// 新增收货地址Arr
@property (nonatomic, strong)   NSArray *titleArr;              /// 返回section数目
@property (nonatomic, strong)   NSArray *jfTitleArr;              /// 返回section数目

@property (nonatomic, strong)   NSMutableArray *detailArr;             ///
@property (nonatomic, strong) GoodsOrderModel *orderModel;
@property (nonatomic, assign) NSInteger paySelectIndex;
@property (nonatomic, assign) BOOL  isValue;  /// 用来定位  新增收货地址是否有效


@property (nonatomic, strong)   NSString *invoiceTy;            ///发票选定

@property (nonatomic, strong)    PayOrderView *payOrderView;            //

@property (nonatomic, strong)    PayModels *payModel;            //

@property (nonatomic, strong)    NSAttributedString *allCountStr;            //
@property (nonatomic, strong) JHCoverView *coverView;
@property (nonatomic, strong) KYTextView *textView;

@end

@implementation GoodsOrderNomalVC
static NSString *const defaultAdressCellID = @"DefaultAdressCellID";
static NSString *const goodSOrderCommonCell = @"GoodSOrderCommonCellID";
static NSString *const goodSOrderNomalCellID = @"goodSOrderNomalCell";
static NSString * const ContenGeneralCellID = @"ContenGeneralCellID";
static NSString * const goodsCombinedCellID = @"goodsCombinedCellID";
static NSString * const MailTypeCellCellID = @"MailTypeCellCellID";
static NSString * const DeductionCellID = @"DeductionCellID";



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
    [self getGoodsOrderInfoRequest];

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self getDefaultAddressRequest];
    
}



/// 配置基础设置
- (void)setConfiguration
{

    self.title  = @"确认订单";
    _submitBtn.backgroundColor = KMAINCOLOR;
    _addressArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = BACKGROUND_COLOR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = BACKGROUND_COLOR;
    [_bottomView layerForViewWith:0 AndLineWidth:0.5];
    
    
    _orderPiceLB.textColor = TITLETEXTLOWCOLOR;
    _orderPiceLB.font = Font15;
    [self.tableView registerNib:[UINib nibWithNibName:@"DefaultAdressCell" bundle:nil] forCellReuseIdentifier:defaultAdressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodSOrderCommonCell" bundle:nil] forCellReuseIdentifier:goodSOrderCommonCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodSOrderNomalCell" bundle:nil] forCellReuseIdentifier:goodSOrderNomalCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"KX_ApprovalContentCell" bundle:nil] forCellReuseIdentifier:ContenGeneralCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsCombinedCell" bundle:nil] forCellReuseIdentifier:goodsCombinedCellID];
    
    [self.tableView registerClass:[MailTypeCell class] forCellReuseIdentifier:MailTypeCellCellID];

    [self.tableView registerNib:[UINib nibWithNibName:@"DeductionCell" bundle:nil] forCellReuseIdentifier:DeductionCellID];

}


/// 初始化视图
- (void)setup
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPayTypeRelute:) name:NOTICEMEPAYMSG object:nil];

    [self.view addSubview:self.tableView];

    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.tableView.tableFooterView = [UIView new];
    
    JHCoverView *coverView = [[JHCoverView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    coverView.delegate = self;
    self.coverView = coverView;
    coverView.hidden = YES;
    [ coverView show];
    
//    [coverView show];
}





/// 展示 付款方式
- (void)showPayView
{
    WEAKSELF;
    NSMutableArray *titleArr = [[NSMutableArray alloc] init];
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];

    if ([_orderModel.pay_method.wxpay isEqualToString:@"Y"]) {
        [titleArr addObject:@"微信支付"];
        [imageArr addObject:@"wxzf@3x.png"];
    }
    
    if ([_orderModel.pay_method.alipay isEqualToString:@"Y"]) {
        [titleArr addObject:@"支付宝支付"];
        [imageArr addObject:@"zfb@3x.png"];
    }
    
    if ([_orderModel.pay_method.coins_money isEqualToString:@"Y"]) {
        [titleArr addObject:@"激励笑脸支付"];
        [imageArr addObject:@"jlxl@3x.png"];
    }
    
    if ([_orderModel.pay_method.coins_air_money isEqualToString:@"Y"]) {
        [titleArr addObject:@"空充笑脸支付"];
        [imageArr addObject:@"kcxl@3x.png"];
    }
    
    if ([_orderModel.pay_method.phone_money isEqualToString:@"Y"]) {
        [titleArr addObject:@"话费支付"];
        [imageArr addObject:@"hfdh@3x.png"];
    }
    
    if ([_orderModel.pay_method.point isEqualToString:@"Y"]) {
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

    
//    if ( _orderModel.allFreight <= 0 ) {
////        _orderModel.allFreight = 2;
//        if ( _orderModel.allFreight> 0) {
//            [titleArr removeAllObjects];
//            [imageArr removeAllObjects];
//
//            [titleArr addObject:@"微信支付"];
//            [imageArr addObject:@"wxzf@3x.png"];
//
//            [titleArr addObject:@"支付宝支付"];
//            [imageArr addObject:@"zfb@3x.png"];
//
//
//            [titleArr addObject:@"激励笑脸支付"];
//            [imageArr addObject:@"jlxl@3x.png"];
//
//            [titleArr addObject:@"空充笑脸支付"];
//            [imageArr addObject:@"kcxl@3x.png"];
//
//            [titleArr addObject:@"兑换积分支付"];
//            [imageArr addObject:@"jfzf@3x.png"];
//        }
//        for (int i = 0; i<titleArr.count; i++) {
//            PayDetailModel *model = [PayDetailModel new];
//            model.mark = @"";
//            model.icon = imageArr[i];
//            model.isSelect = NO;
//            model.title = titleArr[i];
//
//            if ( [model.title isEqualToString:@"兑换积分支付"]) {
//                model.isSelect = YES;
//                _orderModel.payIndexStr = @"兑换积分支付";
//            }
//            [dataArray addObject:model];
//        }
//
//
//
//    }
//    else{
//
//        for (int i = 0; i<titleArr.count; i++) {
//            PayDetailModel *model = [PayDetailModel new];
//            model.mark = @"";
//            model.icon = imageArr[i];
//            model.isSelect = NO;
//            if (titleArr.count == 1 && [titleArr.firstObject isEqualToString:@"兑换积分支付"]) {
//                model.isSelect = YES;
//                _orderModel.payIndexStr = @"兑换积分支付";
//            }
//            model.title = titleArr[i];
//
//            [dataArray addObject:model];
//        }
//    }

    view.didChangeJFValueBlock = ^(GoodsOrderModel *orderModel) {
        
        [weakSelf submitOrderInfoRequest];
    };
    


    view.dataArr = dataArray;
    view.orderModel = _orderModel;
    [view show];
    self.payOrderView = view;
}


#pragma mark = request
/// 获取新增收货地址
- (void)getDefaultAddressRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
    [GoodsOrderVModel getGoodsOrderAddressParam:param successBlock:^(NSArray<GoodsOrderAddressModel *> *dataArray,NSArray<GoodsOrderAddressModel *>*allDataArr,BOOL isSuccess) {
        if (isSuccess) {
            [_addressArr removeAllObjects];
            [_addressArr addObjectsFromArray:dataArray];
            _isValue = NO;
            if (!KX_NULLString(_model.addressID)) {
                for (GoodsOrderAddressModel *addressModel in allDataArr) {
                    if ([addressModel.addr_id isEqualToString:_model.addressID]) {
                        NSArray *arr = @[addressModel];
                        [weakSelf.resorceArray replaceObjectAtIndex:0 withObject:arr];
                        [weakSelf.addressArr addObjectsFromArray:arr];
                        _model.addressID = addressModel.addr_id;
                        _isValue = YES;
                        [weakSelf.tableView reloadData];
                        
                        break;
                    }
                }
                if (_isValue == NO) {
                    [_addressArr removeAllObjects];
                    weakSelf.model.addressID = @"";
                    [weakSelf.resorceArray  replaceObjectAtIndex:0  withObject:@[@"新增收货地址"]];
                    [weakSelf.tableView reloadData];
                }
            }
        }
        [weakSelf.resorceArray  replaceObjectAtIndex:0  withObject:@[@"新增收货地址"]];
        [weakSelf.tableView reloadData];
    }];
}



///订单信息 (限定：新机、配构件、二手设备、整机流转的出租、标准节共享的出租)
- (void)getGoodsOrderInfoRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    if (_orderType == ShoppinCarType) {
        if (KX_NULLString(_uuid)) {
            [param setObject:@"product" forKey:@"type"];
            [param setObject:_cart_ids forKey:@"cart_ids"];
            [param setObject:_itemsModel.cartNum?_itemsModel.cartNum:@"1" forKey:@"goods_num"];
            [param setObject:@"" forKey:@"address_id"];
        }else{
            [param setObject:_spec?_spec:@"" forKey:@"spec"];
            [param setObject:@"uuid" forKey:@"type"];
            [param setObject:_uuid?_uuid:@"" forKey:@"uuid"];
        }
        
    }else{
        [param setObject:@"goods" forKey:@"type"];
        [param setObject:_itemsModel.goods_id forKey:@"goods_id"];
        [param setObject:_spec?_spec:@"" forKey:@"spec"];
        [param setObject:_itemsModel.cartNum?_itemsModel.cartNum:@"1" forKey:@"goods_num"];
        [param setObject:@"" forKey:@"address_id"];

    }
    
    
    [GoodsOrderVModel getGoodsOrderParam:param successBlock:^(NSArray<GoodsOrderModel *> *dataArray, BOOL isSuccess) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isSuccess) {
            if (weakSelf.resorceArray.count >0) {
                [weakSelf.resorceArray removeAllObjects];
            }
            if (dataArray.count > 0) {
                GoodsOrderModel *model = dataArray[0];
                if (KX_NULLString(weakSelf.orderModel.express_type)) {
                    model.express_type = @"";
                }else{
                    model.express_type = weakSelf.orderModel.express_type;

                }
                
                if (KX_NULLString(weakSelf.orderModel.message)) {
                    model.message = @"";
                }else{
                    model.message = weakSelf.textView.text;
                    
                }
                weakSelf.orderModel = model;
                model.address.province = @"";
                if (KX_NULLString(model.address.province)) {
                    weakSelf.model.addressID = @"";
                    [weakSelf.resorceArray addObject:@"新增收货地址"];
                }else{
                    [weakSelf.resorceArray addObject:@"新增收货地址"];
                }
                [weakSelf.resorceArray addObjectsFromArray:model.seller];
                weakSelf.orderModel = model;

            }
        
            if (KX_NULLString(_model.noteConten)) {
                _model.noteConten = @"";
            }
   
            [weakSelf getGoodsOrderAllInfo];

        }else{
        
        
        }
    }];

}

///生成订单
- (void)submitOrderInfoRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    if (_orderType == ShoppinCarType) {
        if (KX_NULLString(_uuid)) {
            [param setObject:@"product" forKey:@"direct_type"];
            [param setObject:_cart_ids forKey:@"cart_ids"];
             [param setObject:_itemsModel.cartNum?_itemsModel.cartNum:@"1" forKey:@"goods_num"];
        }else{
            [param setObject:@"uuid" forKey:@"direct_type"];
            [param setObject:_uuid?_uuid:@"" forKey:@"uuid"];
        }
        
    }else{
        [param setObject:@"goods" forKey:@"direct_type"];
        [param setObject:@"1" forKey:@"goods_num"];
        [param setObject:_itemsModel.goods_id forKey:@"goods_id"];

    }
    [param setObject:_orderModel.address.addr_id forKey:@"address_id"];
    
    if ([_orderModel.message isEqualToString:@"选填(对本次交易的说明,限50个字以内)"] ) {
        _orderModel.message = @"";
    }
    [param setObject:_orderModel.message forKey:@"message"];
    [param setObject:_orderModel.express_type forKey:@"express_type"];
    [param setObject:_spec?_spec:@"" forKey:@"spec"];
    [GoodsOrderVModel getSubmitOrderInfoParam:param successBlock:^(NSString *orderID,BOOL isSuccess, NSString *msg) {
        if (isSuccess) {
            weakSelf.orderModel.orderno = orderID;
            
            [[PayTool sharedPayTool] getPayInfoOrderModle:weakSelf.orderModel payVC:weakSelf reluteBlock:^(NSString *msg, BOOL success) {
                
            }];
//            if ([_orderModel.payIndexStr isEqualToString:@"微信支付"] || [_orderModel.payIndexStr isEqualToString:@"支付宝支付"]) {
//                [weakSelf getPayKeyInfoRequest:orderID];
//            }
//            else{
//                [weakSelf getPayPwdYZRequest];
//            }
        }
        else{
            [weakSelf showHint:msg];
        }

    }];
}


- (void)getPayKeyInfoRequest:(NSString *)orderID
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:orderID forKey:@"orderno"];
    
  
    
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

/// 微信  支付宝
- (void)getPayKeyRequesParam:(id)param
{
    WEAKSELF;
    [GoodsOrderVModel getPayInfoKryParam:param successBlock:^(PayModels *model, BOOL isSuccess,NSString *msg) {
        if (isSuccess ) {
            weakSelf.payModel = model;
            [weakSelf doAPPay];
        }
        else{
            [weakSelf showHint:msg];
        }
    }];
}


#pragma mark - UITaleViewDelegate and UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return self.resorceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.resorceArray[section] isKindOfClass:[NSString class]]) {
        return 1;
    }else{
        Seller *seller = _orderModel.seller[section -1];
        return seller.products.count;

    }

    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    if ([self.resorceArray[indexPath.section] isKindOfClass:[NSString class]]) {
        NSString *str = self.resorceArray[indexPath.section];
        if ([str isEqualToString:@"新增收货地址"]) {
            if (KX_NULLString(_orderModel.address.addr_id)) {
                GoodSOrderCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderCommonCell forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleLB.text = self.resorceArray[indexPath.section];
                cell.titleLB.textColor = TITLETEXTLOWCOLOR;
                cell.detailLB.text = @"";
                return cell;
            }else{
                DefaultAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultAdressCellID forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.addressModel = _orderModel.address;
                return cell;
            }
        }

    }else{
        GoodSOrderNomalCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderNomalCellID forIndexPath:indexPath];
        cell.didChangeNumberBlock = ^(NSString *buyNumber){
            weakSelf.model.goodSCount = [buyNumber integerValue];
            [self getGoodsOrderInfoRequest];
        };
     
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Seller *seller = _orderModel.seller[indexPath.section-1];
        cell.products = seller.products[indexPath.row];
        
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
            if (KX_NULLString(_orderModel.address.addr_id)) {
                return 44;
            }
            return 82;
        }
    }
    return 100;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.resorceArray[section] isKindOfClass:[Seller class]]) {
        return 45;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  
    Seller *seller = _orderModel.seller[section -1];

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 45)];
    headView.backgroundColor = [UIColor whiteColor];
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
//    lineView.backgroundColor = BACKGROUND_COLOR;
//    [headView addSubview:lineView];
    
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


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (![self.resorceArray[section] isKindOfClass:[NSString class]]) {
        return 185;
    }
    return 0.01f;
}



- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    WEAKSELF;
    if (![self.resorceArray[section] isKindOfClass:[NSString class]]) {
        OrderSectionFooterView *footView=  [[OrderSectionFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 145)];
        footView.model = _orderModel;
        _textView = footView.textField;
        footView.didChangeEmailTypeBlock = ^(NSInteger type) {
            _orderModel.message = _textView.text;

            // type  0 邮寄  1门店
            weakSelf.orderModel.express_type = [NSString stringWithFormat:@"%ld",type+1];
            if (type == 1) {
                
//                Seller *seller = weakSelf.orderModel.seller[section - 1];
                
                for (Seller *seller in weakSelf.orderModel.seller) {
                    seller.freight = @"0";
                }
//                for (Products *item  in seller.products) {
//                    item.freight = @"0";
//                }
                [weakSelf getGoodsOrderAllInfo];
                
                
            }else{
//                Seller *seller = weakSelf.orderModel.seller[section - 1];
//                for (Products *item  in seller.products) {
//                    item.freight = item.freight;
//                }
//                [weakSelf getGoodsOrderAllInfo];
                [weakSelf getGoodsOrderInfoRequest];
            }
        };
        footView.backgroundColor = [UIColor whiteColor];
        footView.titleLB3.attributedText = _allCountStr;
        return footView;
    }
    
    return nil;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    if ([self.resorceArray[indexPath.section] isKindOfClass:[NSString class]]) {
        NSString *str = self.resorceArray[indexPath.section];
        if ([str isEqualToString:@"新增收货地址"]) {
            AddressManageVC *VC = [[AddressManageVC alloc] init];
            VC.model = _model;
            VC.isValue = @"0";
            VC.didClickAddressCellBlock = ^(GoodsOrderAddressModel* model){

                if ( weakSelf.orderModel.address == nil) {
                    weakSelf.orderModel.address = [[Address alloc] init];
                }
                weakSelf.orderModel.address.addr_id = model.addr_id;
                weakSelf.orderModel.address.contact_username = model.contact_username;
                weakSelf.orderModel.address.contact_mobile = model.contact_mobile;
                weakSelf.orderModel.address.province = model.province;
                weakSelf.orderModel.address.city = model.city;
                weakSelf.orderModel.address.district = model.district;
                [weakSelf.tableView reloadData];

            };
            [self.navigationController pushViewController:VC animated:YES];
        }
    }

}




#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.tag == 200) {
        _model.noteConten = textView.text;

    }
    else{
        _detailArr[textView.tag - 100] = textView.text;

    }
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

#pragma mark - KYDatePickerDelegate
-(void)selectDate:(NSString *)date
{
    
}

#pragma mark  - JHCoverViewDelegate
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


#pragma mark - private
- (void)showPaySheetView
{
    WEAKSELF;
    
    SQActionSheetView *sheetView = [[SQActionSheetView alloc]initWithTitle:@"选择付款方式" buttons:_model.payArr buttonClick:^(NSInteger buttonIndex,NSString *title) {
        
        if ([title isEqualToString:@"直接付款"]) {
            weakSelf.model.payTypeID =@"1";
        }
        if ([title isEqualToString:@"分期付款"]) {
            weakSelf.model.payTypeID =@"2";
        }
        
        if ([title isEqualToString:@"先用后付"] || [title isEqualToString:_model.monthlyPayments]) {
            weakSelf.model.payTypeID =@"3";
        }
        
        if ([title isEqualToString:@"融资租赁"]) {
            weakSelf.model.payTypeID =@"4";
        }
        weakSelf.model.payTypeTitle = title;
        weakSelf.paySelectIndex = buttonIndex;

        
    }];
    sheetView.oldSelectIndex = _paySelectIndex;
    [sheetView showView];
    
}


- (IBAction)submitBtn:(id)sender {
    
    if (KX_NULLString(_orderModel.address.addr_id)) {
        [self.view makeToast:@"请选择收货地址~"];
        return;
    }
    if (KX_NULLString(_orderModel.express_type)) {
        [self.view makeToast:@"请选择快递方式~"];
        return;
    }
    
    _orderModel.message = _textView.text;
    [self showPayView];
    
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



/// 支付成功
- (void)getPayTypeRelute:(NSNotification *)notification
{
    OrderCommitSuccessVC *vc = [[OrderCommitSuccessVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)getGoodsOrderAllInfo
{
    CGFloat allPrices = 0;
    CGFloat allPoint = 0;
    CGFloat allFreight = 0;
    int count =0;
    
    for (Seller *seller in _orderModel.seller) {
        for (Products *item  in seller.products) {
            allPrices += item.price.floatValue *item.goods_nums.intValue;
            allPoint += item.point.floatValue *item.goods_nums.intValue;
            count += item.goods_nums.intValue;
        }
        allFreight +=  seller.freight.floatValue;

    }
    _orderModel.allFreight = allFreight;
    NSString *allPriceStr = @"";
    NSMutableArray *priceArr = [NSMutableArray array];
    NSMutableArray *infoArr = [NSMutableArray array];
    [infoArr addObject:[NSString stringWithFormat:@"%d",count]];
    [infoArr addObject:@"+"];
    [infoArr addObject:@"(包邮)"];


    NSString *str1;
    if (allPrices>0) {
       str1 = [NSString stringWithFormat:@"¥%.2f",allPrices];
        str1 = [str1 stringByReplacingOccurrencesOfString:@".00" withString:@""];
        [priceArr addObject:str1];
        [infoArr addObject:str1];
    }
    
    _orderModel.allPrices = allPrices;
    NSString *str2;
    if (allPoint>0) {
        str2 = [NSString stringWithFormat:@"%.2f积分",allPoint];
        str2 = [str2 stringByReplacingOccurrencesOfString:@".00" withString:@""];
        [infoArr addObject:str2];

        [priceArr addObject:str2];
    }
    
    NSString *str3;
    if (allFreight>0 && !KX_NULLString(_orderModel.express_type)) {
       str3 = [NSString stringWithFormat:@"%.2f快递费",allFreight];
        str3 = [str3 stringByReplacingOccurrencesOfString:@".00" withString:@""];

        [priceArr addObject:str3];
        [infoArr addObject:str3];

    }else{
        if ([_itemsModel.freight_msg isEqualToString:@"包邮"]) {
            [priceArr addObject:@"(包邮)"];
        }

    }
    
   
    
    allPriceStr = [priceArr componentsJoinedByString:@"+"];
    allPriceStr = [allPriceStr stringByReplacingOccurrencesOfString:@".00" withString:@""];
    allPriceStr = [allPriceStr stringByReplacingOccurrencesOfString:@"+(包邮)" withString:@" (包邮)"];
    NSString *countStr = [NSString stringWithFormat:@"共%d件商品   小计:",count];

    NSString *allStr = [NSString stringWithFormat:@"%@%@",countStr,allPriceStr];
//    NSAttributedString *attributedStr =  [allStr creatAttributedString:allStr withMakeRange:NSMakeRange(countStr.length, allStr.length - countStr.length) withColor:KMAINCOLOR withFont:[UIFont systemFontOfSize:15 ]];
    _allCountStr =  [self attributeStringWithContent:allStr keyWords:infoArr fonts:Font13 color:KMAINCOLOR];

//    weight:UIFontWeightMedium

    NSString *countStr1 = [NSString stringWithFormat:@"合计:%@",allPriceStr];
//    NSString *allStr1 = [NSString stringWithFormat:@"%@%@",countStr1,allPriceStr];
//    NSAttributedString *attributedStr2 =  [allStr1 creatAttributedString:allStr1 withMakeRange:NSMakeRange(countStr1.length, allStr1.length - countStr1.length) withColor:KMAINCOLOR withFont:[UIFont systemFontOfSize:15 ]];
    _orderPiceLB.attributedText =   [self attributeStringWithContent:countStr1 keyWords:infoArr fonts:Font13 color:KMAINCOLOR];
    

    
//    NSString *countStr2 = @"待支付:";
//    NSString *allStr2 = [NSString stringWithFormat:@"%@%@",countStr2,allPriceStr];
//    NSAttributedString *attributedStr3 =  [allStr1 creatAttributedString:allStr2 withMakeRange:NSMakeRange(countStr2.length, allStr2.length - countStr2.length) withColor:KMAINCOLOR withFont:[UIFont systemFontOfSize:15 ]];
//    _orderModel.allPriceAttriStr = attributedStr3;
    
    _orderModel.allPoint = allPoint;
    [self.tableView reloadData];

}


- (NSAttributedString *)attributeStringWithContent:(NSString *)content keyWords:(NSArray *)keyWords fonts:(UIFont *)fonts color:(UIColor *)color
{
  __block  UIColor *colors = color;
    __block  UIFont *font = fonts;

    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:content];
    
    if (keyWords) {
        
        [keyWords enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
          
            NSMutableString *tmpString=[NSMutableString stringWithString:content];
            if ([obj isEqualToString:@"(包邮)"]) {
                colors = DETAILTEXTCOLOR;
            }else{
                colors = color;
            }
//            if ( [obj containsString:@"¥"] || [obj containsString:@"积分"]|| [obj containsString:@"快递费"]) {
//                font = KY_FONT(9);
//            }else{
//                font = fonts;
//            }
            NSRange range=[content rangeOfString:obj];
            
            NSInteger location=0;
            while (range.length>0) {
                
                [attString addAttribute:(NSString*)NSForegroundColorAttributeName value:colors range:NSMakeRange(location+range.location, range.length)];
                [attString addAttribute:NSFontAttributeName
                                  value:font
                                  range:range];
                
                location+=(range.location+range.length);
                
                NSString *tmp= [tmpString substringWithRange:NSMakeRange(range.location+range.length, content.length-location)];
                
                tmpString=[NSMutableString stringWithString:tmp];
                
                range=[tmp rangeOfString:obj];
            }
        }];
    }
    return attString;
}

@end
