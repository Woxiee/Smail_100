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
#import "RecommendedView.h"
#import "SIDADView.h"
#import "GoodsScreeningVC.h"

@interface HomeMainVC ()<PYSearchViewControllerDelegate>
@property (nonatomic, strong)  UITextField *inPutTextField;
@property (nonatomic, strong)  NSMutableArray *hotArray;

@end

@implementation HomeMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getHomeIndexRequest];
    [self getHoldKeyWorld];
}



- (void)setup
{
    self.view.backgroundColor = [UIColor whiteColor];
   _hotArray= [[NSMutableArray alloc] init];

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
//    NSArray *vcArr = @[vc1,vc2,vc3,vc4,vc5,vc6];
    NSMutableArray *vcArr = [[NSMutableArray alloc] init];
    for (ColumnModel *model in self.resorceArray) {
        HomeVC    *vc1 = [[HomeVC alloc]init];
        vc1.categoryId = model.category_id;
        vc1.bottomHeight = 45;
        [vcArr addObject:vc1];
        [titles addObject:model.name];
    }
    
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
    [self.leftNaviBtn setImage:[UIImage imageNamed:@"shouye17@3x.png"] forState:UIControlStateHighlighted];\
    self.leftNaviBtn.frame = CGRectMake(0, 0, 45, 40);

//    [self.leftNaviBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    self.leftNaviBtn.titleLabel.font= Font13;
    [self.leftNaviBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    self.leftNaviBtn.backgroundColor=[UIColor clearColor];
    [self.leftNaviBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:self.leftNaviBtn];
    leftBarButton.width = -15;
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
//    [self.leftNaviBtn sizeToFit];
    
//    [self.leftNaviBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
    
    
//    self.rightNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.rightNaviBtn setImage:[UIImage imageNamed:@"shouye17@3x.png"] forState:UIControlStateNormal];
//    [self.rightNaviBtn setImage:[UIImage imageNamed:@"shouye17@3x.png"] forState:UIControlStateHighlighted];
//    message_icon@2x.png
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 45, 40);
    [btn setTitle:@"消息" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"message_icon@2x.png"] forState:UIControlStateNormal];
    btn.titleLabel.font = KY_FONT(13);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:0];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    rightItem.width = +15;

    self.navigationItem.rightBarButtonItem = rightItem;
//    [self.leftNaviBtn sizeToFit];
//    [btn addTarget:self action:@selector(didClickBottomAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
//    [self setRightNaviBtnImage:[UIImage imageNamed:@"message_icon@2x.png"]];
//    [self.rightNaviBtn setTitle:@"消息" forState:UIControlStateNormal];
//    self.rightNaviBtn.titleLabel.font = KY_FONT(13);
//    self.rightNaviBtn.backgroundColor = [UIColor blueColor];
    
    UITextField *inPutTextField = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, SCREEN_WIDTH -120, 30)];
  
    inPutTextField.placeholder = @"找商品、找商家、找品牌";
    inPutTextField.textColor = [UIColor whiteColor];
    inPutTextField.font = Font13;
    inPutTextField.returnKeyType = UIReturnKeySearch;
    inPutTextField.backgroundColor =[UIColor whiteColor];
    inPutTextField.borderStyle = UITextBorderStyleNone;
    [inPutTextField layerForViewWith:10 AndLineWidth:0];
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
//

}

- (void)getHomeIndexRequest
{
//    WEAKSELF;
//    [HomeVModel getHomeIndexList:^(NSArray *dataArray, BOOL isSuccess) {
//        if (isSuccess) {
//            [weakSelf.resorceArray addObjectsFromArray:dataArray];
//            [weakSelf setup];
//        }
//
//    }];
    
    WEAKSELF;
    [HomeVModel getHomeIndexParam:nil list:^(NSArray *dataArray, BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.resorceArray addObjectsFromArray:dataArray];
            [weakSelf setup];
        }

    }];
}



/// 获取热门关键词
- (void)getHoldKeyWorld
{
    WEAKSELF;
    [HomeVModel getHotList:^(NSArray *dataArray, BOOL isSuccess) {
        if (isSuccess) {
//            [weakSelf.resorceArray addObjectsFromArray:dataArray];
//            [weakSelf setup];
            for (NSDictionary *dic in dataArray) {
                [weakSelf.hotArray addObject:dic];
            }
        }
        
    }];
    
}

///获取支付宝相关资料
- (void)getAppPayInfo
{
    
}

- (void)didClickRightNaviBtn
{
    
//    self.tabBarController.selectedIndex = 3;
}

///搜索
- (void)clickToSearch
{
    NSMutableArray *listArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in _hotArray) {
        [listArr addObject:dic[@"keyword"]];
    }
    WEAKSELF;
    
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:listArr searchBarPlaceholder:@"找商品、找商家、找品牌" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];

        for (NSDictionary *dics in _hotArray) {
            if ([searchText isEqualToString:dics[@"keyword"]]) {
                GoodsScreeningVC *VC = [[GoodsScreeningVC alloc] init];
                VC.hidesBottomBarWhenPushed = YES;
//                VC.category_id = dics[@"id"];
                VC.goodsScreenType = GoodsScreenSerchType;
                VC.title =  searchText;
                [weakSelf.navigationController pushViewController:VC animated:YES];
                break;
            }
        }
//        NSDictionary *dic = weakSelf.hotArray[]

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
