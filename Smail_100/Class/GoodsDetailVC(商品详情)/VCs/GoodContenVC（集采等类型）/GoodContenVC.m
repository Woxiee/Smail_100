//
//  GoodContenVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/9.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodContenVC.h"
#import "SDCycleScrollView.h"
#import "SDPhotoBrowser.h"
#import "GoodsDetailInfoCell.h"
#import "StoreBottomView.h"
#import "GoodsVModel.h"
#import "GoodsDetailInfoCell.h"
#import "GoodsCommonCell.h"
#import "GoodSDetailModel.h"
#import "GoodGuigeView.h"
#import "AttributeListView.h"
#import "GoodsSameDetailCollectionView.h"
#import "GoodsSameWebCell.h"
#import "GoodsListModel.h"
#import "HomeHeaderView.h"
#import "GoodsSameCell.h"
#import "GoodsSameFootView.h"
#import "LoadingTableFootView.h"
#import "GoodsClassVC.h"
#import "GoodsOrderNomalVC.h"
#import "MemberInforVC.h"
#import "MemberBaseInfoVC.h"
#import "ItemContentList.h"

#import "shoppingCarVM.h"
#import "HomeVModel.h"
#import "NewProductCell.h"
#import "DWQSelectAttributes.h"
#import "DWQSelectView.h"
#import "GoodWebInfoCell.h"

#define NAVBAR_COLORCHANGE_POINT 0
#define NAV_HEIGHT 64
#define IMAGE_HEIGHT 400
#define SCROLL_DOWN_LIMIT 0
#define LIMIT_OFFSET_Y -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)


@interface GoodContenVC ()<UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate,SDPhotoBrowserDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIWebViewDelegate,SelectAttributesDelegate>
@property (nonatomic, copy) NSMutableArray  *resorceArray;

@property (nonatomic, strong) UIView        *contentView;
@property (nonatomic, strong) UILabel       *headLab;
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) UIWebView     *webView;
@property (nonatomic, strong) SDCycleScrollView *headView;
@property (nonatomic, strong) NSString  *isCollectionID;   /// 收藏或者取消收藏 商品ID
@property (nonatomic, strong) StoreBottomView *bottomView;
@property (nonatomic, assign) NSInteger goodSCount; ///  产品数量   如果没选的话  是不能进行购买 或者加入购物车操作
@property (nonatomic, strong) NSString *guiGeVlue; ///  保存规格属性字段
@property (nonatomic, strong)  NSMutableArray *titleArray;   ///产品参数 扩展参数 规格参数
@property (nonatomic, strong) NSMutableArray *commentsArray; /// 商品评价
@property (nonatomic, assign)   NSInteger sectionCount;           /// 返回section数目
@property (nonatomic, weak)   GoodGuigeView *goodGuigeView; /// 规格View

@property (nonatomic, strong) UICollectionView *sameGoodsCollectView;

@property (nonatomic, strong) NSMutableArray *sameArray;
@property (nonatomic, strong) LoadingTableFootView *footView;
@property (nonatomic, strong) NSMutableArray *sameTitleArr;
@property (nonatomic, strong) ItemInfoList *itemIfoModel;

@property (nonatomic, strong) NSMutableArray *allItems; /// 规格属性所有字段

@property(nonatomic,strong)NSArray *standardList;
@property(nonatomic,strong)NSArray *standardValueList;
@property (nonatomic, strong) NSMutableArray *dataArray;  /// 选择数据源
@property (nonatomic, strong) NSArray *selectItems;  /// 选择规格属性

@property(nonatomic,strong)DWQSelectView *selectView;
@property(nonatomic,strong)DWQSelectAttributes *selectAttributes;
@property(nonatomic,strong)NSMutableArray *attributesArray;


@property (nonatomic, assign) BOOL isLoading;
@end

@implementation GoodContenVC
{
    CGFloat _maxContentOffSet_Y;      /// 最大偏移值
    NSMutableArray *_productList;     /// 产品参数
    CGFloat _maxWebHight;      /// webview的高度
    CGFloat _maxWebWidth;      /// webview的宽度

    
}

static NSString *const goodsDetailInfoCellID = @"GoodsDetailInfoCellID";
static NSString *const goodsDetailCommonCellID = @"goodsDetailCommonCellID";
static NSString *const goodsCommonCellID = @"GoodsCommonCellID";
static NSString * const goodsSameWebCellID = @"goodsSameWebCellID";
static NSString *homeStoreHeaderViewIdentifier = @"HomeStoreHeaderView";
static NSString *newProductCell = @"newProductID";
static NSString *goodsSameFootViewID = @"goodsSameFootViewID";



