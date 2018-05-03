//
//  ShoppingCarVC.m
//  ShiShi
//
//  Created by ac on 16/3/24.
//  Copyright © 2016年 fec. All rights reserved.
//

#import "ShoppingCarVC.h"
#import "ShopCarGoodsCell.h"
#import "ShoppingCarHeaderView.h"
#import "GoodsOrderNomalVC.h"
#import "OrderGoodsModel.h"
#import "SuccessView.h"
#import "shoppingCarVM.h"
#import "GoodsDetailVC.h"
#import "GoodsOrderModel.h"
#import "ChangeGoodsCountView.h"


// jp
#import "shoppingCarVM.h"
@interface ShoppingCarVC ()<UITableViewDataSource,UITableViewDelegate,MGSwipeTableCellDelegate,UITextFieldDelegate>

{
    __weak IBOutlet UILabel *minCountLb;
    __weak IBOutlet UILabel *totalMoneyLable;
    __weak IBOutlet UIButton *toPayBtn;
    __weak IBOutlet UIView *backView;//是否为空，为空就隐藏
    __weak IBOutlet UITableView *shopCarGoodsList;
    
    __weak IBOutlet UICollectionView *limitCollectionView;
    
    NSMutableArray * _dataSocure;//购物车的所有商品
    NSString * chooseGoodsID;
    NSString * chooseShopID;
    int lastCount;
    BOOL isBlackCar;
    
    shoppingCarVM *carVM;
    ShoppingCarHeaderView *limitHeader;
    
    __weak IBOutlet NSLayoutConstraint *bottowHeight;
}

@property (nonatomic, strong)   NSMutableArray * dataSocure;//购物车的所有商品
;
@property (weak, nonatomic) IBOutlet UIButton *allSelectbtn;
@property (weak, nonatomic) IBOutlet UILabel *jifeLB;


@property (nonatomic,strong) UIButton *rightButton;

@end

@implementation ShoppingCarVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    //得到购物车数据 net
    [self loadShopCarData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    [self laodComment];
    
}


