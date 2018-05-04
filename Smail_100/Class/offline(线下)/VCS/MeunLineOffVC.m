//
//  MeunLineOffVC.m
//  Smail_100
//
//  Created by ap on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "MeunLineOffVC.h"
#import "GoodsCategoryCell.h"
#import "RighMeumtCell.h"
#import "shoppingCarVM.h"
#import "ChangeGoodsCountView.h"
#import "GoodsOrderNomalVC.h"
#import "GoodSDetailModel.h"
#import "MenulineView.h"

#import "GoodsOrderModel.h"
#import "PayModels.h"
#import "PayOrderView.h"
#import "PayDetailModel.h"

@interface MeunLineOffVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (nonatomic, strong) NSMutableArray *titleArr;

@property (weak, nonatomic) IBOutlet UITableView *rightTableview;

@property (nonatomic, strong) NSString *sub_category_id;

@property (nonatomic, strong)  GoodsClassModel *classModel;


@property (nonatomic, strong) shoppingCarVM *carVM;

@property (nonatomic, assign) NSInteger  oldIndex;

@property (weak, nonatomic) IBOutlet UILabel *bugInfoLb;

@property (strong, nonatomic)  UIButton *cartBtn;
@property (strong, nonatomic)  NSMutableArray * allInfoArr;

@property (strong, nonatomic)  NSString  * allPrice;

@property (nonatomic,copy)  NSMutableDictionary *itemsDic;
@property (nonatomic, strong) GoodsOrderModel *orderModel;
@property (nonatomic, strong)    PayModels *payModel;            //
@property (nonatomic, strong)    PayOrderView *payOrderView;            //
@property (nonatomic, strong)    MenulineView *headView;            //



@end




@implementation MeunLineOffVC
{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self loadShopCarData];
    [self allMoneyAfterSelect];
   
    if (_orderModel == nil) {
        _orderModel = [GoodsOrderModel new];
    }
    [self showPayView];
}


- (void)loadShopCarData
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_sub_category_id?_sub_category_id:@"" forKey:@"sub_category_id"];
    [param setObject:_detailModel.shop_id forKey:@"shop_id"];
    [param setObject:_classModel.UUID?_classModel.UUID:@"" forKey:@"uuid"];

//    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    
    [BaseHttpRequest postWithUrl:@"/shop/shop_category_goods" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            [weakSelf.titleArr removeAllObjects];
            [weakSelf.resorceArray removeAllObjects];

            GoodsClassModel *model = [GoodsClassModel yy_modelWithJSON:result[@"data"]];
            model.leftCategory = [NSArray yy_modelArrayWithClass:[LeftCategory class] json:model.leftCategory];
            for (int i = 0; i<model.leftCategory.count; i++) {
                LeftCategory *category = model.leftCategory[i];
                if (i == _oldIndex) {
                    category.select = YES;
                    weakSelf.sub_category_id = category.id;
                }
                [weakSelf.titleArr addObject:category];

            }
//            LeftCategory *category = [LeftCategory new];
//            category.name = @"ceshi ";
//            [weakSelf.titleArr addObject:category];

            NSMutableArray * list = [[NSMutableArray alloc] init];
            model.rightGoods = [NSArray yy_modelArrayWithClass:[RightGoods class] json:model.rightGoods];
            for (RightGoods *item in model.rightGoods) {
               OrderGoodsModel *model = [shoppingCarVM changeRightGoodsModelInListToOrderGoodsModel:item];
                [list addObject:model];
            }
            [weakSelf.resorceArray addObjectsFromArray:list];
            weakSelf.classModel = model;
            [weakSelf.itemsDic setObject:list forKey:[NSString stringWithFormat:@"%ld",(long)_oldIndex]];
            [weakSelf.leftTableView reloadData];
            [weakSelf.rightTableview reloadData];
            [weakSelf allMoneyAfterSelect];

            
        }
        else{
            [weakSelf.view makeToast:msg];
        }
    }];
}

