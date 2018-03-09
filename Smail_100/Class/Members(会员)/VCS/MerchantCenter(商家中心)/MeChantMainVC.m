//
//  MeChantMainVC.m
//  Smile_100
//
//  Created by ap on 2018/2/27.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MeChantMainVC.h"
#import "MeChantOrderVC.h"

@interface MeChantMainVC ()

@end

@implementation MeChantMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    self.title = @"订单管理";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
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
    /* 创建测试数据 */
    NSArray *titles = @[@"全部",@"代付款",@"待评价",@"已评价"];
    MeChantOrderVC *vc1 = [[MeChantOrderVC alloc] init];
    vc1.orderTye = MeChantAllOrderType;
    
    MeChantOrderVC *vc2 = [[MeChantOrderVC alloc] init];
    vc2.orderTye = MeChantwaitOrderType;

    MeChantOrderVC *vc3 = [[MeChantOrderVC alloc] init];
    vc3.orderTye = MeChantcommodOrderType;

    MeChantOrderVC *vc4 = [[MeChantOrderVC alloc] init];
    vc4.orderTye = MeChantcompleOrderType;

    NSArray *vcArr = @[vc1,vc2,vc3,vc4];
    
    /* 导入数据 */
    [segmentMenuVc addSubVc:vcArr subTitles:titles];
}

@end
