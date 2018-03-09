//
//  MeChantOrderDetailVC.m
//  Smile_100
//
//  Created by ap on 2018/2/27.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MeChantOrderDetailVC.h"
#import "MeChantOrderInfoCell.h"
#import "MeOrderGoodsCell.h"
#import "MyChantPirceCell.h"
#import "MeOrderNumberCell.h"

@interface MeChantOrderDetailVC ()
@property(nonatomic,assign)NSUInteger page;

@end

@implementation MeChantOrderDetailVC
static NSString * const meChantOrderInfoID = @"MeChantOrderInfoCell";
static NSString * const meOrderGoodsCellID = @"MeOrderGoodsCellID";
static NSString * const myChantPirceCellD = @"MyChantPirceCellID";
static NSString * const meOrderNumberCellID = @"meOrderNumberCellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfiguration];
    [self setup];
    [self setRefresh];
}

/// 初始化视图
- (void)setup
{
    [self.resorceArray addObject:@"个人信息"];
    [self.resorceArray addObject:@"商品"];
    [self.resorceArray addObject:@"价格"];
    [self.resorceArray addObject:@"订单号"];

    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}


/// 配置基础设置
- (void)setConfiguration
{
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self.tableView registerNib:[UINib nibWithNibName:@"MeChantOrderInfoCell" bundle:nil] forCellReuseIdentifier:meChantOrderInfoID];
    [self.tableView registerNib:[UINib nibWithNibName:@"MeOrderGoodsCell" bundle:nil] forCellReuseIdentifier:meOrderGoodsCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyChantPirceCell" bundle:nil] forCellReuseIdentifier:myChantPirceCellD];
    [self.tableView registerNib:[UINib nibWithNibName:@"MeOrderNumberCell" bundle:nil] forCellReuseIdentifier:meOrderNumberCellID];

    
}
#pragma mark - 得到网络数据
-(void)requestListNetWork
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageIndex"];
    [param setObject:@"10" forKey:@"pageSize"];
}


/// 处理订单操作
- (void)operationRequestUrl:(NSString *)url Param:(id)param
{
    
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resorceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.resorceArray[indexPath.section];
    
    if ([title isEqualToString:@"个人信息"]) {
        MeChantOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:meChantOrderInfoID];
        if (cell == nil) {
            cell = [[MeChantOrderInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:meChantOrderInfoID];
        }
        return cell;
    }
    
    if ([title isEqualToString:@"商品"]) {
        MeOrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:meOrderGoodsCellID];
        if (cell == nil) {
            cell = [[MeOrderGoodsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:meOrderGoodsCellID];
        }
        return cell;
    }
    
    if ([title isEqualToString:@"价格"]) {
        MyChantPirceCell *cell = [tableView dequeueReusableCellWithIdentifier:myChantPirceCellD];
        if (cell == nil) {
            cell = [[MyChantPirceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myChantPirceCellD];
        }
        return cell;
    }
    
    if ([title isEqualToString:@"订单号"]) {
        MeOrderNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:meOrderNumberCellID];
        if (cell == nil) {
            cell = [[MeOrderNumberCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:meOrderNumberCellID];
        }
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.resorceArray[indexPath.section];
    if ([title isEqualToString:@"个人信息"]) {
        return 108;
    }
    if ([title isEqualToString:@"商品"]) {
        return 90;
    }
    if ([title isEqualToString:@"价格"]) {
        return 42;
    }
    if ([title isEqualToString:@"订单号"]) {
           return 44;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
}


#pragma mark - public 共有方法



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
    //    _quickSearch = @"";
    [self requestListNetWork];
}

-(void)loadMoreData{
    
    self.page++;
    [self requestListNetWork];
}

-(void)stopRefresh
{
    [self.tableView stopFresh:self.resorceArray.count pageIndex:self.page];
    if (self.resorceArray.count == 0) {
        [self.tableView addSubview:[KX_LoginHintView notDataView]];
    }else{
        [KX_LoginHintView removeFromSupView:self.tableView];
    }
    
}

@end
