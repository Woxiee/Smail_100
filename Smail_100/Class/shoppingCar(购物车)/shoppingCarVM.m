//
//  shoppingCarVM.m
//  ShiShi
//
//  Created by mac_KY on 17/3/6.
//  Copyright © 2017年 fec. All rights reserved.
//  插件化做准备  几乎购物车的逻辑都在这里   －请求数据－选中（本地处理）－加、减数量 －删除 － 收藏
//除喽 选中其他的状态都是网络标记  那么其他的状态改变必须重新请求购物车数据 但是标记选中从本地那数据


#import "shoppingCarVM.h"
#import "GoodsOrderModel.h"

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
        if (model.products.count >0) {
            for (OrderGoodsModel*item in model.goodModel) {
                if (item.selectStatue.integerValue == 1) {
                    allPrice += item.productPrice.floatValue *item.itemCount.intValue;
                }
            }
            
        }else{
            if (model.selectStatue.integerValue == 1) {
                allPrice += model.productPrice.floatValue *model.itemCount.intValue;

            }
        }
       
    }
    
    return [NSString stringWithFormat:@"%.2f",allPrice];
    
}

-(NSString *)calculationCarAllPoint:(NSArray <OrderGoodsModel*>*)goodsModels{
    
    CGFloat allPoint = 0;

    for (OrderGoodsModel*model in goodsModels  ) {
        if (model.products.count >0) {
            for (OrderGoodsModel*item in model.goodModel) {
                if (item.selectStatue.integerValue == 1) {
                    allPoint += item.point.floatValue *item.itemCount.intValue;
                }
            }
            
        }else{
            if (model.selectStatue.integerValue == 1) {
                allPoint += model.point.floatValue *model.itemCount.intValue;
            }
        }
        
    }
    
    return [NSString stringWithFormat:@"%.2f",allPoint];
}


/*
 计算 item的个数
 
 @param goodsModels 商品
 @return 总的选中个数
 */
-(NSString *)calcilationShopCarAllCount:(NSArray <OrderGoodsModel*>*)goodsModels{
    
    int allCount = 0;
    for (OrderGoodsModel*model in goodsModels ) {
        if (model.products.count >0) {
            for (OrderGoodsModel*item in model.goodModel) {
                if (item.selectStatue.integerValue == 1) {
                    allCount += item.itemCount.integerValue;
                }
            }
            
        }else{
            if (model.selectStatue.integerValue == 1) {
                allCount += model.itemCount.integerValue;
            }
        }
        
    }
  
    return [NSString stringWithFormat:@"%d",allCount];
    
    
}

