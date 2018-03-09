//
//  shoppingCarVM.m
//  ShiShi
//
//  Created by mac_KY on 17/3/6.
//  Copyright © 2017年 fec. All rights reserved.
//  插件化做准备  几乎购物车的逻辑都在这里   －请求数据－选中（本地处理）－加、减数量 －删除 － 收藏
//除喽 选中其他的状态都是网络标记  那么其他的状态改变必须重新请求购物车数据 但是标记选中从本地那数据


#import "shoppingCarVM.h"

@implementation shoppingCarVM

/*懒加载*/
-(NSMutableArray *)limitDatasArr
{
    if (!_limitDatasArr) {
        //初始化数据
        _limitDatasArr = [NSMutableArray array];
    }
    return _limitDatasArr;
}



/**
 计算总价
 
 @param goodsModels 商品
 */
-(NSString *)calculationCarAllPrice:(NSArray <OrderGoodsModel*>*)goodsModels{
    CGFloat allPrice = 0;
    for (OrderGoodsModel*model in goodsModels  ) {
        if (model.selectStatue.integerValue == 1) {
            allPrice += model.productPrice.floatValue *model.itemCount.floatValue;
        }
    }
    return [NSString stringWithFormat:@"¥%.2f",allPrice];
    
}
/*
 计算 item的个数
 
 @param goodsModels 商品
 @return 总的选中个数
 */
-(NSString *)calcilationShopCarAllCount:(NSArray <OrderGoodsModel*>*)goodsModels{
    
    int allCount = 0;
    for (OrderGoodsModel*model in goodsModels  ) {
        if (model.selectStatue.integerValue == 1) {
            allCount += model.itemCount.integerValue;
        }
    }
    return [NSString stringWithFormat:@"%d",allCount];
    
    
}
#pragma mark - 数据处理模块
/**
 4.1新增购物车
 _itemCount	NSTaggedPointerString *	@"1"	0xa000000000000311
 @param shopaCarGoodsBlock 返回数据模型和成功代码
 */
-(void)addShopCar:(ItemContentList*)goodsModel handleback:(void(^) (NSInteger code))shopaCarGoodsBlock{
    
    NSDictionary *list = @{@"productId":goodsModel.goods_id?goodsModel.goods_id:@"",@"nums":goodsModel.cartNum?goodsModel.cartNum:@""};
    NSArray* arr = @[list];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject: [arr mj_JSONString] forKey:@"productList"];
    [dic setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [dic setObject:goodsModel.goods_id forKey:@"goods_id"];
    [dic setObject:goodsModel.cartNum forKey:@"nums"];
    [dic setObject:goodsModel.comment?goodsModel.comment:@"" forKey:@"comment"];
    [dic setObject:@"add" forKey:@"method"];

    [BaseHttpRequest postWithUrl:@"/ucenter/cart" andParameters:dic andRequesultBlock:^(id result, NSError *error) {
        if (error) {
            [self showErrMsg:LocalMyString(NOTICEMESSAGE)];
        }else{
            NSString *msg = result[@"msg"];
            shopaCarGoodsBlock([result[@"code"] integerValue]);
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                [self showErrMsg:msg];
            }else{
                [self showErrMsg:msg];
            }
        }
    }];
}

/**
 得到购物车的数据
 
 @param shopaCarGoodsBlock 返回数据模型和成功代码
 */
-(void)getShopCarGoodsHandleback:(void(^)(NSArray *shopCarGoods ,NSInteger code))shopaCarGoodsBlock{
    
//    NSDictionary *dic  =@{@"type":kType,@"mid":[[LoginData loginData] getMid]};
//    [BaseHttpRequest postWithUrl:@"/cart/c_003" andParameters:dic  andRequesultBlock:^(id result, NSError *error) {
//        LOG(@"%@",result);
//        if (error) {
//            [self showErrMsg :LocalMyString(NOTICEMESSAGE)];
//        }else{
//            NSInteger state = [result[@"data"][@"state"] integerValue];
//            NSString *msg = result[@"data"][@"msg"];
//            if ([result[@"data"][@"list"] isKindOfClass:[NSArray class]]) {
//                NSArray *arr = [OrderGoodsModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
//                shopaCarGoodsBlock(arr,state);
//                return ;
//            }
//            shopaCarGoodsBlock([NSArray array],state);
//            if (state == 0) return ;
//            [self showErrMsg:msg];
//        }
//    }];
    
}

/**
 4.4修改购物车
 */
-(void)changeShopCarGoodsCount:(NSString *)count goods:(OrderGoodsModel*)goodsModel handleback:(void(^) (NSInteger code))shopaCarGoodsBlock{
    
    if (count == nil) {
        [self showErrMsg:@"系统异常"];
    }
    NSDictionary *dic = @{@"type":kType,@"itemCount":count,@"id":goodsModel.id};
    
    [BaseHttpRequest postWithUrl:@"/cart/c_004" andParameters:dic  andRequesultBlock:^(id result, NSError *error) {
        
        if (error) {
            [self showErrMsg:LocalMyString(NOTICEMESSAGE)];
        }else{
            NSInteger state = [result[@"data"][@"state"] integerValue];
            NSString *msg = result[@"data"][@"msg"];
            shopaCarGoodsBlock(state);
            if (state == 0) return ;
            [self showErrMsg:msg];
        }
    }];
}


/**
 4.5完成结算 清空购物车
 0
 @param shopaCarGoodsBlock 成功／失败回调
 */
