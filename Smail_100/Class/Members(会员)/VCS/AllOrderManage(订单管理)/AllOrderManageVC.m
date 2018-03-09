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
@property (strong, nonatomic)  OrderManagementVC *rentingVC; ///在租

@property (strong, nonatomic)  OrderManagementVC *completeVC;
@property (strong, nonatomic)  OrderManagementVC *guanVC;
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
    
    if (_orderTitleType == NewOrderTitleType) {
        self.title = @"新机订单";
        titleArr = @[@"全部",@"待审核",@"待签约",@"待发货",@"已发货",@"已收货",@"已完成",@"已关闭"];
        _allVC = [[OrderManagementVC alloc]init];
        _allVC.orderType = AllOrderType;
        _allVC.orderTypeTitle = @"1";
        
        _waitVC = [[OrderManagementVC alloc]init];
        _waitVC.orderType = WaitOrderType;
        _waitVC.orderTypeTitle = @"1";
        
        _signingVC = [[OrderManagementVC alloc]init];
        _signingVC.orderType = SigningOrderType;
        _signingVC.orderTypeTitle = @"1";

       _waitSendVC = [[OrderManagementVC alloc]init];
        _waitSendVC.orderType = WaitSendOrderType;
        _waitSendVC.orderTypeTitle = @"1";

        
        _didSendVC = [[OrderManagementVC alloc]init];
        _didSendVC.orderType = DidSendOrderType;
        _didSendVC.orderTypeTitle = @"1";

        _closedVC = [[OrderManagementVC alloc]init];
        _closedVC.orderType = DidClosedOrderType;
        _closedVC.orderTypeTitle = @"1";
        
        _completeVC = [[OrderManagementVC alloc]init];
        _completeVC.orderType = ComplteOrderType;
        _completeVC.orderTypeTitle = @"1";

        _guanVC = [[OrderManagementVC alloc]init];
        _guanVC.orderType = DownOrderType;
        _guanVC.orderTypeTitle = @"1";

        _contollers = @[_allVC,_waitVC,_signingVC,_waitSendVC,_didSendVC,_closedVC,_completeVC,_guanVC];

        
    }
    else if (_orderTitleType == AccessoriesOrderTitleType)
    {
        self.title = @"配构件订单";
        titleArr = @[@"全部",@"待审核",@"待签约",@"待发货",@"已发货",@"已收货",@"已完成",@"已关闭"];
        _allVC = [[OrderManagementVC alloc]init];
        _allVC.orderType = AllOrderType;
        _allVC.orderTypeTitle = @"2";
        
        _waitVC = [[OrderManagementVC alloc]init];
        _waitVC.orderType = WaitOrderType;
        _waitVC.orderTypeTitle = @"2";
        
        _signingVC = [[OrderManagementVC alloc]init];
        _signingVC.orderType = SigningOrderType;
        _signingVC.orderTypeTitle = @"2";
        
        _waitSendVC = [[OrderManagementVC alloc]init];
        _waitSendVC.orderType = WaitSendOrderType;
        _waitSendVC.orderTypeTitle = @"2";
        
        
        _didSendVC = [[OrderManagementVC alloc]init];
        _didSendVC.orderType = DidSendOrderType;
        _didSendVC.orderTypeTitle = @"2";
        
        _closedVC = [[OrderManagementVC alloc]init];
        _closedVC.orderType = DidClosedOrderType;
        _closedVC.orderTypeTitle = @"2";
        
        _completeVC = [[OrderManagementVC alloc]init];
        _completeVC.orderType = ComplteOrderType;
        _completeVC.orderTypeTitle = @"2";
        
        _guanVC = [[OrderManagementVC alloc]init];
        _guanVC.orderType = DownOrderType;
        _guanVC.orderTypeTitle = @"2";
        
        _contollers = @[_allVC,_waitVC,_signingVC,_waitSendVC,_didSendVC,_closedVC,_completeVC,_guanVC];
    }
    else if (_orderTitleType == GoodsOrderTitleType)
    {
        self.title = @"二手设备订单";
        titleArr = @[@"全部",@"待审核",@"待签约",@"待发货",@"已发货",@"已收货",@"已完成",@"已关闭"];
        _allVC = [[OrderManagementVC alloc]init];
        _allVC.orderType = AllOrderType;
        _allVC.orderTypeTitle = @"5";
        
        _waitVC = [[OrderManagementVC alloc]init];
        _waitVC.orderType = WaitOrderType;
        _waitVC.orderTypeTitle = @"5";
        
        _signingVC = [[OrderManagementVC alloc]init];
        _signingVC.orderType = SigningOrderType;
        _signingVC.orderTypeTitle = @"5";
        
        _waitSendVC = [[OrderManagementVC alloc]init];
        _waitSendVC.orderType = WaitSendOrderType;
        _waitSendVC.orderTypeTitle = @"5";
        
        
        _didSendVC = [[OrderManagementVC alloc]init];
        _didSendVC.orderType = DidSendOrderType;
        _didSendVC.orderTypeTitle = @"5";
        
        _closedVC = [[OrderManagementVC alloc]init];
        _closedVC.orderType = DidClosedOrderType;
        _closedVC.orderTypeTitle = @"5";
        
        _completeVC = [[OrderManagementVC alloc]init];
        _completeVC.orderType = ComplteOrderType;
        _completeVC.orderTypeTitle = @"5";
        
        _guanVC = [[OrderManagementVC alloc]init];
        _guanVC.orderType = DownOrderType;
        _guanVC.orderTypeTitle = @"5";
        
        _contollers = @[_allVC,_waitVC,_signingVC,_waitSendVC,_didSendVC,_closedVC,_completeVC,_guanVC];
    }
    else if (_orderTitleType == WholeOrderTitleType )
    {
        self.title = @"整机流转订单";
        titleArr = @[@"全部",@"待审核",@"待签约",@"待发货",@"已发货",@"在租",@"已完成",@"已关闭"];
        _allVC = [[OrderManagementVC alloc]init];
        _allVC.orderType = AllOrderType;
        _allVC.orderTypeTitle = @"3";
        _allVC.isLease = YES;
        
        _waitVC = [[OrderManagementVC alloc]init];
        _waitVC.orderType = WaitOrderType;
        _waitVC.orderTypeTitle = @"3";
        _waitVC.isLease = YES;

        _signingVC = [[OrderManagementVC alloc]init];
        _signingVC.orderType = SigningOrderType;
        _signingVC.orderTypeTitle = @"3";
        _signingVC.isLease = YES;

        _waitSendVC = [[OrderManagementVC alloc]init];
        _waitSendVC.orderType = WaitSendOrderType;
        _waitSendVC.orderTypeTitle = @"3";
        _waitSendVC.isLease = YES;

        
        _didSendVC = [[OrderManagementVC alloc]init];
        _didSendVC.orderType = DidSendOrderType;
        _didSendVC.orderTypeTitle = @"3";
        _didSendVC.isLease = YES;

   
        _rentingVC = [[OrderManagementVC alloc]init];
        _rentingVC.orderType = RentingOrderType;
        _rentingVC.orderTypeTitle = @"3";
        _rentingVC.isLease = YES;

        _completeVC = [[OrderManagementVC alloc]init];
        _completeVC.orderType = ComplteOrderType;
        _completeVC.orderTypeTitle = @"3";
        _completeVC.isLease = YES;

        _guanVC = [[OrderManagementVC alloc]init];
        _guanVC.orderType = DownOrderType;
        _guanVC.orderTypeTitle = @"3";
        _guanVC.isLease = YES;

        _contollers = @[_allVC,_waitVC,_signingVC,_waitSendVC,_didSendVC,_rentingVC,_completeVC,_guanVC];
        
    }
    else if (_orderTitleType == SharedOrderTitleType)
    {
        self.title = @"标准节共享订单";
        titleArr = @[@"全部",@"待审核",@"待签约",@"待发货",@"已发货",@"在租",@"已完成",@"已关闭"];
        _allVC = [[OrderManagementVC alloc]init];
        _allVC.orderType = AllOrderType;
        _allVC.orderTypeTitle = @"4";
        _allVC.isLease = YES;
        
        _waitVC = [[OrderManagementVC alloc]init];
        _waitVC.orderType = WaitOrderType;
        _waitVC.orderTypeTitle = @"4";
        _waitVC.isLease = YES;
        
        _signingVC = [[OrderManagementVC alloc]init];
        _signingVC.orderType = SigningOrderType;
        _signingVC.orderTypeTitle = @"4";
        _signingVC.isLease = YES;
        
        _waitSendVC = [[OrderManagementVC alloc]init];
        _waitSendVC.orderType = WaitSendOrderType;
        _waitSendVC.orderTypeTitle = @"4";
        _waitSendVC.isLease = YES;
        
        _didSendVC = [[OrderManagementVC alloc]init];
        _didSendVC.orderType = DidSendOrderType;
        _didSendVC.orderTypeTitle = @"4";
        _didSendVC.isLease = YES;
        
        _rentingVC = [[OrderManagementVC alloc]init];
        _rentingVC.orderType = RentingOrderType;
        _rentingVC.orderTypeTitle = @"4";
        _rentingVC.isLease = YES;
        
        _completeVC = [[OrderManagementVC alloc]init];
        _completeVC.orderType = ComplteOrderType;
        _completeVC.orderTypeTitle = @"4";
        _completeVC.isLease = YES;
        
        _guanVC = [[OrderManagementVC alloc]init];
        _guanVC.orderType = DownOrderType;
        _guanVC.orderTypeTitle = @"4";
        _guanVC.isLease = YES;
        
        _contollers = @[_allVC,_waitVC,_signingVC,_waitSendVC,_didSendVC,_rentingVC,_completeVC,_guanVC];
        
    }
    else if (_orderTitleType == DetectionrderTitleType)
    {
        self.title = @"检测吊运订单";
        titleArr = @[@"全部",@"待审核",@"待签约",@"待服务",@"已服务",@"已确认",@"已完成",@"已关闭"];
        _allVC = [[OrderManagementVC alloc]init];
        _allVC.orderType = AllOrderType;
        _allVC.orderTypeTitle = @"6";
        _allVC.isDetection = YES;
        
  
        
        _waitVC = [[OrderManagementVC alloc]init];
        _waitVC.orderType = WaitOrderType;
        _waitVC.orderTypeTitle = @"6";
        _waitVC.isDetection = YES;

        OrderManagementVC *singleVC = [[OrderManagementVC alloc]init];
        singleVC.orderType = SigningOrderType;
        singleVC.orderTypeTitle = @"6";
        singleVC.isDetection = YES;
        
        _signingVC = [[OrderManagementVC alloc]init];
        _signingVC.orderType = WaitServiceOrderType;
        _signingVC.orderTypeTitle = @"6";
        _signingVC.isDetection = YES;

        
        _waitSendVC = [[OrderManagementVC alloc]init];
        _waitSendVC.orderType = HasServiceOrderType;
        _waitSendVC.orderTypeTitle = @"6";
        _waitSendVC.isDetection = YES;

        
        _didSendVC = [[OrderManagementVC alloc]init];
        _didSendVC.orderType = HasSureOrderType;
        _didSendVC.orderTypeTitle = @"6";
        _didSendVC.isDetection = YES;

        
        _completeVC = [[OrderManagementVC alloc]init];
        _completeVC.orderType = ComplteOrderType;
        _completeVC.orderTypeTitle = @"6";
        _completeVC.isDetection = YES;

        _guanVC = [[OrderManagementVC alloc]init];
        _guanVC.orderType = DownOrderType;
        _guanVC.orderTypeTitle = @"6";
        _guanVC.isDetection = YES;

        _contollers = @[_allVC,_waitVC,singleVC,_signingVC,_waitSendVC,_didSendVC,_completeVC,_guanVC];

    }
    
    else if (_orderTitleType == BuyOrderTitleType)
    {
        self.title = @"集采订单";
        titleArr = @[@"已参与",@"已达成",@"已关闭"];
        
        
        _waitVC = [[OrderManagementVC alloc]init];
        _waitVC.orderType = JoinOrderType;
        _waitVC.orderTypeTitle = @"9";
        _waitVC.isCollect = YES;

        _signingVC = [[OrderManagementVC alloc]init];
        _signingVC.orderType = ComplteOrderType;
        _signingVC.orderTypeTitle = @"9";
        _signingVC.isCollect = YES;
        
        _allVC = [[OrderManagementVC alloc]init];
        _allVC.orderType = DownOrderType;
        _allVC.orderTypeTitle = @"9";
        _allVC.isCollect = YES;

        _contollers = @[_waitVC,_signingVC,_allVC];
//        segmentMenuVc.MenuVcSlideType = WJSegmentMenuVcSameWithTypeSlide;
    }
    else if (_orderTitleType == AuctionOrderTitleType)
    {
        self.title = @"拍卖订单";
        titleArr = @[@"已报名",@"已出价",@"已达成"];

        _allVC = [[OrderManagementVC alloc]init];
        _allVC.orderType = JoinOrderType;
        _allVC.orderTypeTitle = @"10";
        _allVC.isAuction = YES;
        
        _waitVC = [[OrderManagementVC alloc]init];
        _waitVC.orderType = ComplteAuctionType;
        _waitVC.orderTypeTitle = @"10";
        _waitVC.isAuction = YES;
        
        _signingVC = [[OrderManagementVC alloc]init];
        _signingVC.orderType = ComplteOrderType;
        _signingVC.orderTypeTitle = @"10";
        _signingVC.isAuction = YES;
        _contollers = @[_allVC,_waitVC,_signingVC];
//        segmentMenuVc.MenuVcSlideType = WJSegmentMenuVcSameWithTypeSlide;
    }
    
    
    if (_supplyRoleType == sellingSupplRoleType) {
        for (OrderManagementVC *VC in _contollers) {
            VC.supplListRoleType  = sellingSupplListRoleType;
        }
    }
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