-(void)laodComment{
    _dataSocure = [NSMutableArray array];
    carVM = [shoppingCarVM new];
    //删除购物车数据
    
    shopCarGoodsList.delegate = self;
    shopCarGoodsList.dataSource = self;
    shopCarGoodsList.tableFooterView = [UIView new];

    [self setTabHeader];
    
    toPayBtn.backgroundColor = KMAINCOLOR;
    _jifeLB.textColor = TITLETEXTLOWCOLOR;
    
    // 右上角编辑
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(0, 0, 40, 40);
    [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"完成" forState:UIControlStateSelected];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.rightButton setTitle:@"编辑" forState:UIControlStateDisabled];
    [self.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.rightButton addTarget:self action:@selector(clickAllEdit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *batbutton = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = batbutton;
//    [cell showSwipe:MGSwipeDirectionRightToLeft animated:YES];

}


-(void)setTabHeader{
    WS(b_self);
//    ShoppingCarHeaderView *header = [[ShoppingCarHeaderView alloc]initWithHeaderHadGoodsSelect:^{
//        [b_self clickSelectAllGoods];
//    } delectAll:^{
//         [b_self clickDelectAllGoods];
//    }];
//    _allSelectbtn = header._allSelectbtn;
//    shopCarGoodsList.tableHeaderView  = header;
}

///设置推荐相关的信息UI
-(void)setLimitView{
  //请求数据
   [carVM getLimitBuyData];
 
}

#pragma mark - 得到购物车数据
-(void)loadShopCarData{
    WS(b_self)
    [MBProgressHUD showMessag:@"正在加载..." toView:self.view];
    [carVM getShopCarGoodsHandleback:^(NSArray *shopCarGoods, NSInteger code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [_dataSocure removeAllObjects];
            //保存本地数据
            NSMutableArray *goodList = [[NSMutableArray alloc] init];
            for (OrderGoodsModel *model in shopCarGoods ) {
                for (Products *product in  model.products ) {
                [goodList addObject:[shoppingCarVM changeProductsModelInListToOrderGoodsModel:product]];
                }
                model.goodModel = (NSArray*)goodList;
            }
            
            [_dataSocure addObjectsFromArray:shopCarGoods];

            
            [b_self allMoneyAfterSelect];
            [shopCarGoodsList reloadData];
            backView.hidden = NO;
        
        if (shopCarGoods.count > 0) {
            bottowHeight.constant = 49;
            self.view.backgroundColor = [UIColor whiteColor];

            
        }else{
            bottowHeight.constant = 0;
            self.view.backgroundColor = BACKGROUND_COLOR;
            backView.hidden = YES;

        }
        [shopCarGoodsList stopFresh:_dataSocure.count pageIndex:0];

    }];
}

#pragma mark - 点击事件
///绑定VM的点击事件
-(void)handleClick
{
//    WS(b_self)
//    carVM.clickLimitCellBlock = ^(GoodsModelInList *listModel){
//        //跳转详情界面
//        GoodsDetailVC *goodVC = [GoodsDetailVC new];
//        goodVC.productID = listModel.productId;
//        goodVC.hidesBottomBarWhenPushed = YES;
//        [b_self.navigationController pushViewController:goodVC animated:YES];
//    };
    
}



-(void)clickSelectAllGoods:(NSIndexPath *)indexPath{
    //OrderGoodsModel  KVC
    for (OrderGoodsModel *model in _dataSocure) {
        if ([model.selectStatue isEqualToString:@"0"] || KX_NULLString(model.selectStatue )) {
            model.selectStatue = @"1";
        }else{
            model.selectStatue = @"0";
        }

        [self changeLocationShopCarState:model indexPath:indexPath];
    }
    [self allMoneyAfterSelect];
    [shopCarGoodsList reloadData];
}



/// 设置下面红点
- (void)showShoppingCarGoodsNum{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

///清空购物车
-(void)clickDelectAllGoods{
    
   WS(b_self)
    NSArray *arr = [_dataSocure valueForKey:@"selectStatue"];
    NSNumber *sum = [arr valueForKeyPath:@"@sum.floatValue"];
    if (sum.integerValue == 0) {
        [self.view makeToast:@"至少选择一件商品~"];
        return;
    }
    NSString *title = [NSString stringWithFormat:@"确认删除选中的%@个商品吗?",sum];
    SuccessView *successV = [[SuccessView alloc]initWithTrueCancleTitle:title clickDex:^(NSInteger clickDex) {
        if (clickDex == 1) {
            [b_self delectAllGoods];
        }
    }];
    [successV showSuccess];
    
}

///删除选中的产品
-(void)delectAllGoods{
    for (OrderGoodsModel *model in _dataSocure) {
        if (model.selectStatue.integerValue ==1) {
            [self deleteAGoods:model];
        }
    }
}

///删除一个商品
-(void)deleteAGoods:(OrderGoodsModel*)goods
{
    WS(b_self)
    NSDictionary *param = @{@"cart_id":goods.cid,@"goods_id":goods.id,@"method":@"delete",@"user_id":[KX_UserInfo sharedKX_UserInfo].user_id};

    [carVM delectaShopCarGoods:goods Params:param  handleback:^(NSInteger code) {
        if (code == 0) {
        [b_self loadShopCarData];
        }
    }];
}

///计算勾选后的总金额 和iitem的数量
- (void)allMoneyAfterSelect{
  
    totalMoneyLable.textColor = KMAINCOLOR;
    _jifeLB.textColor = KMAINCOLOR;
    NSMutableArray *allPriceArr = [[NSMutableArray alloc] init];
    
    NSString *allPrice =  [carVM calculationCarAllPrice:_dataSocure];
    if ([allPrice floatValue] > 0) {
        [allPriceArr addObject:[NSString stringWithFormat:@"¥%@",allPrice]];
    }
    
    NSString *allPoint = [carVM calculationCarAllPoint:_dataSocure];

    if ([allPoint floatValue] > 0) {
        [allPriceArr addObject:[NSString stringWithFormat:@"%@积分",allPoint]];
    }
    
    totalMoneyLable.text = [allPriceArr componentsJoinedByString:@"+"];
    
//    if ([allPoint floatValue] > 0) {
//        NSString *str1 = [NSString stringWithFormat:@"%@",allPoint];
//        NSString *str =[NSString stringWithFormat:@"+%@积分",str1];
//        NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(1, str1.length) withColor:BACKGROUND_COLORHL withFont:Font15];
//        _jifeLB.attributedText = attributedStr;
//    }else{
//        _jifeLB.text = @"";
//    }

    
    NSString *allCount =  [carVM calcilationShopCarAllNomalCount:_dataSocure];
    if (allCount.integerValue >0) {
        [self.navigationController.tabBarController.viewControllers[3].tabBarItem setBadgeValue:allCount];
    }
    
    NSString *count = [carVM calcilationShopCarAllCount:_dataSocure];
  
//    minCountLb.text = [NSString stringWithFormat:@"%@件商品",count];
    [toPayBtn setTitle:[NSString stringWithFormat:@"结算(%@)",count] forState:UIControlStateNormal];

}


///选中／取消选中 某一个产品
-(void)selectAGoods:(OrderGoodsModel *)goods select:(BOOL)select{
    goods.selectStatue = select?@"1":@"0";
    [self allMoneyAfterSelect];
    [shopCarGoodsList reloadData];
}

///添加 减少一个商品的数目
-(void)changeShopCarGoodsCount:(OrderGoodsModel *)goods add:(BOOL)add{
  
    NSString *count = [NSString stringWithFormat:@"%ld",(goods.itemCount.integerValue + (add?1:-1))];
    if ([count isEqualToString:@"0"]) {
        [self.view makeToast:@"数量最少是1"];
        return;
    }
    NSDictionary *param = @{@"cart_id":goods.cid,@"nums":count,@"goods_id":goods.id,@"method":@"edit",@"user_id":[KX_UserInfo sharedKX_UserInfo].user_id};

    [carVM changeShopCarGoodsCount:count goods:goods Params:param  handleback:^(NSInteger code) {
        if (code == 0) {
            //修改本地
            goods.itemCount = count;
            [self loadShopCarData];
        }
     
    }];
}

//手动修改商品的数目
-(void)changeShopCarGoodsCount:(OrderGoodsModel *)goods {
    
    NSString *count = [NSString stringWithFormat:@"%ld",goods.itemCount.integerValue];
    if ([count isEqualToString:@"0"]) {
        [self.view makeToast:@"数量最少是1"];
        return;
    }
    WS(b_self)
   ChangeGoodsCountView *changeView = [ChangeGoodsCountView changeCountViewWith:count getChangeValue:^(NSString *changeValue) {
       NSDictionary *param = @{@"cart_id":goods.cid,@"nums":changeValue,@"goods_id":goods.id,@"method":@"edit",@"user_id":[KX_UserInfo sharedKX_UserInfo].user_id};
        [carVM changeShopCarGoodsCount:changeValue goods:goods  Params:param  handleback:^(NSInteger code) {
            if (code == 0) {
                //修改本地
                goods.itemCount = count;
//                [ShoppingCar_dataSocure updateGoodsCount:goods];
                [b_self loadShopCarData];
            }

        }];
    }];
    [changeView show];
}

-(NSArray *) createRightButtons:(OrderGoodsModel *)goods
{
    NSMutableArray * result = [NSMutableArray array];
    WS(b_self);
    //删除
    MGSwipeButton * deleteBtn = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor]callback:^BOOL(MGSwipeTableCell *sender) {
      
        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"确认删除该商品吗?" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
              [b_self deleteAGoods:goods];
            }
        }];
        [successV showSuccess]; return  NO;
    }];
    
    //添加到收藏
    MGSwipeButton * storeBtn = [MGSwipeButton buttonWithTitle:@"移入收藏" backgroundColor:[UIColor lightGrayColor]callback:^BOOL(MGSwipeTableCell *sender) {
        [carVM collectShopCarGoods:goods state:@"1" handleback:^(NSInteger code) {
            if (code == 0) {
                [b_self.view makeToast:@"收藏成功!"];
            }
            [shopCarGoodsList reloadData];
        }]; return  NO;
    }];
    [result addObject:deleteBtn];
    [result addObject:storeBtn];
    return result;
}

