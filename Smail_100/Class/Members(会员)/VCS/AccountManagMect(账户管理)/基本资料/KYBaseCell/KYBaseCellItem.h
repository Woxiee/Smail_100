//
//  KYBaseCellItem.h
//  KYBaseCell
//
//  Created by mac_KY on 17/3/3.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^BaseCellItemOption)();
@interface KYBaseCellItem : NSObject


/**  图标 */
@property (nonatomic, copy) NSString *imgName;
/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 子标题 */
@property (nonatomic, copy) NSString *subTitle;


/** 右边的图片 */
@property(nonatomic,strong)NSString *rightIcom;
/** 选中才会有的右边的图片 */
@property(nonatomic,strong)NSString *selectRightIcom;

@property(nonatomic,assign)BOOL cellSelect;

/**
 *  存储数据用的key
 */
//@property (nonatomic, copy) NSString *key;

/**
 *  点击那个cell需要做什么事情
 */
@property (nonatomic, copy) BaseCellItemOption operation;
/**
 *  点击那个cell需要跳到那一个类
 */
@property(nonatomic,strong)NSString *className;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle;
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;



/**
 左边标题 右边一张图片的河右边距离 12
 
 @param title 标题
 @param selectRightIcom 图片
 @return item
 */
+(instancetype)itemWithTitle:(NSString *)title selectRightIcom:(NSString *)selectRightIcom;
/*右边图片 传控那么将 不显示*/
+(instancetype)itemWithTitle:(NSString *)title rightIcom:(NSString *)rightIcom;

@end
