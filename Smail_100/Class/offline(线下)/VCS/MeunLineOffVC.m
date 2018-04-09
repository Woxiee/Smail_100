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


@property (nonatomic,copy)  NSMutableDictionary *itemsDic;


@end




@implementation MeunLineOffVC
{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self loadShopCarData];
    [self allMoneyAfterSelect];

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
            [weakSelf.view toastShow:msg];
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
    self.view.backgroundColor = BACKGROUND_COLOR;
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _leftTableView.backgroundColor = RGB(246, 247, 248);
    
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
    
    if (tableView == _leftTableView) {
        return 60;
    }
    return 100;
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

    NSMutableArray *cart_ids = [[NSMutableArray alloc] init];
    NSMutableArray *specs = [[NSMutableArray alloc] init];
    for (NSArray *items in _itemsDic.allValues  ) {
        for (OrderGoodsModel*item in items) {
            if (item.itemCount.intValue >0) {
                [cart_ids addObject:item.cid];
                [specs addObject:item.spec];
            }
        }
    }
    
    GoodsOrderNomalVC *VC = [[GoodsOrderNomalVC alloc] init];
    VC.cart_ids = [cart_ids componentsJoinedByString:@","];
    VC.spec = [specs componentsJoinedByString:@","];
    VC.orderType  = ShoppinCarType;
    VC.uuid  = _classModel.UUID?_classModel.UUID:@"";
    [self.navigationController pushViewController:VC animated:YES];
   
}

- (IBAction)goToCartAction:(id)sender {

    self.tabBarController.selectedIndex = 3;

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
            [weakSelf.view toastShow:msg];
            
            
            
        }else{
            [weakSelf.view toastShow:msg];
        }
    }];
    
}



/**
 计算总价
 
 @param goodsModels 商品
 */
- (void)allMoneyAfterSelect{
    CGFloat allPrice = 0;
    int allPoint  = 0;
    int allCount  = 0;
    
    NSString *allPriceStr = @"";
    NSString *allPointStr = @"";
    NSString *allCountStr = @"";
    for (NSArray *items in _itemsDic.allValues  ) {
        
        for (OrderGoodsModel*item in items) {
            if (item.itemCount.intValue >0) {
                allPrice += item.productPrice.intValue *item.itemCount.intValue;
                allPoint += item.point.integerValue *item.itemCount.intValue;
                allCount += item.itemCount.integerValue;
            }
            
        }
        
    }
    
    
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
        allPointStr = [NSString stringWithFormat:@"送%d积分",allPoint];
        [_allInfoArr addObject:allPointStr];
    }
    if (KX_NULLString(_bugInfoLb.text )) {
        _bugInfoLb.text = @"赶紧下单吧~";
    }else{
        _bugInfoLb.text = [_allInfoArr componentsJoinedByString:@","];
    }
}



@end
