//
//  HomeVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/3.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "HomeVC.h"
#import "PYSearchViewController.h"
#import "HomeScrollCell.h"
#import "ColumnCell.h"
#import "HomeVModel.h"
#import "HomeHeaderView.h"
#import "NewProductCell.h"
#import "HomeFootView.h"
#import "FinancialCellCell.h"
#import "InsuranceCellCell.h"

#import "ItemContentList.h"

#import "ColumnModel.h"
#import "TimeLimtKillCell.h"

//#import "GoodsNewsVC.h"

#import "LoginVModel.h"
#import "TimelimitCell.h"
#import "RecommendedView.h"

#import "GoodsDetailVC.h"

#import "TimeLimtCollectCell.h"

@interface HomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PYSearchViewControllerDelegate,HomePageCycScrollViewDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong)  UITextField *inPutTextField;
@property (nonatomic, strong)   NSMutableArray *titltArray ; ///标题

@end

@implementation HomeVC
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
    
    //    [self cheackAccoutRequest];

    [self getHomeGoodsRequest:_categoryId?_categoryId:@"22"];

    WEAKSELF
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getHomeGoodsRequest:_categoryId?_categoryId:@"22"];
    }];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    


}

#pragma mark - request

/// 获取首页商品
- (void)getHomeGoodsRequest:(NSString *)categoryId
{
    WEAKSELF;
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:categoryId  forKey:@"category_id"];
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


///检查账号是否有异常
- (void)cheackAccoutRequest
{
    if (!KX_NULLString([KX_UserInfo sharedKX_UserInfo].accout)) {
        WEAKSELF;
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        [param setObject:[KX_UserInfo  sharedKX_UserInfo].accout  forKey:@"account"];
        [param setObject:[KX_UserInfo  sharedKX_UserInfo].pwd  forKey:@"password"];
        [param setObject:@"1" forKey:@"type"];
        [LoginVModel getLoginStateParam:param SBlock:^( BOOL isSuccess) {
            if (isSuccess) {
                [weakSelf updetaUserInfoRequest];
            }
            else{
                SuccessView *successV = [[SuccessView alloc] initWithTrueCancleTitle:@"您的账号出现异常，请重新登录，如若不是本人操作，请联系管理员~" cancelTitle:@"" clickDex:^(NSInteger clickDex) {
                    if (clickDex == 1) {
                        [KX_UserInfo presentToLoginView:self];

                    }}];
                [successV showSuccess];
            }
        }];
        
    }
}

///更新用户数据
- (void)updetaUserInfoRequest
{
    if (!KX_NULLString([KX_UserInfo sharedKX_UserInfo].accout)) {
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].accout forKey:@"account"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].pwd forKey:@"password"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
        [LoginVModel getMemberInfoParam:param SBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                
            }
        }];
        
    }
}



#pragma mark - private
/// 配置基础设置
- (void)setConfiguration
{
    self.title = @"首页";
    //轮播图
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeScrollCell" bundle:nil] forCellWithReuseIdentifier:imageCellIdentifier];
    ///栏目
    [self.collectionView registerNib:[UINib nibWithNibName:@"ColumnCell" bundle:nil] forCellWithReuseIdentifier:columnCellID];
    ///限时抢购
//    [self.collectionView registerNib:[UINib nibWithNibName:@"TimeLimtCollectCell" bundle:nil] forCellWithReuseIdentifier:timelimitCellID];
    [self.collectionView registerClass:[TimeLimtCollectCell class] forCellWithReuseIdentifier:timelimitCellID];
    
    
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
}


/// 初始化视图
- (void)setup
{
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    layout.sectionInset = UIEdgeInsetsZero;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44- 44) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}



- (void)popVC
{
//    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
//        [KX_UserInfo presentToLoginView:self];
//        return;
//    }
    CityViewController *controller = [[CityViewController alloc] init];
    [[KX_UserInfo sharedKX_UserInfo] loadUserInfoFromSanbox];
    if (!KX_NULLString([KX_UserInfo sharedKX_UserInfo].city)) {
        controller.currentCityString = [KX_UserInfo sharedKX_UserInfo].city;
    }
    WEAKSELF;
    controller.selectString = ^(NSString *string){
        LOG(@" 城市 = %@",string);
        [[KX_UserInfo sharedKX_UserInfo] loadUserInfoFromSanbox];
        [KX_UserInfo sharedKX_UserInfo].city = string;
        [[KX_UserInfo sharedKX_UserInfo] saveUserInfoToSanbox];
//        [weakSelf.leftNaviBtn setTitle:string forState:UIControlStateNormal];
//        [weakSelf.leftNaviBtn sizeToFit];
//        [weakSelf.leftNaviBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
    };
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)didClickRightNaviBtn
{
//    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
//        [KX_UserInfo presentToLoginView:self];
//        return;
//    }
//    BMapSearchVC *VC = [[BMapSearchVC alloc] init];
//    VC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:VC animated:YES];
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
    

    else if ([model.itemType isEqualToString:@"rushPurchaseContent"]){
        return 1;
    }

    
    else if ([model.itemType isEqualToString:@"action"]){
        return 1;
    }
    
    
    if ([model.itemType isEqualToString:@"themeBanner"]) {
        return 1;
    }
  

    
    else if ([model.itemType isEqualToString:@"recommended_ware"]){
        return model.itemContentList.count;
    }
    
   
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ItemInfoList *model =   self.resorceArray[indexPath.section];

    if ([model.itemType isEqualToString:@"topBanner"]){
     HomeScrollCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageCellIdentifier forIndexPath:indexPath];
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
        cell.model = model.itemContentList[indexPath.row];
      return cell;
        
    }
    
 else if ([model.itemType isEqualToString:@"rushPurchaseContent"]){
        TimeLimtCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:timelimitCellID  forIndexPath:indexPath];
        if (!cell) {
            cell = [TimeLimtCollectCell new];
        }
        cell.model = model;
        return cell;
        
        
    }
 else if ([model.itemType isEqualToString:@"action"]){
     TimeLimtKillCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TimeLimtKillCellID  forIndexPath:indexPath];
     if (!cell) {
         cell = [TimeLimtKillCell new];
     }
     NSMutableArray *listArr = [[NSMutableArray alloc] init];
     for (ItemContentList *items in  model.itemContentList) {
         [listArr addObject:items.imageUrl];
     }
     cell.modelArray = listArr;
     return cell;
     
 }
    
       else if ([model.itemType isEqualToString:@"themeBanner"]) {
        HomeScrollCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageCellIdentifier forIndexPath:indexPath];
        NSMutableArray *listArr = [[NSMutableArray alloc] init];
        for (ItemContentList *items in  model.itemContentList) {
            [listArr addObject:items.imageUrl];
        }
        cell.modelArray = listArr;
