//
//  OnlineVC.m
//  Smile_100
//
//  Created by Faker on 2018/2/7.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "OnlineVC.h"
#import "TopScreenView.h"
#import "ItemContentList.h"
#import "ColumnCell.h"
#import "HomeScrollCell.h"
#import "PYSearchViewController.h"
#import "NewProductCell.h"
#import "RecommendedView.h"
#import "GoodsDetailVC.h"
#import "HomeVModel.h"
#import "GoodsClassVC.h"
#import "shoppingCarVM.h"
#import "GoodsAuctionXYVC.h"
#import "ClouldPhoneVC.h"

@interface OnlineVC ()<PYSearchViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HomePageCycScrollViewDelegate>
@property (nonatomic, weak) TopScreenView *topSreenView;
@property (nonatomic, strong)  UITextField *inPutTextField;
@property (nonatomic, weak) KYActionSheetDown *sheet;          /// 弹窗
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong)  NSMutableArray *hotArray;

@end

@implementation OnlineVC
{
    NSInteger oldIndex[4] ;   /// 记录上一次选择tabelviewlist
}
static NSString * const imageCellIdentifier = @"HomeScrollCellID";
static NSString * const columnCellID = @"ColumnCellID";
static NSString *homeStoreHeaderViewIdentifier = @"HomeStoreHeaderView";
static NSString *RecommendedViewIdentifier = @"RecommendedViewIdentifier";


static NSString *newProductCell = @"newProductID";
static NSString *homeFooterView = @"homeFooterViewID";

static NSString *insuranceCellCell = @"InsuranceCellCellID";
static NSString *financialCellCell = @"financialCellCellID";
static NSString *timelimitCellID = @"timelimitCellID";

static NSString *TimeLimtKillCellID = @"TimeLimtKillCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
    [self getHomeGoodsRequest];
    WEAKSELF
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    [weakSelf getHomeGoodsRequest];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_sheet) {
        [_sheet removeFromSuperview];
        _sheet =nil;
    }
    
}

                                     
#pragma mark - request
/// 获取首页商品
- (void)getHomeGoodsRequest
{
//    [HomeVModel getHomGoodsParam:nil successBlock:^(NSArray<ColumnModel *> *dataArray, BOOL isSuccess) {
//        if (self.resorceArray.count >0) {
//            [self.resorceArray removeAllObjects];
//        }
//        [self.resorceArray addObjectsFromArray: dataArray];
//        [self.collectionView reloadData];
//        [self.collectionView.mj_header endRefreshing];
//    }];
    
    WEAKSELF;
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:@"0"  forKey:@"is_home"];
    [param setObject:@"2"  forKey:@"pos"];
    
    [HomeVModel getHomGoodsParam:param successBlock:^(NSArray<ItemContentList *> *dataArray, BOOL isSuccess) {
        if (weakSelf.resorceArray.count >0) {
            [weakSelf.resorceArray removeAllObjects];
        }
        [weakSelf.resorceArray addObjectsFromArray: dataArray];
        [weakSelf getRecommendedRequest];
        [self.collectionView reloadData];
    }];
}


- (void)getRecommendedRequest
{
    WEAKSELF;
    [HomeVModel getHomeNewsParam:nil successBlock:^(ItemInfoList *listModel, BOOL isSuccess) {
        [weakSelf.resorceArray addObject:listModel];
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
}

                                     

/// 获取热门关键词
- (void)getHoldKeyWorld
{
    WEAKSELF;
    [HomeVModel getHotList:^(NSArray *dataArray, BOOL isSuccess) {
        if (isSuccess) {
            //            [weakSelf.resorceArray addObjectsFromArray:dataArray];
            //            [weakSelf setup];
            for (NSDictionary *dic in dataArray) {
                [weakSelf.hotArray addObject:dic[@"keyword"]];
            }
        }
        
    }];
    
    
}


#pragma mark - private
/// 初始化视图
- (void)setup
{
    UITextField *inPutTextField = [[UITextField alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 100 , 30)];
    inPutTextField.placeholder = @"商品";
    inPutTextField.textColor = [UIColor whiteColor];
    inPutTextField.font = [UIFont systemFontOfSize:13];
    inPutTextField.returnKeyType = UIReturnKeySearch;
    inPutTextField.backgroundColor =[UIColor whiteColor];
    inPutTextField.borderStyle = UITextBorderStyleNone;
    [inPutTextField layerForViewWith:5 AndLineWidth:0];
    _inPutTextField = inPutTextField;
    
    //搜索框里面的UI
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    view.backgroundColor = [UIColor clearColor];
    inPutTextField.leftViewMode = UITextFieldViewModeAlways;
    inPutTextField.leftView = view;
    UIImageView * searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 14, 14)];
    searchImage.backgroundColor = [UIColor clearColor];
    searchImage.image = [UIImage imageNamed:@"21@3x.png"];
    [view addSubview:searchImage];
    
    UIButton *coverToSeach =  [[UIButton alloc]initWithFrame:CGRectMake(0, 0, inPutTextField.width, inPutTextField.height)];
    coverToSeach.backgroundColor = [UIColor clearColor];
    [coverToSeach addTarget:self  action:@selector(clickToSearch) forControlEvents:UIControlEventTouchUpInside];
    [inPutTextField addSubview:coverToSeach];
    self.navigationItem.titleView = inPutTextField;
    
 
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    layout.sectionInset = UIEdgeInsetsZero;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;

    [self setRightNaviBtnImage:[UIImage imageNamed:@"shouye18@3x.png"]];
}