- (void)viewDidLoad {
    [super viewDidLoad];
    
    WEAKSELF;
    /// 判断productID非空
    if (KX_NULLString(_productID)) {
        _productID = @"";
    }
    [self setup];
    [self setConfiguration];
    [self setLeftItems];
    [self initBottomView];

//    [self.tableView headerWithRefreshingBlock:^{
//        [weakSelf getGoodsDetailInfoRequest];
//    }];
    [self getGoodsDetailInfoRequest];

    [self getRecommendedRequest];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    _guiGeVlue = @"";
    _goodSCount = 1;
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.selectView removeFromSuperview];
    self.selectView = nil;
}

/// 配置基础设置
- (void)setConfiguration
{
    _sameArray = [[NSMutableArray alloc] init];
    _titleArray = [[NSMutableArray alloc] init];
    _sameTitleArr = [[NSMutableArray alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    
    _allItems = [[NSMutableArray alloc] init];
    _goodSCount = 1;
    _maxContentOffSet_Y = 80;
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsDetailInfoCell" bundle:nil] forCellReuseIdentifier:goodsDetailInfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsCommonCell" bundle:nil] forCellReuseIdentifier:goodsCommonCellID];
    [self.tableView  registerNib:[UINib nibWithNibName:@"GoodWebInfoCell" bundle:nil] forCellReuseIdentifier:goodsSameWebCellID];

    
//    [_sameGoodsCollectView registerNib:[UINib nibWithNibName:@"GoodsSameWebCell" bundle:nil] forCellWithReuseIdentifier:goodsSameWebCellID];
//
//    [_sameGoodsCollectView registerNib:[UINib nibWithNibName:@"NewProductCell" bundle:nil] forCellWithReuseIdentifier:newProductCell];
//
//    //SectionheaderView
//    [_sameGoodsCollectView registerNib:[UINib nibWithNibName:@"HomeHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:homeStoreHeaderViewIdentifier];
//
//    //SectionfooterView
//    [_sameGoodsCollectView registerNib:[UINib nibWithNibName:@"GoodsSameFootView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:goodsSameFootViewID];
    
    _productList = [[NSMutableArray alloc] init];
}

/// 初始化视图
- (void)setup
{
    _isLoading = NO;
//    self.contentView = [UIView new];
//    self.contentView.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 45);
//    [self.view addSubview:self.contentView];
    [self.view addSubview:self.tableView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);

    self.tableView.tableHeaderView = self.headView;
    
    [self.superVC wr_setNavBarBackgroundAlpha:0];
    self.navigationTabBar.alpha = 0;
    self.superVC.navigationItem.titleView.hidden = YES;
    [self.superVC wr_setNavBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarShadowImageHidden:NO];
    
    
//    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.minimumLineSpacing = 0.0;
//    layout.minimumInteritemSpacing = 0.0;
//    layout.sectionInset = UIEdgeInsetsZero;
//    _sameGoodsCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, SCREEN_HEIGHT- 45) collectionViewLayout:layout];
//    _sameGoodsCollectView.delegate = self;
//    _sameGoodsCollectView.dataSource = self;
//    _sameGoodsCollectView.backgroundColor = BACKGROUND_COLOR;
//    [self.contentView addSubview:_sameGoodsCollectView];
//    // 开始监听_sameGoodsCollectView的偏移量
//    [_sameGoodsCollectView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

}