//        if (_orderTitleType == NewOrderTitleType || _orderTitleType == GoodsOrderTitleType || _orderTitleType == AccessoriesOrderTitleType) {
//            OrderManagementVC *VC  = [_contollers objectAtIndex:index];
//            [VC requestListNetWork];
//
//        }
//        
//        else if (_orderTitleType == WholeOrderTitleType || _orderTitleType == SharedOrderTitleType ) {
//            OrderManagementVC *VC  = [_contollers objectAtIndex:index];
//            [VC requestListNetWork];
//        }
//
//        else if (_orderTitleType == DetectionrderTitleType ) {
//
//            switch (index ) {
//                case 0:
//                    [weakSelf.allVC  requestListNetWork];
//                    break;
//                case 1:
//                    [weakSelf.waitVC  requestListNetWork];
//                    break;
//                case 2:
//                    [weakSelf.signingVC  requestListNetWork];
//                    break;
//                case 3:
//                    [weakSelf.waitSendVC  requestListNetWork];
//                    break;
//                case 4:
//                    [weakSelf.didSendVC  requestListNetWork];
//                    break;
//                case 5:
//                    [weakSelf.completeVC  requestListNetWork];
//                    break;
//                case 6:
//                    [weakSelf.guanVC  requestListNetWork];
//                    break;
//                default:
//                    break;
//            }
//            
//        }
//        else if (_orderTitleType == BuyOrderTitleType  || _orderTitleType == AuctionOrderTitleType) {
//            switch (index ) {
//                case 0:
//                    [weakSelf.allVC  requestListNetWork];
//                    break;
//                case 1:
//                    [weakSelf.waitVC  requestListNetWork];
//                    break;
//                case 2:
//                    [weakSelf.signingVC  requestListNetWork];
//                    break;
//                default:
//                    break;
//            }
//
//        }

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
