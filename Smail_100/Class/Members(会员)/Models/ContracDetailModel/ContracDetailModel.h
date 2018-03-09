//
//  ContracDetailModel.h
//  MyCityProject
//
//  Created by Faker on 17/7/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Order;

@interface Contract :NSObject 
@property (nonatomic , copy) NSString              * propertyRecordNumber;
@property (nonatomic , copy) NSString              * supplementInfo;
@property (nonatomic , copy) NSString              * bilateralLiability;
@property (nonatomic , copy) NSString              * afterService;
@property (nonatomic , copy) NSString              * orderCode;
@property (nonatomic , copy) NSString              * secondSignTime;

@end

@interface ContracDetailModel : NSObject
@property (nonatomic , strong) Order              * order;
@property (nonatomic , strong) Contract              * contract;
@end