-(void)setLeftItems
{
    UIButton *leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"18@3x.png"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"18@3x.png"] forState:UIControlStateHighlighted];
    leftBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    [leftBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    leftBtn.backgroundColor=[UIColor clearColor];
    [leftBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    [leftBtn sizeToFit];
}


- (void)initBottomView
{
    if (_bottomView == nil ) {
        WEAKSELF
        _bottomView = [[StoreBottomView alloc] init];
        _bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, 50);
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.selectBlock = ^(NSInteger index){
            ItemInfoList *model = nil;
            if (weakSelf.resorceArray.count >0) {
                model = weakSelf.resorceArray[1];
            }
            if (index == 0) {
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//    weakSelf.superVC.tabBarController.selectedIndex = 0;
            }
            else if (index == 1){
                [weakSelf getCollectionRequestWithISCollect];
            }
            else if (index == 2){
//                [weakSelf.superVC.navigationController popToRootViewControllerAnimated:YES];
                weakSelf.superVC.tabBarController.selectedIndex = 3;
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }
            else if (index == 3){
                if (weakSelf.selectView == nil) {
                    [weakSelf initSelectView];
                }
                [weakSelf.selectView show];
                
//                [weakSelf addGoodsInCar:model.itemContent];
            }
            else if (index == 4){
//                if (weakSelf.itemIfoModel.spec.count >0) {
//                    if (KX_NULLString(weakSelf.itemIfoModel.itemContent.spec)) {
                        if (weakSelf.selectView == nil) {
                            [weakSelf initSelectView];
                        }
                        [weakSelf.selectView show];
//                        return;
//                    }
//                }
               
//                GoodsOrderNomalVC *VC = [[GoodsOrderNomalVC alloc] init];
//                model.itemContent.goods_id = weakSelf.productID;
//                VC.itemsModel = model.itemContent;
//                [weakSelf.superVC.navigationController pushViewController:VC animated:YES];
            }

        };

        [self.superVC.view addSubview:_bottomView];
    }


}
#pragma mark --弹出规格属性
-(void)initSelectView{

    WEAKSELF;
    if (self.standardList.count == 0) {
        NSMutableArray *titles = [NSMutableArray new];
        NSMutableArray *itemList = [NSMutableArray new];
        NSArray *contenArray = [[NSArray alloc] init];
        for (SKU *property in _itemIfoModel.spec) {
            NSMutableArray *items = [NSMutableArray new];
            
            LOG(@"%@", property.name);
            [titles addObject:property.name];
            contenArray = property.value;
            for (Value *value in contenArray) {
                [items addObject:value.spec_name];
                
                [_allItems addObject:value];
            }
            [itemList addObject:items];
            [self.dataArray addObject:contenArray];
        }
        
        self.standardList = titles;
        self.standardValueList = itemList;
    }
    
    _itemIfoModel.titleArr = self.standardList;
    self.selectView = [[DWQSelectView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.selectView.headImage  sd_setImageWithURL:[NSURL URLWithString:_itemIfoModel.itemContent.imageUrl] placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW]];
    
    self.selectView.nameLB.text = _itemIfoModel.itemContent.name;
    NSMutableArray *priceArr = [[NSMutableArray alloc] init];
    
    if (_itemIfoModel.itemContent.price.floatValue >0) {
        [priceArr addObject:[NSString stringWithFormat:@"¥%@",_itemIfoModel.itemContent.price]];
    }
    if (_itemIfoModel.itemContent.point.floatValue >0) {
        [priceArr addObject:[NSString stringWithFormat:@"%@ 积分",_itemIfoModel.itemContent.point]];
    }
//    if ([_itemIfoModel.itemContent.freight floatValue] >0) {
//        [priceArr addObject:[NSString stringWithFormat:@"快递费:%@",_itemIfoModel.itemContent.freight]];
//    }
    NSString *allPrice = [priceArr componentsJoinedByString:@"+"];
    NSString *moneyStr = [NSString stringWithFormat:@"%@",allPrice];
    NSAttributedString *attributedStr =  [self attributeStringWithContent:moneyStr keyWords:@[@"+",@"快递费:",@" 积分"]];
    self.selectView.LB_price.attributedText  = attributedStr;
    
    self.selectView.LB_stock.text =[NSString stringWithFormat:@"库存:%@件",_itemIfoModel.itemContent.volume] ; 
    self.selectView.LB_showSales.text = [NSString stringWithFormat:@"销量%@件",_itemIfoModel.itemContent.sale_num] ;
    if (weakSelf.itemIfoModel.spec.count >0) {
        self.selectView.LB_detail.text = @"请选择规格属性";
    }
    self.selectView.itemIfoModel = _itemIfoModel;
    self.selectView.didClickComTFpltBlock = ^(NSInteger index, NSInteger goodCout) {
        weakSelf.goodSCount = goodCout;
        NSString *sper_vlue = [weakSelf.selectItems componentsJoinedByString:@","];
        weakSelf.itemIfoModel.itemContent.spec = sper_vlue;
            LOG(@"购物车");
        if (index ==0) {
            [weakSelf addGoodsInCar:weakSelf.itemIfoModel.itemContent];
        }else{
            LOG(@"购买");
            weakSelf.itemIfoModel.itemContent.cartNum = [NSString stringWithFormat:@"%ld",goodCout];

            GoodsOrderNomalVC *VC = [[GoodsOrderNomalVC alloc] init];
            weakSelf.itemIfoModel.itemContent.goods_id = weakSelf.productID;
            VC.itemsModel = weakSelf.itemIfoModel.itemContent;
            VC.spec = weakSelf.itemIfoModel.itemContent.spec;
            [weakSelf.superVC.navigationController pushViewController:VC animated:YES];
            
        }
    };
    
    CGFloat maxY = 0;
    CGFloat height = 0;
    for (int i = 0; i < self.standardList.count; i ++)
    {
        self.selectAttributes = [[DWQSelectAttributes alloc] initWithTitle:self.standardList[i] titleArr:self.standardValueList[i] andFrame:CGRectMake(0, maxY, SCREEN_WIDTH, 60)];
        maxY = CGRectGetMaxY(self.selectAttributes.frame);
        height += self.selectAttributes.dwq_height;
        self.selectAttributes.tag = 8000+i;
        self.selectAttributes.delegate = self;
        
        [self.selectView.mainscrollview addSubview:self.selectAttributes];
    }
    self.selectView.mainscrollview.contentSize = CGSizeMake(0, height);
    
    
    
  
}


