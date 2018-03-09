//
//  SupplyModel.h
//  MyCityProject
//
//  Created by Faker on 17/6/24.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SupplyModel : NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * productId;
@property (nonatomic , copy) NSString              * contacts;
@property (nonatomic , copy) NSString              * dealPrice;
@property (nonatomic , copy) NSString              * needBuyId;
@property (nonatomic , copy) NSString              * supplyCount;
@property (nonatomic , copy) NSString              * supplyGoodsNum;
@property (nonatomic , copy) NSString              * telephone;
@property (nonatomic , assign) BOOL              isSelect;

@property (nonatomic , copy) NSString              * isOverdue;
@property (nonatomic , copy) NSString              * invoiceType;
@property (nonatomic , copy) NSString              * param2;
@property (nonatomic , strong) NSArray<NSString *>              * invoiceTypeArray;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * mid;
@property (nonatomic , copy) NSString              * updateTime;
@property (nonatomic , copy) NSString              * param4;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * sendType;
@property (nonatomic , copy) NSString              * param1;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * isDel;
@property (nonatomic , strong) NSArray<NSString *>              * sendTypeArray;
@property (nonatomic , copy) NSString              * param3;
@property (nonatomic , copy) NSString              * createBy;
@property (nonatomic , copy) NSString              * updateBy;
@property (nonatomic , copy) NSString              * area;
@property (nonatomic , copy) NSString              * param5;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , copy) NSString              * mainId;
@property (nonatomic , copy) NSString              * bid;
@property (nonatomic , copy) NSString              * paymentType;

@property (nonatomic , copy) NSString              * busiCompName;
@end
