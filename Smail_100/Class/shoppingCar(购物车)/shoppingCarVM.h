//
//  shoppingCarVM.h
//  ShiShi
//
//  Created by mac_KY on 17/3/6.
//  Copyright © 2017年 fec. All rights reserved.
//注:  code == 0 =ok    code = 999 =err

#import <Foundation/Foundation.h>

#import "OrderGoodsModel.h"

#import "ItemContentList.h"



@interface shoppingCarVM : NSObject

@property (nonatomic,strong)NSMutableArray *limitDatasArr;

//@property (nonatomic,copy)void(^limitDatasBlock)(NSArray <GoodsModelInList*>*limitDatas ,NSInteger code);



/**
 计算总价

 @param goodsModels 商品
 */
-(NSString *)calculationCarAllPrice:(NSArray <OrderGoodsModel*>*)goodsModels;



/**
 计算 item的个数

 @param goodsModels 商品
 @return 总的选中个数
 */
-(NSString *)calcilationShopCarAllCount:(NSArray <OrderGoodsModel*>*)goodsModels;


#pragma mark - Datas
/**
 4.1新增购物车
 
 @param shopaCarGoodsBlock 返回数据模型和成功代码
 */
-(void)addShopCar:(ItemContentList*)goodsModel handleback:(void(^) (NSInteger code))shopaCarGoodsBlock;

/**
 得到购物车的数据

 @param shopaCarGoodsBlock 返回数据模型和成功代码
 */
-(void)getShopCarGoodsHandleback:(void(^)(NSArray *shopCarGoods ,NSInteger code))shopaCarGoodsBlock;

/**
 修改购物车的数量

 @param count 修改后的数量
 @param shopaCarGoodsBlock 成功／失败回调
 */
-(void)changeShopCarGoodsCount:(NSString *)count goods:(OrderGoodsModel*)goodsModel handleback:(void(^) (NSInteger code))shopaCarGoodsBlock;


/**
 清空购物车

 @param shopaCarGoodsBlock 成功／失败回调
 */
-(void)delectAllShopCarGoodsHandleback:(void(^) (NSInteger code))shopaCarGoodsBlock;



/**
 删除购物车某个购物项 4.2

 @param goodsModel 产品
 @param shopaCarGoodsBlock 成功／失败回调
 */
-(void)delectaShopCarGoods:(OrderGoodsModel*)goodsModel handleback:(void(^) (NSInteger code))shopaCarGoodsBlock;


/**
  收藏购物车的某个购物项

 @param goodsModel 产品
 @param state  1.收藏2.取消收藏
 @param shopaCarGoodsBlock 成功／失败回调
 */
-(void)collectShopCarGoods:(OrderGoodsModel*)goodsModel state:(NSString*)state handleback:(void(^) (NSInteger code))shopaCarGoodsBlock;


-(void)getLimitBuyData;
;


#pragma mark - publick
/**
 * GoodsModel -> OrderGoodsModel
 **/
//+ (OrderGoodsModel*)changeOrderGoodsModeValueWithGoodsModel:(GoodsModel *)model;
//
//+ (OrderGoodsModel*)changeGoodsModelInListToOrderGoodsModel:(GoodsModelInList*)model;

+ (OrderGoodsModel*)changeMarkModeValueWithGoodsModel:(MarketRuleList *)model;


@end