-(NSMutableArray *)attributesArray{
    
    if (_attributesArray == nil) {
        
        _attributesArray = [[NSMutableArray alloc] init];
    }
    return _attributesArray;
}



-(void)selectBtnTitle:(NSString *)title andBtn:(UIButton *)btn{
    
    [self.attributesArray removeAllObjects];
    
    for (int i=0; i < _standardList.count; i++)
    {
        DWQSelectAttributes *view = [self.selectView.mainscrollview  viewWithTag:8000+i];
        
        for (UIButton *obj in  view.btnView.subviews)
        {
            if(obj.selected){
                for (NSArray *arr in self.standardValueList)
                {
                    for (NSString *details in arr) {
                        if ([view.selectBtn.titleLabel.text isEqualToString:details]) {
                            [_attributesArray addObject:[NSString stringWithFormat:@"%@",details]];
                        }
                    }
                }
            }
        }
    }
    
    NSLog(@"%@",_attributesArray);
    NSMutableArray *selectItems = [NSMutableArray new];

    for (NSString *str in _attributesArray) {
        for (Value *value in _allItems) {
            if ([str isEqualToString:value.spec_name]) {
                [selectItems addObject:value.spec_value];
            }
        }
    }
    
    _selectItems =  [selectItems mutableCopy];
    
    NSString *comm = [_attributesArray componentsJoinedByString:@","];
    self.selectView.LB_detail.text = [NSString stringWithFormat:@"选择了 %@",comm];
    _itemIfoModel.itemContent.spec =  [_selectItems componentsJoinedByString:@","];
    _selectView.itemIfoModel = _itemIfoModel;
    [self getGoodsDetailPriceRequest];
}


#pragma mark - request
/// 商品详情
- (void) getGoodsDetailInfoRequest
{
    WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_productID forKey:@"goods_id"];
    [GoodsVModel getGoodsDetailParam:param successBlock:^(NSArray<ItemInfoList *> *dataArray, BOOL isSuccess) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        [weakSelf.tableView endRefreshTableView];
        if (isSuccess) {
            if (weakSelf.resorceArray.count >0) {
                [weakSelf.resorceArray removeAllObjects];
            }
            if (weakSelf.titleArray.count >0) {
                [weakSelf.titleArray removeAllObjects];
            }
          

            NSMutableArray *imggeList = [[NSMutableArray alloc] init];
            ItemInfoList *infoModel = dataArray[0];
            weakSelf.itemIfoModel = dataArray[1];
            
            [weakSelf.titleArray addObject:@"商品详情"];
            [weakSelf.titleArray addObject:@"查看商品规格"];
            if (!KX_NULLString(_itemIfoModel.itemContent.content)) {
                [weakSelf.titleArray addObject:@"图文详情"];
            }
            
            weakSelf.bottomView.contenModel = weakSelf.itemIfoModel.itemContent;
            for (ItemContentList *items in infoModel.itemContentList) {
                [imggeList addObject:items.imageUrl];
            }
            weakSelf.headView.imageURLStringsGroup = imggeList;

            _itemIfoModel.itemContent.imageUrl = imggeList.firstObject;
            [weakSelf.resorceArray addObjectsFromArray:dataArray];
            [weakSelf.tableView reloadData];
            [weakSelf getGoodsValueRequest];

            
        }else{
            [self showHint:@"商品已下架,不能购买"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeAfter * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }
        
    }];
    
  
    
}

