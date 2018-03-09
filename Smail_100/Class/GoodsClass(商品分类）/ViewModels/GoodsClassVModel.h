//
//  GoodsClassVModel.h
//  MyCityProject
//
//  Created by Faker on 17/6/14.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsClassModel.h"
@interface GoodsClassVModel : NSObject
/// 分类表接口
+ (void)getGoodsClassListParam:(id)pararm successBlock:(void(^)(NSArray < GoodsClassModel *>*dataArray,BOOL isSuccess))sBlcok;

/// 层级表接口
+ (void)getGoodsLevesListParam:(id)pararm successBlock:(void(^)(NSArray < GoodsClassModel *>*dataArray,BOOL isSuccess))sBlcok;


/// 层级表接口
+ (void)getGoodsLevesOtherListParam:(id)pararm successBlock:(void(^)(NSArray < GoodsClassModel *>*dataArray,BOOL isSuccess))sBlcok;

@end