- (void)didClickRightNaviBtn
{
    
    self.tabBarController.selectedIndex = 3;
}

/// 配置基础设置
- (void)setConfiguration
{
    //轮播图
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeScrollCell" bundle:nil] forCellWithReuseIdentifier:imageCellIdentifier];
    ///栏目
    [self.collectionView registerNib:[UINib nibWithNibName:@"ColumnCell" bundle:nil] forCellWithReuseIdentifier:columnCellID];
    ///限时抢购
    //    [self.collectionView registerNib:[UINib nibWithNibName:@"TimeLimtCollectCell" bundle:nil] forCellWithReuseIdentifier:timelimitCellID];
//    [self.collectionView registerClass:[TimeLimtCollectCell class] forCellWithReuseIdentifier:timelimitCellID];
    
    ///限时秒杀
    [self.collectionView registerNib:[UINib nibWithNibName:@"TimeLimtKillCell" bundle:nil] forCellWithReuseIdentifier:TimeLimtKillCellID];
    
    ///商品
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewProductCell" bundle:nil] forCellWithReuseIdentifier:newProductCell];
    ///金融
    [self.collectionView registerNib:[UINib nibWithNibName:@"FinancialCellCell" bundle:nil] forCellWithReuseIdentifier:financialCellCell];
    ///保险
    [self.collectionView registerNib:[UINib nibWithNibName:@"InsuranceCellCell" bundle:nil] forCellWithReuseIdentifier:insuranceCellCell];
    //SectionheaderView
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:homeStoreHeaderViewIdentifier];
    
    [self.collectionView registerClass:[RecommendedView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RecommendedViewIdentifier];
    
    [self.collectionView registerClass:[RecommendedView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"RecommendedViewID"];
    
    //SectionFooterView
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeFootView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:homeFooterView];
    
    
    _hotArray= [[NSMutableArray alloc] init];

}




- (void)clickToSearch
{

    WEAKSELF;
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:_hotArray searchBarPlaceholder:@"找商品、找商家、找品牌" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        //        weakSelf.keyWord = searchText;
        //        [weakSelf requestListNetWork];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    // 3. Set style for popular search and search history
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleCell;
    searchViewController.hotSearchStyle =  PYHotSearchStyleRectangleTag;
    // 4. Set delegate
    searchViewController.delegate = self;
    // 5. Present a navigation controller
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

///  加入购物车
- (void)addGoodsInCar:(ItemContentList *)model{
    [MBProgressHUD showMessag:@"加入购物车中..." toView:self.view];
    model.cartNum = @"1";
    [[shoppingCarVM alloc] addShopCar:model handleback:^(NSInteger code) {
        //        [iToast alertWithTitle:@"已添加购物车成功~"];
        [self.collectionView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}


#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    //    return 1;
    
    return self.resorceArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    ItemInfoList *model =   self.resorceArray[section];
    if ([model.itemType isEqualToString:@"topBanner"]) {
        return 1;
    }
    
    else if ([model.itemType isEqualToString:@"cateList"]){
        return model.itemContentList.count;

    }
    
    else if ([model.itemType isEqualToString:@"recommended_ware"]){
        return model.itemContentList.count;
    }
//
    
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     WEAKSELF;
    ItemInfoList *model =   self.resorceArray[indexPath.section];
    if ([model.itemType isEqualToString:@"topBanner"]){
        HomeScrollCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageCellIdentifier forIndexPath:indexPath];
        NSMutableArray *listArr = [[NSMutableArray alloc] init];
        for (ItemContentList *items in  model.itemContentList) {
            [listArr addObject:items.imageUrl];
        }
        cell.modelArray = listArr;
        cell.delegate = self;
        return cell;
        
    }
    else  if ([model.itemType isEqualToString:@"cateList"]){
        ColumnCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:columnCellID forIndexPath:indexPath];
        if (!cell) {
            cell = [ColumnCell new];
        }
        cell.model = model.itemContentList[indexPath.row];
        return cell;
        
    }
   
    else if ([model.itemType isEqualToString:@"recommended_ware"]){
        
        NewProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:newProductCell forIndexPath:indexPath];
        if (!cell) {
            cell = [NewProductCell new];
        }
        cell.didClickCellBlock = ^(ItemContentList *model) {
            [weakSelf addGoodsInCar:model];
        };
        cell.model = model.itemContentList[indexPath.row];
        return cell;
    }
    
    return nil;
}


