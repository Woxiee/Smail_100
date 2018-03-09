//
//  KX_BaseTableViewController.h
//  KX_Service
//
//  Created by mac on 16/8/1.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>
//提示框
typedef void (^UIAlertViewBlock)(BOOL isOk);
//选择框
typedef void (^UIActionSheetViewBlock)(NSInteger index);
@interface KX_BaseTableViewController : UITableViewController
@property (nonatomic,copy) ImagePickerBlock imagePickerBlock;

@property (nonatomic,copy) UIAlertViewBlock alertViewblock;
@property (nonatomic,copy) UIActionSheetViewBlock sheetBlock;

@property (nonatomic, strong) NSMutableArray *resorceArray;

@property(retain,nonatomic)UIButton *rightNaviBtn;
@property(retain,nonatomic)UIButton *leftNaviBtn;

#pragma mark 封装系统对话框
- (void) systemAlertWithTitle:(NSString *)title andMsg:(NSString *)msg cancel:(NSString *)cancel sure:(NSString *)sure withOkBlock:(UIAlertViewBlock)block;
- (void) systemAlertWithTitle:(NSString *)title andMsg:(NSString *)msg withOkBlock:(UIAlertViewBlock)block;
- (void) systemAlertWithTitle:(NSString *)title andMsg:(NSString *)msg;
- (void) systemAlertTitle:(NSString *)title andMsg:(NSString *)msg withOkBlock:(UIAlertViewBlock)block;

#pragma 系统UIActionSheet封装
- (void) sheetWithTitle:(NSString *)title  andBlock:(UIActionSheetViewBlock)block andArray:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;


- (void)setNavigationTitleImage:(NSString *)imageName; // 设置Nav背景样式

-(void)setRightNaviBtnImage:(UIImage*)img;
-(void)setRightNaviBtnTitle:(NSString*)str;
-(void)setLeftNaviBtnImage:(UIImage*)img;
-(void)setLeftNaviBtnTitle:(NSString*)str;

-(void)setRightNaviBtnTitle:(NSString*)str withTitleColor:(UIColor *)titleColor;

//系统返回
- (void)setbackBarAction;

- (void)popVC;

#pragma mark - 封装选择图片
/**
 *  picker image
 */
//从相册中选择图片
- (void)selectImageByPhotoWithBlock:(ImagePickerBlock)block;

//从拍照中选择图片
- (void)selectImageByCameraWithBlock:(ImagePickerBlock)block;
@end
