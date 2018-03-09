//
//  GoodDetailImageVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/9.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodDetailImageVC.h"
#import "GoodSDetailModel.h"
#import "LoadingTableFootView.h"
#import "GoodsSameWebCell.h"
#import "GoodsListModel.h"
#import "HomeHeaderView.h"
#import "GoodsSameCell.h"
#import "GoodsSameFootView.h"
#import "GoodsVModel.h"

@interface GoodDetailImageVC ()<UIWebViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *sameGoodsCollectView;
@property (nonatomic, strong) NSMutableArray *sameArray;
@property (nonatomic, strong) LoadingTableFootView *footView;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation GoodDetailImageVC
{
    CGFloat _maxWebHight;      /// webview的高度
}

static NSString * const goodsSameWebCellID = @"goodsSameWebCellID";
static NSString *homeStoreHeaderViewIdentifier = @"HomeStoreHeaderView";
static NSString *goodsSameCellID = @"goodsSameCellID";
static NSString *goodsSameFootViewID = @"goodsSameFootViewID";

- (void)viewDidLoad {
    [super viewDidLoad];
    _sameArray = [[NSMutableArray alloc] init];
    [self setup];
    [self setConfiguration];
    [self getGoodsDetailInfoRequest];
}

/// 配置基础设置
- (void)setConfiguration
{
    [_sameGoodsCollectView registerNib:[UINib nibWithNibName:@"GoodsSameWebCell" bundle:nil] forCellWithReuseIdentifier:goodsSameWebCellID];
    
    [_sameGoodsCollectView registerNib:[UINib nibWithNibName:@"GoodsSameCell" bundle:nil] forCellWithReuseIdentifier:goodsSameCellID];
    
    //SectionheaderView
    [_sameGoodsCollectView registerNib:[UINib nibWithNibName:@"HomeHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:homeStoreHeaderViewIdentifier];
    
    //SectionfooterView
    [_sameGoodsCollectView registerNib:[UINib nibWithNibName:@"GoodsSameFootView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:goodsSameFootViewID];
    

}

/// 初始化视图
- (void)setup
{
//    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
//    _sameGoodsCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, SCREEN_HEIGHT-50 - 64) collectionViewLayout:layout];
//    _sameGoodsCollectView.delegate = self;
//    _sameGoodsCollectView.dataSource = self;
//    _sameGoodsCollectView.backgroundColor = BACKGROUND_COLOR;
//    
//    [self.view addSubview:_sameGoodsCollectView];
    [self.view addSubview:self.webView];
    
}


#pragma mark - request
#pragma mark - request
/// 商品详情
- (void)getGoodsDetailInfoRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
    if ([self.typeStr isEqualToString:@"6"]) {
        [param setObject:_productID forKey:@"serviceId"];
        [GoodsVModel getGoodsLiftDetailParam:param successBlock:^(NSArray *dataArray, BOOL isSuccess) {
            if (isSuccess) {
                if (weakSelf.resorceArray.count >0) {
                    [weakSelf.resorceArray removeAllObjects];
                }
                GoodSDetailModel *model = dataArray[0];
                [ weakSelf.webView loadHTMLString:model.serviceResultMap.detailDesc baseURL:[NSURL URLWithString:HEAD__URL]];

                
            }else{
                [self.view toastShow:@"请求错误~"];
            }
            
        }];

    }
    else if ([_typeStr isEqualToString:@"9"]){
            [param setObject:_productID forKey:@"hotId"];
        [GoodsVModel getGoodscollectDetailParam:param successBlock:^(NSArray<GoodSDetailModel *> *dataArray, BOOL isSuccess) {
            if (isSuccess) {
                if (weakSelf.resorceArray.count >0) {
                    [weakSelf.resorceArray removeAllObjects];
                }
                GoodSDetailModel *model = dataArray[0];
                [ weakSelf.webView loadHTMLString:model.mainResult.detailDesc baseURL:[NSURL URLWithString:HEAD__URL]];
                //            [weakSelf.resorceArray addObjectsFromArray:dataArray];
                //            [weakSelf.sameArray addObject:dataArray];
                //            [weakSelf.sameGoodsCollectView reloadData];
                //            [weakSelf getGoodsDetailSameRequest];
                
            }else{
                [self.view toastShow:@"请求错误~"];
                
            }

        }];

    }
    else{
        [param setObject:_productID forKey:@"mainId"];
        [GoodsVModel getGoodsDetailParam:param successBlock:^(NSArray<GoodSDetailModel *> *dataArray, BOOL isSuccess) {
            if (isSuccess) {
                if (weakSelf.resorceArray.count >0) {
                    [weakSelf.resorceArray removeAllObjects];
                }
                GoodSDetailModel *model = dataArray[0];
                [ weakSelf.webView loadHTMLString:model.mainResult.detailDesc baseURL:[NSURL URLWithString:HEAD__URL]];
                //            [weakSelf.resorceArray addObjectsFromArray:dataArray];
                //            [weakSelf.sameArray addObject:dataArray];
                //            [weakSelf.sameGoodsCollectView reloadData];
                //            [weakSelf getGoodsDetailSameRequest];
                
            }else{
                [self.view toastShow:@"请求错误~"];

            }
            
        }];

    }
    
}
///  类似产品
- (void)getGoodsDetailSameRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_typeStr forKey:@"itemsType"];
    [GoodsVModel getGoodsSameDetailParam:param successBlock:^(NSArray *dataArray,NSArray *dataArray1, BOOL isSuccess) {
        if (isSuccess) {
          [_sameArray addObject:dataArray];
          [_sameArray addObject:dataArray1];
        [weakSelf.sameGoodsCollectView reloadData];

        }
    }];
}


//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    NSLog(@"加载成功");
//    NSString *jsStr = [NSString getJSWithScreentWidth:SCREEN_WIDTH];
//    //注入js
//    [webView stringByEvaluatingJavaScriptFromString:jsStr];
//    //获取webView的contentSize
//    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].scrollHeight"] floatValue];
//      CGRect webFrame = self.webView.frame;
//    _maxWebHight = height;
//    webFrame.size.height = height - 50;
//    self.webView.frame = webFrame;
//
////    if (_isLoading == NO) {
////        [_sameGoodsCollectView reloadData];
////        _isLoading= YES;
////    }
//}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"加载失败");
}


