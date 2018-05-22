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
#import "shoppingCarVM.h"
#import "GoodsAuctionXYVC.h"
#import "GoodsScreeningVC.h"
#import "GoodsVModel.h"

/// VC
#import "ClouldPhoneVC.h"
#import "GoodsScreeningVC.h"
#import "SIDADView.h"
#import "GoodsClassVC.h"
#import "KYGotoHeaderAndShowCountView.h"


@interface HomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PYSearchViewControllerDelegate,HomePageCycScrollViewDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong)  UITextField *inPutTextField;
@property (nonatomic, strong)   NSMutableArray *itemsArr ; ///商品
@property(nonatomic,assign)NSUInteger page;
@property (nonatomic,weak) KYGotoHeaderAndShowCountView *countView;

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
    [self getShowInfoRequest];

    WEAKSELF
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf getHomeGoodsRequest:_categoryId?_categoryId:@"44"];
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf getRecommendedRequest];
    }];
    [self .collectionView.mj_header beginRefreshing];


}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"click+%@",_categoryId]];
    if (KX_NULLString(str)) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:[NSString stringWithFormat:@"click+%@",_categoryId]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [self addShowCountView];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.countView removeGotoHeaderAndShowCountView];
}

#pragma mark - request

/// 获取首页商品
- (void)getHomeGoodsRequest:(NSString *)categoryId
{
    WEAKSELF;
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:categoryId  forKey:@"category_id"];
    [param setObject:@"1"  forKey:@"is_home"];
    [param setObject:@"1"  forKey:@"pos"];

    [HomeVModel getHomGoodsParam:param successBlock:^(NSArray<ItemContentList *> *dataArray, BOOL isSuccess) {
        if (weakSelf.resorceArray.count >0) {
            [weakSelf.resorceArray removeAllObjects];
        }
        [weakSelf.resorceArray addObjectsFromArray: dataArray];
        [weakSelf getRecommendedRequest];
    }];
    
}

- (void)getRecommendedRequest
{
    WEAKSELF;
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:@"1"  forKey:@"pos"];
    [param setObject:_categoryId  forKey:@"category_id"];
    [param setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageno"];
    [param setObject:@"10" forKey:@"page_size"];

    [HomeVModel getHomeNewsParam:param successBlock:^(ItemInfoList *listModel, BOOL isSuccess) {
        if (isSuccess) {
            if (listModel.itemContentList.count>0) {
                [weakSelf.resorceArray removeLastObject];
                if (weakSelf.page == 1) {
                    [weakSelf.itemsArr removeAllObjects];
                }
                [weakSelf.itemsArr addObjectsFromArray:listModel.itemContentList];
                
                listModel.itemContentList = weakSelf.itemsArr;
                [weakSelf.resorceArray addObject:listModel];
                [weakSelf.collectionView reloadData];
    
            }
        }
        [self stopRefresh];

    }];
}


