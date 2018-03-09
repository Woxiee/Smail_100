//
//  GoodsCollectCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/16.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsCollectCell.h"
#import "GoodsCollectionCell.h"

@interface GoodsCollectCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation GoodsCollectCell
{
    UILabel *_nameLabel;
    UICollectionView *_collectionView;

}
static NSString *homePageCellID = @"homePageCellID";

- (void)awakeFromNib {
    [super awakeFromNib];


}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
           [self setup];
    }
    return self;
}

/// 初始化视图
- (void)setup
{
    _dataArray = [[NSMutableArray alloc ] init];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, SCREEN_WIDTH - 24, 20)];
    _nameLabel.textColor = TITLETEXTLOWCOLOR;
    _nameLabel.font = Font15;
    _nameLabel.numberOfLines = 2;
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_nameLabel];
    
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH -24)/3, 50);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameLabel.frame), SCREEN_WIDTH, 50) collectionViewLayout:layout];
    [self addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.scrollsToTop = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerNib:[UINib nibWithNibName:@"GoodsCollectionCell" bundle:nil] forCellWithReuseIdentifier:homePageCellID];
}


-(void)setModel:(GoodSDetailModel *)model
{
    _model = model;
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray: _model.groupBuyResult.groupBuyPriceList] ;

    CGSize  nameLabelSize = [NSString heightForString:_model.groupBuyResult.groupBuyName fontSize:Font15 WithSize:CGSizeMake(SCREEN_WIDTH - 24, 40)];
    _nameLabel.frame = CGRectMake(12, 10, SCREEN_WIDTH - 24, nameLabelSize.height);

    int j = 0;
    for (int i = 0; i<_dataArray.count; i++) {
        if (i%3 == 0 ) {
            j++;
        }
    }
    
    _collectionView.frame = CGRectMake(0, CGRectGetMaxY(_nameLabel.frame), SCREEN_WIDTH, 50*j);
    _nameLabel.text = _model.groupBuyResult.groupBuyName;
    [_collectionView reloadData];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:homePageCellID forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
    
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 10.0f);
}

@end
