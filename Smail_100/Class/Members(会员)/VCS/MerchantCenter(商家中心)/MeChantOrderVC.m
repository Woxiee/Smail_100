//
//  MeChantOrderVC.m
//  Smile_100
//
//  Created by ap on 2018/2/27.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MeChantOrderVC.h"
#import "MeChantOrderInfoCell.h"
#import "MeOrderGoodsCell.h"
#import "MyChantPirceCell.h"

@interface MeChantOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)NSUInteger page;

@end

@implementation MeChantOrderVC
static NSString * const meChantOrderInfoID = @"MeChantOrderInfoCell";
static NSString * const meOrderGoodsCellID = @"MeOrderGoodsCellID";
static NSString * const myChantPirceCellD = @"MyChantPirceCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfiguration];
    [self setup];
    [self setRefresh];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestListNetWork];
    
}

/// 初始化视图
- (void)setup
{
    [self.resorceArray addObject:@"个人信息"];
    [self.resorceArray addObject:@"商品"];
    [self.resorceArray addObject:@"价格"];
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

#pragma mark - set懒加载
/*懒加载*/
-(UITableView *)tableView
{
    if (!_tableView) {
        //初始化数据
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64  - 45) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];//默认设置为空
        [_tableView setSeparatorInset:UIEdgeInsetsZero];//默认设置下划线左边移动 15.0f
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUND_COLOR;
    }
    return _tableView;
}
@end
