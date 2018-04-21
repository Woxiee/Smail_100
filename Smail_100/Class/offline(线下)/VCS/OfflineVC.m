//
//  OfflineVC.m
//  Smile_100
//
//  Created by Faker on 2018/2/7.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "OfflineVC.h"
#import "SDCycleScrollView.h"
#import "LineRecommendedView.h"
#import "GoodsDetailVC.h"
#import "LineOffGoodsCell.h"
#import "OffLineModel.h"
#import "GoodsClassModel.h"
//view
#import "MenuView.h"
#import "TopScreenView.h"
#import "OffLineDetailVC.h"

#import "GoodsAuctionXYVC.h"
#import "GoodsScreeningVC.h"

#import "GoodsDetailVC.h"

#import "HomeVModel.h"

@interface OfflineVC ()<SDCycleScrollViewDelegate,PYSearchViewControllerDelegate,YBPopupMenuDelegate>
@property (weak, nonatomic) SDCycleScrollView  *cycleView;
@property (nonatomic, strong)  UITextField *inPutTextField;
@property (nonatomic, strong)  NSMutableArray *hotArray;
@property (weak, nonatomic) UIView *  headerView;
@property (weak, nonatomic)   LineRecommendedView *teamPersenView;
@property(nonatomic,assign)NSUInteger page;
//偏移量
//@property (assign, nonatomic) CGFloat scrollViewY;
@property (assign, nonatomic)  UIButton *selectBtn;

@property (nonatomic, strong) NSString *category_id;
@property (nonatomic, strong) NSString *xy;
@property (nonatomic, strong) NSString *order;
@property (nonatomic, strong) NSString *q;

@property (nonatomic, strong) TopScreenView *topSreenView;

@property (nonatomic, strong) NSArray *catelist;

@property (nonatomic, strong)  UIButton *item;


@end

@implementation OfflineVC
static NSString * const llineOffGoodsCell = @"LineOffGoodsCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
//    PageScrollTableViewsController * pageController = [[PageScrollTableViewsController alloc]initWithTitleArray:@[@"附近商家",@"销量优先",@"距离优先",@"评价优先"]];
//    pageController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationHeight);
//    pageController.navigationItem = self.navigationItem;
//    [self.view addSubview:pageController.view];
//    [self addChildViewController:pageController];
//    pageController.superVC = self;
    [self setup];
    [self setNavationView];
    
    
    WEAKSELF
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf requestListNetWork];
    }];
    
    [self getHoldKeyWorld];
    [self setRefresh];
}


- (void)requestListNetWork
{
    _xy = [NSString stringWithFormat:@"%@,%@",[KX_UserInfo sharedKX_UserInfo].latitude,[KX_UserInfo sharedKX_UserInfo].longitude];

    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageno"];
    [param setObject:@"20" forKey:@"page_size"];
    [param setObject:@"" forKey:@"type"];
    [param setObject:_category_id?_category_id:@"" forKey:@"category_id"];
    [param setObject:_xy?_xy:@"" forKey:@"xy"];
    [param setObject:_order?_order:@"" forKey:@"order"];
    //    [param setObject:@"" forKey:@"sort"];
    [param setObject:_q?_q:@"" forKey:@"q"];
    //    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/shop/shop_list" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单列表 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dic = result[@"data"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            NSArray *listArray  = [[NSArray alloc] init];
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                listArray = [OffLineModel mj_objectArrayWithKeyValuesArray:dic[@"list"]];
                NSArray *bannerList = [Banners mj_objectArrayWithKeyValuesArray:dic[@"banners"]];
                NSArray *catelist = [Catelist mj_objectArrayWithKeyValuesArray:dic[@"catelist"]];
                int i = 0;
                for (int j = 0; j<catelist.count; j++) {
                    if (j%5 == 0) {
                        i++;
                    }
                }
                weakSelf.teamPersenView.frame = CGRectMake(0, CGRectGetMaxY(_cycleView.frame), SCREEN_WIDTH, i*75);
               weakSelf.headerView.frame = CGRectMake(0, 0, kScreenWidth, weakSelf.cycleView.mj_h +weakSelf.teamPersenView.mj_h);

               weakSelf.teamPersenView.catelist = catelist;

                NSMutableArray *imgList = [[NSMutableArray alloc] init];
                for (Banners *banner in bannerList) {
                    [imgList addObject:banner.pict_url];
                }
                _cycleView.imageURLStringsGroup = imgList;
                if (weakSelf.page == 1) {
                    [weakSelf.resorceArray removeAllObjects];
                }
                [weakSelf.resorceArray removeAllObjects];
                [weakSelf.resorceArray addObjectsFromArray:listArray];
                [weakSelf.tableView reloadData];
                [weakSelf stopRefresh];
            }
        }else{
            [weakSelf showHint:msg];
            
        }
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
                [weakSelf.hotArray addObject:dic];
            }
        }
        
    }];
    
}

