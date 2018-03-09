//
//  SheetDownCollectonView.m
//  MyCityProject
//
//  Created by Faker on 17/5/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "SheetDownCollectonView.h"
#import "GoodGuigeCell.h"
#import "GoodGuigeSectionHeadView.h"
@interface SheetDownCollectonView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;  /// 选择数据源
@property (nonatomic, strong) NSMutableArray *titleArray;  ///标题数据源
@property (nonatomic, weak) UIView *darkView;
@property (nonatomic, strong) Values *selectValues; /// 选择属性


@end

@implementation SheetDownCollectonView
static NSString * const cellID = @"cellID";
static NSString *goodGuigeSectionHeadViewID = @"GoodGuigeSectionHeadView";

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
    UIView *darkView                = [[UIView alloc] init];
    darkView.userInteractionEnabled = YES;
    darkView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    darkView.backgroundColor        = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self addSubview:darkView];
    self.darkView = darkView;
    
    UITapGestureRecognizer  *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheetView)];
    [self.darkView addGestureRecognizer:tapGestureRecognizer];

    
    UICollectionViewFlowLayout  *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,self.height/2) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollEnabled = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    self.collectionView = collectionView;
    [self.collectionView registerNib:[UINib nibWithNibName:@"GoodGuigeCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GoodGuigeSectionHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:goodGuigeSectionHeadViewID];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), SCREEN_WIDTH, 45)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bottomView layerForViewWith:0 AndLineWidth:0.5];
    [self addSubview:bottomView];
    
    
    UIButton *restBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    restBtn.frame = CGRectMake(0, 0, bottomView.width/2, 45);
    [restBtn setTitle:@"重置" forState:UIControlStateNormal];
    [restBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    restBtn.titleLabel.font = Font15;
    [restBtn addTarget:self action:@selector(didClickRestAction:) forControlEvents:UIControlEventTouchUpInside];
    restBtn.tag = 100;

    [bottomView addSubview:restBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(bottomView.width/2, 0, bottomView.width/2, 45);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = Font15;
    sureBtn.tag = 101;
    [sureBtn addTarget:self action:@selector(didClickRestAction:) forControlEvents:UIControlEventTouchUpInside];

    sureBtn.backgroundColor = BACKGROUND_COLORHL;
    [bottomView addSubview:sureBtn];
    
}

/// 配置基础设置
- (void)setConfiguration
{

    _titleArray = [[NSMutableArray alloc] init];
}

/// 出现
- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    [keyWindow addSubview:self];
}

/// 消失
- (void)hiddenSheetView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        //        CGRect bgRect =  weakSelf.darkView.frame;
        //        CGRect chooseMenuRect =  weakSelf.contenView.frame;
        //        bgRect.origin.x= SCREEN_WIDTH;
        //        chooseMenuRect  = CGRectMake(SCREEN_WIDTH +40, 0, SCREEN_WIDTH- 40, SCREEN_HEIGHT);
        //        weakSelf.darkView.frame = bgRect;
        //        weakSelf.contenView.frame = chooseMenuRect;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }];
}

#pragma mark - get &set
-(void)setModel:(GoodsScreenmodel *)model
{
  _model = model;
  ///  NSArray *goodsSizeIDArray = nil;
    NSMutableArray *contenArray = [[NSMutableArray alloc] init];
    for (ItemsTypeDetail *itemsTypeDetail in _model.itemsTypeDetail) {
        LOG(@"%@", itemsTypeDetail.name);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:itemsTypeDetail.name forKey:@"name"];
        [dic setObject:@"0" forKey:@"isSelect"];

        [_titleArray addObject:dic];
    
        contenArray = [Values mj_objectArrayWithKeyValuesArray:itemsTypeDetail.values];
        for (Values *values in contenArray) {
            if (!KX_NULLString(self.values.id)) {
                if ([self.values.id isEqualToString:values.id]) {
                    values.isSelect = YES;
                }
            }
        }
        [self.dataArray addObject:contenArray];
    }
    
    
    
    [self.collectionView reloadData];

    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return  _titleArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSMutableDictionary *dic =  _titleArray[section];
    if ([dic[@"isSelect"] isEqualToString:@"0"]) {
        return 0;
    }
    return [_dataArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodGuigeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.section][indexPath.row];
    //    SelectAttrMap   * selectAttrMap  = _model.selectAttrMap;
   // LOG(@"%ld",(long)[cell.model.attrvalueId integerValue]);
    return cell;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake((SCREEN_WIDTH - 45 - 60)/2, 30);
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 70, 0, 10);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self changeModelValueWithIndexPatch:indexPath];

    Values *model = _dataArray[indexPath.section][indexPath.row];
    LOG(@"attrModel = %@",model.name);
    model.isSelect = YES;
    _selectValues = model;
  
    [self.collectionView reloadData];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if ([_model.onSale isEqualToString:@"0"]) {
        [iToast alertWithTitle:@"该商品已下架~"];
        return NO;
    }
     */
    return YES;
}



- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_WIDTH, 30);
    
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
        WEAKSELF;
    if (kind == UICollectionElementKindSectionHeader) {
        NSMutableDictionary *dic = _titleArray[indexPath.section];
        GoodGuigeSectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:goodGuigeSectionHeadViewID forIndexPath:indexPath];
        headerView.titleLabel.text = dic[@"name"];
        headerView.indexPath = indexPath;
        headerView.didClickHeadViewBtnBlock = ^(NSInteger index){
            if ([dic[@"isSelect"] isEqualToString:@"1"]) {
                dic[@"isSelect"] = @"0";
            }else{
                dic[@"isSelect"] = @"1";
            }
            [weakSelf.collectionView reloadData];

        };
        return headerView;
    
    }
    
    return nil;
    
}


#pragma mark  -private
- (void)changeModelValueWithIndexPatch:(NSIndexPath *)indexPath
{
    //LOG(@"_model.goodsSizeID = %@",_model.goodsSizeID);
    //LOG(@"_model.goodsSi = %@",_model.propertys);
    
    for ( Values *model  in  self.dataArray[indexPath.section]) {
        model.isSelect = NO;
    }

}


-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


- (void)didClickRestAction:(UIButton*)sender
{

    if (sender.tag == 100) {
        if (_didClickCollectionBlock) {
            _didClickCollectionBlock(_selectValues,sender.tag);
            [self hiddenSheetView];
        }
    }else
    {
        if (_selectValues == nil) {
            _didClickCollectionBlock(_selectValues,100);
            [self hiddenSheetView];
        }else{
            if (_didClickCollectionBlock) {
                _didClickCollectionBlock(_selectValues,sender.tag);
                [self hiddenSheetView];
            }
        }
        
       
    }

   
}
@end