- (void)getRecommendedRequest
{
    WEAKSELF;
    [HomeVModel getHomeNewsParam:nil successBlock:^(ItemInfoList *listModel, BOOL isSuccess) {
        [_sameArray addObject:@[@""]];
        [_sameArray addObject:listModel.itemContentList];
        [_sameTitleArr addObject:@"热销商品"];
        if (_isLoading == NO) {
            [_sameGoodsCollectView reloadData];
            _isLoading= YES;
        }
    }];
}




///  加入购物车
- (void)addGoodsInCar:(ItemContentList *)model{
    [MBProgressHUD showMessag:@"加入购物车中..." toView:self.view];
    if (_goodSCount >0) {
        
    }else{
        _goodSCount = 1;
    }
    model.cartNum =  [NSString stringWithFormat:@"%ld",(long)_goodSCount];
    model.goods_id = self.productID;

    [[shoppingCarVM alloc] addShopCar:model handleback:^(NSInteger code) {
//        [iToast alertWithTitle:@"已添加购物车成功~"];
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


///  商品价格
- (void)getGoodsDetailPriceRequest
{
    WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_productID forKey:@"goods_id"];
    if (self.selectItems.count > 0) {
        NSString *sper_vlue = [self.selectItems componentsJoinedByString:@","];
        [param setObject:sper_vlue forKey:@"spec"];
    }
    [GoodsVModel getGoodsDetailPriceParam:param successBlock:^(NSDictionary *relust, BOOL isSuccess) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (isSuccess == YES) {
            
            weakSelf.itemIfoModel.itemContent.price = relust[@"sell_price"];
            weakSelf.itemIfoModel.itemContent.store_nums = relust[@"store_nums"];
            NSMutableArray *priceArr = [[NSMutableArray alloc] init];
            
            if (_itemIfoModel.itemContent.price.floatValue >0) {
                [priceArr addObject:[NSString stringWithFormat:@"¥%@",_itemIfoModel.itemContent.price]];
            }
            if (_itemIfoModel.itemContent.point.floatValue >0) {
                [priceArr addObject:[NSString stringWithFormat:@"%@积分",_itemIfoModel.itemContent.point]];
            }
//            if ([_itemIfoModel.itemContent.freight floatValue] >0) {
//                [priceArr addObject:[NSString stringWithFormat:@"%@快递费",_itemIfoModel.itemContent.freight]];
//            }
            NSString *allPrice = [priceArr componentsJoinedByString:@"+"];
            NSString *moneyStr = [NSString stringWithFormat:@"%@",allPrice];
            NSAttributedString *attributedStr =  [self attributeStringWithContent:moneyStr keyWords:@[@"+",@"快递费"]];
            self.selectView.LB_price.attributedText  = attributedStr;
            
//            if (_itemIfoModel.itemContent.earn_money.floatValue >0) {
////                NSString *getMoney = [NSString stringWithFormat:@"赚¥%@",_itemIfoModel.itemContent.earn_money];
//                NSString *moneyStr = [NSString stringWithFormat:@"%@ %@",allPrice];
//                NSAttributedString *attributedStr =  [self attributeStringWithContent:moneyStr keyWords:@[getMoney,@"+"]];
//                self.selectView.LB_price.attributedText  = attributedStr;
//
//            }else{
//                self.selectView.LB_price.text = allPrice;
//            }
            self.selectView.LB_stock.text = [NSString stringWithFormat:@"库存%@件", weakSelf.itemIfoModel.itemContent.store_nums];
            self.selectView.itemIfoModel = weakSelf.itemIfoModel;
             [self.tableView reloadData];
            
        }else{
            
        }

    }];
}



- (void)getGoodsValueRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_productID forKey:@"goods_id"];
    [GoodsVModel getGoodDetailConfigParm:param successBlock:^(NSArray *dataArray, BOOL isSuccess) {
        if (isSuccess) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            weakSelf.itemIfoModel.spec = dataArray;
            [weakSelf initSelectView];

        }
        else{
            [weakSelf.view makeToast:NOTICEMESSAGE];
        }
    }];
}