///计算购物车所有个数
-(NSString *)calcilationShopCarAllNomalCount:(NSArray <OrderGoodsModel*>*)goodsModels
{
    int allCount = 0;
    for (OrderGoodsModel*model in goodsModels ) {
        if (model.products.count >0) {
            for (OrderGoodsModel*item in model.goodModel) {
//                if (item.selectStatue.integerValue == 1) {
                    allCount += item.itemCount.integerValue;
//                }
            }
            
        }else{
//            if (model.selectStatue.integerValue == 1) {
                allCount += model.itemCount.integerValue;
//            }
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
    [dic setObject:goodsModel.spec forKey:@"spec"];
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
    
    NSDictionary *dic  =@{@"method":@"get",@"user_id":[KX_UserInfo sharedKX_UserInfo].user_id};
    [BaseHttpRequest postWithUrl:@"/ucenter/cart" andParameters:dic  andRequesultBlock:^(id result, NSError *error) {
        LOG(@"%@",result);
        if (error) {
            [self showErrMsg :LocalMyString(NOTICEMESSAGE)];
        }else{

            NSInteger state = [result[@"code"] integerValue];
            NSString *msg = result[@"msg"];
            if ([result[@"data"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [NSArray yy_modelArrayWithClass:[OrderGoodsModel class] json:result[@"data"]];
//                [OrderGoodsModel mj_objectArrayWithKeyValuesArray:];
                for (OrderGoodsModel *model in arr ) {
                    model.products = [NSArray yy_modelArrayWithClass:[Products class] json:model.products];
                
                }
                
          
                shopaCarGoodsBlock(arr,state);
                return ;
            }
            shopaCarGoodsBlock([NSArray array],state);
            if (state == 0) return ;
            [self showErrMsg:msg];
        }
    }];
    
}

/**
 4.4修改购物车
 */
-(void)changeShopCarGoodsCount:(NSString *)count goods:(OrderGoodsModel*)goodsModel Params:(id)param handleback:(void(^) (NSInteger code))shopaCarGoodsBlock{
    
    if (count == nil) {
        [self showErrMsg:@"系统异常"];
    }
    
    [BaseHttpRequest postWithUrl:@"/ucenter/cart" andParameters:param  andRequesultBlock:^(id result, NSError *error) {
        
        if (error) {
            [self showErrMsg:LocalMyString(NOTICEMESSAGE)];
        }else{
            NSInteger state = [result[@"code"] integerValue];
            NSString *msg = result[@"msg"];
            shopaCarGoodsBlock(state);
            [self showErrMsg:msg];
            if (state == 0) return ;
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
 修改本地商家购物车的数量
 
 @param count 修改后的数量
 @param shopaCarGoodsBlock 成功／失败回调
 */
-(void)changeOffLineShopCarGoodsCount:(NSString *)count goods:(OrderGoodsModel*)goodsModel  Params:(id)param  handleback:(void(^) (NSInteger code))shopaCarGoodsBlock
{
    if (count == nil) {
        [self showErrMsg:@"系统异常"];
    }
    
    [BaseHttpRequest postWithUrl:@"/shop/save_goods_nums" andParameters:param  andRequesultBlock:^(id result, NSError *error) {
        
        if (error) {
            [self showErrMsg:LocalMyString(NOTICEMESSAGE)];
        }else{
            NSInteger state = [result[@"code"] integerValue];
            NSString *msg = result[@"msg"];
            shopaCarGoodsBlock(state);
//            [self showErrMsg:msg];
            if (state == 0) return ;
        }
    }];
}



/**
 删除购物车某个购物项 4.2
 
 @param goodsModel 产品
 @param shopaCarGoodsBlock 成功／失败回调
 */
-(void)delectaShopCarGoods:(OrderGoodsModel*)goodsModel Params:(id)param handleback:(void(^) (NSInteger code))shopaCarGoodsBlock{
    if (goodsModel.id == nil) return;
    
    [BaseHttpRequest postWithUrl:@"/ucenter/cart" andParameters:param  andRequesultBlock:^(id result, NSError *error) {
        
        if (error) {
            [self showErrMsg:LocalMyString(NOTICEMESSAGE)];
        }else{
            NSInteger state = [result[@"state"] integerValue];
            NSString *msg = result[@"msg"];
            shopaCarGoodsBlock(state);
            [self showErrMsg:msg];
            if (state == 0) return ;
            
            
        }
    }];
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
//}

+ (OrderGoodsModel*)changeProductsModelInListToOrderGoodsModel:(Products*)model;
{
    
//    @property (nonatomic , copy) NSString              * name;
//    @property (nonatomic , copy) NSString              * usepoint_per;
//    @property (nonatomic , copy) NSString              * img;
//    @property (nonatomic , copy) NSString              * cid;
//    @property (nonatomic , copy) NSString              * price;
//    @property (nonatomic , copy) NSString              * sid;
//    @property (nonatomic , copy) NSString              * point;
//    @property (nonatomic , copy) NSString              * goods_id;
//    @property (nonatomic , copy) NSString              * goods_nums;
//    @property (nonatomic , copy) NSString              * spec;
//    @property (nonatomic , copy) NSString              * seller_id;
//    @property (nonatomic , copy) NSString              * commend_id;
//    @property (nonatomic , copy) NSString              * seller_name;
    OrderGoodsModel *item = [OrderGoodsModel new];
    item.id = model.goods_id;
    item.productId = model.goods_id;
    item.productName = model.name;
    item.itemCount = [NSString stringWithFormat:@"%@",model.goods_nums];
    item.productPrice = model.price;
    item.point = model.point;
    item.seller_id = model.goods_id;
    item.store_nums = model.store_nums;

    item.property = model.spec;
    item.productLogo = model.img;
    item.selectStatue = model.selectStatue?model.selectStatue:@"0";
    item.cid = model.cid;
    return item;

}


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


+ (OrderGoodsModel*)changeRightGoodsModelInListToOrderGoodsModel:(RightGoods *)model
{
    OrderGoodsModel *item = [OrderGoodsModel new];
    item.id = model.goods_id;
    item.productId = model.goods_id;
    item.productName = model.title;

    item.itemCount = model.nums;
    item.productPrice = model.price;
    item.point = model.earn_point;
    item.seller_id = @"";
    item.store_nums = @"";
    item.productLogo = model.pict_url;

//    item.property = model.spec;
//    item.selectStatue = model.selectStatue?model.selectStatue:@"0";
    return item;
}
#pragma mark - private
-(void)showErrMsg:(NSString *)errMsg{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow makeToast:errMsg];
    });
}

@end
