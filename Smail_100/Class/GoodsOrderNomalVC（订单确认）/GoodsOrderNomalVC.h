//
//  GoodsOrderNomalVC.h
//  MyCityProject
//
//  Created by Faker on 17/5/22.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodSDetailModel.h" 
#import "ItemContentList.h"
#import "OrderGoodsModel.h"
typedef NS_ENUM(NSInteger, GoodsOrderType) {
    NomalOrderType,
    ShoppinCarType,

};


@interface GoodsOrderNomalVC : KX_BaseViewController
@property (nonatomic, strong) GoodSDetailModel *model;
@property (nonatomic, assign) GoodsOrderType orderType;
@property (nonatomic, strong) ItemContentList *itemsModel;
//@property (nonatomic, strong) OrderGoodsModel *orderGoodsModel;
@property(nonatomic,strong) NSMutableArray <OrderGoodsModel*>* goodsListArray;
@end