- (void)getOrderNoRequrst:(NSString *)money
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_detailModel.shop_id forKey:@"shop_id"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:money forKey:@"money"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    
    [BaseHttpRequest postWithUrl:@"/pay/shop_pay" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            weakSelf.orderModel.orderno = result[@"data"];
            _payOrderView.orderModel = weakSelf.orderModel;

              [weakSelf.payOrderView show];
          
        }else{
            [weakSelf.view makeToast:msg];

        }
    }];
}


- (void)setUI
{
    self.title = @"查看商家产品";
    _bugInfoLb.text = @"赶紧下单吧~";
    _carVM = [shoppingCarVM new];
    _titleArr = [[NSMutableArray alloc] init];
    

    _allInfoArr= [[NSMutableArray alloc] init];
    _itemsDic = [[NSMutableDictionary alloc] init];
    
    self.view.backgroundColor = [UIColor clearColor];
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.backgroundColor =[UIColor whiteColor];;
    
    _rightTableview.dataSource = self;
    _rightTableview.delegate = self;
    _rightTableview.rowHeight = 44.f;
    _rightTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableview.backgroundColor = BACKGROUND_COLOR;
    
    [self setRightNaviBtnImage:[UIImage imageNamed:@"moreOne@2x.png"]];

//    [self.rightNaviBtn showBadgeWithStyle:WBadgeStyleNumber value:3 animationType:WBadgeAnimTypeNone];

    
    
    _cartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cartBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 50 - 64, 74, 50);
//    _cartBtn.backgroundColor = [UIColor redColor];
//    [self.view addSubview:_cartBtn];
//    _cartBtn.badgeCenterOffset = CGPointMake(-25, 9);

//    [_cartBtn showBadgeWithStyle:WBadgeStyleNumber value:3 animationType:WBadgeAnimTypeNone];
//    _cartBtn.badgeCenterOffset = CGPointMake(-25, 9);
    WEAKSELF;
    MenulineView *headView = [[MenulineView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50 - SafeAreaTopHeight - 50, SCREEN_WIDTH, 50)];
    headView.didClickSureBlock = ^(NSString *str){
        _orderModel.allPrices = str.floatValue;
        [weakSelf getOrderNoRequrst:str];
    };
    [self.view addSubview:headView];
    _headView = headView;
}



/// 展示 付款方式
- (void)showPayView
{
    WEAKSELF;
    NSMutableArray *titleArr = [[NSMutableArray alloc] init];
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    PayOrderView *view;
//    if ([_orderModel.pay_method.wxpay isEqualToString:@"Y"]) {
        [titleArr addObject:@"微信支付"];
        [imageArr addObject:@"wxzf@3x.png"];
//    }
    
//    if ([_orderModel.pay_method.alipay isEqualToString:@"Y"]) {
        [titleArr addObject:@"支付宝支付"];
        [imageArr addObject:@"zfb@3x.png"];
//    }
    
//    if ([_orderModel.pay_method.coins_money isEqualToString:@"Y"]) {
        [titleArr addObject:@"激励笑脸支付"];
        [imageArr addObject:@"jlxl@3x.png"];
//    }
    
//    if ([_orderModel.pay_method.coins_air_money isEqualToString:@"Y"]) {
        [titleArr addObject:@"空充笑脸支付"];
        [imageArr addObject:@"kcxl@3x.png"];
//    }
    
//    if ([_orderModel.pay_method.phone_money isEqualToString:@"Y"]) {
//    }
    
  
    
    view = [[PayOrderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withPayType:PayTypeNoaml];
 
    view.didChangeJFValueBlock = ^(GoodsOrderModel *orderModel) {
        [PayTool sharedPayTool].isType = @"1";
        
        [[PayTool sharedPayTool] getPayInfoOrderModle:weakSelf.orderModel payVC:weakSelf reluteBlock:^(NSString *msg, BOOL success) {
            
        }];
    };
    
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<titleArr.count; i++) {
        PayDetailModel *model = [PayDetailModel new];
        model.mark = @"";
        model.icon = imageArr[i];
        model.isSelect = NO;
        if (titleArr.count == 1 && [titleArr.firstObject isEqualToString:@"兑换积分"]) {
            model.isSelect = YES;
            _orderModel.payIndexStr = @"兑换积分";
        }
        model.title = titleArr[i];
        
        [dataArray addObject:model];
    }
    view.dataArr = dataArray;
//    _orderModel.allPricesb=
    
    
    view.orderModel = _orderModel;
    self.payOrderView = view;
}

