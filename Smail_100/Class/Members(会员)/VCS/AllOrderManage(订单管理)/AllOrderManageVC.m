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
@property (strong, nonatomic)  OrderManagementVC *receiveVC;

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
//    [self gettHotSearchRequest];
    
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
    //    segmentMenuVc.backgroundColor = [UIColor colorWithRed:240/250.0 green:240/250.0 blue:240/250.0 alpha:1];
    segmentMenuVc.titleFont = PLACEHOLDERFONT;
    segmentMenuVc.unlSelectedColor = [UIColor darkGrayColor];
    segmentMenuVc.selectedColor = KMAINCOLOR;
    segmentMenuVc.MenuVcSlideType = WJSegmentMenuVcSlideTypeSlide;
    segmentMenuVc.SlideColor = KMAINCOLOR;
    segmentMenuVc.advanceLoadNextVc = NO;
    segmentMenuVc.backgroundColor = [UIColor whiteColor];
    //    NewOrderTitleType,                  /// 新机
    //    AccessoriesOrderTitleType,          ///配件
    //    WholeOrderTitleType,                ///整机
    //    SharedOrderTitleType,               ///  整机流转 &  共享
    //    GoodsOrderTitleType,                ///  二手
    //    DetectionrderTitleType,             ///  检测
    //    BuyOrderTitleType,                  ///  集采
    //    AuctionOrderTitleType,              /// 拍卖
    NSArray *titleArr ;
    
  
    self.title = @"订单管理";
    titleArr = @[@"全部",@"待付款",@"待发货",@"待收货",@"已完成"];
    _allVC = [[OrderManagementVC alloc]init];
    _allVC.orderType = AllOrderType;
    _allVC.shipstatus = @"";
//http://39.108.4.18:6803/api/order/order_list  page_size=10&pageno=1&user_id=84561&paystatus=Pendding%2CPreview%2CFail
    _allVC.shop_id = _shop_id?_shop_id:@"";

    _waitVC = [[OrderManagementVC alloc]init];
    _waitVC.orderType = WaitOrderType;
    _waitVC.shipstatus = @"";
    _waitVC.paystatus = @"Pendding,Preview,Fail";
    _waitVC.shop_id = _shop_id?_shop_id:@"";

    _signingVC = [[OrderManagementVC alloc]init];
    _signingVC.orderType = SigningOrderType;
    _signingVC.shipstatus = @"Waiting";
    _signingVC. paystatus = @"Complete";
    _signingVC.shop_id = _shop_id?_shop_id:@"";

    _closedVC = [[OrderManagementVC alloc]init];
    _closedVC.orderType = DidClosedOrderType;
    _closedVC.shipstatus = @"Delivery";
    _closedVC.shop_id = _shop_id?_shop_id:@"";

     _receiveVC = [[OrderManagementVC alloc]init];
    _receiveVC.shipstatus = @"Receive";
    _receiveVC.orderType = HasSureOrderType;

    
    _receiveVC.shop_id = _shop_id?_shop_id:@"";
    
    
    _contollers = @[_allVC,_waitVC,_signingVC,_closedVC,_receiveVC];

/// 商家中心 订单管理 特殊化
    if (!KX_NULLString(_shop_id)) {
        self.title = @"订单管理";

        titleArr = @[@"全部",@"待付款",@"已完成"];
        
        _contollers = @[_allVC,_waitVC,_receiveVC];
    }

    
    if (_orderTitleType == OffLineTitleType) {
        self.title = @"线下订单";

        _allVC.paystatus = @"";
        _allVC.type = @"Shop";
        
        _waitVC.shop_id = _shop_id?_shop_id:@"";
        _waitVC.paystatus = @"Pendding,Preview,Fail";
        _waitVC.type = @"Shop";

        _signingVC.shop_id = _shop_id?_shop_id:@"";
        _signingVC.paystatus = @"Complete";
        _signingVC.type = @"Shop";
        
//        http://39.108.4.18:6803/api/order/order_list  page_size=10&paystatus=Complete&type=Shop&pageno=1&user_id=84561&comm_nums=1
        _closedVC.shop_id = _shop_id?_shop_id:@"";
        _closedVC.paystatus = @"Complete";
        _closedVC.type = @"Shop";
        _closedVC.comm_nums = @"1";

        titleArr = @[@"全部",@"待付款",@"待评价",@"已评价"];
        _contollers = @[_allVC,_waitVC,_signingVC,_closedVC];


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
