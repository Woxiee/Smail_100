//
//  GoodsClassVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/3.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsClassVC.h"
#import "GoodsClassVModel.h"
#import "ShopMoreGoodsCell.h"
#import "GoodsCategoryCell.h"
#import "GoodsCategoryCollectionHeader.h"
#import "PYSearchViewController.h"
#import "GoodsDetailVC.h"
#import "HomeScrollCell.h"
#import "GoodsScreeningVC.h"

//#import "header"
@interface GoodsClassVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,PYSearchViewControllerDelegate,HomePageCycScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) GoodsClassModel *classModel;
@property (nonatomic, strong)  UITextField *inPutTextField;


@end

@implementation GoodsClassVC
{

}
static NSString *GOODCATEGORYCVHEADERID = @"GOODCATEGORYCVHEADERID";//头部
#define ShopMoreGoodsCellIndefiner @"ShopMoreGoodsCell"
static NSString * const imageCellIdentifier = @"HomeScrollCellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getGoodsList:@"0"];

}

/// 配置基础设置
- (void)setConfiguration
{
//    self.title = @"分类";
    _titleArr = [[NSMutableArray alloc] init];

}

/// 初始化视图
- (void)setup
{
//    self.leftNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftNaviBtn setImage:[UIImage imageNamed:@"muban1@3x.png"] forState:UIControlStateNormal];
//    [self.leftNaviBtn setImage:[UIImage imageNamed:@"muban1@3x.png"] forState:UIControlStateHighlighted];
//    [self.leftNaviBtn setTitle:[KX_UserInfo sharedKX_UserInfo].city forState:UIControlStateNormal];
//
//    self.leftNaviBtn.titleLabel.font=[UIFont systemFontOfSize:16];
//    [self.leftNaviBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
//    self.leftNaviBtn.backgroundColor=[UIColor clearColor];
    
//    [self.leftNaviBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:self.leftNaviBtn];
//    self.navigationItem.leftBarButtonItem = rightButton;
//    [self.leftNaviBtn sizeToFit];
//    [self.leftNaviBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
//
    [self setRightNaviBtnImage:[UIImage imageNamed:@"shouye18@3x.png"]];

    self.view.backgroundColor = BACKGROUNDNOMAL_COLOR;
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 115, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 44.f;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:tableView];
    self.tableView = tableView;

    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(tableView.frame), 0, SCREEN_WIDTH -CGRectGetMaxX(tableView.frame)   , SCREEN_HEIGHT - 64) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
  
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
//
    //注册需要的cell和header
    [ self.collectionView registerNib:[UINib nibWithNibName:@"GoodsCategoryCollectionHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GOODCATEGORYCVHEADERID];
    [ self.collectionView registerNib:[UINib nibWithNibName:@"ShopMoreGoodsCell" bundle:nil] forCellWithReuseIdentifier:ShopMoreGoodsCellIndefiner];
    //轮播图
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeScrollCell" bundle:nil] forCellWithReuseIdentifier:imageCellIdentifier];
    
    UITextField *inPutTextField = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 120)/2, 10, SCREEN_WIDTH - 120, 30)];
    
    inPutTextField.placeholder = @"找商品, 找商家,找品牌";
    inPutTextField.textColor = [UIColor whiteColor];
    inPutTextField.font = Font13;
    inPutTextField.returnKeyType = UIReturnKeySearch;
    inPutTextField.backgroundColor =[UIColor whiteColor];
    inPutTextField.borderStyle = UITextBorderStyleNone;
    [inPutTextField layerForViewWith:15 AndLineWidth:0];
    _inPutTextField = inPutTextField;
    //搜索框里面的UI
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    view.backgroundColor = [UIColor clearColor];
    inPutTextField.leftViewMode = UITextFieldViewModeAlways;
    inPutTextField.leftView = view;
    UIImageView * searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 14, 14)];
    searchImage.backgroundColor = [UIColor clearColor];
    searchImage.image = [UIImage imageNamed:@"21@3x.png"];
    [view addSubview:searchImage];
    
    UIButton *coverToSeach =  [[UIButton alloc]initWithFrame:CGRectMake(0, 0, inPutTextField.width, inPutTextField.height)];
    coverToSeach.backgroundColor = [UIColor clearColor];
    [coverToSeach addTarget:self  action:@selector(clickToSearch) forControlEvents:UIControlEventTouchUpInside];
    [inPutTextField addSubview:coverToSeach];
    self.navigationItem.titleView = inPutTextField;
    
}





///搜索
- (void)clickToSearch
{
    WEAKSELF;
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:@[@"新机",@"采购",@"集采"] searchBarPlaceholder:@"找商品、找商家、找品牌" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        //        weakSelf.keyWord = searchText;
        //        [weakSelf requestListNetWork];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    // 3. Set style for popular search and search history
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleCell;
    searchViewController.hotSearchStyle =  PYHotSearchStyleRectangleTag;
    // 4. Set delegate
    searchViewController.delegate = self;
    // 5. Present a navigation controller
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)popVC
{
//    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
//        [KX_UserInfo presentToLoginView:self];
//        return;
//    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didClickRightNaviBtn
{
//    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
//        [KX_UserInfo presentToLoginView:self];
//        return;
//    }
    self.tabBarController.selectedIndex = 3;
}


#pragma mark - request
/// 获取分类
- (void)getGoodsList:(NSString *)ids
{
    WEAKSELF;
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:ids,@"pid", nil];
    [GoodsClassVModel getGoodsClassListParam:param successBlock:^(NSArray<GoodsClassModel *> *dataArray, BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.titleArr removeAllObjects];
            if (weakSelf.resorceArray.count >0) {
                [weakSelf.resorceArray removeAllObjects];
            }

            GoodsClassModel *model = dataArray.firstObject;
            
            for (int i = 0; i<model.leftCategory.count; i++) {
                LeftCategory *category = model.leftCategory[i];
                if (i == 0) {
                    category.select = YES;
                    [weakSelf getLeveGoodsRequestIds:category.id];
                }
                [weakSelf.titleArr addObject:category];

            }
            
            
          

            [weakSelf.tableView reloadData];

        }
       
        
    }];
}


