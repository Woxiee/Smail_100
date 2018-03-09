//
//  OrderGoodsModel.m
//  ShiShi
//
//  Created by ac on 16/4/6.
//  Copyright © 2016年 fec. All rights reserved.
//

#import "OrderGoodsModel.h"

@implementation OrderGoodsModel


-(void)setMarketRuleList:(NSArray<MarketRuleList *> *)marketRuleList
{
    _marketRuleList = marketRuleList;
    
    //开始排序
//    if ([marketRuleList isKindOfClass:[NSArray class]] && marketRuleList.count > 0) {
//        if ([marketRuleList[0] isKindOfClass:[NSDictionary class]]) {
//                   _marketRuleList= [marketRuleList sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary*obj2) {
//                       return [obj1[@"reachStandardVaule"] compare:obj2[@"reachStandardVaule"]];
//                    }];
//        }}
}
@end
