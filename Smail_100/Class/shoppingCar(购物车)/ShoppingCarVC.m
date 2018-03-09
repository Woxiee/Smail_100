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
    
    NSMutableArray * dataSocure;//购物车的所有商品
    NSString * chooseGoodsID;
    NSString * chooseShopID;
    int lastCount;
    BOOL isBlackCar;
    
    shoppingCarVM *carVM;
    UIButton *allSelectbtn;
    ShoppingCarHeaderView *limitHeader;
    
}



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
    dataSocure = [NSMutableArray array];
    carVM = [shoppingCarVM new];
    //删除购物车数据
    
    shopCarGoodsList.delegate = self;
    shopCarGoodsList.dataSource = self;
//    [self viewDidLayoutSubviews:shopCarGoodsList];
//    [self setExtraCellLineHidden:shopCarGoodsList];
    [self setTabHeader];

}


-(void)setTabHeader{
    WS(b_self);
    ShoppingCarHeaderView *header = [[ShoppingCarHeaderView alloc]initWithHeaderHadGoodsSelect:^{
        [b_self clickSelectAllGoods];
    } delectAll:^{
         [b_self clickDelectAllGoods];
    }];
    allSelectbtn = header.allSelectbtn;
    shopCarGoodsList.tableHeaderView  = header;
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
        if (shopCarGoods.count>0) {
            [dataSocure removeAllObjects];
            //保存本地数据
            [b_self allMoneyAfterSelect];
            [shopCarGoodsList reloadData];
            backView.hidden = NO;
            
            //清空backView 的数据
            [carVM.limitDatasArr removeAllObjects];
            [limitCollectionView reloadData];
            return ;
        }
            backView.hidden = YES;
            [b_self setLimitView];
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

-(void)clickSelectAllGoods{
   
    //OrderGoodsModel  KVC
    allSelectbtn.selected = !allSelectbtn.selected;
    [dataSocure setValue:allSelectbtn.selected?@"1":@"0" forKey:@"selectStatue"];
    for (OrderGoodsModel *model in dataSocure) {
        [self changeLocationShopCarState:model];
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
    NSArray *arr = [dataSocure valueForKey:@"selectStatue"];
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
    
    for (OrderGoodsModel *model in dataSocure) {
        if (model.selectStatue.integerValue ==1) {
            [self deleteAGoods:model];
        }
    }
}

///删除一个商品
-(void)deleteAGoods:(OrderGoodsModel*)goods
{
    WS(b_self)
    [carVM delectaShopCarGoods:goods handleback:^(NSInteger code) {
        if (code == 0) {
        [b_self loadShopCarData];
        }
    }];
}

///计算勾选后的总金额 和iitem的数量
- (void)allMoneyAfterSelect{
    totalMoneyLable.text = [carVM calculationCarAllPrice:dataSocure];
    NSString *count = [carVM calcilationShopCarAllCount:dataSocure];
    minCountLb.text = [NSString stringWithFormat:@"%@件商品",count];
    [toPayBtn setTitle:[NSString stringWithFormat:@"去结算(%@)",count] forState:UIControlStateNormal];
    allSelectbtn.selected = YES;
    //全选状态的处理
    if ([[dataSocure valueForKey:@"selectStatue"] containsObject:@"0"]) {
        allSelectbtn.selected = NO;
    }
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
    [carVM changeShopCarGoodsCount:count goods:goods handleback:^(NSInteger code) {
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
//   ChangeGoodsCountView *changeView = [ChangeGoodsCountView changeCountViewWith:count getChangeValue:^(NSString *changeValue) {
//        [carVM changeShopCarGoodsCount:changeValue goods:goods handleback:^(NSInteger code) {
//            if (code == 0) {
//                //修改本地
//                goods.itemCount = count;
//                [ShoppingCarDataSocure updateGoodsCount:goods];
//                [b_self loadShopCarData];
//            }
//
//        }];
//    }];
//    [changeView show];
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


///结算
- (IBAction)toMakeOrder:(UIButton *)sender {
    
    GoodsOrderNomalVC * makeSure = [GoodsOrderNomalVC new];
    NSString *ruleStr = @"";

 
    [makeSure setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:makeSure animated:YES];
}



#pragma mark - UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSocure.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  dataSocure.count==0?0:1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderGoodsModel * model  = dataSocure[indexPath.section];
 
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
    OrderGoodsModel * cellModel  = dataSocure[indexPath.section];
   // chooseShopID = cellModel.shopID;
    cell.rightButtons = [self createRightButtons:cellModel];
    cell.goodsModel = cellModel;

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
        [b_self changeLocationShopCarState:goodsModel];
        [b_self refreshData];
    };
    
    cell.changeNumberBlock = ^(OrderGoodsModel *goodsModel){
  
      [b_self changeShopCarGoodsCount:goodsModel];
    };
    
   return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([dataSocure count] <= 0) {
        return CGFLOAT_MIN;
    }else{
        return 10;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //跳转详情界面
    OrderGoodsModel * cellModel  = dataSocure[indexPath.section];

    GoodsDetailVC *goodVC = [GoodsDetailVC new];
    goodVC.productID = cellModel.productId;
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
-(void)changeLocationShopCarState:(OrderGoodsModel *)goodsModel
{
    //本地处理
}

@end
