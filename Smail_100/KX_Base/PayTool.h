//
//  PayTool.h
//  Smail_100
//
//  Created by Faker on 2018/4/26.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsOrderModel.h"
@interface PayTool : NSObject
singleton_interface(PayTool);
@property (nonatomic,copy) void(^didClicCompltBlock)(NSString *msg,BOOL success);
@property (nonatomic, strong) NSString *isType ; /// 空 表示正常   1线下 2 订单列表
- (void)getPayInfoOrderModle:(GoodsOrderModel*)orderModel payVC:(UIViewController *)VC reluteBlock:(void(^)(NSString *msg,BOOL success))compleBlock;
@end