/// 获取顶部弹出框
- (void)getShowInfoRequest
{
    WEAKSELF;


    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:_categoryId  forKey:@"category_id"];
    [BaseHttpRequest postWithUrl:@"/mall/getpopup" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
        
            if ([result[@"data"][@"clickType"] isEqualToString:@"web"]) {
                    SIDADView *adView = [[SIDADView alloc]init];
                adView.didClickImageBlock = ^{
                    if ([result[@"data"][@"clickType"] isEqualToString:@"web"]) {
                        if (KX_NULLString(result[@"data"][@"url"])) {
                            return;
                        }
                        GoodsAuctionXYVC *VC = [GoodsAuctionXYVC new];
                        VC.clickUrl = result[@"data"][@"url"] ;
                        VC.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:VC animated:YES];
                    }
                    else if ([result[@"data"][@"clickType"] isEqualToString:@"app_category"]){
                        GoodsScreeningVC *VC = [[GoodsScreeningVC alloc] init];
                        VC.hidesBottomBarWhenPushed = YES;
                        VC.category_id = result[@"data"][@"id"];
                        VC.title = result[@"data"][@"title"];
                        [self.navigationController pushViewController:VC animated:YES];
                    }
                    else {
                        /// 商品类型=1:新机。2:配构件。3:整机流转
                        GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                                     navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
                        vc.productID = result[@"data"][@"id"];
                        vc.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController: vc animated:YES];
                    }
                };
                    [adView showInView:self.view.window withFaceInfo:result[@"data"][@"imageUrl"] advertisementImage:[UIImage imageNamed:DEFAULTIMAGEW3] borderColor:nil];
            }else{
                [weakSelf systemAlertWithTitle:@"通知" andMsg:result[@"data"][@"content"]];
            }

        }
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
    
    _page = 1;
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    layout.sectionInset = UIEdgeInsetsZero;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44- _bottomHeight) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (void) addShowCountView
{
    KYGotoHeaderAndShowCountView *countView = [KYGotoHeaderAndShowCountView shareFKHeaderAndShowCountViewWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60 , SCREEN_HEIGHT - 220, 40, 40) view:self.view block:^{
        [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
//    countView.backgroundColor = [UIColor redColor];
    self.countView = countView;
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


///  加入购物车
- (void)addGoodsInCar:(ItemContentList *)model{
//    WEAKSELF;
//    [MBProgressHUD showMessag:@"添加收藏..." toView:self.view];
//    model.cartNum = @"1";
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setObject:model.id  forKey:@"goods_id"];
//    [param setObject:@"add" forKey:@"method"];
//    [param setObject:@"Maker" forKey:@"type"];
//    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
//    [GoodsVModel getGoodCollectParam:param successBlock:^(BOOL isSuccess, NSString *msg) {
//
//        [weakSelf.view makeToast:msg];
//        if (isSuccess) {
//        }
//    }];
   
}


- (NSMutableArray *)itemsArr
{
    if (_itemsArr == nil) {
        _itemsArr = [[NSMutableArray alloc] init];
    }
    return _itemsArr;
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
//    return 1;

    return self.resorceArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    ItemInfoList *model =   self.resorceArray[section];
    if ([model.itemType isEqualToString:@"topBanner"]) {
        if (model.itemContentList.count >0) {
            return 1;
        }
      return 0;
    }
    
    else if ([model.itemType isEqualToString:@"cateList"]){
        return model.itemContentList.count;
    }
    
    else if ([model.itemType isEqualToString:@"recommended_goods"]){
        if (model.itemContentList.count >0) {
         return 1;
        }
        return 0;
       
    }
    
    else if ([model.itemType isEqualToString:@"action"]){
        return 0;
    }
    
    if ([model.itemType isEqualToString:@"themeBanner"]) {
        return 0;
    }
    
    else if ([model.itemType isEqualToString:@"recommended_ware"]){
        return model.itemContentList.count;
    }
   
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ItemInfoList *model =   self.resorceArray[indexPath.section];
    WEAKSELF;
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
        if (model.itemContentList.count>0) {
            cell.model = model.itemContentList[indexPath.row];

        }
      return cell;
        
    }
    
 else if ([model.itemType isEqualToString:@"recommended_goods"]){
        TimeLimtCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:timelimitCellID  forIndexPath:indexPath];
        if (!cell) {
            cell = [TimeLimtCollectCell new];
        }
   
        cell.didClickItemBlock = ^(ItemContentList *model) {
         GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                      navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];

         vc.productID = model.id;
         vc.hidesBottomBarWhenPushed = YES;
         [weakSelf.navigationController pushViewController: vc animated:YES];
         
     };
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
//    else if ([model.itemType isEqualToString:@"themeBanner"]) {
//        HomeScrollCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageCellIdentifier forIndexPath:indexPath];
//        NSMutableArray *listArr = [[NSMutableArray alloc] init];
//        for (ItemContentList *items in  model.itemContentList) {
//            [listArr addObject:items.imageUrl];
//        }
//        
//        cell.modelArray = listArr;
//        cell.backgroundColor = [UIColor clearColor];
//        cell.delegate = self;
//        return cell;
//    }
    
    else if ([model.itemType isEqualToString:@"recommended_ware"]){
        
        NewProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:newProductCell forIndexPath:indexPath];
        if (!cell) {
            cell = [NewProductCell new];
        }
        cell.didClickCellBlock = ^(ItemContentList *model) {
            [weakSelf addGoodsInCar:model];
        };
        if (model.itemContentList.count>0) {
             cell.model = model.itemContentList[indexPath.row];
        }
       
        return cell;
    }
    return nil;
}