- (void)setNavationView
{
    UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cityBtn addTarget:self action:@selector(cityClick) forControlEvents:UIControlEventTouchUpInside];
    [cityBtn setImage:[UIImage imageNamed:@"20@3x.png"] forState:UIControlStateNormal];
    [cityBtn setImage:[UIImage imageNamed:@"20@3x.png"] forState:UIControlStateHighlighted];
    cityBtn.titleLabel.font = Font15;
    [cityBtn setTitle:[KX_UserInfo sharedKX_UserInfo].city forState:UIControlStateNormal];
    UIBarButtonItem *cityItem = [[UIBarButtonItem alloc] initWithCustomView:cityBtn];
    _item = cityBtn;
    [_item sizeToFit];
    [_item layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
    self.navigationItem.leftBarButtonItems  = @[cityItem];
    
    
    UIView *navationView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 120)/2, 10, SCREEN_WIDTH - 120, 30)];
    navationView.backgroundColor = [UIColor whiteColor];
    [navationView layerForViewWith:4 AndLineWidth:0];
    
    UIButton *selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    selectBtn.backgroundColor = RGB(228, 229, 230);
    [selectBtn setTitle:@"商家" forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"xianxiashangjia1@3x.png"] forState:UIControlStateNormal];
    [selectBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    selectBtn.titleLabel.font = Font15;
    [selectBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
    [selectBtn addTarget:self  action:@selector(clickToSelect:) forControlEvents:UIControlEventTouchUpInside];
    [navationView addSubview:selectBtn];
    self.selectBtn = selectBtn;
    
    UITextField *inPutTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(selectBtn.frame), 0, navationView.width -CGRectGetMaxX(selectBtn.frame), 30)];
    inPutTextField.placeholder = @"请输入搜索内容";
    inPutTextField.textColor = [UIColor whiteColor];
    inPutTextField.font = Font13;
    inPutTextField.returnKeyType = UIReturnKeySearch;
    inPutTextField.backgroundColor =[UIColor whiteColor];
    inPutTextField.borderStyle = UITextBorderStyleNone;
    [inPutTextField layerForViewWith:15 AndLineWidth:0];
    [navationView addSubview:inPutTextField];

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
    
    self.navigationItem.titleView = navationView;
    [self.tableView registerNib:[UINib nibWithNibName:@"LineOffGoodsCell" bundle:nil] forCellReuseIdentifier:llineOffGoodsCell];
    [self requestListNetWork];

    

}


- (void)setup
{
    _page = 1;
//    self.leftNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.leftNaviBtn setImage:[UIImage imageNamed:@"muban1@3x.png"] forState:UIControlStateNormal];
//    [self.leftNaviBtn setImage:[UIImage imageNamed:@"muban1@3x.png"] forState:UIControlStateHighlighted];
//    [self.leftNaviBtn setTitle:[KX_UserInfo sharedKX_UserInfo].city?[KX_UserInfo sharedKX_UserInfo].city:@"深圳" forState:UIControlStateNormal];
//    self.leftNaviBtn.titleLabel.font=[UIFont systemFontOfSize:16];
//    [self.leftNaviBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
//    self.leftNaviBtn.backgroundColor=[UIColor clearColor];
//    [self.leftNaviBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:self.leftNaviBtn];
//    self.navigationItem.leftBarButtonItem = rightButton;
//    [self.leftNaviBtn sizeToFit];
//
//    [self.leftNaviBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
    UIView * headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 280 );
    _headerView = headerView;
//    [self.view addSubview:headerView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = _headerView;
//    self.tableView
    [self setRightNaviBtnImage:[UIImage imageNamed:@"shouye18@3x.png"]];

    
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220 *hScale) delegate:self placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW]];
    [headerView addSubview:cycleView];
    self.cycleView = cycleView;
    
    LineRecommendedView *teamPersenView = [[LineRecommendedView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cycleView.frame), SCREEN_WIDTH, 0)];
    teamPersenView.didClickItemBlock = ^(Catelist *item) {

            if ([item.click_type isEqualToString:@"web"]) {
                if (KX_NULLString(item.url)) {
                    return;
                }
                GoodsAuctionXYVC *VC = [GoodsAuctionXYVC new];
                VC.clickUrl = item.url;
                VC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:VC animated:YES];
            }
            else if ([item.click_type isEqualToString:@"app_category"]){
                GoodsScreeningVC *VC = [[GoodsScreeningVC alloc] init];
                VC.hidesBottomBarWhenPushed = YES;
                VC.category_id = item.id;
                VC.title =  item.title;
                [self.navigationController pushViewController:VC animated:YES];
            }
            else {
                /// 商品类型=1:新机。2:配构件。3:整机流转
                GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                             navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
                vc.productID = item.id;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController: vc animated:YES];
            }
        
    };
    [headerView addSubview:teamPersenView];
    self.teamPersenView = teamPersenView;
    
    self.tableView.tableHeaderView = headerView;
    
}