//        cell.newsList = _newsList;
        cell.backgroundColor = [UIColor clearColor];
        cell.delegate = self;
        return cell;
    }
    
    else if ([model.itemType isEqualToString:@"recommended_ware"]){
        NewProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:newProductCell forIndexPath:indexPath];
        if (!cell) {
            cell = [NewProductCell new];
        }
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
    
    else if ([model.itemType isEqualToString:@"rushPurchaseContent"]){
        return CGSizeMake(SCREEN_WIDTH, 160);
    }
    
    
    else if ([model.itemType isEqualToString:@"action"]){
        return CGSizeMake(SCREEN_WIDTH , 200);
    }
    else if ([model.itemType isEqualToString:@"themeBanner"])
    {
        return CGSizeMake(SCREEN_WIDTH, 105 *hScale);

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
    if ([model.itemType isEqualToString:@"action"]){
        return UIEdgeInsetsMake(5, 0, 0, 0);
    }
    else if ([model.itemType isEqualToString:@"recommended_ware"]){
        return UIEdgeInsetsMake(5, 10,0, 10);//商品cell

    }
    return UIEdgeInsetsMake(5, 10, 5, 10);//商品cell
}


//item 列间距(纵)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    ItemInfoList *model =   self.resorceArray[section];

    if ([model.itemType isEqualToString:@"recommended_ware"]){
        return 5;//商品cell
    }
    return 0;
}
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    ItemInfoList *model =   self.resorceArray[section];

   if ([model.itemType isEqualToString:@"rushPurchaseContent"]){
        return CGSizeMake(SCREEN_WIDTH , 44);
    }
    
   else if ([model.itemType isEqualToString:@"themeBanner"]){
       return CGSizeMake(SCREEN_WIDTH , 50);
    }
    
    
    return CGSizeZero;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    ItemInfoList *model =   self.resorceArray[section];

    if ([model.itemType isEqualToString:@"themeBanner"]){
        return CGSizeMake(SCREEN_WIDTH , 50);
    }

    return CGSizeZero;
}



- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
        if (kind == UICollectionElementKindSectionHeader) {
            ItemInfoList *model =  self.resorceArray[indexPath.section];
            if ([model.itemType isEqualToString:@"rushPurchaseContent"]){
                HomeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:homeStoreHeaderViewIdentifier forIndexPath:indexPath];
                headerView.didClickMoreBtnBlock = ^(){

                };
                return headerView;
            }
            
            else if ([model.itemType isEqualToString:@"themeBanner"]){
                RecommendedView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:RecommendedViewIdentifier forIndexPath:indexPath];
                headerView.titleLB.text = @"-- 主题推荐 --";
                headerView.detailLB.text = @"都是你的兴趣";
                return headerView;
            }
            
      
            return nil;

        }
    
        else if (kind == UICollectionElementKindSectionFooter) {
            ItemInfoList *model =  self.resorceArray[indexPath.section];

//            if (indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5 || indexPath.section == 6 || indexPath.section == 7) {
//                HomeFootView *footerView  = [collectionView  dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:homeFooterView forIndexPath:indexPath];
//                footerView.backgroundColor = [UIColor clearColor];
//                return footerView;
//            }
            
           if ([model.itemType isEqualToString:@"themeBanner"]){
                RecommendedView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"RecommendedViewID"
                                                                                        forIndexPath:indexPath];
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
    /// 商品类型=1:新机。2:配构件。3:整机流转
    GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                 navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
//    vc.productID = model.mainResult.mainId;
//    vc.typeStr = model.productType;
    vc.productID = contenModle.goods_id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: vc animated:YES];
    
//
    

}


#pragma mark - HomePageCycScrollViewDelegate
/** 点击图片回调 */
- (void)didSelectCycleScrollViewItemAtIndex:(NSInteger)index
{
    

}


@end