/// 收藏取消收藏操作
- (void)getCollectionRequestWithISCollect
{
    WEAKSELF;
    GoodSDetailModel *model;
 
    if (self.resorceArray.count >0 ) {
        model = weakSelf.resorceArray[0];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:_productID forKey:@"goods_id"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
        if (KX_NULLString(_itemIfoModel.itemContent.coll_id)) {
            [param setObject:@"add" forKey:@"method"];
        }else{
            [param setObject:@"delete" forKey:@"method"];
        }
        [param setObject:_itemIfoModel.itemContent.coll_id forKey:@"coll_id"];

        [GoodsVModel getGoodCollectParam:param successBlock:^(BOOL isSuccess, NSString *msg) {
            [weakSelf.view makeToast:msg];
            if (isSuccess) {
                [weakSelf getGoodsDetailInfoRequest];
            }
        }];
    }
   
}


- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 50) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 40.f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.tableFooterView = self.footView;
        _tableView.tableFooterView = [UIView new];

    }
    return _tableView;
}




-(SDCycleScrollView *)headView
{
    if (!_headView) {
        _headView= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) delegate:self placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW3]];
        _headView.delegate = self;
    }
    return _headView;
}

- (NSMutableArray *)commentsArray
{
    if (_commentsArray == nil) {
        _commentsArray = [[NSMutableArray alloc] init];
    }
    return _commentsArray;
}

#pragma mark  - 懒加载
-(LoadingTableFootView *)footView
{
    if (!_footView ) {
        _footView =  [[LoadingTableFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    }
    return _footView;
    
}

/**
 * 懒加载数据源
 */
- (NSMutableArray *)resorceArray
{
    if (_resorceArray == nil) {
        _resorceArray = [[NSMutableArray alloc] init];
    }
    return _resorceArray;
}


#pragma mark -SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    //    browser.currentImageIndex = index;
    //    browser.sourceImagesContainerView = self.view;
    //    browser.imageCount = _headView.imageURLStringsGroup.count;
    //    browser.delegate = self;
    //    [browser show];
}

#pragma mark - SDPhotoBrowserDelegate
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName =  _headView.imageURLStringsGroup[index];
    NSURL *url = [NSURL URLWithString:imageName];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = _headView.subviews[index];
    return imageView.image;
}


#pragma mark - UITaleViewDelegate and UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    if ([_titleArray[indexPath.section] isEqualToString:@"商品详情"]) {
        if(self.resorceArray.count <2) return nil;
        ItemInfoList *model = self.resorceArray[indexPath.section+1];
        GoodsDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsDetailInfoCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.model = model.itemContent;
        cell.clickCollectBlcok = ^(NSString *str,NSInteger index){

        };
        return cell;
    }
    else if([_titleArray[indexPath.section] isEqualToString:@"图文详情"]){
        GoodWebInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:goodsSameWebCellID];
        cell.detailWebView.delegate = self;
        cell.detailWebView.scrollView.scrollEnabled = NO;
        [ cell.detailWebView loadHTMLString:_itemIfoModel.itemContent.content baseURL:[NSURL URLWithString:HEAD__URL]];
        return cell;
    }
    GoodsCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCommonCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     cell.titleLabel.text = _titleArray[indexPath.section];
    cell.titleLabel.textColor = TITLETEXTLOWCOLOR;
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
//        GoodSDetailModel *model = self.resorceArray[indexPath.section];
//        CGSize contenH = [NSString heightForString:model.mainResult.productName fontSize:Font15 WithSize:CGSizeMake(SCREEN_WIDTH - 24, 35)];
//        if (contenH.height >20) {
//               return 165+contenH.height;
//        }
        ItemInfoList *model = self.resorceArray[indexPath.section+1];

        NSInteger row = SCREEN_WIDTH/27;
        if(self.resorceArray.count <2) return 140;
           CGSize contenSize1 = [NSString heightForString:model.itemContent.desc fontSize:Font13 WithSize:CGSizeMake(SCREEN_WIDTH - 30, SCREEN_WIDTH)];
        
        CGSize contenSize2 = [NSString heightForString:model.itemContent.name fontSize:Font15 WithSize:CGSizeMake(SCREEN_WIDTH - 30, SCREEN_WIDTH)];

        if (model.itemContent.tags.count > row) {
            return 160+15 +contenSize1.height - 15;
        }
        if (model.itemContent.tags.count == 0) {
            return 160 +contenSize1.height  - 23;
        }
     
        return 160 +contenSize1.height + contenSize2.height - 25;
    }
    else if (indexPath.section == 2){
        if (_maxWebHight == 0) {
            return SCREEN_HEIGHT;
        }
        return _maxWebHight;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    NSString *title = _titleArray[section];
  
    if ([title isEqualToString:@"认证详情"]) {
        return 10;
    }
    if ([title isEqualToString:@"选择数量"]) {
        return 10;
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GoodSDetailModel *model = self.resorceArray[0];
    NSString *title = _titleArray[indexPath.section];
    if (![title isEqualToString:@"查看规格"]) {
     
//        [self showGuigeView:GoodGuigeAddCartOrBuyType];
        [self.selectView show];


    }
   
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _sameArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [(NSMutableArray *)_sameArray[section] count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF;
    if (indexPath.section ==0) {
        GoodsSameWebCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:goodsSameWebCellID forIndexPath:indexPath];
        if (!cell) {
            cell = [GoodsSameWebCell new];
        }
        cell.detailWebView.delegate = self;
        cell.detailWebView.scrollView.scrollEnabled = NO;
        [ cell.detailWebView loadHTMLString: _itemIfoModel.itemContent.content baseURL:[NSURL URLWithString:HEAD__URL]];
        return cell;
    }
    NewProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:newProductCell forIndexPath:indexPath];
    if (!cell) {
        cell = [NewProductCell new];
    }
    cell.didClickCellBlock = ^(ItemContentList *model) {
        [weakSelf addGoodsInCar:model];
    };
    cell.model =_sameArray[indexPath.section][indexPath.row];
    return cell;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (_maxWebHight == 0) {
            return CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT);
        }
        return CGSizeMake(SCREEN_WIDTH,_maxWebHight);
    }
    return CGSizeMake((SCREEN_WIDTH - 25)/2, 290);
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(SCREEN_WIDTH, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 40);
    }
    return CGSizeZero;
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 5, 10);//商品cell

}

