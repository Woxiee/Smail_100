//
//  GoodsScreeningVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsScreeningVC.h"
#import "PYSearchViewController.h"
#import "GoodsScreenVmodel.h"
#import "TopScreenView.h"
#import "GoodsDetailVC.h"
#import "ItemContentList.h"
#import "NewProductCell.h"
#import "shoppingCarVM.h"

@interface GoodsScreeningVC ()<PYSearchViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)  UITextField *inPutTextField;
@property (nonatomic, weak) TopScreenView *topSreenView;
@property (nonatomic, weak) KYActionSheetDown *sheet;          /// 弹窗
@property (nonatomic, strong) Values *values;        /// 记录上一次选择collectList;
@property(nonatomic,strong)NSMutableArray *sourceData;
@property (weak, nonatomic) UICollectionView *collectionView;
@property(nonatomic,assign)NSUInteger page;
@property (nonatomic, strong) NSArray *hotSeaches;

@property (nonatomic, strong)  UIButton *item;

@end

@implementation GoodsScreeningVC
{
    NSInteger oldIndex[4] ;   /// 记录上一次选择tabelviewlist
}
static NSString *newProductCell = @"newProductID";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];

    WEAKSELF
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [self requestListNetWork];
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf requestListNetWork];
    }];
    [self .collectionView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_sheet) {
        [_sheet removeFromSuperview];
        _sheet =nil;
    }
    
 
}



#pragma mark  - requestNetWork
- (void)requestNetWork
{
    WEAKSELF
    if (KX_NULLString([KX_UserInfo sharedKX_UserInfo].ID)) {
        [KX_UserInfo sharedKX_UserInfo].ID = @"";
    }
    [MBProgressHUD showMessag:@"正在加载..." toView:self.view];

//    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:[KX_UserInfo sharedKX_UserInfo].ID ,@"mid",_typeStr,@"itemsType", nil];
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:_typeStr,@"itemsType", nil];

  [GoodsScreenVmodel getGoodsScreenParam:param WithDataList:^(NSArray *dataArray, BOOL success) {
      if (success) {
           weakSelf.topSreenView.hidden = NO;
          weakSelf.topSreenView.model = dataArray[0];
          [self.resorceArray addObjectsFromArray:dataArray];
          [self requestListNetWork];
      }
      else{
          [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
          [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];

      }
  }];
}


- (void)requestListNetWork
{
    WEAKSELF;

    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:_category_id forKey:@"category_id"];
    [param setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageIndex"];
    [param setObject:@"10" forKey:@"pageSize"];
    [GoodsScreenVmodel getGoodsScreenListParam:param WithDataList:^(NSArray *dataArray, BOOL success) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if (success) {
            if (dataArray.count>0) {
                if (weakSelf.page == 1) {
                    [weakSelf.resorceArray removeAllObjects];
                }
                [weakSelf.resorceArray addObjectsFromArray:dataArray];
                [weakSelf.collectionView reloadData];
                [weakSelf.collectionView.mj_header endRefreshing];
                [weakSelf.collectionView.mj_footer endRefreshing];
                
            }else{
                [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];

            }
           
        }else{
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }
        [weakSelf stopRefresh];
    }];

}

/// 热搜数据
- (void)gettHotSearchRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@"10" forKey:@"siteConfigId"];
    [GoodsScreenVmodel getProbuilListParam:param WithDataList:^(NSArray *dataArray, BOOL success) {
        if (success) {
            if (success) {
                GoodsScreenListModel *model = dataArray[0];
                weakSelf.hotSeaches = [model.configValue componentsSeparatedByString:NSLocalizedString(@",", nil)];
            }
        }else{
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }
    }];
}




