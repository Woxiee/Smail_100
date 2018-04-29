//
//  GoodsDetailVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/9.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsDetailVC.h"
#import "GoodContenVC.h"
#import "GoodDetailImageVC.h"
#import "PopupView.h"
#import "GoodsDetailCommenAllVC.h"
#import "AppDelegate.h"
#import "StoreBottomView.h"

#import "DLNavigationTabBar.h"



@interface GoodsDetailVC ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,YBPopupMenuDelegate>
@property(nonatomic,strong)DLNavigationTabBar *navigationTabBar;
@property(nonatomic,strong)NSMutableArray<UIViewController *> *subViewControllers;

@property(nonatomic,strong) UIButton *backButton;


@end

@implementation GoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /// 配置基础设置
    [self setConfiguration];
    /// 初始化视图
    [self setup];
    /// 初始化导航栏按钮
    [self setNavigetionBarItms];

}



#pragma mark - private

/// 初始化视图
- (void)setup
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    GoodContenVC  *VC1 = [[GoodContenVC alloc] init];
    VC1.title = @"商品详情";
    VC1.typeStr = self.typeStr;
    VC1.productID = self.productID;
    VC1.superVC = self;
    [array addObject:@"商品详情"];
    [_subViewControllers addObject:VC1];
 
    GoodDetailImageVC *webViewVC1 = [GoodDetailImageVC new];
    webViewVC1.title = @"购买须知";
    webViewVC1.typeStr = self.typeStr;
    webViewVC1.productID = self.productID;
    [array addObject:@"购买须知"];
    [_subViewControllers addObject:webViewVC1];

    WEAKSELF;
    self.navigationTabBar = [[DLNavigationTabBar alloc] initWithTitles:array];
    [self.navigationTabBar setDidClickAtIndex:^(NSInteger index){
        [weakSelf navigationDidSelectedControllerIndex:index];
    }];

    self.navigationItem.titleView = self.navigationTabBar;
    self.navigationTabBar.sliderBackgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    
    [self setViewControllers:@[_subViewControllers.firstObject]
                   direction:UIPageViewControllerNavigationDirectionReverse
                    animated:NO
                  completion:nil];
    
    VC1.navigationTabBar =   self.navigationTabBar;
    
    /// 自定义返回按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [backButton setImage:[UIImage imageNamed:@"shouye6@3x.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"shouye6@3x.png"] forState:UIControlStateHighlighted];
    backButton.titleLabel.font=[UIFont systemFontOfSize:18];
    [backButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    [backButton sizeToFit];
    _backButton = backButton;
    
    VC1.backButton = _backButton;

}


/// 配置基础设置
- (void)setConfiguration
{
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationItem.backBarButtonItem = nil;
    _subViewControllers  = [NSMutableArray arrayWithCapacity:0];

  
}

- (void)setNavigetionBarItms
{

//
    
//    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
//    [moreBtn setImage:[UIImage imageNamed:@"shouye5@3x.png"] forState:UIControlStateNormal];
//    [moreBtn setImage:[UIImage imageNamed:@"shouye5@3x.png"] forState:UIControlStateHighlighted];
//    moreBtn.titleLabel.font=[UIFont systemFontOfSize:18];
//    [moreBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
//
//    [moreBtn addTarget:self action:@selector(didClickMoreAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
//    [self.navigationItem setRightBarButtonItem:moreItem];
//    [moreBtn sizeToFit];
    
}


- (void)backAction
{

    [PopupView hide];
    [self.navigationController popViewControllerAnimated:YES];
}


///定制更多点击
- (void)didClickMoreAction:(UIButton *)sender{
    [YBPopupMenu showRelyOnView:sender titles:@[@"首页",@"我的"] icons:nil menuWidth:70 delegate:self];
}


#pragma mark - UIPageViewControllerDelegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.subViewControllers indexOfObject:viewController];
    if(index == 0 || index == NSNotFound) {
        return nil;
    }
    
    return [self.subViewControllers objectAtIndex:index - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.subViewControllers indexOfObject:viewController];
    if(index == NSNotFound || index == self.subViewControllers.count - 1) {
        return nil;
    }
    return [self.subViewControllers objectAtIndex:index + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    UIViewController *viewController = self.viewControllers[0];
    NSUInteger index = [self.subViewControllers indexOfObject:viewController];

    [self.navigationTabBar scrollToIndex:index];
    
}




#pragma mark - PrivateMethod
- (void)navigationDidSelectedControllerIndex:(NSInteger)index {
    [self setViewControllers:@[[self.subViewControllers objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    if (index == 0) {
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else{
        self.tabBarController.selectedIndex = 3;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