//item 列间距(纵)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{

    return 5;
}


- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        HomeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:homeStoreHeaderViewIdentifier forIndexPath:indexPath];
        headerView.titleLabel.text = _sameTitleArr.lastObject;
        headerView.moreBtn.hidden = YES;
        indexPath.section == 0?  (headerView.hidden = YES): (headerView.hidden = NO);
        return headerView;
    }
    else if (kind == UICollectionElementKindSectionFooter){
        GoodsSameFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:goodsSameFootViewID forIndexPath:indexPath];
        return footView;
    }
    return nil;
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    GoodsListModel *model = _sameArray[indexPath.section][indexPath.row] ;
//
//    GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
//                                                 navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
//    vc.productID = model.mainProductIdAdv;
//    vc.typeStr = model.salesType;
//    [self.navigationController pushViewController: vc animated:YES];
}

#pragma mark ---- scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <15) {
        offsetY = 0;
    }
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self.superVC wr_setNavBarBackgroundAlpha:alpha];
        self.navigationTabBar.alpha = alpha;
        self.superVC.navigationItem.titleView.hidden = NO;

        if (alpha > 0.5) {
            [self.backButton setImage:[UIImage imageNamed:@"back_icon@2x.png"] forState:UIControlStateNormal];

            [self wr_setNavBarTintColor:[UIColor redColor]];

            [self.superVC wr_setNavBarTitleColor:[UIColor blackColor]];
            [self.superVC wr_setStatusBarStyle:UIStatusBarStyleDefault];
        } else {
            [self.backButton setImage:[UIImage imageNamed:@"shouye6@3x.png"] forState:UIControlStateNormal];

            [self.superVC wr_setNavBarTintColor:[UIColor whiteColor]];
            [self.superVC wr_setNavBarTitleColor:[UIColor clearColor]];
            [self.superVC wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        }

    }
    else
    {
        [self.superVC wr_setNavBarBackgroundAlpha:0];
        self.navigationTabBar.alpha = 0;

        [self.superVC wr_setNavBarTintColor:[UIColor whiteColor]];
        [self.superVC wr_setNavBarTitleColor:[UIColor clearColor]];
        [self.superVC wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    //限制下拉的距离
    if(offsetY < LIMIT_OFFSET_Y) {
        [scrollView setContentOffset:CGPointMake(0, LIMIT_OFFSET_Y)];
    }
    
    // 改变图片框的大小 (上滑的时候不改变)
    // 这里不能使用offsetY，因为当（offsetY < LIMIT_OFFSET_Y）的时候，y = LIMIT_OFFSET_Y 不等于 offsetY
    CGFloat newOffsetY = scrollView.contentOffset.y;
    if (newOffsetY < -IMAGE_HEIGHT)
    {
        self.headView.frame = CGRectMake(0, newOffsetY, kScreenWidth, -newOffsetY);
    }
}


//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    CGFloat offsetY = scrollView.contentOffset.y;
//
//    if([scrollView isKindOfClass:[UITableView class]]) // tableView界面上的滚动
//    {
//        // 能触发翻页的理想值:tableView整体的高度减去屏幕本省的高度
//        CGFloat valueNum = _tableView.contentSize.height -SCREEN_HEIGHT +50;
//        if ((offsetY - valueNum) > _maxContentOffSet_Y)
//        {
//            [self goToDetailAnimation]; // 进入图片详情的动画
//        }
//    }
//    else // webView页面上的滚动
//    {
//        NSLog(@"-----webView-------");
//        if(offsetY<0 && -offsetY>_maxContentOffSet_Y)
//        {
//            [self backToFirstPageAnimation]; // 返回基本详情界面的动画
//        }
//    }
//}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *jsStr = [NSString getJSWithScreentWidth:SCREEN_WIDTH];
    //注入js
    [webView stringByEvaluatingJavaScriptFromString:jsStr];
    //获取webView的contentSize
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].scrollHeight"] floatValue];
    if ([webView isFinishLoading] == YES) {
        _maxWebHight = height;
        if (_isLoading) {
            [_tableView reloadData];
        }
        _isLoading = NO;

    }

}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"%@",error);
    NSLog(@"加载失败");
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    if(object == _sameGoodsCollectView && [keyPath isEqualToString:@"contentOffset"])
//    {
//        [self headLabAnimation:[change[@"new"] CGPointValue].y];
//    }else
//    {
//        [self observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//
//}

