//
//  OfflineVC.m
//  Smile_100
//
//  Created by Faker on 2018/2/7.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "OfflineVC.h"
#import "PageTableController.h"
#import "PageScrollTableViewsController.h"

//view
#import "MenuView.h"
@interface OfflineVC ()<UIScrollViewDelegate>

//偏移量
@property (assign, nonatomic) CGFloat scrollViewY;
@end

@implementation OfflineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    PageScrollTableViewsController * pageController = [[PageScrollTableViewsController alloc]initWithTitleArray:@[@"附近商家",@"销量优先",@"距离优先",@"评价优先"]];
    pageController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationHeight);
    [self.view addSubview:pageController.view];
    [self addChildViewController:pageController];
    pageController.superVC = self;
    [self setup];
}


- (void)setup
{
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
}
@end
