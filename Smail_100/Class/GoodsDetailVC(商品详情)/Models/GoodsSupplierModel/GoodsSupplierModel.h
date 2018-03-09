//
//  GoodsSupplierModel.h
//  MyCityProject
//
//  Created by Faker on 17/6/1.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsSupplierModel : NSObject
@property (nonatomic , copy) NSString              * mainId;
@property (nonatomic , copy) NSString              * subId;
@property (nonatomic , copy) NSString              * mainParam2;
@property (nonatomic , copy) NSString              * mainParam1;
@property (nonatomic , copy) NSString              * productName;
@property (nonatomic , copy) NSString              * parentClassId;
@property (nonatomic , copy) NSString              * classId;
@property (nonatomic , copy) NSString              * busicompcity;
@property (nonatomic , copy) NSString              * busicompprov;
@property (nonatomic , copy) NSString              * busicomparea;

/// 供应商供货
@property (nonatomic , copy) NSString                  *cargoTotal;
@property (nonatomic , copy) NSString                  *invoiceType;
@property (nonatomic , copy) NSString                  *deliveryType;
@property (nonatomic , copy) NSString                  *cargoNumber;
@property (nonatomic , copy) NSString                  *param5;



@end
