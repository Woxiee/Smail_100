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


#import "DWQSelectAttributes.h"
#import "DWQSelectView.h"

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
static NSString *goodsSameCellID = @"goodsSameCellID";
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

    [self.tableView headerWithRefreshingBlock:^{
        [weakSelf getGoodsDetailInfoRequest];
    }];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getGoodsDetailInfoRequest];

    _guiGeVlue = @"";
    _goodSCount = 1;
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
    
    [_sameGoodsCollectView registerNib:[UINib nibWithNibName:@"GoodsSameWebCell" bundle:nil] forCellWithReuseIdentifier:goodsSameWebCellID];
    
    [_sameGoodsCollectView registerNib:[UINib nibWithNibName:@"GoodsSameCell" bundle:nil] forCellWithReuseIdentifier:goodsSameCellID];

    //SectionheaderView
    [_sameGoodsCollectView registerNib:[UINib nibWithNibName:@"HomeHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:homeStoreHeaderViewIdentifier];
    
    //SectionfooterView
    [_sameGoodsCollectView registerNib:[UINib nibWithNibName:@"GoodsSameFootView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:goodsSameFootViewID];
    
    _productList = [[NSMutableArray alloc] init];
}

/// 初始化视图
- (void)setup
{
    
    [self.view addSubview:self.tableView];

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
        _bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, 45);

        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.selectBlock = ^(NSInteger index){
            ItemInfoList *model = nil;

            if (weakSelf.resorceArray.count >0) {
                model = weakSelf.resorceArray[1];
            }
            if (index == 0) {
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                weakSelf.tabBarController.selectedIndex = 0;
            }
            else if (index == 1){
                [weakSelf getCollectionRequestWithISCollect];
            }
            else if (index == 2){
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];

                weakSelf.tabBarController.selectedIndex = 3;

            }
            else if (index == 3){
                
                [weakSelf addGoodsInCar:model.itemContent];
            }
            else if (index == 4){
                
                
                
                GoodsOrderNomalVC *VC = [[GoodsOrderNomalVC alloc] init];
                model.itemContent.goods_id = weakSelf.productID;
                VC.itemsModel = model.itemContent;
                [weakSelf.superVC.navigationController pushViewController:VC animated:YES];
            }

        };

        [self.superVC.view addSubview:_bottomView];
    }


}

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
    self.selectView = [[DWQSelectView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.selectView.headImage  sd_setImageWithURL:[NSURL URLWithString:_itemIfoModel.itemContent.imageUrl] placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW]];
    
    self.selectView.nameLB.text = _itemIfoModel.itemContent.name;
    self.selectView.LB_price.text =[NSString stringWithFormat:@"￥%@",_itemIfoModel.itemContent.price];
    self.selectView.LB_stock.text = @"";
    self.selectView.LB_showSales.text = [NSString stringWithFormat:@"销量%@件",_itemIfoModel.itemContent.sale_num] ;
    self.selectView.LB_detail.text = @"请选择规格属性";
    self.selectView.didClickComTFpltBlock = ^(NSInteger index, NSInteger goodCout) {
        weakSelf.goodSCount = goodCout;
        NSString *sper_vlue = [weakSelf.selectItems componentsJoinedByString:@","];
        weakSelf.itemIfoModel.itemContent.spec = sper_vlue;
            LOG(@"购物车");
        if (index ==0) {
            [weakSelf addGoodsInCar:weakSelf.itemIfoModel.itemContent];
        }else{
            LOG(@"购买");
            GoodsOrderNomalVC *VC = [[GoodsOrderNomalVC alloc] init];
            weakSelf.itemIfoModel.itemContent.goods_id = weakSelf.productID;
            VC.itemsModel = weakSelf.itemIfoModel.itemContent;
            [weakSelf.superVC.navigationController pushViewController:VC animated:YES];
            
        }
    };
    
    CGFloat maxY = 0;
    CGFloat height = 0;
    for (int i = 0; i < self.standardList.count; i ++)
    {
        self.selectAttributes = [[DWQSelectAttributes alloc] initWithTitle:self.standardList[i] titleArr:self.standardValueList[i] andFrame:CGRectMake(0, maxY, SCREEN_WIDTH, 40)];
        maxY = CGRectGetMaxY(self.selectAttributes.frame);
        height += self.selectAttributes.dwq_height;
        self.selectAttributes.tag = 8000+i;
        self.selectAttributes.delegate = self;
        
        [self.selectView.mainscrollview addSubview:self.selectAttributes];
    }
    self.selectView.mainscrollview.contentSize = CGSizeMake(0, height);
    
    
    
  
}

#pragma mark --弹出规格属性

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
    
    [self getGoodsDetailPriceRequest];
}


