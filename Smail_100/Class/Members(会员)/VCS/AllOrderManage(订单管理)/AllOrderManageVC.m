//
//  AllOrderManageVC.m
//  MyCityProject
//
//  Created by Faker on 17/6/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "AllOrderManageVC.h"
#import "SegmentTapView.h"
#import "FlipTableView.h"
//#import "ManagementVC.h"
#import "OrderManagementVC.h"
#import "WJSegmentMenuVc.h"
#import "PYSearchViewController.h"
#import "GoodsScreenVmodel.h"
#import "GoodsScreenListModel.h"
@interface AllOrderManageVC ()
@property (strong, nonatomic) NSMutableArray *controllsArray;
@property(nonatomic,assign) NSInteger mySelectIndex;

@property (strong, nonatomic)  OrderManagementVC *allVC;
@property (strong, nonatomic)  OrderManagementVC *waitVC;
@property (strong, nonatomic)  OrderManagementVC *signingVC;
@property (strong, nonatomic)  OrderManagementVC *waitSendVC;
@property (strong, nonatomic)  OrderManagementVC *didSendVC;
@property (strong, nonatomic)  OrderManagementVC *closedVC;

@property (nonatomic, strong) NSArray *hotSeaches;
@property (nonatomic, strong)  NSString   *keyWord; ///关键字筛选

@property (nonatomic, strong)  NSArray *contollers;

@property (nonatomic, assign)  NSInteger index;

@end

@implementation AllOrderManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfiguration];
    [self setup];
    [self gettHotSearchRequest];
    
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

/// 初始化视图
- (void)setup
{
//    48@3x.png
    
    [self setRightNaviBtnImage:[UIImage imageNamed:@"48@3x.png"]];
    /* 创建WJSegmentMenuVc */
    WJSegmentMenuVc *segmentMenuVc = [[WJSegmentMenuVc alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    [self.view addSubview:segmentMenuVc];
    
    /* 自定义设置(可不设置为默认值) */
    segmentMenuVc.backgroundColor = [UIColor whiteColor];
    segmentMenuVc.titleFont = PLACEHOLDERFONT;
    segmentMenuVc.unlSelectedColor = [UIColor darkGrayColor];
    segmentMenuVc.selectedColor = BACKGROUND_COLORHL;
    segmentMenuVc.MenuVcSlideType = WJSegmentMenuVcSlideTypeSlide;
    segmentMenuVc.SlideColor = [UIColor clearColor];
    segmentMenuVc.advanceLoadNextVc = NO;

    //    NewOrderTitleType,                  /// 新机
    //    AccessoriesOrderTitleType,          ///配件
    //    WholeOrderTitleType,                ///整机
    //    SharedOrderTitleType,               ///  整机流转 &  共享
    //    GoodsOrderTitleType,                ///  二手
    //    DetectionrderTitleType,             ///  检测
    //    BuyOrderTitleType,                  ///  集采
    //    AuctionOrderTitleType,              /// 拍卖
    NSArray *titleArr ;
    
  
    self.title = @"商场订单";
    titleArr = @[@"全部",@"待付款",@"待发货",@"待收货",@"售后"];
    _allVC = [[OrderManagementVC alloc]init];
    _allVC.orderType = AllOrderType;
    _allVC.orderTypeTitle = @"";
    
    _waitVC = [[OrderManagementVC alloc]init];
    _waitVC.orderType = WaitOrderType;
    _waitVC.orderTypeTitle = @"0";
    
    _signingVC = [[OrderManagementVC alloc]init];
    _signingVC.orderType = SigningOrderType;
    _signingVC.orderTypeTitle = @"1";
    
    _waitSendVC = [[OrderManagementVC alloc]init];
    _waitSendVC.orderType = WaitSendOrderType;
    _waitSendVC.orderTypeTitle = @"4";
    
    
    _didSendVC = [[OrderManagementVC alloc]init];
    _didSendVC.orderType = DidSendOrderType;
    _didSendVC.orderTypeTitle = @"5";
    
    _closedVC = [[OrderManagementVC alloc]init];
    _closedVC.orderType = DidClosedOrderType;
    _closedVC.orderTypeTitle = @"6";
    _contollers = @[_allVC,_waitVC,_signingVC,_waitSendVC,_didSendVC,_closedVC];

      /* 导入数据 */
    [segmentMenuVc addSubVc:_contollers subTitles:titleArr];
    WEAKSELF;
    segmentMenuVc.didClickPageIndexBlock = ^(NSInteger index){
        LOG(@"index = %ld",(long)index);
        weakSelf.index = index;
        if (_contollers.count >0) {
            OrderManagementVC *VC  = [_contollers objectAtIndex:index];
            [VC requestListNetWork];
        }

    };
    
    
}

/// 配置基础设置
- (void)setConfiguration
{
    _contollers = [NSArray array];
    _index = 0;
}

-(void)didClickRightNaviBtn
{
    if (_hotSeaches.count == 0) {
        _hotSeaches = @[@"新机",@"采购",@"集采"];
    }
    WEAKSELF;
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:nil searchBarPlaceholder:@"请输入商品名称，订单号搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        if (_contollers.count >0) {
            OrderManagementVC *VC  = [_contollers objectAtIndex:weakSelf.index];
            VC.quickSearch = searchText;
            [VC requestListNetWork];
        }
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleCell;
    searchViewController.hotSearchStyle =  PYHotSearchStyleRectangleTag;

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];
    
}


@end
