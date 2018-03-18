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
@interface OfflineVC ()<UIScrollViewDelegate,YBPopupMenuDelegate>

//偏移量
@property (assign, nonatomic) CGFloat scrollViewY;
@property (assign, nonatomic)  UIButton *selectBtn;
@property (nonatomic, strong)  UITextField *inPutTextField;

@end

@implementation OfflineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    PageScrollTableViewsController * pageController = [[PageScrollTableViewsController alloc]initWithTitleArray:@[@"附近商家",@"销量优先",@"距离优先",@"评价优先"]];
    pageController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationHeight);
    pageController.navigationItem = self.navigationItem;
    [self.view addSubview:pageController.view];
    [self addChildViewController:pageController];
    pageController.superVC = self;
    [self setup];
    [self setNavationView];
}


- (void)setNavationView
{
    UIView *navationView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 120)/2, 10, SCREEN_WIDTH - 120, 30)];
    navationView.backgroundColor = [UIColor whiteColor];
    [navationView layerForViewWith:4 AndLineWidth:0];
    
    UIButton *selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    selectBtn.backgroundColor = [UIColor lightGrayColor];
    [selectBtn setTitle:@"商家" forState:UIControlStateNormal];
    [selectBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    selectBtn.titleLabel.font = Font15;
    [selectBtn addTarget:self  action:@selector(clickToSelect:) forControlEvents:UIControlEventTouchUpInside];
    [navationView addSubview:selectBtn];
    self.selectBtn = selectBtn;
    
    UITextField *inPutTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(selectBtn.frame), 0, navationView.width -CGRectGetMaxX(selectBtn.frame), 30)];
    inPutTextField.placeholder = @"请输入搜索内容";
    inPutTextField.textColor = [UIColor whiteColor];
    inPutTextField.font = Font13;
    inPutTextField.returnKeyType = UIReturnKeySearch;
    inPutTextField.backgroundColor =[UIColor whiteColor];
    inPutTextField.borderStyle = UITextBorderStyleNone;
    [inPutTextField layerForViewWith:15 AndLineWidth:0];
    [navationView addSubview:inPutTextField];

    _inPutTextField = inPutTextField;
    //搜索框里面的UI
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    view.backgroundColor = [UIColor clearColor];
    inPutTextField.leftViewMode = UITextFieldViewModeAlways;
    inPutTextField.leftView = view;
    UIImageView * searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 14, 14)];
    searchImage.backgroundColor = [UIColor clearColor];
    searchImage.image = [UIImage imageNamed:@"21@3x.png"];
    [view addSubview:searchImage];
    
    UIButton *coverToSeach =  [[UIButton alloc]initWithFrame:CGRectMake(0, 0, inPutTextField.width, inPutTextField.height)];
    coverToSeach.backgroundColor = [UIColor clearColor];
    [coverToSeach addTarget:self  action:@selector(clickToSearch) forControlEvents:UIControlEventTouchUpInside];
    [inPutTextField addSubview:coverToSeach];
    
    self.navigationItem.titleView = navationView;
    
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


- (void)clickToSelect:(UIButton *)sender{
    [YBPopupMenu showRelyOnView:sender titles:@[@"商家",@"商品"] icons: nil menuWidth:60 delegate:self];
}


#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    NSArray * titles = @[@"商家",@"商品"];
    NSLog(@"点击了 %@ 选项",titles[index]);
    [self.selectBtn setTitle:titles[index] forState:UIControlStateNormal];

}



- (void)clickToSearch
{
    
    
}
@end
