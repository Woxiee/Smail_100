//
//  OffLineDetailVC.m
//  Smail_100
//
//  Created by ap on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "OffLineDetailVC.h"
#import "SDCycleScrollView.h"
#import "SDPhotoBrowser.h"
#import "OfflineInfoDetailCell.h"

#import "GoodsDetailCommenAllVC.h"
#import "MeunLineOffVC.h"
#import "OfflineDetailModel.h"


@interface OffLineDetailVC ()<UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate,SDPhotoBrowserDelegate>
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong)  NSMutableArray *titleArray;
@property (nonatomic, strong) SDCycleScrollView *headView;

@end

@implementation OffLineDetailVC
static NSString * const OfflineInfoDetailCellID = @"OfflineInfoDetailCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
    WEAKSELF;
    [self.tableView headerWithRefreshingBlock:^{
        [weakSelf getGoodsDetailInfoRequest];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getGoodsDetailInfoRequest];
    
//    _guiGeVlue = @"";
//    _goodSCount = 1;
}


/// 配置基础设置
- (void)setConfiguration
{
    
}


/// 初始化视图
- (void)setup
{
    self.title = @"商家详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"OfflineInfoDetailCell" bundle:nil] forCellReuseIdentifier:OfflineInfoDetailCellID];

    [self.view addSubview:self.tableView];
}


#pragma mark - request
/// 商品详情
- (void)getGoodsDetailInfoRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_model.shop_id forKey:@"shop_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/shop/shop_detail" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            OfflineDetailModel *model = [OfflineDetailModel yy_modelWithJSON:result[@"data"]];
            model.comment = [NSArray yy_modelArrayWithClass:[Comment class] json: model.comment];
            [weakSelf.resorceArray removeAllObjects];
            [weakSelf.resorceArray addObject:model];
            
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            [arr addObject:model.shop_image];
            weakSelf.headView.imageURLStringsGroup = arr;
            [weakSelf.tableView reloadData];
            
        }
        else{
            [weakSelf showHint:msg];

        }
    }];
}


- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 45) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.tableFooterView = self.footView;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.headView;
        self.tableView.estimatedRowHeight = 350;
        self.tableView.rowHeight = UITableViewAutomaticDimension;

    }
    return _tableView;
}


-(SDCycleScrollView *)headView
{
    if (!_headView) {
        _headView= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) delegate:self placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW2]];
        _headView.delegate = self;
    }
    return _headView;
}

#pragma mark -SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    //    browser.currentImageIndex = index;
    //    browser.sourceImagesContainerView = self.view;
    //    browser.imageCount = _headView.imageURLStringsGroup.count;
    //    browser.delegate = self;
    //    [browser show];
}

#pragma mark - SDPhotoBrowserDelegate
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName =  _headView.imageURLStringsGroup[index];
    NSURL *url = [NSURL URLWithString:imageName];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = _headView.subviews[index];
    return imageView.image;
}

#pragma mark - UITaleViewDelegate and UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.resorceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
//    OffLineModel *model = self.resorceArray[indexPath.row];
    OfflineInfoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:OfflineInfoDetailCellID];
    if (cell == nil) {
        cell = [[OfflineInfoDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:OfflineInfoDetailCellID];
    }
    OfflineDetailModel *model = self.resorceArray[indexPath.row];

    cell.didClickInfoCellBlock = ^(NSInteger index) {
        if (index == 0) {//找位置
            
        }
        
        if (index == 1) {//查看商家
            MeunLineOffVC *VC = [[MeunLineOffVC alloc] init];
            VC.detailModel = model;
            [weakSelf.navigationController pushViewController:VC animated:YES];

        }
        if (index == 2) {//查看评论
            GoodsDetailCommenAllVC *VC = [[GoodsDetailCommenAllVC alloc] init];
            [weakSelf.navigationController pushViewController:VC animated:YES];
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    
    return cell;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 340;
//
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