#pragma mark - request
/// 商品详情
- (void)getGoodsDetailInfoRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_productID forKey:@"goods_id"];
    [GoodsVModel getGoodsDetailParam:param successBlock:^(NSArray<ItemInfoList *> *dataArray, BOOL isSuccess) {
        [weakSelf.tableView endRefreshTableView];
        if (isSuccess) {
            if (weakSelf.resorceArray.count >0) {
                [weakSelf.resorceArray removeAllObjects];
            }
            if (weakSelf.titleArray.count >0) {
                [weakSelf.titleArray removeAllObjects];
            }
            [weakSelf.titleArray addObject:@"商品详情"];
            [weakSelf.titleArray addObject:@"查看商品规格"];
            NSMutableArray *imggeList = [[NSMutableArray alloc] init];
            ItemInfoList *infoModel = dataArray[0];
            weakSelf.itemIfoModel = dataArray[1];
            weakSelf.bottomView.contenModel = weakSelf.itemIfoModel.itemContent;
            for (ItemContentList *items in infoModel.itemContentList) {
                [imggeList addObject:items.imageUrl];
            }
            weakSelf.headView.imageURLStringsGroup = imggeList;

            [weakSelf.resorceArray addObjectsFromArray:dataArray];
            [weakSelf.tableView reloadData];
            [weakSelf getGoodsValueRequest];

            
        }else{
            
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
            weakSelf.selectView.LB_price.text =[NSString stringWithFormat:@"￥%@", weakSelf.itemIfoModel.itemContent.price ];
            self.selectView.LB_stock.text = [NSString stringWithFormat:@"库存%@件", weakSelf.itemIfoModel.itemContent.store_nums];
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
            
            weakSelf.itemIfoModel.spec = dataArray;
            [weakSelf initSelectView];

        }
        else{
            [weakSelf.view toastShow:NOTICEMESSAGE];
        }
    }];
}

///  类似产品
- (void)getGoodsDetailSameRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_typeStr forKey:@"itemsType"];
    [GoodsVModel getGoodsSameDetailParam:param successBlock:^(NSArray *dataArray,NSArray *dataArray1, BOOL isSuccess) {
        if (isSuccess) {
            [_sameArray removeAllObjects];
            [_sameArray addObject:self.resorceArray];
            [_sameTitleArr addObject:@""];

            if (dataArray.count >0) {
                [_sameArray addObject:dataArray];
                [_sameTitleArr addObject:@"热销商品"];
            }
            if (dataArray1.count >0) {
                [_sameArray addObject:dataArray1];
                [_sameTitleArr addObject:@"产品推荐"];

            }
        }
        if (_isLoading == NO) {
            [_sameGoodsCollectView reloadData];
            _isLoading= YES;
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
            [weakSelf.view toastShow:msg];
            if (isSuccess) {
                [weakSelf getGoodsDetailInfoRequest];
            }
        }];
    }
   
}


- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 45) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.tableFooterView = self.footView;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.headView;
    }
    return _tableView;
}

- (UIWebView *)webView
{
    if(!_webView){
        _webView = [[UIWebView alloc] init];
        if (_tableView.contentSize.height < SCREEN_HEIGHT) {
            _webView.frame =    CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, SCREEN_HEIGHT-50 - 64);
        }else
        {
            _webView.frame =    CGRectMake(0, _tableView.contentSize.height, SCREEN_WIDTH,  SCREEN_HEIGHT-50 - 64);
        }
        
        _webView.delegate = self;
//        _webView.scrollView.delegate = self;
        _webView.scrollView.scrollEnabled = YES;
    }
    return _webView;
}


-(SDCycleScrollView *)headView
{
    if (!_headView) {
        _headView= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH + 50) delegate:self placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW2]];
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
//        if (model.mainResult.dizhi.count <2) {
//            cell.rightImageView.hidden = YES;
//        }
        cell.model = model.itemContent;
        cell.clickCollectBlcok = ^(NSString *str,NSInteger index){
   
//            if (index == 100) {
//                if (KX_NULLString(str)) {
//                    [weakSelf.view toastShow:@"此号码无效~"];
//                    return ;
//                }
//                if ( !KX_NULLString(model.businessResult.busiCompTel) && !KX_NULLString(model.businessResult.userPhone)) {
//
//
//                }else{
//                    SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:[NSString stringWithFormat:@"%@",str] clickDex:^(NSInteger clickDex) {
//                        if (clickDex == 1) {
//                            NSMutableString *str1=[[NSMutableString alloc] initWithFormat:@"tel:%@",str];
//                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str1]];
//                        }}];
//                    [successV showSuccess];
        
        
                

//            }else{
//                if (model.mainResult.dizhi.count >1) {
//                    AttributeListView *view = [[AttributeListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//                    view.dizhiArr = model.mainResult.dizhi;
//                    [view show];
//                }
//            }
        
        };
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
        return 140;
    }
    return 44;
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
    if (![title isEqualToString:@"商品详情"]) {
        
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
    if (indexPath.section ==0) {
        GoodSDetailModel *model = _sameArray[0][0];
        GoodsSameWebCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:goodsSameWebCellID forIndexPath:indexPath];
        if (!cell) {
            cell = [GoodsSameWebCell new];
        }
        cell.detailWebView.delegate = self;
        cell.detailWebView.scrollView.scrollEnabled = NO;
        [ cell.detailWebView loadHTMLString:model.mainResult.detailDesc baseURL:[NSURL URLWithString:HEAD__URL]];
        return cell;
    }
    GoodsSameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:goodsSameCellID forIndexPath:indexPath];
    if (!cell) {
        cell = [GoodsSameCell new];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = _sameArray[indexPath.section][indexPath.row];
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
    return CGSizeMake((SCREEN_WIDTH - 12)/2, 237);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
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


- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        HomeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:homeStoreHeaderViewIdentifier forIndexPath:indexPath];
        headerView.titleLabel.text = _sameTitleArr[indexPath.section];
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

- (void)dealloc
{
    /// 清除监听
    [_sameGoodsCollectView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