//// 头部提示文本动画
//- (void)headLabAnimation:(CGFloat)offsetY
//{
//    _headLab.alpha = -offsetY/60;
//    _headLab.center = CGPointMake(SCREEN_WIDTH/2, -offsetY/2.f);
//    // 图标翻转，表示已超过临界值，松手就会返回上页
//    if(-offsetY>_maxContentOffSet_Y){
//        _headLab.textColor = BACKGROUND_COLORHL;
//        _headLab.text = @"释放，返回详情";
//    }else{
//        _headLab.textColor = BACKGROUND_COLORHL;
//        _headLab.text = @"上拉，返回详情";
//    }
//}


// 进入详情的动画
- (void)goToDetailAnimation
{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _sameGoodsCollectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 45);
        _tableView.frame = CGRectMake(0, -self.contentView.bounds.size.height, SCREEN_WIDTH, self.contentView.bounds.size.height);
    } completion:^(BOOL finished) {
        
    }];
}


// 返回第一个界面的动画
- (void)backToFirstPageAnimation
{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentView.bounds.size.height);
        _sameGoodsCollectView.frame = CGRectMake(0, _tableView.contentSize.height, SCREEN_WIDTH, SCREEN_HEIGHT-45);
        
    } completion:^(BOOL finished) {
        
    }];
}


- (UILabel *)headLab
{
    if(!_headLab){
        _headLab = [[UILabel alloc] init];
        _headLab.text = @"上拉，返回详情";
        _headLab.font = Font15;
        _headLab.textAlignment = NSTextAlignmentCenter;
    }
    _headLab.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40.f);
    _headLab.alpha = 0.f;
    return _headLab;
}



- (void)dealloc
{
    /// 清除监听
//    [_sameGoodsCollectView removeObserver:self forKeyPath:@"contentOffset"];
}


- (NSAttributedString *)attributeStringWithContent:(NSString *)content keyWords:(NSArray *)keyWords
{
    UIColor *color = KMAINCOLOR;
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:content];
    
    if (keyWords) {
        
        [keyWords enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSMutableString *tmpString=[NSMutableString stringWithString:content];
            
            NSRange range=[content rangeOfString:obj];
            
            NSInteger location=0;
            
            while (range.length>0) {
                
                [attString addAttribute:(NSString*)NSForegroundColorAttributeName value:color range:NSMakeRange(location+range.location, range.length)];
                [attString addAttribute:NSFontAttributeName
                                  value:Font11
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