-(void)delectAllShopCarGoodsHandleback:(void(^) (NSInteger code))shopaCarGoodsBlock{
    
//    NSDictionary *dic  =@{@"type":kType,@"mid":[[LoginData loginData] getMid]};
//    [BaseHttpRequest postWithUrl:@"/cart/c_005" andParameters:dic  andRequesultBlock:^(id result, NSError *error) {
//
//        if (error) {
//            [self showErrMsg:LocalMyString(NOTICEMESSAGE)];
//        }else{
//            NSInteger state = [result[@"data"][@"state"] integerValue];
//            NSString *msg = result[@"data"][@"msg"];
//            shopaCarGoodsBlock(state);
//            if (state == 0) return ;
//            [self showErrMsg:msg];
//
//        }
//    }];
}



/**
 删除购物车某个购物项 4.2
 
 @param goodsModel 产品
 @param shopaCarGoodsBlock 成功／失败回调
 */
-(void)delectaShopCarGoods:(OrderGoodsModel*)goodsModel handleback:(void(^) (NSInteger code))shopaCarGoodsBlock{
    if (goodsModel.id == nil) return;
    
//    NSDictionary *dic  =@{@"type":kType,@"mid":[[LoginData loginData] getMid],@"id":goodsModel.id};
//    [BaseHttpRequest postWithUrl:@"/cart/c_002" andParameters:dic  andRequesultBlock:^(id result, NSError *error) {
//        
//        if (error) {
//            [self showErrMsg:LocalMyString(NOTICEMESSAGE)];
//        }else{
//            NSInteger state = [result[@"data"][@"state"] integerValue];
//            NSString *msg = result[@"data"][@"msg"];
//            shopaCarGoodsBlock(state);
//            if (state == 0) return ;
//            [self showErrMsg:msg];
//            
//            
//        }
//    }];
//    
}


/**
 收藏购物车的某个购物项
 
 @param goodsModel 产品
 @param shopaCarGoodsBlock 成功／失败回调
 */
-(void)collectShopCarGoods:(OrderGoodsModel*)goodsModel state:(NSString*)state handleback:(void(^) (NSInteger code))shopaCarGoodsBlock{
    
//    NSDictionary *dic  =@{@"type":kType,@"mid":[[LoginData loginData] getMid],@"productId":goodsModel.productId,@"state":state};
//    [BaseHttpRequest postWithUrl:@"/m/m_025" andParameters:dic  andRequesultBlock:^(id result, NSError *error) {
//
//        if (error) {
//            [appD.window makeToast:LocalMyString(NOTICEMESSAGE)];
//        }else{
//            NSInteger state = [result[@"data"][@"state"] integerValue];
//            NSString *msg = result[@"data"][@"msg"];
//            shopaCarGoodsBlock(state);
//            if (state == 0) return ;
//            [self showErrMsg:msg];
//
//        }
//    }];
}

//推荐产品

-(void)getLimitBuyData
{
    
//    [BaseHttpRequest postWithUrl:@"/r/r_008" andParameters:@{@"mid":[LoginData loginData].getMid,@"bid":kBid}  andRequesultBlock:^(id result, NSError *error) {
//
//        if (error) {
//            [self showErrMsg :LocalMyString(NOTICEMESSAGE)];
//        }else{
//            NSInteger state = [result[@"data"][@"state"] integerValue];
//            NSString *msg = result[@"data"][@"msg"];
//            if ([result[@"data"][@"list"] isKindOfClass:[NSArray class]]) {
//                NSArray *arr = [GoodsModelInList mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];
//                if (_limitDatasBlock) {
//                    _limitDatasBlock(arr,state);
//                }
//
//                return ;
//            }
//            if (_limitDatasBlock) {
//                _limitDatasBlock([NSArray array],state);
//            }
//
//            if (state == 0) return ;
//            [self showErrMsg:msg];
//        }
//
//
//    }];
//
}

#pragma mark - publick
///**
// * GoodsModel -> OrderGoodsModel
// **/
//+ (OrderGoodsModel*)changeOrderGoodsModeValueWithGoodsModel:(GoodsModel *)model
//{
//    OrderGoodsModel *item = [OrderGoodsModel new];
//    item.id = model.cartItemId;
//    item.productId = model.productId;
//    item.productName = model.productName;
//    item.itemCount = [NSString stringWithFormat:@"%@",model.cartNum];
//    item.productPrice = model.productScPrice;
//    item.property = model.propertys;
//    item.productLogo = model.productLogo;
//    return item;
//}
//
//+ (OrderGoodsModel*)changeGoodsModelInListToOrderGoodsModel:(GoodsModelInList*)model
//{
//    OrderGoodsModel *item = [OrderGoodsModel new];
//    item.id = model.cartItemId;
//    item.productId = model.productId;
//    item.productName = model.productName;
//    item.itemCount = [NSString stringWithFormat:@"%@",model.cartNum];
//    item.productPrice = model.productScPrice;
//    item.property = model.property;
//    item.productLogo = model.productLogo;
//    return item;
//}


//+ (OrderGoodsModel*)changeMarkModeValueWithGoodsModel:(MarketRuleList *)model
//{
//    OrderGoodsModel *item = [OrderGoodsModel new];
//    item.id = @"";
//    item.productId = model.productId;
//    item.productName = model.productName;
//    item.itemCount = model.giftProductNum;
//    if (KX_NULLString(item.itemCount)) {
//        item.itemCount = model.number;
//
//    }
//    item.number = model.number;
//    item.productPrice = @"赠品";
//    item.isGive = @"1";
//    item.property = model.property;
//    item.productLogo = model.imgUrl;
//    item.sendInfo = model.ruleInfo;
//    return item;
//}
#pragma mark - private
-(void)showErrMsg:(NSString *)errMsg{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow makeToast:errMsg];
    });
}

@end
