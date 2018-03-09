//
//  BrowsingHistoryVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/3.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "BrowsingHistoryVC.h"
#import "HistoryVModel.h"

#import "GoodsScreenCel.h"
#import "GoodsScreenOutCell.h"

@interface BrowsingHistoryVC ()
@property(nonatomic,assign)NSUInteger page;

@end

@implementation BrowsingHistoryVC
static NSString * const goodsScreenCellID = @"goodsScreenCelID";
static NSString * const goodsScreenOutCellID = @"goodsScreenOutCellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
    [self setRefresh];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestListNetWork];
    if ([KX_UserInfo sharedKX_UserInfo].city) {
        [self.leftNaviBtn setTitle:[KX_UserInfo sharedKX_UserInfo].city forState:UIControlStateNormal];
    }
    else{
        [self.leftNaviBtn setTitle:@"全国" forState:UIControlStateNormal];
    }
    
}

- (void)requestListNetWork
{
    WEAKSELF;
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:[KX_UserInfo sharedKX_UserInfo].ID,@"mid", nil];
//    [MBProgressHUD showMessag:@"加载中..." toView:self.view];

    [HistoryVModel getHistoryListParam:param successBlock:^(NSArray<HistoryModel *> *dataArray, BOOL isSuccess) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (isSuccess) {
            if (weakSelf.resorceArray.count >0) {
                [weakSelf.resorceArray removeAllObjects];
            }
            [self.resorceArray addObjectsFromArray:dataArray];
            [weakSelf.tableView reloadData];
        }
        [weakSelf stopRefresh];

    }];
}



#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.resorceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HistoryModel *model = [self.resorceArray objectAtIndex:indexPath.section];
    if (KX_NULLString(model.param6)) {
           return 130;
    }
    return 162;
 

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    GoodsScreenListModel *model = [self.resorceArray objectAtIndex:indexPath.section];
//    /// 商品类型=1:新机。2:配构件。3:整机流转 4:标准节共享。
//    //    5:二手设备。
//    //    6:检测吊运。
//    //    9:集采。
//
    HistoryModel *model = [self.resorceArray objectAtIndex:indexPath.section];
    if (KX_NULLString(model.param6)) {
        GoodsScreenCel * cell = [tableView dequeueReusableCellWithIdentifier:goodsScreenCellID];
        cell.cellShowType = GoodsScreenCellNomalType;
        cell.isCollect = YES;
        cell.historyModel =  model;
        return cell;
    }else{
        GoodsScreenOutCell * cell = [tableView dequeueReusableCellWithIdentifier:goodsScreenOutCellID];
        cell.historyModel =  model;
        return cell;

    }
//
    
    return nil;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*productType
     1:新机。
     2:配构件。
     3:整机流转。
     4:标准节共享。
     5:二手设备。
     6:检测吊运。
     9:集采。
     10:集采
     11:求租
     */
   
    
}

/// 配置基础设置
- (void)setConfiguration
{
    self.title = @"购物车";
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsScreenCel" bundle:nil] forCellReuseIdentifier:goodsScreenCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsScreenOutCell" bundle:nil] forCellReuseIdentifier:goodsScreenOutCellID];
}

/// 初始化视图
- (void)setup
{
    self.leftNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftNaviBtn setImage:[UIImage imageNamed:@"20@3x.png"] forState:UIControlStateNormal];
    [self.leftNaviBtn setImage:[UIImage imageNamed:@"20@3x.png"] forState:UIControlStateHighlighted];
    [self.leftNaviBtn setTitle:[KX_UserInfo sharedKX_UserInfo].city forState:UIControlStateNormal];
    
    self.leftNaviBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.leftNaviBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    self.leftNaviBtn.backgroundColor=[UIColor clearColor];
    [self.leftNaviBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:self.leftNaviBtn];
    self.navigationItem.leftBarButtonItem = rightButton;
    [self.leftNaviBtn sizeToFit];
    [self.leftNaviBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
    
    
    [self setRightNaviBtnImage:[UIImage imageNamed:@"17@3x.png"]];

}


- (void)popVC
{
    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
        [KX_UserInfo presentToLoginView:self];
        return;
    }
    CityViewController *controller = [[CityViewController alloc] init];
    [[KX_UserInfo sharedKX_UserInfo] loadUserInfoFromSanbox];
    if (!KX_NULLString([KX_UserInfo sharedKX_UserInfo].city)) {
        controller.currentCityString = [KX_UserInfo sharedKX_UserInfo].city;
    }
    WEAKSELF;
    controller.selectString = ^(NSString *string){
        LOG(@" 城市 = %@",string);
        [[KX_UserInfo sharedKX_UserInfo] loadUserInfoFromSanbox];
        [KX_UserInfo sharedKX_UserInfo].city = string;
        [[KX_UserInfo sharedKX_UserInfo] saveUserInfoToSanbox];
        [weakSelf.leftNaviBtn setTitle:string forState:UIControlStateNormal];
        [weakSelf.leftNaviBtn sizeToFit];
        [weakSelf.leftNaviBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
    };
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)didClickRightNaviBtn
{
    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
        [KX_UserInfo presentToLoginView:self];
        return;
    }
  
}

#pragma mark - refresh 添加刷新方法
-(void)setRefresh
{
    WEAKSELF;
    [self.tableView headerWithRefreshingBlock:^{
        [weakSelf loadNewDate];
    }];
    
    [self.tableView footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}

-(void)loadNewDate
{
    self.page = 0;
    [self requestListNetWork];
}

-(void)loadMoreData{
    
    self.page++;
    [self requestListNetWork];
}


-(void)stopRefresh
{
   
}

@end
