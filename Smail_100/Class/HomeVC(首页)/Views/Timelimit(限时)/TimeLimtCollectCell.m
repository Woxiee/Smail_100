//
//  TimeLimtCollectCell.m
//  Smile_100
//
//  Created by ap on 2018/3/5.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "TimeLimtCollectCell.h"
#import "TimelimitCell.h"


@interface TimeLimtCollectCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end


@implementation TimeLimtCollectCell
static NSString *ID = @"ZYShareSheetCell";

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
         [self addSubview:self.collectionView];
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.frame = CGRectMake(0, 10, self.mj_w, self.mj_h - 10);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.itemContentList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TimelimitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
   ItemContentList *model =  self.model.itemContentList[indexPath.item];
    cell.model = model;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemContentList *model =  self.model.itemContentList[indexPath.item];
    if (_didClickItemBlock) {
        _didClickItemBlock(model);
    }
}

#pragma mark - getter


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, self.mj_w, self.mj_h - 10) collectionViewLayout:self.flowLayout];
        _collectionView.alwaysBounceHorizontal = YES; // 小于等于一页时, 允许bounce
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = nil;
        [_collectionView registerNib:[UINib nibWithNibName:@"TimelimitCell" bundle:nil] forCellWithReuseIdentifier:ID];

    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH /3.5, SCREEN_WIDTH /3.5 + 35);
    }
    return _flowLayout;
}


- (void)setModel:(ItemInfoList *)model
{
    _model = model;
    [self.collectionView reloadData];
}
@end