//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemInfoList *model =   self.resorceArray[indexPath.section];
    
    if ([model.itemType isEqualToString:@"topBanner"]) {
        return CGSizeMake(SCREEN_WIDTH, 220 *hScale);
    }
    
    
    else if ([model.itemType isEqualToString:@"cateList"]){
        return CGSizeMake((SCREEN_WIDTH)/5 ,(SCREEN_WIDTH)/5 + 20);
    }
    
    return CGSizeMake((SCREEN_WIDTH - 25)/2, 285);

}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    ItemInfoList *model =   self.resorceArray[section];
    if ([model.itemType isEqualToString:@"cateList"]){
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    if ([model.itemType isEqualToString:@"rushPurchaseHeader"]){
        return UIEdgeInsetsMake(5, 12, 0, 12);
    }
    
    if ([model.itemType isEqualToString:@"rushPurchaseContent"]){
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    else if ([model.itemType isEqualToString:@"recommended_ware"]){
        return UIEdgeInsetsMake(5, 10, 0, 10);//商品cell
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);

}



- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    ItemInfoList *model =   self.resorceArray[section];
    if ([model.itemType isEqualToString:@"themeBanner"]){
        return CGSizeMake(SCREEN_WIDTH , 50);
    }
    return CGSizeZero;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
//    ItemInfoList *model =   self.resorceArray[section];
//
//    if ([model.itemType isEqualToString:@"themeBanner"]){
//        return CGSizeMake(SCREEN_WIDTH , 50);
//    }
//
    //
    //    NSString *title = _titltArray[section];
    //    if (KX_NULLString(title) || [title isEqualToString:@"保险"] || [title isEqualToString:@"金融"]) {
    //             return CGSizeZero;
    //    }else{
    //        return CGSizeMake(SCREEN_WIDTH, 75);
    //
    //    }
    return CGSizeZero;
}



- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        ItemInfoList *model =  self.resorceArray[indexPath.section];
        if ([model.itemType isEqualToString:@"themeBanner"]){
            RecommendedView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:RecommendedViewIdentifier forIndexPath:indexPath];
            headerView.titleLB.text =  @"-- 精品推荐 --";
            headerView.detailLB.text = @"每日为您推荐最新火爆单品";
            return headerView;
        }
        return nil;
    }
    return nil;
    
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ItemInfoList *model =  self.resorceArray[indexPath.section];
    ItemContentList *contenModle =  model.itemContentList[indexPath.row];

    if ([contenModle.itemTitle isEqualToString:@"产品分类"]){
        if (indexPath.row == 4) {
            GoodsClassVC *VC = [[GoodsClassVC alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            return;
        }

    }
    
    if ([contenModle.itemTitle isEqualToString:@"我的云设备"]){
        if (indexPath.row == 4) {
            ClouldPhoneVC *VC = [[ClouldPhoneVC alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            return;
        }
        
    }
    
    if ([contenModle.clickType isEqualToString:@"web"]) {
        GoodsAuctionXYVC *VC = [GoodsAuctionXYVC new];
        VC.clickUrl = @"";
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if ([contenModle.clickType isEqualToString:@"app_category"]){
        
        
    }
    else {
        
        GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                     navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        //    vc.productID = model.mainResult.mainId;
        //    vc.typeStr = model.productType;
        vc.productID = contenModle.goods_id;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController: vc animated:YES];
    }
    
    
    
    
}


#pragma mark - HomePageCycScrollViewDelegate
/** 点击图片回调 */
- (void)didSelectCycleScrollViewItemAtIndex:(NSInteger)index
{
    //    ItemInfoList *model =   self.resorceArray[indexPath.section];
    for (ItemInfoList *model  in self.resorceArray) {
        if ([model.itemType isEqualToString:@"themeBanner"]) {
            ItemContentList *contenModle =  model.itemContentList[index];
            if ([contenModle.clickType isEqualToString:@"web"]) {
                GoodsAuctionXYVC *VC = [GoodsAuctionXYVC new];
                VC.clickUrl = @"";
                VC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:VC animated:YES];
                
            }
            else if ([contenModle.clickType isEqualToString:@"app_category"]){
                
            }
            else {
                /// 商品类型=1:新机。2:配构件。3:整机流转
                GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                             navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
                vc.productID = contenModle.id;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController: vc animated:YES];
            }
            
        }
    }
    
}


@end