#pragma mark - private
/// 初始化视图
- (void)setup
{
    
//    UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cityBtn addTarget:self action:@selector(cityClick) forControlEvents:UIControlEventTouchUpInside];
//    [cityBtn setImage:[UIImage imageNamed:@"20@3x.png"] forState:UIControlStateNormal];
//    [cityBtn setImage:[UIImage imageNamed:@"20@3x.png"] forState:UIControlStateHighlighted];
//    cityBtn.titleLabel.font = Font15;
//    [cityBtn setTitle:[KX_UserInfo sharedKX_UserInfo].city forState:UIControlStateNormal];
//    UIBarButtonItem *cityItem = [[UIBarButtonItem alloc] initWithCustomView:cityBtn];
//    _item = cityBtn;
//    [_item sizeToFit];
//    [_item layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
//
//
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backBtn addTarget:self action:@selector(clickLeftItem) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setImage:[UIImage imageNamed:@"18@3x.png"] forState:UIControlStateNormal];
//    [backBtn sizeToFit];
//    //    self.addBtn = addBtn;
//    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItems  = @[backBtnItem,cityItem];
//    UITextField *inPutTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 10, SCREEN_WIDTH - 135, 30)];
//
//
//    inPutTextField.placeholder = @"找商品, 找商家,找品牌";
//    inPutTextField.textColor = [UIColor whiteColor];
//    inPutTextField.font = [UIFont systemFontOfSize:13];
//    inPutTextField.returnKeyType = UIReturnKeySearch;
//    inPutTextField.backgroundColor =[UIColor whiteColor];
//    inPutTextField.borderStyle = UITextBorderStyleNone;
//    [inPutTextField layerForViewWith:5 AndLineWidth:0];
//    _inPutTextField = inPutTextField;
//    //搜索框里面的UI
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    view.backgroundColor = [UIColor clearColor];
//    inPutTextField.leftViewMode = UITextFieldViewModeAlways;
//    inPutTextField.leftView = view;
//    UIImageView * searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 14, 14)];
//    searchImage.backgroundColor = [UIColor clearColor];
//    searchImage.image = [UIImage imageNamed:@"21@3x.png"];
//    [view addSubview:searchImage];
//
//    UIButton *coverToSeach =  [[UIButton alloc]initWithFrame:CGRectMake(0, 0, inPutTextField.width, inPutTextField.height)];
//    coverToSeach.backgroundColor = [UIColor clearColor];
//    [coverToSeach addTarget:self  action:@selector(clickToSearch) forControlEvents:UIControlEventTouchUpInside];
//    [inPutTextField addSubview:coverToSeach];
//

    WEAKSELF;
    /// 顶部视图    [_titleArray addObject:@"全部分类"];
    TopScreenView *topSreenView = [[TopScreenView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    topSreenView.titleArray = @[@"全部分类",@"价格排序",@"销售优先",@"时间排序"];
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
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(topSreenView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [self setRightNaviBtnImage:[UIImage imageNamed:@"shouye18@3x.png"]];
   
}


- (void)cityClick
{
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
        [weakSelf.item setTitle:string forState:UIControlStateNormal];
        [weakSelf.item sizeToFit];
        [weakSelf.item layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
        weakSelf.region = string;
        [weakSelf requestListNetWork];
    };
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)clickLeftItem
{
    [self.navigationController popViewControllerAnimated:YES];
}


/// 配置基础设置
- (void)setConfiguration
{
    //    _seachClassId = @"";
    _keyWord = @"";


    [self.collectionView registerNib:[UINib nibWithNibName:@"NewProductCell" bundle:nil] forCellWithReuseIdentifier:newProductCell];


    self.view.backgroundColor = BACKGROUND_COLOR;

}


///搜索
- (void)clickToSearch
{
    if (_hotSeaches.count == 0) {
        _hotSeaches = @[@"新机",@"采购",@"集采"];
    }
    WEAKSELF;
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:_hotSeaches searchBarPlaceholder:@"请输入关键词搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        weakSelf.keyWord = searchText;
        [weakSelf requestListNetWork];
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

-(void)didClickRightNaviBtn
{
//    BMapSearchVC *VC = [[BMapSearchVC alloc] init];
//    VC.hidesBottomBarWhenPushed = YES;
//    //    [self presentViewController:VC animated:YES completion:nil];
//    [self.navigationController pushViewController:VC animated:YES];
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


/*懒加载*/
-(NSMutableArray *)sourceData
{
    if (!_sourceData) {
        //初始化数据
        _sourceData = [NSMutableArray array];
    }
    return _sourceData;
}


#pragma mark - refresh 添加刷新方法
-(void)setRefresh
{
    WEAKSELF;
//    [self.tableView headerWithRefreshingBlock:^{
//        [weakSelf loadNewDate];
//    }];
//    
//    [self.tableView footerWithRefreshingBlock:^{
//        [weakSelf loadMoreData];
//    }];
    
}

-(void)loadNewDate
{
    self.page = 0;
    [self requestListNetWork];
}

-(void)loadMoreData{
    
    self.page++;
    [self requestListNetWork];
}


-(void)stopRefresh
{
//    [self.tableView stopFresh:self.sourceData.count pageIndex:self.page];
//
//    if (self.sourceData.count == 0) {
//        [self.tableView addSubview:[KX_LoginHintView notDataView]];
//    }else{
//        [KX_LoginHintView removeFromSupView:self.tableView];
//    }
  
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    //    return 1;
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.resorceArray.count;

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WEAKSELF;
    NewProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:newProductCell forIndexPath:indexPath];
    if (!cell) {
        cell = [NewProductCell new];
    }
    cell.didClickCellBlock = ^(ItemContentList *model) {
        [weakSelf addGoodsInCar:model];
    };
    cell.model = self.resorceArray[indexPath.row];
    return cell;
    
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 15)/2, 285);

}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,5, 5,5);//商品cell

}

//item 列间距(纵)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 5;//商品cell

}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   ItemContentList *model = self.resorceArray[indexPath.row];
    
   
    GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                 navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    vc.productID = model.goods_id;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: vc animated:YES];
}

@end
