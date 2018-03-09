//
//  AssetVModel.h
//  MyCityProject
//
//  Created by Faker on 17/6/15.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssetModel.h"
@interface AssetVModel : NSObject
/// 资产列表接口
+ (void)getAssetListUrl:(NSString *)url  Param:(id)pararm successBlock:(void(^)(NSArray <AssetModel *>*dataArray,BOOL isSuccess))sBlcok;


/// 状态处理
+ (void)getAssetOperationUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(BOOL isSuccess))sBlcok;

/// 详情
+ (void)getAssetDetailUrl:(NSString *)url Param:(id)pararm successBlock:(void(^)(BOOL isSuccess))sBlcok;
@end
