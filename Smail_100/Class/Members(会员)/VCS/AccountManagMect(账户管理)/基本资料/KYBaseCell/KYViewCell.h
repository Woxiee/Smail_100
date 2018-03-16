//
//  KYViewCell.h
//  KYBaseCell
//
//  Created by mac_KY on 17/3/7.
//  Copyright © 2017年 mac_KY. All rights reserved.
//用于京台页面 不做自动适配 固定大小

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KYBaseCellItem.h"

@interface KYViewCell : UIView


@property(nonatomic,strong)UILabel  *titleLabel;
@property(nonatomic,strong)UILabel  *subTitleLabel;
@property(nonatomic,strong)UIView *bottonLine;

///*左边title  右边sunTitle和image  iamge可能空则隐藏 默认高44*/
//+(id)viewCellItem:(KYBaseCellItem *)item;//title---->(subTitle image)
//
//-(id)initWithItem:(KYBaseCellItem *)item;

/*使用该方法*/
-(id)initWithFrame:(CGRect)frame Item:(KYBaseCellItem *)item clickBack:(void(^)())handleBack;



@end
