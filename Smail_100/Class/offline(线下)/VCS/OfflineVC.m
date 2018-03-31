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
    
  
}


- (void)requestListNetWork
{
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
                NSMutableArray *imgList = [[NSMutableArray alloc] init];
                for (Banners *banner in bannerList) {
                    [imgList addObject:banner.pict_url];
                }
                _cycleView.imageURLStringsGroup = imgList;
                if (weakSelf.page == 0) {
                    [weakSelf.resorceArray removeAllObjects];
                }
                [weakSelf.resorceArray addObjectsFromArray:listArray];
                [weakSelf.tableView reloadData];
                [weakSelf setRefreshs];
            }
        }else{
            [weakSelf showHint:msg];
            
        }
    }];
}


- (void)setNavationView
{
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
    self.leftNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftNaviBtn setImage:[UIImage imageNamed:@"muban1@3x.png"] forState:UIControlStateNormal];
    [self.leftNaviBtn setImage:[UIImage imageNamed:@"muban1@3x.png"] forState:UIControlStateHighlighted];
    [self.leftNaviBtn setTitle:[KX_UserInfo sharedKX_UserInfo].city?[KX_UserInfo sharedKX_UserInfo].city:@"深圳" forState:UIControlStateNormal];
    self.leftNaviBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.leftNaviBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    self.leftNaviBtn.backgroundColor=[UIColor clearColor];
    [self.leftNaviBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:self.leftNaviBtn];
    self.navigationItem.leftBarButtonItem = rightButton;
    [self.leftNaviBtn sizeToFit];
    
    [self.leftNaviBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
    UIView * headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, kHeaderViewHeight+10);
    _headerView = headerView;
//    [self.view addSubview:headerView];
    self.tableView.tableHeaderView = _headerView;
    
    [self setRightNaviBtnImage:[UIImage imageNamed:@"shouye18@3x.png"]];

    
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125) delegate:self placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW]];
    [headerView addSubview:cycleView];
    self.cycleView = cycleView;
    
    LineRecommendedView *teamPersenView = [[LineRecommendedView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cycleView.frame), SCREEN_WIDTH, 145)];
    [headerView addSubview:teamPersenView];
    self.teamPersenView = teamPersenView;
    
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
//    GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
//                                                 navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
//    //    vc.productID = model.mainResult.mainId;
//    //    vc.typeStr = model.productType;
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController: vc animated:YES];
    
    OffLineDetailVC *VC = [[OffLineDetailVC alloc] init];
    OffLineModel *model = self.resorceArray[indexPath.row];
    VC.model = model;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    self.topSreenView.backgroundColor = [UIColor redColor];
    return self.topSreenView;
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

-(void)setRefreshs
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
    }
    return _topSreenView;
}

@end
