//
//  PageScrollTableViewsController.m
//  ScrollViewAndTableView
//
//  Created by fantasy on 16/5/14.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "PageScrollTableViewsController.h"

//controller
#import "PageTableController.h"

//view
#import "MenuView.h"

#import "SDCycleScrollView.h"
#import "LineRecommendedView.h"


@interface PageScrollTableViewsController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate>

@property (strong, nonatomic) NSArray * titleArray;

@property (weak, nonatomic) UIScrollView * scrollView;
@property (weak, nonatomic) MenuView * menuView;
@property (weak, nonatomic) UIView *  headerView;
@property (weak, nonatomic) SDCycleScrollView  *cycleView;
@property (weak, nonatomic)   LineRecommendedView *teamPersenView;


//偏移量
@property (assign, nonatomic) CGFloat scrollViewY;

@end

@implementation PageScrollTableViewsController

- (instancetype)initWithTitleArray:(NSArray *)titleArray{
  
  if (self = [super init]) {
    
    NSAssert(titleArray.count > 0, @"");
    _scrollViewY = -kScrollViewOriginY;
    _titleArray = titleArray;
//    self.automaticallyAdjustsScrollViewInsets = NO;
  }
  return self;
  
}

- (void)viewDidLoad{
  
  [super viewDidLoad];
  
  [self setupAllViews];
  
}
- (void)setupAllViews{
    WEAKSELF;
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(self.titleArray.count * kScreenWidth,0);
    _scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < self.titleArray.count; i++) {
        PageTableController * pageController = [[PageTableController alloc]init];
        pageController.tableViewDidScroll = ^(CGFloat tableViewOffsetY){
            [weakSelf tableViewDidScroll:tableViewOffsetY];
            
        };
        pageController.tableView.backgroundColor = [UIColor whiteColor];
        pageController.numOfController = i+1;
        pageController.tableView.frame = CGRectMake(i*kScreenWidth, kMenuViewHeight, kScreenWidth, kScreenHeight - kMenuViewHeight - kNavigationHeight - 50);
        pageController.tableView.contentInset = UIEdgeInsetsMake(kScrollViewOriginY, 0, 0, 0);
        [scrollView addSubview:pageController.tableView];
        [self addChildViewController:pageController];
        pageController.superVC = self;
        
        
    }
    
    UIView * headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, kHeaderViewHeight+10);
    _headerView = headerView;
    [self.view addSubview:headerView];
    
 
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125) delegate:self placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    [headerView addSubview:cycleView];
    self.cycleView = cycleView;
    
    LineRecommendedView *teamPersenView = [[LineRecommendedView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cycleView.frame), SCREEN_WIDTH, 145)];
    [headerView addSubview:teamPersenView];
    self.teamPersenView = teamPersenView;
    
    
    MenuView * menuView = [[MenuView alloc]initWithTitleArray:self.titleArray andDidClickButtonBlock:^(int buttonIndex) {
        [weakSelf didClickMenuButton:buttonIndex];
    }];
    [menuView layerForViewWith:0 AndLineWidth:0.5];
    menuView.frame = CGRectMake(0, CGRectGetMaxY(_headerView.frame), kScreenWidth, kMenuViewHeight);
    _menuView = menuView;
    [self.view addSubview:menuView];
}

- (void)tableViewDidScroll:(CGFloat)tableViewOffsetY{
  
  CGFloat everyChange = tableViewOffsetY - _scrollViewY;
  _scrollViewY = tableViewOffsetY;
  if (_scrollViewY >= 0) {//悬浮在顶部
    
    _headerView.mj_y = -kHeaderViewHeight;
    _menuView.mj_y   = 0;
    
  } else if (_scrollViewY <= -kScrollViewOriginY){//固定在下面
    _headerView.mj_y = 0;
    _menuView.mj_y= CGRectGetMaxY(_headerView.frame);
  } else {//随着移动
   
    _headerView.mj_y -= everyChange;
    _menuView.mj_y   =  CGRectGetMaxY(_headerView.frame);
    
  }

}

- (void)didClickMenuButton:(int)buttonIndex{
  
  [self.scrollView setContentOffset:CGPointMake(buttonIndex * kScreenWidth, 0) animated:YES];
  
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
  if (scrollView == self.scrollView) {
    
    if (_scrollViewY >= -kScrollViewOriginY) {//menuView滑动了
      
      for (PageTableController * pageController in self.childViewControllers) {
        pageController.tableView.contentOffset = CGPointMake(0, _scrollViewY);
      }
      
    }
    
  }
  
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  
  if (scrollView == self.scrollView) {
    
    int index = scrollView.contentOffset.x / kScreenWidth;
    [_menuView updateIndexButtonStatus:index];
    
  }
  
}


@end
