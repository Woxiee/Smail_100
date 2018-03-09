//
//  HistoryVModel.h
//  MyCityProject
//
//  Created by Faker on 17/6/15.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryModel.h"
@interface HistoryVModel : NSObject
/// 历史记录表接口
+ (void)getHistoryListParam:(id)pararm successBlock:(void(^)(NSArray < HistoryModel *>*dataArray,BOOL isSuccess))sBlcok;
@end
