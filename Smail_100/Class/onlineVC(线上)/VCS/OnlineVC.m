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

@interface OnlineVC ()<PYSearchViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) TopScreenView *topSreenView;
@property (nonatomic, strong)  UITextField *inPutTextField;
@property (nonatomic, weak) KYActionSheetDown *sheet;          /// 弹窗
@property (weak, nonatomic) UICollectionView *collectionView;

@end

@implementation OnlineVC
{
    NSInteger oldIndex[4] ;   /// 记录上一次选择tabelviewlist
}
static NSString * HomeScrollCellIDS = @"HomeScrollCellIDS";
static NSString * columnCellID = @"ColumnCellID";
static NSString *RecommendedViewIdentifier = @"RecommendedViewIdentifier";
static NSString *newProductCell = @"newProductID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];

    [self getHomeGoodsRequest];
    WEAKSELF
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    [self getHomeGoodsRequest];
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
    [HomeVModel getHomGoodsParam:nil successBlock:^(NSArray<ColumnModel *> *dataArray, BOOL isSuccess) {
        if (self.resorceArray.count >0) {
            [self.resorceArray removeAllObjects];
        }
        [self.resorceArray addObjectsFromArray: dataArray];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
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
    
    
    WEAKSELF;
    /// 顶部视图
    TopScreenView *topSreenView = [[TopScreenView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    topSreenView.selectTopIndexBlock = ^(NSInteger index, NSString *key, NSString *title){
        
        if (_sheet) {
            [_sheet hiddenSheetView];
            _sheet =nil;
        }
        [weakSelf showDownMuenTitleKey:key andIndex:index andTitle:title];

    };
    [self.view addSubview:topSreenView];
    _topSreenView = topSreenView;
    
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    layout.sectionInset = UIEdgeInsetsZero;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topSreenView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44- 44) collectionViewLayout:layout];
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
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeScrollCell" bundle:nil] forCellWithReuseIdentifier:HomeScrollCellIDS];
    ///栏目
    [self.collectionView registerNib:[UINib nibWithNibName:@"ColumnCell" bundle:nil] forCellWithReuseIdentifier:columnCellID];
  
    [self.collectionView registerClass:[RecommendedView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RecommendedViewIdentifier];
    ///商品
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewProductCell" bundle:nil] forCellWithReuseIdentifier:newProductCell];
}


///显示商品下拉列表
- (void)showDownMuenTitleKey:(NSString *)key andIndex:(NSInteger )index andTitle:(NSString *)title
{
     KYActionSheetDown *sheet = [KYActionSheetDown sheetWithFrame:CGRectMake(0, 64 + 47, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 47) clicked:^(NSInteger buttonIndex, NSInteger buttonTag) {
         
     } otherButtonTitleArray:@[@"测试数据1",@"测试数据2",@"测试数据3",@"测试数据4"]];
    sheet.oldSelectIndex = index[oldIndex] ;
    sheet.isCustom = YES;
    sheet.titleStateType = TableViewCellTitleStateTypeCenter;
    [sheet show];
    self.sheet  = sheet;
}


- (void)clickToSearch
{

    WEAKSELF;
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:@[@"新机",@"采购",@"集采"]searchBarPlaceholder:@"找商品、找商家、找品牌" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
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
//        return model.itemContentList.count;
        return 5;

    }
    

    
    else if ([model.itemType isEqualToString:@"type_Title2"]){
        return model.itemContentList.count;
    }
    
    
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ItemInfoList *model =   self.resorceArray[indexPath.section];
    if ([model.itemType isEqualToString:@"topBanner"]){
        HomeScrollCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeScrollCellIDS forIndexPath:indexPath];
        NSMutableArray *listArr = [[NSMutableArray alloc] init];
        for (ItemContentList *items in  model.itemContentList) {
            [listArr addObject:items.imageUrl];
        }
        cell.modelArray = listArr;
        return cell;
        
    }
    else  if ([model.itemType isEqualToString:@"cateList"]){
        ColumnCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:columnCellID forIndexPath:indexPath];
        if (!cell) {
            cell = [ColumnCell new];
        }
        cell.model = model.itemContentList[0];
        return cell;
        
    }
   
    else if ([model.itemType isEqualToString:@"type_Title2"]){
        NewProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:newProductCell forIndexPath:indexPath];
        if (!cell) {
            cell = [NewProductCell new];
        }
        cell.model = model.itemContentList[indexPath.row];;
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
    
    return CGSizeMake((SCREEN_WIDTH - 30)/2, 285);
    
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
    
    if ([model.itemType isEqualToString:@"type_Title2"]){
        return UIEdgeInsetsMake(5, 10, 0, 10);//商品cell
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);

}



- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    ItemInfoList *model =   self.resorceArray[section];
    
    if ([model.itemType isEqualToString:@"type_Title2"]){
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
        if ([model.itemType isEqualToString:@"type_Title2"]){
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
    
 
    
    if ([model.itemType isEqualToString:@"cateList"]){
        if (indexPath.row == 4) {
            GoodsClassVC *VC = [[GoodsClassVC alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            return;
        }
        
    }
    /// 商品类型=1:新机。2:配构件。3:整机流转
    GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                 navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    //    vc.productID = model.mainResult.mainId;
    //    vc.typeStr = model.productType;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: vc animated:YES];
    //
    
    
}

@end
