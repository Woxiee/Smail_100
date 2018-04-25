//
//  AcctoutWater.m
//  Smail_100
//
//  Created by ap on 2018/3/15.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AcctoutWater.h"
#import "AcctoutWaterLIstVC.h"
#import "AcctouWaterMeunView.h"

@interface AcctoutWater ()
@property (nonatomic, strong) AcctoutWaterLIstVC *allVC;
@property (nonatomic, strong) AcctoutWaterLIstVC *inVC;
@property (nonatomic, strong) AcctoutWaterLIstVC *outVC;

@property(nonatomic,strong)  AcctouWaterMeunView *meunView;
@property(nonatomic,assign)  NSInteger selectIndex;
@property(nonatomic,strong)  NSArray *contollers;


@end

@implementation AcctoutWater

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

/// 初始化视图
- (void)setup
{
    //    48@3x.png
    [self setRightNaviBtnTitle:@"筛选" withTitleColor:[UIColor whiteColor]];
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
    segmentMenuVc.backgroundColor = [UIColor whiteColor];
    segmentMenuVc.advanceLoadNextVc = NO;
    
    [segmentMenuVc layerForViewWith:0 AndLineWidth:1];
    
    //    NewOrderTitleType,                  /// 新机
    //    AccessoriesOrderTitleType,          ///配件
    //    WholeOrderTitleType,                ///整机
    //    SharedOrderTitleType,               ///  整机流转 &  共享
    //    GoodsOrderTitleType,                ///  二手
    //    DetectionrderTitleType,             ///  检测
    //    BuyOrderTitleType,                  ///  集采
    //    AuctionOrderTitleType,              /// 拍卖
    NSArray *titleArr ;

    
//    self.title = @"账户流水";
    titleArr = @[@"全部",@"收入",@"支出"];
    
    _allVC = [[AcctoutWaterLIstVC alloc] init];
    _allVC.directions = @"";
  
    _inVC = [[AcctoutWaterLIstVC alloc] init];
    _inVC.directions = @"IN";
    _outVC = [[AcctoutWaterLIstVC alloc] init];
    _outVC.directions = @"OUT";
    
    
    if (!KX_NULLString(_trans_type)) {
        _allVC.trans_type = @"Transfer";
        _inVC.trans_type = @"Transfer";
        _outVC.trans_type = @"Transfer";
    }
    _contollers = @[_allVC,_inVC,_outVC];
    /* 导入数据 */
    [segmentMenuVc addSubVc:_contollers subTitles:titleArr];
    WEAKSELF;
    _selectIndex = 0;
    segmentMenuVc.didClickPageIndexBlock = ^(NSInteger index){
        weakSelf.selectIndex = index;
        if (_contollers.count >0) {
            AcctoutWaterLIstVC *VC  = [_contollers objectAtIndex:index];
            [VC requestListNetWork];
        }
    };
    
    AcctouWaterMeunView *meunView = [[AcctouWaterMeunView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 47) withtrans_type:_trans_type];
    meunView.didClickCellBlock = ^(NSString *str, NSString *str1) {
        AcctoutWaterLIstVC *VC  = [_contollers objectAtIndex:weakSelf.selectIndex];
        VC.directions = str;
        VC.type = str1;
        [VC requestListNetWork];
    };
    self.meunView = meunView;
}



///筛选
- (void)didClickRightNaviBtn
{
    [self.meunView show];
    
}
@end
