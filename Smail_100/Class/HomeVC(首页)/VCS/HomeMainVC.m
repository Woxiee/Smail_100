//
//  HomeMainVC.m
//  Smile_100
//
//  Created by Faker on 2018/2/8.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "HomeMainVC.h"
#import "HomeVC.h"
#import "HomeVModel.h"
#import "ColumnModel.h"
@interface HomeMainVC ()<PYSearchViewControllerDelegate>
@property (nonatomic, strong)  UITextField *inPutTextField;

@end

@implementation HomeMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getHomeIndexRequest];
//    [self setup];
}


- (void)setup
{
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
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (ColumnModel *model in self.resorceArray) {
        [titles addObject:model.name];
    }
    /* 创建测试数据 */
//    NSArray *titles = @[@"推荐",@"积分商城",@"品牌馆",@"随身Wifi",@"智能科技",@"日用商品"];
    HomeVC      *vc1 = [[HomeVC alloc]init];
    HomeVC      *vc2 = [[HomeVC alloc]init];
    HomeVC    *vc3 = [[HomeVC alloc]init];
    HomeVC     *vc4 = [[HomeVC alloc]init];
    HomeVC     *vc5 = [[HomeVC alloc]init];
    HomeVC      *vc6 = [[HomeVC alloc]init];
    
    NSArray *vcArr = @[vc1,vc2,vc3,vc4,vc5,vc6];
    
    /* 导入数据 */
    [segmentMenuVc addSubVc:vcArr subTitles:titles];
    WEAKSELF;
    segmentMenuVc.didClickPageIndexBlock = ^(NSInteger index) {
        HomeVC *VC = vcArr[index];
        ColumnModel *model = weakSelf.resorceArray[index];
        VC.categoryId = model.category_id;
        [VC getHomeGoodsRequest:model.category_id];
        
    };
    self.leftNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftNaviBtn setImage:[UIImage imageNamed:@"shouye17@3x.png"] forState:UIControlStateNormal];
    [self.leftNaviBtn setImage:[UIImage imageNamed:@"shouye17@3x.png"] forState:UIControlStateHighlighted];
//    [self.leftNaviBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    self.leftNaviBtn.titleLabel.font= Font13;
    [self.leftNaviBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    self.leftNaviBtn.backgroundColor=[UIColor clearColor];
    [self.leftNaviBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:self.leftNaviBtn];
    self.navigationItem.leftBarButtonItem = rightButton;
    [self.leftNaviBtn sizeToFit];
    
    [self.leftNaviBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
    
    [self setRightNaviBtnImage:[UIImage imageNamed:@"shouye18@3x.png"]];
    
    
    UITextField *inPutTextField = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 120)/2, 10, SCREEN_WIDTH - 120, 30)];
   
    inPutTextField.placeholder = @"找商品, 找商家,找品牌";
    inPutTextField.textColor = [UIColor whiteColor];
    inPutTextField.font = Font13;
    inPutTextField.returnKeyType = UIReturnKeySearch;
    inPutTextField.backgroundColor =[UIColor whiteColor];
    inPutTextField.borderStyle = UITextBorderStyleNone;
    [inPutTextField layerForViewWith:15 AndLineWidth:0];
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
    self.navigationItem.titleView = inPutTextField;

}

- (void)getHomeIndexRequest
{
    WEAKSELF;
    [HomeVModel getHomeIndexList:^(NSArray *dataArray, BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.resorceArray addObjectsFromArray:dataArray];
            [weakSelf setup];
        }
        
    }];
}

- (void)didClickRightNaviBtn
{
    
    self.tabBarController.selectedIndex = 3;
}

///搜索
- (void)clickToSearch
{
 
    WEAKSELF;
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:@[@"新机",@"采购",@"集采"] searchBarPlaceholder:@"找商品、找商家、找品牌" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
//        weakSelf.keyWord = searchText;
//        [weakSelf requestListNetWork];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    // 3. Set style for popular search and search history
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleCell;
    searchViewController.hotSearchStyle =  PYHotSearchStyleRectangleTag;
    // 4. Set delegate
    searchViewController.delegate = self;
    // 5. Present a navigation controller
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
