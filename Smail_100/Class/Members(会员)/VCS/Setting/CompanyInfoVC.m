//
//  CompanyInfoVC.m
//  MyCityProject
//
//  Created by mac_KY on 17/5/26.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "CompanyInfoVC.h"
#import "SDPhotoBrowser.h"
#import "ChangeInfoVC.h"
#import "MemberInfoVModel.h"
#import "CategoryVC.h"

static  NSString  *cellectID = @"cellectID";
@interface CompanyInfoVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDPhotoBrowserDelegate>
/** 企业名称 */
@property (weak, nonatomic) IBOutlet UILabel *companyNameLb;
/** 企业简介 */
@property (weak, nonatomic) IBOutlet UILabel *companyDetailLb;
/** 经营类目 */
@property (weak, nonatomic) IBOutlet UILabel *categoryLb;
/** 营业执照编码 */
@property (weak, nonatomic) IBOutlet UILabel *CardIDLb;
/** 企业LOGO */
@property (weak, nonatomic) IBOutlet UIImageView *logoImgV;

/** 企业图片 */
@property (weak, nonatomic) IBOutlet UICollectionView *imgCellectionView;
/**  */
@property (nonatomic,strong) SDPhotoBrowser *photoBrower;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layouutConstraintHeigh;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *busiCateList;
@end

@implementation CompanyInfoVC

/*懒加载*/
-(SDPhotoBrowser *)photoBrower
{
    if (!_photoBrower) {
        //初始化数据
        _photoBrower = [[SDPhotoBrowser alloc]init];
        _photoBrower.backgroundColor = RGBA(53, 53, 53, 0.7);
        _photoBrower.delegate = self;
        _photoBrower.sourceImagesContainerView = self.view;
    }
    return _photoBrower;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadComment];
    [self loadSubView];
    [self loadData];
    
}

#pragma mark - 常数设置
- (void)loadComment
{
    self.photoBrower.backgroundColor = RGBA(53, 53, 53, 0.7);
    _busiCateList = [[NSArray alloc] init];
   
}


#pragma mark - 初始化子View
- (void)loadSubView
{
    [self loadNavItem];
    [self.imgCellectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellectID];
}

- (void)loadNavItem
{
    
}


#pragma mark - 网络数据请求
- (void)loadData
{
    WEAKSELF;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].bid forKey:@"bid"];

    [MemberInfoVModel getEnterpriseInfoUrl:@"/m/m_048" Param:param successBlock:^(NSArray<MemberModel *> *dataArray, BOOL isSuccess) {
        if (isSuccess) {
          LOG(@"%f", _layouutConstraintHeigh.constant);
            MemberModel *model = dataArray[0];
            _busiCateList = model.busiCateList;
            weakSelf.companyNameLb.text = model.business.busiCompName;
            //model.business.remark
            weakSelf.companyDetailLb.text = model.business.remark;
            NSMutableArray *busicateArr = [[NSMutableArray alloc] init];
            for (BusiCateList *cateModel in _busiCateList) {
                NSString *str = [NSString stringWithFormat:@"%@ %@ %@",cateModel.cateName1,cateModel.cateName2,cateModel.cateName3];
                [busicateArr addObject:str];
            }
            weakSelf.categoryLb.text = [busicateArr componentsJoinedByString:@"\n"];
            weakSelf.CardIDLb.text = model.business.busiCompTax;
         
            [weakSelf.logoImgV sd_setImageWithURL:[NSURL URLWithString:model.business.busiCompLogoUrl] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
            [weakSelf.resorceArray addObjectsFromArray:model.busiImgList];
            [weakSelf.imgCellectionView reloadData];
            NSString *categoryStr = [busicateArr componentsJoinedByString:@"\n"];
            NSString *contenStr = [NSString stringWithFormat:@"%@%@",model.business.remark,categoryStr];
            CGSize retSize = [NSString heightForString:contenStr fontSize:Font15 WithSize:CGSizeMake(SCREEN_WIDTH -24, 10000)];
            LOG(@"%f",retSize.height);
            _layouutConstraintHeigh.constant = 600+ retSize.height;

//            NSString *contenStr = [NSString stringWithFormat:@"%@%@",model.business.remark,weakSelf.categoryLb.text];
//
        }
    }];
}


#pragma mark - 点击事件
- (IBAction)clickCell:(UIButton *)sender {
    
    NSUInteger tag = sender.tag - 100;
    WEAKSELF
    /** 企业名称 */ /** 企业简介 *//** 经营类目 *//** 营业执照编码 */
    switch (tag) {
        case 0:
        {
       
        }break;
        case 1:
        {
            
        }break;
        case 2:
        {
//            CategoryVC *VC = [[CategoryVC alloc ] init];
//            VC.resorceArray = _busiCateList;
//            [self.navigationController pushViewController:VC animated:YES];
        }break;
        case 3:
        {
            
        }break;
            
        default:
            break;
    }
    
}



#pragma mark - private




#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
 
    return self.resorceArray.count;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellectID forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    BusiImgList *model = self.resorceArray[indexPath.row];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgName] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    [cell.contentView addSubview:imageView];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    self.photoBrower.imageCount = 10;
//    self.photoBrower.currentImageIndex = indexPath.row;
//    self.photoBrower.backgroundColor = RGBA(53, 53, 53, 0.7);
//
//    [self.photoBrower show];
}

#pragma mark - SDPhotoBrowserDelegate


- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [UIImage imageNamed:DEFAULTIMAGE];
}










@end
