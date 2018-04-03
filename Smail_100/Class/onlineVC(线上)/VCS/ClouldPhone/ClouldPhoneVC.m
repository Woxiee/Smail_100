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
    [self getNetWorkRequest];

    WEAKSELF;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf getNetWorkRequest];
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf getNetWorkRequest];
    }];
    [weakSelf.collectionView.mj_header endRefreshing];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDeviceInfoRequest];
}
#pragma mark - request



- (void)getNetWorkRequest
{
    WEAKSELF;
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageno"];
    [param setObject:@"10" forKey:@"page_size"];
    [BaseHttpRequest postWithUrl:@"/Device/getGoods" andParameters:nil andRequesultBlock:^(id result, NSError *error) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                NSArray  *imgList = [NSArray yy_modelArrayWithClass:[ItemContentList class] json:result[@"itemInfoList"]];
                for (int i= 0; i< imgList.count;i++) {
                    NSDictionary *dic = result[@"itemInfoList"][i];
                    ItemContentList *item = [ItemContentList yy_modelWithJSON:dic[@"itemContentList"]];
                    [weakSelf.resorceArray addObject:item];

                }
                [weakSelf.collectionView reloadData];
               
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
                [weakSelf.view toastShow:result[@"msg"]];
          
            }
        }else{
            _deviceDic[@""] = @"";
            _deviceDic = nil;
//            [weakSelf.view toastShow:result[@"msg"]];
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

//            [weakSelf.view toastShow:result[@"msg"]];
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
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    layout.sectionInset = UIEdgeInsetsZero;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
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


//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 130);
    }
    return CGSizeMake((SCREEN_WIDTH - 15)/2, 270);

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
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5,5, 5);//商品cell

}

//item 列间距(纵)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 5;
}

@end