#pragma mark UITableView  delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _leftTableView) {
        return _titleArr.count;
    }
    return self.resorceArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _leftTableView) {
        static NSString *cellID = @"GoodsCategoryCellID";
        GoodsCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCategoryCell" owner:nil options:nil]lastObject];
            cell = [[GoodsCategoryCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        LeftCategory * model = _titleArr[indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
     
        cell.model = model;
        return cell;
    }
    
    static NSString *cellID = @"GoodsCategoryCellID";
    RighMeumtCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RighMeumtCell" owner:nil options:nil]lastObject];
    }
    WEAKSELF;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellAdd = ^(OrderGoodsModel *model){
        model.selectStatue =@"1";
        [weakSelf changeShopCarGoodsCount:model add:YES];
    };
    
    cell.cellReduce = ^(OrderGoodsModel *model){
          model.selectStatue =@"1";
        [weakSelf changeShopCarGoodsCount:model add:NO];

    };
    
    cell.cellInputText = ^(OrderGoodsModel *model){
        
        [weakSelf changeShopCarGoodsCount:model ];
    };

    cell.model =  self.resorceArray[indexPath.section];
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _leftTableView) {
        return 0;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    return view;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
        [KX_UserInfo presentToLoginView:self];
        return;
    }
    if (tableView == _leftTableView) {
        for (LeftCategory * model in _titleArr) {
            model.select = NO;
        }
        LeftCategory * model = _titleArr[indexPath.section];
        model.select = YES;
        _sub_category_id = model.id;
        _oldIndex = indexPath.section;
        [self loadShopCarData];
    }
    
}


///添加 减少一个商品的数目
-(void)changeShopCarGoodsCount:(OrderGoodsModel *)goods add:(BOOL)add{
    
    NSString *count = [NSString stringWithFormat:@"%ld",(goods.itemCount.integerValue + (add?1:-1))];
//    if ([count isEqualToString:@"0"]) {
//        [self.view makeToast:@"数量最少是1"];
//        return;
//    }
    NSDictionary *param = @{@"nums":count,@"goods_id":goods.id,@"uuid":_classModel.UUID,@"sub_category_id":_sub_category_id};
    WEAKSELF;
//    /shop/save_goods_nums
    [_carVM changeOffLineShopCarGoodsCount:count goods:goods Params:param  handleback:^(NSInteger code) {
        if (code == 0) {
            //修改本地
            goods.itemCount = count;
            [weakSelf loadShopCarData];

        }
        
    }];
    
}

//手动修改商品的数目
-(void)changeShopCarGoodsCount:(OrderGoodsModel *)goods {
    
    NSString *count = [NSString stringWithFormat:@"%ld",goods.itemCount.integerValue];
//    if ([count isEqualToString:@"0"]) {
//        [self.view makeToast:@"数量最少是1"];
//        return;
//    }
    WS(b_self)
    ChangeGoodsCountView *changeView = [ChangeGoodsCountView changeCountViewWith:count getChangeValue:^(NSString *changeValue) {
        NSDictionary *param = @{@"cart_id":goods.cid,@"nums":changeValue,@"goods_id":goods.id,@"method":@"edit",@"user_id":[KX_UserInfo sharedKX_UserInfo].user_id};
        [_carVM changeShopCarGoodsCount:changeValue goods:goods  Params:param  handleback:^(NSInteger code) {
            if (code == 0) {
                //修改本地
                goods.itemCount = count;
                //                [ShoppingCar_dataSocure updateGoodsCount:goods];
                
            }
            
        }];
    }];
    [changeView show];
}


