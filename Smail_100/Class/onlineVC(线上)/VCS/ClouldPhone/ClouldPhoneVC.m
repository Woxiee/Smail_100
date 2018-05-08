//
//  ClouldPhoneVC.m
//  Smail_100
//
//  Created by ap on 2018/3/26.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "ClouldPhoneVC.h"
#import "CloudPhoneCell.h"
#import "ItemContentList.h"
#import "HomeVModel.h"
#import "HomeHeaderView.h"
#import "NewProductCell.h"
#import "RecommendedView.h"
#import "ItemContentList.h"
#import "CloudInfoEditAndAddVC.h"
#import "GoodsAuctionXYVC.h"

#import "GoodsScreeningVC.h"
#import "GoodsDetailVC.h"

@interface ClouldPhoneVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) UICollectionView *collectionView;
@property(nonatomic,assign) NSUInteger page;
@property (nonatomic, strong) NSMutableDictionary *deviceDic;

@end

@implementation ClouldPhoneVC
static NSString *homeStoreHeaderViewIdentifier = @"RecommendedView";
static NSString *newProductCell = @"newProductID";
static NSString *CloudPhoneCellID = @"CloudPhoneCellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
    [self requestListNetWork];

    WEAKSELF;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf requestListNetWork];
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf requestListNetWork];
    }];
    [weakSelf.collectionView.mj_header endRefreshing];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDeviceInfoRequest];
}
#pragma mark - request

- (void)requestListNetWork
{
    WEAKSELF;
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageno"];
    [param setObject:@"10" forKey:@"page_size"];
    [BaseHttpRequest postWithUrl:@"/Device/getGoods" andParameters:nil andRequesultBlock:^(id result, NSError *error) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            if (weakSelf.page == 1) {
                [weakSelf.resorceArray removeAllObjects];
            }
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                NSArray  *imgList = [NSArray yy_modelArrayWithClass:[ItemContentList class] json:result[@"itemInfoList"]];
                for (int i= 0; i< imgList.count;i++) {
                    NSDictionary *dic = result[@"itemInfoList"][i];
                    ItemContentList *item = [ItemContentList yy_modelWithJSON:dic[@"itemContentList"]];
                    [weakSelf.resorceArray addObject:item];

                }
                [weakSelf.collectionView reloadData];
                [weakSelf stopRefresh];

            }
        }else{
            
        }
        
    }];
}


- (void)getRemoveRequest
{
    WEAKSELF;
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_deviceDic[@"devid"] forKey:@"devid"];
    [BaseHttpRequest postWithUrl:@"/device/unbind" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                [weakSelf getDeviceInfoRequest];
                [weakSelf.view makeToast:result[@"msg"]];
          
            }
        }else{
            _deviceDic[@""] = @"";
            _deviceDic = nil;
//            [weakSelf.view makeToast:result[@"msg"]];
        }
        
    }];

}



- (void)getDeviceInfoRequest
{
    WEAKSELF;
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [BaseHttpRequest postWithUrl:@"/device/getInfo" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:result[@"data"]];
            weakSelf.deviceDic = mutableItem ;
            [weakSelf.collectionView reloadData];
        }
        else{
            weakSelf.deviceDic = [[NSMutableDictionary alloc] init];
            weakSelf.deviceDic[@"status"] = @"status";
            weakSelf.deviceDic[@"devid"] = @"";
            [weakSelf.collectionView reloadData];

//            [weakSelf.view makeToast:result[@"msg"]];
        }
    }];
    
}


//api/device/getInfo
#pragma mark - private
/// 配置基础设置
- (void)setConfiguration
{
    self.title = @"我的云设备";
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CloudPhoneCell" bundle:nil] forCellWithReuseIdentifier:CloudPhoneCellID];
    ///商品
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewProductCell" bundle:nil] forCellWithReuseIdentifier:newProductCell];
    //SectionheaderView
    [self.collectionView registerClass:[RecommendedView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:homeStoreHeaderViewIdentifier];

}


/// 初始化视图
- (void)setup
{
    _page = 1;
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsZero;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT ) collectionViewLayout:layout];

    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    self.collectionView.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
}


