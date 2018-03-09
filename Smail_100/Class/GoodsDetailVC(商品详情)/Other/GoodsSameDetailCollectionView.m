//
//  GoodsSameDetailCollectionView.m
//  MyCityProject
//
//  Created by Faker on 17/5/18.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsSameDetailCollectionView.h"

#import "GoodsSameWebCell.h"
#import "GoodsListModel.h"
#import "HomeHeaderView.h"
#import "GoodsSameCell.h"
#import "GoodsSameFootView.h"
#import "GoodSDetailModel.h"

@interface  GoodsSameDetailCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource,UIWebViewDelegate>

@end


@implementation GoodsSameDetailCollectionView
{
    CGFloat _maxWebHight;      /// webview的高度

}
static NSString * const goodsSameWebCellID = @"goodsSameWebCellID";
static NSString *homeStoreHeaderViewIdentifier = @"HomeStoreHeaderView";
static NSString *goodsSameCellID = @"goodsSameCellID";
static NSString *goodsSameFootViewID = @"goodsSameFootViewID";

- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self setConfiguration];
    }
    return self;
    
}

/// 初始化视图
- (void)setup
{
    
}


/// 配置基础设置
- (void)setConfiguration
{
 
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = BACKGROUND_COLOR;

    [self registerNib:[UINib nibWithNibName:@"GoodsSameWebCell" bundle:nil] forCellWithReuseIdentifier:goodsSameWebCellID];
    
    [self registerNib:[UINib nibWithNibName:@"GoodsSameCell" bundle:nil] forCellWithReuseIdentifier:goodsSameCellID];
    
    //SectionheaderView
    [self registerNib:[UINib nibWithNibName:@"HomeHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:homeStoreHeaderViewIdentifier];
    
    //SectionfooterView
    [self registerNib:[UINib nibWithNibName:@"GoodsSameFootView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:goodsSameFootViewID];

    
    

}

- (void)setSameArray:(NSArray *)sameArray
{
    _sameArray = sameArray;
    [self setConfiguration];
    [self reloadData];
}


#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _sameArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_sameArray[section] count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        GoodSDetailModel *model = _sameArray[0][0];
        GoodsSameWebCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:goodsSameWebCellID forIndexPath:indexPath];
        if (!cell) {
            cell = [GoodsSameWebCell new];
        }
        cell.detailWebView.delegate = self;
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
        return CGSizeMake(SCREEN_WIDTH,_maxWebHight);
    }
    return CGSizeMake((SCREEN_WIDTH - 36)/2, 237);
    
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0 ) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 12, 0, 12);
    
}



- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }
    
    return CGSizeMake(SCREEN_WIDTH, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
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


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"加载成功");
    NSString *jsStr = [NSString getJSWithScreentWidth:SCREEN_WIDTH];
    //注入js
    [webView stringByEvaluatingJavaScriptFromString:jsStr];
    //获取webView的contentSize
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].scrollHeight"] floatValue];
 
    _maxWebHight = height;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self reloadData];
    });
    
}

@end
