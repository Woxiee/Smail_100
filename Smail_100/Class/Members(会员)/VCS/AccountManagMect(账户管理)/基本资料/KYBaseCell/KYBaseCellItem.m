//
//  KYBaseCellItem.m
//  KYBaseCell
//
//  Created by mac_KY on 17/3/3.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import "KYBaseCellItem.h"

@implementation KYBaseCellItem


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    KYBaseCellItem *item = [[self alloc] init];
    item.imgName = icon;
    item.title = title;
    return item;
}


+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle
{
    KYBaseCellItem *item = [[self alloc] init];
    item.imgName = icon;
    item.title = title;
    item.subTitle = subTitle;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    return [self itemWithIcon:nil title:title subTitle:subTitle];
}

/**
 左边标题 右边一张图片的河右边距离 12 
 */
+(instancetype)itemWithTitle:(NSString *)title selectRightIcom:(NSString *)selectRightIcom
{
    KYBaseCellItem *item = [[self alloc] init];
    item.selectRightIcom = selectRightIcom;
    item.title = title;
    return item;
    
}

/*右边图片 传控那么将 不显示*/
+(instancetype)itemWithTitle:(NSString *)title rightIcom:(NSString *)rightIcom
{
    KYBaseCellItem *item = [[self alloc] init];
    item.rightIcom = rightIcom;
    item.title = title;
    return item;
}

@end