#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    //    return 1;
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.resorceArray.count;

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF;
    if (indexPath.section == 0) {
        CloudPhoneCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CloudPhoneCellID forIndexPath:indexPath];
        if (!cell) {
            cell = [CloudPhoneCell new];
        }
        cell.resultDic = _deviceDic;
        cell.didClickLookInfoBlcok = ^{
            GoodsAuctionXYVC  *vc = [[GoodsAuctionXYVC alloc] init];
            vc.clickUrl = _deviceDic[@"vid_url"];
            vc.title = @"设备信息";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        cell.didClickConnectionBlcok = ^(NSString *str ){
            if ([str isEqualToString:@"关联"]) {
                CloudInfoEditAndAddVC *vc = [[CloudInfoEditAndAddVC alloc] init];
                vc.isConnection = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                [weakSelf getRemoveRequest];
            }
        };

        return cell;
    }

    NewProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:newProductCell forIndexPath:indexPath];
    if (!cell) {
        cell = [NewProductCell new];
    }
//    cell.didClickCellBlock = ^(ItemContentList *model) {
//        [weakSelf addGoodsInCar:model];
//    };
    cell.model = self.resorceArray[indexPath.row];
    return cell;

}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        ItemContentList *contenModle =  self.resorceArray[indexPath.row];
        if ([contenModle.clickType isEqualToString:@"web"]) {
            if (KX_NULLString(contenModle.url)) {
                return;
            }
            GoodsAuctionXYVC *VC = [[GoodsAuctionXYVC alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            VC.clickUrl = contenModle.url;
            
            [self.navigationController pushViewController:VC animated:YES];
        }
        else if ([contenModle.clickType isEqualToString:@"app_category"]){
            GoodsScreeningVC *VC = [[GoodsScreeningVC alloc] init];
            VC.category_id = contenModle.id;
            VC.hidesBottomBarWhenPushed = YES;
            VC.title =  contenModle.itemTitle;
            
            [self.navigationController pushViewController:VC animated:YES];
        }
        else {
            
            GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                         navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
            //    vc.productID = model.mainResult.mainId;
            //    vc.typeStr = model.productType;
            vc.productID = contenModle.goods_id;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: vc animated:YES];
        }
        
    }
    
    
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 125);
    }
    ItemContentList *item = self.resorceArray[indexPath.row];
    if (item.tags.count >0) {
        return CGSizeMake((SCREEN_WIDTH - 2)/2, 295 *(hScale - 0.03));
    }
    if (item.tags.count >=6) {
        return CGSizeMake((SCREEN_WIDTH - 2)/2, 310*(hScale - 0.03));
    }
    return CGSizeMake((SCREEN_WIDTH - 2)/2, 280 *(hScale - 0.03));

}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return CGSizeMake(SCREEN_WIDTH , 50);
    }
    return CGSizeMake(0 , 0);

}


- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
    RecommendedView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:homeStoreHeaderViewIdentifier forIndexPath:indexPath];
        [headerView.detailBtn setImage:[UIImage imageNamed:@"yunshebei2@3x.png"] forState:UIControlStateNormal];

        [headerView.detailBtn setTitle:@" 云设备套餐" forState:UIControlStateNormal];
        return headerView;
    }
    return nil;

}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 0, 0);//商品cell
}

//item 列间距(纵)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 2;//商品cell
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}



#pragma mark - refresh 添加刷新方法
-(void)setRefresh
{
    WEAKSELF;
    [self.collectionView headerWithRefreshingBlock:^{
        [weakSelf loadNewDate];
    }];
    
    [self.collectionView footerWithRefreshingBlock:^{
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
    [self.collectionView  stopFresh:self.resorceArray.count pageIndex:self.page];
    //
    if (self.resorceArray.count == 0) {
        [self.collectionView addSubview:[KX_LoginHintView notDataView]];
    }else{
        [KX_LoginHintView removeFromSupView:self.collectionView];
    }
    
}
@end
