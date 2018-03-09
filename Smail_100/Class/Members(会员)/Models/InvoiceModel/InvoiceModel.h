//
//  InvoiceModel.h
//  MyCityProject
//
//  Created by Faker on 17/5/24.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvoiceModel : NSObject
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * depositBank;
@property (nonatomic , copy) NSString              * depositAccount;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * invoiceTitle;
@property (nonatomic , copy) NSString              * invoiceType;
@property (nonatomic , copy) NSString              * param1;
@property (nonatomic , copy) NSString              * ratepayerCode;
@property (nonatomic , copy) NSString              * telephone;
@property (nonatomic , copy) NSString              * invoiceContent;
@property (nonatomic , copy) NSString              * invoiceTypeName;
@end
