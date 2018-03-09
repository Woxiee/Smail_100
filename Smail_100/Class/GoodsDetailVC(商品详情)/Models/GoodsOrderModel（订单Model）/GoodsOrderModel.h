//
//  GoodsOrderModel.h
//  MyCityProject
//
//  Created by Faker on 17/5/22.
//  Copyright © 2017年 Faker. All rights reserved.
//

@class Pay_method;
@interface Products :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * usepoint_per;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * cid;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * sid;
@property (nonatomic , copy) NSString              * point;
@property (nonatomic , copy) NSString              * goods_id;
@property (nonatomic , copy) NSString              * goods_nums;
@property (nonatomic , copy) NSString              * spec;
@property (nonatomic , copy) NSString              * seller_id;
@property (nonatomic , copy) NSString              * commend_id;
@property (nonatomic , copy) NSString              * seller_name;

@end

@interface Seller :NSObject
@property (nonatomic , copy) NSArray<Products *>              * products;
@property (nonatomic , copy) NSString              * point;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * freight;
@property (nonatomic , copy) NSString              * categoryId;
@property (nonatomic , copy) NSString              * count;
@property (nonatomic , copy) NSString              * seller_id;
@property (nonatomic , copy) NSString              * seller_name;
@property (nonatomic , copy) NSString              * categoryName;

@end

@interface Coins :NSObject
@property (nonatomic , copy) NSString              * money;
@property (nonatomic , copy) NSString              * air_money;

@end

@interface Userinfo :NSObject
@property (nonatomic , strong) Coins              * coins;
@property (nonatomic , copy) NSString              * money;
@property (nonatomic , copy) NSString              * point;

@end



@interface Address :NSObject
@property (nonatomic , copy) NSString              * district;
@property (nonatomic , copy) NSString              * contact_username;
@property (nonatomic , copy) NSString              * detail;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * addr_id;
@property (nonatomic , copy) NSString              * contact_mobile;
@property (nonatomic , copy) NSString              * province;

@end

#import <Foundation/Foundation.h>
@interface ProductInfo :NSObject
@property (nonatomic , copy) NSString              * productName;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * property;
@property (nonatomic , copy) NSString              * full_path;
@property (nonatomic , copy) NSString              * companyName;
@property (nonatomic , copy) NSString              * cargoNumber;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * mainImgPath;
@property (nonatomic , copy) NSString              * bondQuota;
@property (nonatomic , copy) NSString              * offerCount;
@property (nonatomic , copy) NSString              * auctionNumber;
@property (nonatomic , copy) NSString              * dqPrice;
@property (nonatomic , copy) NSString              * endTime;
@property (nonatomic , copy) NSString              * productType;
@property (nonatomic , copy) NSString              * paymentTypeAll;
@property (nonatomic , copy) NSString              * param5;
@property (nonatomic , copy) NSString              * monthlyPayments;
@property (nonatomic , copy) NSString              * financingMargin;
@property (nonatomic , copy) NSString              * financingProportion;
@property (nonatomic , copy) NSString              * financingAnnualInterestRate;
@property (nonatomic , copy) NSString              * benchmarkProfitsRise;
@property (nonatomic , copy) NSString              * fixedProfit;
@property (nonatomic , copy) NSString              * poundage;
@property (nonatomic , copy) NSString              * theFinancing;
@property (nonatomic , copy) NSString              * monthlyPaymentAmount;
@property (nonatomic , copy) NSString              * needToBuyInsurance;
@property (nonatomic , copy) NSString              * otherFees;

@property (nonatomic , copy) NSString              * invoiceType;

@property (nonatomic , copy) NSString              * monthSettlementBalanceStage;
@property (nonatomic , copy) NSString              * monthSettlementDownPayment;
@property (nonatomic , copy) NSString              * monthSettlementTimeInterval;

@end


@interface GoodsOrderModel : NSObject
@property (nonatomic , copy) NSString              * realPrice;
@property (nonatomic , copy) NSString              * buyCount;
@property (nonatomic , copy) NSString              * param5;///param5	数量的限定，1表示无限的，0表示限定

@property (nonatomic , copy) NSString              * subProductId;
@property (nonatomic , copy) NSString              * totalMoney;
@property (nonatomic , copy) NSString              * allPoint;


@property (nonatomic , copy) NSString              * paymentTypeAll;
@property (nonatomic , copy) NSString              * payMentType;


@property (nonatomic , copy) NSString              * invoiceType;
@property (nonatomic , copy) NSString              * groupBuyMargin;

@property (nonatomic , strong) ProductInfo              * productInfo;
@property (nonatomic, assign) NSInteger goodSCount;
@property (nonatomic , copy) NSString              * leaseEndTime;
@property (nonatomic , copy) NSString              * leaseStartTime;


@property (nonatomic , copy) NSArray<Seller *>              * seller;
@property (nonatomic , strong) Userinfo              * userinfo;
@property (nonatomic , strong) Pay_method              * pay_method;
@property (nonatomic , strong) Address              * address;


@end
