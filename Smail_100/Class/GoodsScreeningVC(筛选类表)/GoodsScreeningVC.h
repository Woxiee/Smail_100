//
//  GoodsScreeningVC.h
//  MyCityProject
//
//  Created by Faker on 17/5/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,  GoodsScreenSelectType){
    GoodsScreenNomalType,               /// 正常显示
    GoodsScreenCollectType,             ///采集
    GoodsScreenAuctionType,             ///拍卖
    GoodsScreenWholeType,               ///  整机流转 &  共享
    GoodsScreenSoliciType,              ///  求租
    GoodsScreenDetectionType,           ///  检测吊运
    GoodsScreenOtherType,               /// 其他显示
    
};

//typedef NS_ENUM(NSInteger, LookType){
//    
//};

@interface GoodsScreeningVC : KX_BaseViewController
@property (nonatomic, strong) NSString  *typeStr;   ///从首页跳转的类型
@property (nonatomic, strong) NSString  *seachTitle; ///从首页跳转的 title
@property (nonatomic, assign) GoodsScreenSelectType goodsScreenType;  ///筛选数据显示问题

/// 列表接口所需参数
@property (nonatomic, strong)  NSString   *paymentType; /// 付款方式：
@property (nonatomic, strong)  NSString   *transactionType; ///交易类型：
@property (nonatomic, strong)  NSString   *orderBy; /// 排序：：
@property (nonatomic, strong)  NSString   *keyWord; ///关键字筛选
@property (nonatomic, strong)  NSString   *region; ///地区筛选

@property (nonatomic, strong)  NSString   *category_id; ///商品类别id



@end