///全选
- (IBAction)didClickAllBtnAction:(UIButton *)sender {
    sender.selected =! sender.selected;
//    if (sender.selected) {
        for (OrderGoodsModel * model in _dataSocure) {
            for (OrderGoodsModel *goodsModel in model.goodModel) {
                if ([goodsModel.selectStatue isEqualToString:@"0"] || KX_NULLString(goodsModel.selectStatue )) {
                    goodsModel.selectStatue = @"1";
                }else{
                    goodsModel.selectStatue = @"0";
                }
                model.selectStatue = goodsModel.selectStatue ;
            }

        }
//    }
    [self refreshData];
}



///结算
- (IBAction)toMakeOrder:(UIButton *)sender {
    
    NSMutableArray *cart_ids = [[NSMutableArray alloc] init];
    NSMutableArray *specs = [[NSMutableArray alloc] init];
    GoodsOrderNomalVC * makeSure = [GoodsOrderNomalVC new];
    makeSure.orderType =  ShoppinCarType;
    makeSure.goodsListArray  = [NSMutableArray array];
    for (OrderGoodsModel*model in _dataSocure) {
      
        for (OrderGoodsModel*item in model.goodModel) {
            if (item.selectStatue.integerValue ==1) {
                [cart_ids addObject:item.cid];
                [specs addObject:item.spec];
                [makeSure.goodsListArray addObject:model];
            }
        }
    }
    if (makeSure.goodsListArray.count==0) {
        [self.view makeToast:@"至少选择一件商品~"];
        return;
    }
    makeSure.cart_ids = [cart_ids componentsJoinedByString:@","];
    makeSure.spec = [specs componentsJoinedByString:@","];
    [makeSure setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:makeSure animated:YES];
}