- (void)getLeveGoodsRequestIds:(NSString *)ids
{
    WEAKSELF;
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:ids,@"ids", nil];
    [GoodsClassVModel getGoodsLevesListParam:param successBlock:^(NSArray<GoodsClassModel *> *dataArray, BOOL isSuccess) {
        if (isSuccess) {
            if (weakSelf.resorceArray.count >0) {
                [weakSelf.resorceArray removeAllObjects];
            }
            GoodsClassModel *model = dataArray.firstObject;
            weakSelf.classModel = model;

            [weakSelf.resorceArray addObjectsFromArray:model.rightCategory];
            [weakSelf.collectionView reloadData];
        }
        
        
    }];

}


#pragma mark UITableView  delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellID = @"GoodsCategoryCellID";
    GoodsCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCategoryCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     LeftCategory * model = _titleArr[indexPath.row];
    if (model.select) {
        cell.backgroundColor = [UIColor clearColor];
    }else{
    cell.backgroundColor = BACKGROUNDNOMAL_COLOR;
    }
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
        [KX_UserInfo presentToLoginView:self];
        return;
    }
    for (LeftCategory * model in _titleArr) {
        model.select = NO;
    }
    LeftCategory * model = _titleArr[indexPath.row];
    model.select = YES;
    [tableView reloadData];
    [self getLeveGoodsRequestIds:model.id];
    
    
}


#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//  NSMutableDictionary *dic =  self.resorceArray[section];
//    if ([dic[@"isSelect"] isEqualToString:@"0"]) {
//        return 0;
//    }
//    return [dic[@"values"] count];
    
    if (section == 0) {
        return 1;
    }
    return self.resorceArray.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        HomeScrollCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageCellIdentifier forIndexPath:indexPath];
        NSMutableArray *listArr = [[NSMutableArray alloc] init];
        for (  Banners * model in _classModel.banners) {
            [listArr addObject:model.pict_url];
        }
        cell.modelArray = listArr;
        //        cell.newsList = _newsList;
        cell.backgroundColor = [UIColor clearColor];
        cell.delegate = self;
        return cell;
    }
    ShopMoreGoodsCell * mycell = [collectionView dequeueReusableCellWithReuseIdentifier:ShopMoreGoodsCellIndefiner forIndexPath:indexPath];
    if (!mycell) {
        mycell = [ShopMoreGoodsCell new];
    }
   LeftCategory * model =  self.resorceArray[indexPath.row];
//   NSArray *dataArr =  [Values mj_objectArrayWithKeyValuesArray:dic[@"values"]];
    mycell.goodsModel = model;
    return mycell;
}


- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 0);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF;
    if (kind == UICollectionElementKindSectionHeader) {
       __weak GoodsCategoryCollectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:GOODCATEGORYCVHEADERID forIndexPath:indexPath];
        NSMutableDictionary *dic = self.resorceArray[indexPath.section];
        Values *model =  [Values mj_objectWithKeyValues:dic];
        headerView.model = model;
        headerView.indexPath = indexPath;
        headerView.didClickHeadViewBtnBlock = ^(NSInteger index){
//            if ([dic[@"isSelect"] isEqualToString:@"1"]) {
//                dic[@"isSelect"] = @"0";
//                
//            }else{
//                dic[@"isSelect"] = @"1";
//            }
            [weakSelf.collectionView reloadData];
        };
        return headerView;
    }
    return nil;
    
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemW = (self.collectionView.width -10)/3;
    if (indexPath.section == 0 ) {
        return CGSizeMake(self.collectionView.width -10,itemW+30);
    }
    
    return CGSizeMake(itemW,itemW+30);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section ==1) {
        return UIEdgeInsetsMake(5, 5, 5,0);

    }
    return UIEdgeInsetsMake(5, 5, 0,5);
}

//item 列间距(纵)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{

    return 0;
}




//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}




//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (![KX_UserInfo sharedKX_UserInfo].loginStatus) {
        [KX_UserInfo presentToLoginView:self];
        return;
    }

    
    LeftCategory * model =  self.resorceArray[indexPath.row];
    if ([model.type intValue] == 0) {
        GoodsScreeningVC *vc = [[GoodsScreeningVC alloc] init];
        vc.category_id = model.id;
        [self.navigationController pushViewController: vc animated:YES];

    }
    else{
        /// 商品类型=1:新机。2:配构件。3:整机流转
        GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll
                                                     navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        //    vc.productID = model.mainResult.mainId;
        //    vc.typeStr = model.productType;
        vc.productID = model.id;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController: vc animated:YES];
    }




    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
