//
//  OrderDetailVC.h
//  MyCityProject
//
//  Created by Faker on 17/6/8.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
@interface OrderDetailVC : KX_BaseTableViewController
@property (nonatomic, strong) OrderModel *model;
@property (nonatomic, strong) NSString *orderID;
@property (nonatomic, assign)  BOOL isLease;   /// 是否租赁
@property (nonatomic, assign)  BOOL isCollect;   /// 是否集采
@property (nonatomic, assign)  BOOL isAuction;   /// 是否拍卖
@property (nonatomic, assign)  BOOL isDetection;   /// 是否检测吊运

@end
