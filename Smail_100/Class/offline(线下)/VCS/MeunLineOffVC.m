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

@interface MeunLineOffVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (nonatomic, strong) NSMutableArray *titleArr;

@property (weak, nonatomic) IBOutlet UITableView *rightTableview;

@property (nonatomic, strong) NSString *sub_category_id;

@property (nonatomic, strong)  GoodsClassModel *classModel;


@property (nonatomic, strong) shoppingCarVM *carVM;

@property (nonatomic, assign) NSInteger  oldIndex;

@property (weak, nonatomic) IBOutlet UILabel *bugInfoLb;



@end




@implementation MeunLineOffVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self loadShopCarData];
    
}


- (void)loadShopCarData
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_sub_category_id?_sub_category_id:@"" forKey:@"sub_category_id"];
    [param setObject:_detailModel.shop_id forKey:@"shop_id"];
    [param setObject:_classModel.UUID?_classModel.UUID:@"" forKey:@"uuid"];

    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
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
                    //                        break;
                }
                [weakSelf.titleArr addObject:category];
                
            }
            
            model.rightGoods = [NSArray yy_modelArrayWithClass:[RightGoods class] json:model.rightGoods];

            for (RightGoods *item in model.rightGoods) {
               OrderGoodsModel *model = [shoppingCarVM changeRightGoodsModelInListToOrderGoodsModel:item];
                [weakSelf.resorceArray addObject:model];
            }
          
            weakSelf.classModel = model;
            
            
            [weakSelf.leftTableView reloadData];
            
            [weakSelf.rightTableview reloadData];
            
        }
        else{
            [weakSelf.view toastShow:msg];
        }
    }];
}




- (void)setUI
{
    self.title = @"查看商家产品";
    _carVM = [shoppingCarVM new];
    _titleArr = [[NSMutableArray alloc] init];
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

    [self.rightNaviBtn showBadgeWithStyle:WBadgeStyleNumber value:3 animationType:WBadgeAnimTypeNone];

    _bugInfoLb.text = @"￥138.00";
    
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
        [weakSelf changeShopCarGoodsCount:model add:YES];
    };
    
    cell.cellReduce = ^(OrderGoodsModel *model){
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
//        [tableView reloadData];
//
    }
    
}


///添加 减少一个商品的数目
-(void)changeShopCarGoodsCount:(OrderGoodsModel *)goods add:(BOOL)add{
    
    NSString *count = [NSString stringWithFormat:@"%ld",(goods.itemCount.integerValue + (add?1:-1))];
    if ([count isEqualToString:@"0"]) {
        [self.view makeToast:@"数量最少是1"];
        return;
    }
    NSDictionary *param = @{@"nums":count,@"goods_id":goods.id,@"uuid":_classModel.UUID,@"sub_category_id":_sub_category_id};

//    /shop/save_goods_nums
    [_carVM changeOffLineShopCarGoodsCount:count goods:goods Params:param  handleback:^(NSInteger code) {
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
        [_carVM changeShopCarGoodsCount:changeValue goods:goods  Params:param  handleback:^(NSInteger code) {
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


- (IBAction)buyAciton:(id)sender {
    
}

- (IBAction)goToCartAction:(id)sender {
}


- (IBAction)addCartAction:(id)sender {
    
}



@end