//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemInfoList *model =   self.resorceArray[indexPath.section];
    if ([model.itemType isEqualToString:@"topBanner"]) {
        return CGSizeMake(SCREEN_WIDTH, 200 *hScale);
    }
    else if ([model.itemType isEqualToString:@"cateList"]){
        if (model.itemContentList.count <5) {
            return CGSizeMake((SCREEN_WIDTH)/model.itemContentList.count ,72 );
        }
        return CGSizeMake((SCREEN_WIDTH)/5 ,72 );
    }
    else if ([model.itemType isEqualToString:@"recommended_goods"]){
        return CGSizeMake(SCREEN_WIDTH, 145);
    }
//
////    else if ([model.itemType isEqualToString:@"action"]){
////        return CGSizeMake(SCREEN_WIDTH , 200);
////    }
//    else if ([model.itemType isEqualToString:@"themeBanner"])
//    {
//        return CGSizeMake(SCREEN_WIDTH, 105 *hScale);
//    }
   ItemContentList *item =  model.itemContentList[indexPath.row];
    if (item.tags.count >0) {
        return CGSizeMake((SCREEN_WIDTH - 2)/2, 310 *(hScale>0?(hScale - 0.05): hScale));
    }
    if (item.tags.count >=6) {
        return CGSizeMake((SCREEN_WIDTH - 2)/2, 320*(hScale>0?(hScale - 0.05):hScale));
    }
    return CGSizeMake((SCREEN_WIDTH - 2)/2, 290*(hScale>0?(hScale - 0.05):hScale));

}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    ItemInfoList *model =   self.resorceArray[section];
    if ([model.itemType isEqualToString:@"topBanner"]) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    if ([model.itemType isEqualToString:@"cateList"]){
        if (model.itemContentList.count >0) {
            return UIEdgeInsetsMake(0, 0, 5, 0);
        }
        return UIEdgeInsetsMake(0, 0, 0, 0);

    }
    
    //    if ([model.itemType isEqualToString:@"rushPurchaseHeader"]){
    //        return UIEdgeInsetsMake(5, 12, 0, 12);
    //    }
    //
    if ([model.itemType isEqualToString:@"recommended_goods"]){
        if (model.itemContentList.count >0) {
            return UIEdgeInsetsMake(5, 0, 0, 0);
        }
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //    if ([model.itemType isEqualToString:@"action"]){
    //        return UIEdgeInsetsMake(0, 0, 0, 0);
    //    }
    else if ([model.itemType isEqualToString:@"recommended_ware"]){
        return UIEdgeInsetsMake(5, 0, 0, 0);//商品cell
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);//商品cell
    
}


//item 列间距(纵)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    ItemInfoList *model =   self.resorceArray[section];
    if ([model.itemType isEqualToString:@"recommended_ware"]){
        return 2;//商品cell
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    ItemInfoList *model =   self.resorceArray[section];
    if ([model.itemType isEqualToString:@"recommended_ware"]){
        return 2;//商品cell
    }
    return 0;
}


- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    ItemInfoList *model =  self.resorceArray[section];

   if ([model.itemType isEqualToString:@"recommended_ware"] || [model.itemType isEqualToString:@"recommended_goods"]){
       
       if (model.itemContentList.count >0) {
           return CGSizeMake(SCREEN_WIDTH , 44);
       }
       return CGSizeZero;
    }
    return CGSizeZero;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{

    return CGSizeZero;
}



- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
        if (kind == UICollectionElementKindSectionHeader) {
            ItemInfoList *model =  self.resorceArray[indexPath.section];
            if ([model.itemType isEqualToString:@"recommended_goods"]){
                if (self.resorceArray.count >2) {
                    ItemInfoList *models = self.resorceArray[2];
                    HomeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:homeStoreHeaderViewIdentifier forIndexPath:indexPath];
                    headerView.model = models.itemContentList[indexPath.row];
                    headerView.didClickMoreBtnBlock = ^(){
                        
                    };
                    return headerView;
                }
                return nil;
                
            }
            
            else if ([model.itemType isEqualToString:@"recommended_ware"]){
                RecommendedView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:RecommendedViewIdentifier forIndexPath:indexPath];


                headerView.titleLB.text = @"-- 精品推荐 --";
                headerView.detailLB.text = @"每日为您推荐最新火爆单品";
                return headerView;
            }
            
      
            return nil;

        }
    
        else if (kind == UICollectionElementKindSectionFooter) {
            ItemInfoList *model =  self.resorceArray[indexPath.section];
           if ([model.itemType isEqualToString:@"themeBanner"]){
                RecommendedView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"RecommendedViewID"
                                                                                        forIndexPath:indexPath];
                headerView.titleLB.text =  @"-- 商品推荐 --";
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

    if ([contenModle.clickType isEqualToString:@"web"]) {
        if (KX_NULLString(contenModle.url)) {
            return;
        }
        GoodsAuctionXYVC *VC = [[GoodsAuctionXYVC alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        VC.clickUrl = contenModle.url;

        [self.navigationController pushViewController:VC animated:YES];
    }
    else if ([contenModle.clickType isEqualToString:@"app_category"]){
        GoodsScreeningVC *VC = [[GoodsScreeningVC alloc] init];
        VC.category_id = contenModle.id;
        VC.hidesBottomBarWhenPushed = YES;
        VC.title =  contenModle.itemTitle;

        [self.navigationController pushViewController:VC animated:YES];
    }else if ([contenModle.clickType isEqualToString:@"cloud_device"]){//我的云设备
        ClouldPhoneVC *VC = [[ClouldPhoneVC alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
        return;
        
    }else if([contenModle.clickType isEqualToString:@"goods_cate"]){
        
        
        //else if ([contenModle.clickType isEqualToString:@"goods_cate"]){}
        //产品分类
        GoodsClassVC *VC = [[GoodsClassVC alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        VC.title =  contenModle.itemTitle;
        [self.navigationController pushViewController:VC animated:YES];
        return;
        
    }
    else {
        
        if (KX_NULLString(contenModle.goods_id) ) {
            [self.view makeToast:@"该活动暂未开始，请等通知"];
            return;
        }
        GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                     navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        //    vc.productID = model.mainResult.mainId;
        //    vc.typeStr = model.productType;
        vc.productID = contenModle.goods_id;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController: vc animated:YES];
    }
    

}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0)
{
//    if(indexPath.section != 0  )
//    {
//        NSInteger cCount = (indexPath.row + 3) ;
//        [self.countView fkGotoHeaderAndShowCountViewWhitCurrentCout:indexPath.row max:_itemsArr.count];
//    }
    [self.countView fkGotoHeaderAndShowCountViewWhitCurrentCout:indexPath.row max:self.itemsArr.count];

}


#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.countView fkGotoHeaderAndShowCountViewWithScrollView:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.countView fkGotoHeaderAndShowCountViewWithScrollView:scrollView];
}

#pragma mark - HomePageCycScrollViewDelegate
/** 点击图片回调 */
- (void)didSelectCycleScrollViewItemAtIndex:(NSInteger)index
{
    
    
//    ItemInfoList *model =   self.resorceArray[indexPath.section];
    for (ItemInfoList *model  in self.resorceArray) {
        if ([model.itemType isEqualToString:@"topBanner"]) {
            ItemContentList *contenModle =  model.itemContentList[index];
    
            if ([contenModle.clickType isEqualToString:@"web"]) {
                if (KX_NULLString(contenModle.url)) {
                    return;
                }
                GoodsAuctionXYVC *VC = [GoodsAuctionXYVC new];
                VC.clickUrl = contenModle.url;
                VC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:VC animated:YES];
            }
            else if ([contenModle.clickType isEqualToString:@"app_category"]){
                GoodsScreeningVC *VC = [[GoodsScreeningVC alloc] init];
                VC.hidesBottomBarWhenPushed = YES;
                VC.category_id = contenModle.id;
                VC.title =  contenModle.itemTitle;
                [self.navigationController pushViewController:VC animated:YES];
            }
            else {
                if (KX_NULLString(contenModle.id) ) {
                    [self.view makeToast:@"该活动暂未开始，请等通知"];
                    return;
                }
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

-(void)stopRefresh
{
    [self.collectionView stopFresh:self.itemsArr.count pageIndex:self.page];
    if (self.itemsArr.count == 0) {
        [self.collectionView addSubview:[KX_LoginHintView notDataView]];
    }else{
        [KX_LoginHintView removeFromSupView:self.collectionView];
    }
    
}


@end
