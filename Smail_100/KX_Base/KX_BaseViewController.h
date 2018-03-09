//
//  KX_BaseViewController.h
//  KX_Service
//
//  Created by mac on 16/8/1.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

//图片上传
typedef void (^ImagePickerBlock)(UIImage *image);
//提示框
typedef void (^UIAlertViewBlock)(BOOL isOk);
//选择框
typedef void (^UIActionSheetViewBlock)(NSInteger index);

@interface KX_BaseViewController : UIViewController
@property(retain,nonatomic)UIButton *rightNaviBtn;
@property(retain,nonatomic)UIButton *leftNaviBtn;
@property (nonatomic,copy)NSString *customer_id;

@property (nonatomic,copy) ImagePickerBlock imagePickerBlock;
@property (nonatomic,copy) UIAlertViewBlock alertViewblock;
@property (nonatomic,copy) UIActionSheetViewBlock sheetBlock;

@property (nonatomic, copy) NSMutableArray  *resorceArray;

- (void)setNavigationTitleImage:(NSString *)imageName; // 设置Nav背景样式

-(void)setRightNaviBtnImage:(UIImage*)img;
-(void)setRightNaviBtnTitle:(NSString*)str withTitleColor:(UIColor *)titleColor;
-(void)setLeftNaviBtnImage:(UIImage*)img;
-(void)setLeftNaviBtnTitle:(NSString*)str;

- (void)didClickRightNaviBtn;
//系统返回
- (void)setbackBarAction;

- (void)popVC;
- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay;//延迟调用

#pragma mark 添加自定义导航栏颜色
/**
 *  添加白色导航条
 */
- (void)addNavigationBarWhiteStyle;
/**
 *  蓝色导航条
 */
-(void)setNavigationBarColor;
/**
 *  添加红色导航条
 */
- (void)addNavigationBarRedStyle;


#pragma mark 封装系统对话框
- (void) systemAlertWithTitle:(NSString *)title andMsg:(NSString *)msg cancel:(NSString *)cancel sure:(NSString *)sure withOkBlock:(UIAlertViewBlock)block;
- (void) systemAlertWithTitle:(NSString *)title andMsg:(NSString *)msg withOkBlock:(UIAlertViewBlock)block;
- (void) systemAlertWithTitle:(NSString *)title andMsg:(NSString *)msg;
- (void) systemAlertTitle:(NSString *)title andMsg:(NSString *)msg withOkBlock:(UIAlertViewBlock)block;

#pragma 系统UIActionSheet封装
- (void) sheetWithTitle:(NSString *)title  andBlock:(UIActionSheetViewBlock)block andArray:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;


#pragma mark - 封装选择图片
/**
 *  picker image
 */
//从相册中选择图片
- (void)selectImageByPhotoWithBlock:(ImagePickerBlock)block;

//从拍照中选择图片
- (void)selectImageByCameraWithBlock:(ImagePickerBlock)block;

//注册TableViewCell
- (void) registerCollectionViewCellWithNibName:(NSString *) nibName forCellWithReuseIdentifier:(NSString *) identifier forTableView:(UITableView *) TableView;
//注册CollectionViewCell
- (void) registerCollectionViewCellWithNibName:(NSString *) nibName forCellWithReuseIdentifier:(NSString *) identifier forCollectionView:(UICollectionView *) collectionView;

//注册CollectionReusebleView
- (void) registerSectionHeaderFooterViewWithNibName:(NSString *) nibName forSupplementaryViewOfKind:(NSString *) kind withReuseIdentifier:(NSString *) identifier forCollectionView:(UICollectionView *) collectionView;

- (UIImage*) createImageWithColor: (UIColor*) color;

@end
