//
//  AgentPlatfoemMainVC.m
//  Smail_100
//
//  Created by ap on 2018/3/22.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AgentPlatfoemMainVC.h"
#import "AgentPlatfoemListVC.h"

@interface AgentPlatfoemMainVC ()
@property (strong, nonatomic)  AgentPlatfoemListVC *agreeVC;
@property (strong, nonatomic)  AgentPlatfoemListVC *repjectVC;
@property (nonatomic, strong)  NSArray *contollers;

@end

@implementation AgentPlatfoemMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];

}


/// 初始化视图
- (void)setup
{
    self.title = @"商家列表";

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
    NSArray *titleArr ;
    titleArr = @[@"审核通过",@"驳回申请"];
    _agreeVC = [[AgentPlatfoemListVC alloc]init];
    _agreeVC.orderState = @"Enabled";
    
    _repjectVC = [[AgentPlatfoemListVC alloc]init];
    _repjectVC.orderState = @"Fail";
    _contollers = @[_agreeVC,_repjectVC];
    /* 导入数据 */
    [segmentMenuVc addSubVc:_contollers subTitles:titleArr];
    WEAKSELF;
    segmentMenuVc.didClickPageIndexBlock = ^(NSInteger index){
        LOG(@"index = %ld",(long)index);
        if (_contollers.count >0) {
            AgentPlatfoemListVC *VC  = [_contollers objectAtIndex:index];
            [VC requestListNetWork];
        }
        
    };
}

@end