- (void)clickToSelect:(UIButton *)sender{
    [YBPopupMenu showRelyOnView:sender titles:@[@"商家",@"商品"] icons: nil menuWidth:70 delegate:self];
}


#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    NSArray * titles = @[@"商家",@"商品"];
    NSLog(@"点击了 %@ 选项",titles[index]);
    [self.selectBtn setTitle:titles[index] forState:UIControlStateNormal];

}



- (void)clickToSearch
{
    NSMutableArray *listArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in _hotArray) {
        [listArr addObject:dic[@"keyword"]];
    }
    WEAKSELF;
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:listArr searchBarPlaceholder:@"运动户外超级品牌类日 跨店铺" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        
        for (NSDictionary *dics in _hotArray) {
            if ([searchText isEqualToString:dics[@"keyword"]]) {
                GoodsScreeningVC *VC = [[GoodsScreeningVC alloc] init];
                VC.hidesBottomBarWhenPushed = YES;
                //                VC.category_id = dics[@"id"];
                VC.goodsScreenType = GoodsScreenSerchType;
                VC.title =  searchText;
                [weakSelf.navigationController pushViewController:VC animated:YES];
                break;
            }
        }
        //        NSDictionary *dic = weakSelf.hotArray[]
        
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


- (void)cityClick
{
    WEAKSELF;
    CityViewController *controller = [[CityViewController alloc] init];
    [[KX_UserInfo sharedKX_UserInfo] loadUserInfoFromSanbox];
    if (!KX_NULLString([KX_UserInfo sharedKX_UserInfo].city)) {
        controller.currentCityString = [KX_UserInfo sharedKX_UserInfo].city;
    }
    controller.selectString = ^(NSString *string){
        LOG(@" 城市 = %@",string);
        [[KX_UserInfo sharedKX_UserInfo] loadUserInfoFromSanbox];
        [KX_UserInfo sharedKX_UserInfo].city = string;
        [[KX_UserInfo sharedKX_UserInfo] saveUserInfoToSanbox];
        [weakSelf.item setTitle:string forState:UIControlStateNormal];
        [weakSelf.item sizeToFit];
        [weakSelf.item layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
        
        [weakSelf requestListNetWork];
    };
    [self presentViewController:controller animated:YES completion:nil];
  
}

- (void)didClickRightNaviBtn
{
    self.tabBarController.selectedIndex = 3;
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resorceArray.count;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OffLineModel *model = self.resorceArray[indexPath.row];
    LineOffGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:llineOffGoodsCell];
    if (cell == nil) {
        cell = [[LineOffGoodsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:llineOffGoodsCell];
    }
    cell.model = model;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    OffLineDetailVC *VC = [[OffLineDetailVC alloc] init];
    OffLineModel *model = self.resorceArray[indexPath.row];
    VC.model = model;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 117;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.resorceArray.count >0) {
        return 45;

    }
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    self.topSreenView.backgroundColor = [UIColor redColor];
    if (self.resorceArray.count >0) {
        return self.topSreenView;

    }
    return nil;
}

-(void)setRefresh
{
    WEAKSELF;
    [self.tableView headerWithRefreshingBlock:^{
        [weakSelf loadNewDate];
    }];
    
    [self.tableView footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}


-(void)loadNewDate
{
    self.page = 1;
    [self requestListNetWork];
}

-(void)loadMoreData{
    
    self.page++;
    [self requestListNetWork];
}

-(void)stopRefresh
{
    [self.tableView stopFresh:self.resorceArray.count pageIndex:self.page];
    if (self.resorceArray.count == 0) {
        [self.tableView addSubview:[KX_LoginHintView notDataView]];
    }else{
        [KX_LoginHintView removeFromSupView:self.tableView];
    }
    
}

- (TopScreenView *)topSreenView
{
    if (_topSreenView == nil) {
       _topSreenView = [[TopScreenView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        _topSreenView.titleArray = @[@"附近商家",@"销量优先",@"距离优先",@"评价优先"];
        [_topSreenView layerForViewWith:0 AndLineWidth:0.5];
        _topSreenView.selectTopIndexBlock = ^(NSInteger index, NSString *key, NSString *title){
            
//            if (_sheet) {
//                [_sheet hiddenSheetView];
//                _sheet =nil;
//            }
//            [weakSelf showDownMuenTitleKey:key andIndex:index andTitle:title];
            
        };
        [_topSreenView layerForViewWith:0 AndLineWidth:0.5];
    }
    return _topSreenView;
}

@end