#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _sameArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  [_sameArray[section] count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section ==0) {
        GoodSDetailModel *model = _sameArray[0][0];
        GoodsSameWebCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:goodsSameWebCellID forIndexPath:indexPath];
        if (!cell) {
            cell = [GoodsSameWebCell new];
        }
        cell.detailWebView.delegate = self;
        cell.backgroundColor = [UIColor whiteColor];

        [ cell.detailWebView loadHTMLString:model.mainResult.detailDesc baseURL:[NSURL URLWithString:HEAD__URL]];
        return cell;
    }
    GoodsSameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:goodsSameCellID forIndexPath:indexPath];
    if (!cell) {
        cell = [GoodsSameCell new];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = _sameArray[indexPath.section][indexPath.row];
    return cell;
   
   
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (_maxWebHight == 0) {
            return CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT - 64);
        }else{
            return CGSizeMake(SCREEN_WIDTH,_maxWebHight);
        }
    }
    return CGSizeMake((SCREEN_WIDTH - 12)/2, 237);


}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}



- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }
    
    return CGSizeMake(SCREEN_WIDTH, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return CGSizeMake(SCREEN_WIDTH, 50);
    }
    return CGSizeZero;
}


- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        NSArray *titleArr = @[@"",@"热销商品",@"产品推荐"];
        HomeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:homeStoreHeaderViewIdentifier forIndexPath:indexPath];
        headerView.titleLabel.text = titleArr[indexPath.section];
        headerView.moreBtn.hidden = YES;
        indexPath.section == 0?  (headerView.hidden = YES): (headerView.hidden = NO);
        return headerView;
    }
    
    else if (kind == UICollectionElementKindSectionFooter){
        GoodsSameFootView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:goodsSameFootViewID forIndexPath:indexPath];
        return footView;
    }
    return nil;
    
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (UIWebView *)webView
{
    if(!_webView){
        _webView = [[UIWebView alloc] init];
   
        _webView.frame =    CGRectMake(0, 0, SCREEN_WIDTH,  SCREEN_HEIGHT-50 - 64);
        
        _webView.delegate = self;
        [_webView setScalesPageToFit:YES];
        _webView.scrollView.scrollEnabled = YES;
    }
    return _webView;
}

@end
