//
//  MemberBaseInfoVC.m
//  MyCityProject
//
//  Created by mac_KY on 17/5/26.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "MemberBaseInfoVC.h"
#import "CompanyInfoVC.h"
#import "MemberInforVC.h"

@interface MemberBaseInfoVC ()
/**<#Description#>*/
@property(nonatomic,strong)UIButton *selectBtn;
/** <#des#> */
@property(nonatomic,strong)NSArray *childVCs;

@end

@implementation MemberBaseInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadComment];
    [self loadSubView];
    [self loadData];
    
}

#pragma mark - 常数设置
- (void)loadComment
{
    _childVCs = @[[MemberInforVC new],[CompanyInfoVC new]];
    
    [self addChildVC:_childVCs];
    [self changeContentVC:0];
  
}


- (void)addChildVC:(NSArray  *)childVCs
{
    for (UIViewController *vc in childVCs) {
        [self addChildViewController:vc];
        vc.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);
        [self.view addSubview:vc.view];
        self.view.userInteractionEnabled = YES;
        vc.view.userInteractionEnabled   = YES;
    }
}

- (void)changeContentVC:(int)page
{
  
    UIViewController *remVC = _childVCs[page == 1?0:1];
    [remVC.view removeFromSuperview];
    UIViewController *addVC = _childVCs[page == 1?1:0];
    [self.view addSubview:addVC.view];
   
}

#pragma mark - 初始化子View
- (void)loadSubView
{
    [self loadNavItem];
}

- (void)loadNavItem
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 180, 40)];
    UIButton *personInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    personInfoBtn.frame = CGRectMake(0, 0, titleView.width/2, titleView.height);
    [personInfoBtn setTitle:@"个人信息" forState:UIControlStateNormal];
    [personInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [personInfoBtn addTarget:self action:@selector(clickTitle:) forControlEvents:UIControlEventTouchUpInside];
    personInfoBtn.titleLabel.font = KY_FONT(17);
    [titleView addSubview:personInfoBtn];
    
    UIButton *companyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    companyBtn.frame = CGRectMake(titleView.width/2, 0, titleView.width/2, titleView.height);
    [companyBtn setTitle:@"企业信息" forState:UIControlStateNormal];
    [companyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [companyBtn addTarget:self action:@selector(clickTitle:) forControlEvents:UIControlEventTouchUpInside];
    companyBtn.titleLabel.font = KY_FONT(15);
    companyBtn.tag = 1;
    [titleView addSubview:companyBtn];
    self.navigationItem.titleView = titleView;
    
}


#pragma mark - 网络数据请求
- (void)loadData
{
    
}
#pragma mark - 点击事件

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)clickTitle:(UIButton *)btn
{
    if (btn == _selectBtn) return;
    
    _selectBtn.titleLabel.font = KY_FONT(15);
    btn.titleLabel.font  = KY_FONT(17);
    _selectBtn = btn;
    [self changeContentVC:(int)btn.tag];
    
}
#pragma mark - private

@end
