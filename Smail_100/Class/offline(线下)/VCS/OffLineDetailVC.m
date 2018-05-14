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

#import "CommentsCell.h"
#import "CommentsHeadView.h"

@interface OffLineDetailVC ()<UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate,SDPhotoBrowserDelegate>
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong)  NSMutableArray *titleArray;
@property (nonatomic, strong) SDCycleScrollView *headView;
@property (nonatomic, strong) OfflineDetailModel *detailModle;



@end

@implementation OffLineDetailVC
static NSString * const OfflineInfoDetailCellID = @"OfflineInfoDetailCellID";
static NSString * const CommentsCellID = @"CommentsCell";



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
    [self.tableView registerClass:[CommentsCell class] forCellReuseIdentifier:CommentsCellID];

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
            
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            [arr addObject:model.shop_image];
            weakSelf.headView.imageURLStringsGroup = arr;
            weakSelf.detailModle = model;
            [weakSelf.resorceArray addObject:@"详情"];
            [weakSelf.resorceArray addObject:@"评论"];

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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 64 ) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.tableFooterView = self.footView;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.headView;

    }
    return _tableView;
}


-(SDCycleScrollView *)headView
{
    if (!_headView) {
        _headView= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) delegate:self placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW3]];
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
    
    return self.resorceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *title = self.resorceArray[section];
    if ([title isEqualToString:@"详情"]) {
        return 1;

    }
    return _detailModle.comment.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
//    OffLineModel *model = self.resorceArray[indexPath.row];
    NSString *title = self.resorceArray[indexPath.section];
    if ([title isEqualToString:@"详情"]) {
        OfflineInfoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:OfflineInfoDetailCellID];
        if (cell == nil) {
            cell = [[OfflineInfoDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:OfflineInfoDetailCellID];
        }
        
        cell.didClickInfoCellBlock = ^(NSInteger index) {
            if (index == 0) {//找位置
                
            }
            if (index == 1) {//查看商家
                MeunLineOffVC *VC = [[MeunLineOffVC alloc] init];
                VC.detailModel = _detailModle;
                [weakSelf.navigationController pushViewController:VC animated:YES];
            }
            if (index == 2) {//查看评论
                GoodsDetailCommenAllVC *VC = [[GoodsDetailCommenAllVC alloc] init];
                [weakSelf.navigationController pushViewController:VC animated:YES];
            }
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _detailModle;
        
        return cell;
    }
 
    CommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentsCellID];
    if (cell == nil) {
        cell = [[CommentsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:OfflineInfoDetailCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _detailModle.comment[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.resorceArray[indexPath.section];
    if ([title isEqualToString:@"详情"]) {
        CGSize heightSize = [NSString heightForString:_detailModle.business_info fontSize:Font14 WithSize:CGSizeMake(SCREEN_WIDTH - 50, SCREEN_WIDTH)];
        return 345 + heightSize.height;
    }else{
//            return 85;
        Comment *model= _detailModle.comment[indexPath.row];
        return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CommentsCell class] contentViewWidth:SCREEN_WIDTH];
    }
    return 0;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    NSString *title = self.resorceArray[section];
    if ([title isEqualToString:@"详情"]) {

    }else{
            return 50;

    }
    return 0;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
//    UIView *lineView1 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
//    lineView1.backgroundColor = LINECOLOR;
//    [headView addSubview:lineView1];
//
//    UIView *lineView2 =[[UIView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 0.5)];
//    lineView2.backgroundColor = LINECOLOR;
//    [headView addSubview:lineView2];
//
//    UIImageView *starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 15, 15, 14)];
//    starImageView.image = [UIImage imageNamed:@""];
//    [headView addSubview:starImageView];
//
//    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(starImageView.frame) +5, 10, SCREEN_WIDTH, 17)];
//    titleLb.textColor = KMAINCOLOR;
//    titleLb.font = Font15;
//    titleLb.textAlignment = NSTextAlignmentLeft;
//    [headView addSubview:titleLb];
//
//    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    moreBtn setTitle:@"查看更多评价" forState:uicon
    
    CommentsHeadView *headview = [[NSBundle mainBundle] loadNibNamed:@"CommentsHeadView" owner:nil options: nil].lastObject;
    headview.titleLB.text = [NSString stringWithFormat:@"用户评价(%@人评价)",_detailModle.comment_count];
    [headview.moreBtn setTitle:@"查看更多评价 >" forState:UIControlStateNormal];
    [headview.moreBtn addTarget:self action:@selector(didClickMoreAction) forControlEvents:UIControlEventTouchUpInside];
    return headview;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didClickMoreAction
{
    GoodsDetailCommenAllVC *VC = [[GoodsDetailCommenAllVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
@end