- (IBAction)buyAciton:(id)sender {
    [self.view endEditing:YES];
    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
        [KX_UserInfo presentToLoginView:self];
        return;
    }
    
    
    NSMutableArray *cartList = [[NSMutableArray alloc] init];
    NSMutableArray *specs = [[NSMutableArray alloc] init];
    for (NSArray *items in _itemsDic.allValues  ) {
        for (OrderGoodsModel*item in items) {
            if (item.itemCount.intValue >0) {
                [cartList addObject:item];
                [specs addObject:item.spec];
            }
        }
    }
    
    
    if (cartList.count == 0 && _headView.textField.text.intValue <0 ) {
        [self.view makeToast:@"请先添加商品在下单~"];
        return;
    }
    if ([_allPrice isEqualToString:@"0.00"]) {
        _allPrice = _headView.textField.text;
        _orderModel.allPrices = _allPrice.floatValue;
    }
    [self getOrderNoRequrst:_allPrice];
//    GoodsOrderNomalVC *VC = [[GoodsOrderNomalVC alloc] init];
//    VC.cart_ids = [cartList componentsJoinedByString:@","];
//    VC.spec = [specs componentsJoinedByString:@","];
//    VC.orderType  = ShoppinCarType;
//    VC.uuid  = _classModel.UUID?_classModel.UUID:@"";
//
//    [self.navigationController pushViewController:VC animated:YES];
   
}

- (IBAction)goToCartAction:(id)sender {

    self.tabBarController.selectedIndex = 3;

}


- (IBAction)didBottowAction:(UIButton *)sender {
    ///1000 1001  1002
        if (sender.tag == 1000) {
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    if (sender.tag == 1001) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    if (sender.tag == 1002) {
        self.tabBarController.selectedIndex = 3;
        [self.navigationController popToRootViewControllerAnimated:YES];


    }
    
}


- (IBAction)addCartAction:(id)sender {
    
    
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_detailModel.shop_id forKey:@"shop_id"];
    [param setObject:_classModel.UUID?_classModel.UUID:@"" forKey:@"uuid"];
    
    [BaseHttpRequest postWithUrl:@"/ucenter/add_mulit_cart" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            [weakSelf.view makeToast:msg];
            
            
            
        }else{
            [weakSelf.view makeToast:msg];
        }
    }];
    
}



/**
 计算总价
 
 @param goodsModels 商品
 */
- (void)allMoneyAfterSelect{
    CGFloat allPrice = 0;
    CGFloat allPoint  = 0;
    int allCount  = 0;
    
    NSString *allPriceStr = @"";
    NSString *allPointStr = @"";
    NSString *allCountStr = @"";
    for (NSArray *items in _itemsDic.allValues  ) {
        
        for (OrderGoodsModel*item in items) {
            if (item.itemCount.intValue >0) {
                allPrice += item.productPrice.floatValue *item.itemCount.floatValue;
                allPoint += item.point.floatValue *item.itemCount.floatValue;
                allCount += item.itemCount.integerValue;
            }
            
        }
        
    }
    
    _allPrice = [NSString stringWithFormat:@"%.2f",allPrice];
    _orderModel.allPrices = allPrice;
    [_allInfoArr removeAllObjects];
    if (allCount>0) {
        allCountStr = [NSString stringWithFormat:@"已选%d件",allCount];
        [_allInfoArr addObject:allCountStr];
    }
    if (allPrice>0) {
        allPriceStr = [NSString stringWithFormat:@"共%.2f元",allPrice];
        [_allInfoArr addObject:allPriceStr];
    }
    
    if (allPoint>0) {
        allPointStr = [NSString stringWithFormat:@"送%.2f积分",allPoint];
        [_allInfoArr addObject:allPointStr];
    }
    if (_allInfoArr.count>0) {
        _bugInfoLb.text = [_allInfoArr componentsJoinedByString:@","];

    }else{
        _bugInfoLb.text = @"赶紧下单吧~";

    }
}



@end