#pragma mark - UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSocure.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    OrderGoodsModel * model  = _dataSocure[section];

    return  model.goodModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    OrderGoodsModel * model  = _dataSocure[indexPath.section];
 
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(b_self)
    ShopCarGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"goodsCellID"];
    if (cell == nil) {
        cell = [[ShopCarGoodsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"goodsCellID"];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderGoodsModel * cellModel  = _dataSocure[indexPath.section];
   OrderGoodsModel * goodsModel = cellModel.goodModel[indexPath.row];
    cell.rightButtons = [self createRightButtons:goodsModel];
    
    if (goodsModel.isEdit) {
        [cell showSwipe:MGSwipeDirectionRightToLeft animated:YES];
    }else{
        [cell hideSwipeAnimated:YES];
    }

    cell.goodsModel = goodsModel;
//

    //单个购物车商品加
    cell.addBlock = ^(OrderGoodsModel * goodsModel){
        [b_self changeShopCarGoodsCount:goodsModel add:YES];
    };

    //单个购物车商品减
    cell.reduceBlock = ^(OrderGoodsModel * goodsModel){
       [b_self changeShopCarGoodsCount:goodsModel add:NO];
    };
    
    ///勾选
    cell.selectBlock = ^(OrderGoodsModel * goodsModel){
        [b_self changeLocationShopCarState:goodsModel indexPath:indexPath];
        [b_self refreshData];
    };
    
    cell.changeNumberBlock = ^(OrderGoodsModel *goodsModel){
  
      [b_self changeShopCarGoodsCount:goodsModel];
    };
    
   return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([_dataSocure count] <= 0) {
        return CGFLOAT_MIN;
    }else{
        return 45;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WS(b_self)
    OrderGoodsModel * cellModel  = _dataSocure[section];
//    Products *product = cellModel.products[indexPath.row];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    ShoppingCarHeaderView *header = [[ShoppingCarHeaderView alloc]initWithHeaderHadGoodsSelect:^{
        [b_self clickSelectAllGoods:indexPath];
    } delectAll:^{
        [b_self clickDelectAllGoods];
    }];
//    header.backgroundColor = BACKGROUND_COLOR;
    header.model = cellModel;
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //跳转详情界面
    OrderGoodsModel * cellModel  = _dataSocure[indexPath.section];
    OrderGoodsModel * goodsModel = cellModel.goodModel[indexPath.row];

    GoodsDetailVC *goodVC = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                 navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    goodVC.productID = goodsModel.productId?goodsModel.productId:goodsModel.seller_id ;
    goodVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goodVC animated:YES];
}

#pragma mark - pravate
///刷新缓存数据
-(void)refreshData{
    [self allMoneyAfterSelect];
    [shopCarGoodsList reloadData];
    
}


//更新本地的购物车数据
-(void)changeLocationShopCarState:(OrderGoodsModel *)goodsModels indexPath:(NSIndexPath *)indexPath
{
    //本地处理
    OrderGoodsModel * model  = _dataSocure[indexPath.section];
    OrderGoodsModel * chaildModel = model.goodModel[indexPath.row];
    if (goodsModels.products.count >0) {
        for (  OrderGoodsModel *goodsModel in goodsModels.goodModel) {
            goodsModel.selectStatue =  model.selectStatue;
            chaildModel = goodsModel;
        }
    }else{
        if ([goodsModels.selectStatue isEqualToString:@"0"] || KX_NULLString(goodsModels.selectStatue )) {
            goodsModels.selectStatue = @"1";
        }else{
            goodsModels.selectStatue = @"0";
        }
        chaildModel = goodsModels;

    }

}

/// 编辑所有购物车
- (void)clickAllEdit:(UIButton *)button
{
    button.selected =! button.selected;
    for (OrderGoodsModel*model in _dataSocure) {
        for (OrderGoodsModel*item in model.goodModel) {
            item.isEdit = button.selected;
        }
        
    }
    
    [shopCarGoodsList reloadData];

}

@end
