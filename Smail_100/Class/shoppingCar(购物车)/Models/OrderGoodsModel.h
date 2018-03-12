//
//  OrderGoodsModel.h
//  ShiShi
//
//  Created by ac on 16/4/6.
//  Copyright © 2016年 fec. All rights reserved.
////goodsName	goodsID	goodsImage	goodsNum	goodsSKU	goodsPrice	goodsCode goodsType 建表字段



//#import "GoodsModelInList.h"
@class MarketRuleList;
@class Products;
@interface OrderGoodsModel : NSObject
@property (nonatomic , copy) NSArray<Products *>              * products;

@property (nonatomic , copy) NSArray<OrderGoodsModel *>              * goodModel;

@property(nonatomic,strong) NSString * productId;

@property(nonatomic,strong) NSString * seller_id;

@property(nonatomic,strong) NSString * point;

@property(nonatomic,strong) NSString * productName;

@property (nonatomic,strong)NSString *productPrice;

@property (nonatomic,strong)NSString *itemCount;

@property (nonatomic,strong)NSString *productLogo;
@property (nonatomic,strong)NSString *seller_name;

@property (nonatomic,strong) NSString *store_nums;

@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *cid;

@property (nonatomic,strong)NSString *property;

@property (nonatomic, strong)  NSString  *ruleListStr;  ///  传递买送 规则数据
@property (nonatomic , copy) NSString              * number;

//jp
@property(nonatomic,strong) NSString *selectStatue; //1=select 0=deselect

//FK
@property(nonatomic,assign) NSInteger goodCount;

@property (nonatomic, strong) NSString *sendInfo; ///赠品信息


@property (nonatomic , strong) NSArray<MarketRuleList *>              * marketRuleList;


@property (nonatomic, strong) NSString *packQty;

@property(nonatomic,strong)NSString *isGive;//是否正品的如餐





@end
 
