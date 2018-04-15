//
//  SmileMainListVC.m
//  Smail_100
//
//  Created by Faker on 2018/4/15.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SmileMainListVC.h"
#import "SmileForListVC.h"
@interface SmileMainListVC ()
@property(nonatomic,assign)  NSInteger selectIndex;

@end

@implementation SmileMainListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    
    self.title = @"兑换流水";
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
    NSArray *titleArr = @[@"全部",@"兑换中",@"已成功",@"已驳回"];
    NSArray *status = @[@"",@"Pending",@"Enabled",@"Fail"];
    NSMutableArray *contollers =  [[NSMutableArray alloc] init];
    for (int i = 0; i<4; i++) {
        SmileForListVC *vc = [[SmileForListVC alloc] init];
        vc.status = status[i];
        [contollers addObject:vc];
    }
    [segmentMenuVc addSubVc:contollers subTitles:titleArr];

    WEAKSELF;
    _selectIndex = 0;
    segmentMenuVc.didClickPageIndexBlock = ^(NSInteger index){
        weakSelf.selectIndex = index;
        if (contollers.count >0) {
            SmileForListVC *VC  = [contollers objectAtIndex:index];
//            VC.status = status[i];
            [VC requestListNetWork];
        }
    };


}

@end
