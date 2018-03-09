//
//  OrderDetailModel.h
//  MyCityProject
//
//  Created by Faker on 17/6/8.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Order :NSObject
@property (nonatomic , copy) NSString              * signStatus;
@property (nonatomic , copy) NSString              * orderStatus;
@property (nonatomic , copy) NSString              * orderTypeTitle;
@property (nonatomic , copy) NSString              * property;
@property (nonatomic , copy) NSString              * buyCount;
@property (nonatomic , copy) NSString              * isApplyClose;
@property (nonatomic , copy) NSString              * payMentType;
@property (nonatomic , copy) NSString              * buyerPhone;
@property (nonatomic , copy) NSString              * orderType;
@property (nonatomic , copy) NSString              * buyerName;
@property (nonatomic , copy) NSString              * buyerAddress;
@property (nonatomic , copy) NSString              * orderPay;
@property (nonatomic , copy) NSString              * orderCode;
@property (nonatomic , copy) NSString              * contractId;
@property (nonatomic , copy) NSString              * sumAmout;
@property (nonatomic , copy) NSString              * buyerRemarks;
@property (nonatomic , copy) NSString              * orderStatusTitle;
@property (nonatomic , copy) NSString              * productImgPath;
@property (nonatomic , copy) NSString              * sellerCompName;
@property (nonatomic , copy) NSString              * invoiceId;
@property (nonatomic , copy) NSString              * payStatus;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * productName;
@property (nonatomic , copy) NSString              * mainId;
@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic , copy) NSString              * depositPrice;
@property (nonatomic , copy) NSString              * isApplyFinish;

@property (nonatomic , copy) NSString              * settlementDownPayment;
@property (nonatomic , copy) NSString              * settlementBalanceStage;
@property (nonatomic , copy) NSString              * settlementTimeInterval;

@property (nonatomic , copy) NSString              * serviceStartTime;
@property (nonatomic , copy) NSString              * serviceEndTime;


@property (nonatomic , copy) NSString              * deposit;
@property (nonatomic , copy) NSString              * serviceCycle;
@property (nonatomic , copy) NSString              * modelsType;
@property (nonatomic , copy) NSString              * countNumber;
@property (nonatomic , copy) NSString              * leaseStartTimeData;
@property (nonatomic , copy) NSString              * leaseEndTimeData;
@property (nonatomic , copy) NSString              * depositAmout;
@property (nonatomic , copy) NSString              * leaseEndTime;



@end

@interface Invoice :NSObject
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * depositAccount;
@property (nonatomic , copy) NSString              * depositBank;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * invoiceContent;
@property (nonatomic , copy) NSString              * invoiceTitle;
@property (nonatomic , copy) NSString              * ratepayerCode;
@property (nonatomic , copy) NSString              * invoiceType;
@property (nonatomic , copy) NSString              * telephone;

@end

@interface PayRecordList :NSObject
@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic , copy) NSString              * remarks;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * isAudit;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * serialCode;
@property (nonatomic , copy) NSString              * payTypeTitle;
@property (nonatomic , copy) NSString              * isDel;
@property (nonatomic , copy) NSString              * postTime;
@property (nonatomic , copy) NSString              * proceedsAmout;
@property (nonatomic , copy) NSString              * retainage;
@end

@interface PayDetailList :NSObject
@property (nonatomic , copy) NSString              * number;
@property (nonatomic , copy) NSString              * payAmount;
@property (nonatomic , copy) NSString              * payTime;
@property (nonatomic , copy) NSString              * status;
;
@end


@interface OrderDetailModel : NSObject
@property (nonatomic , strong) Order              * order;
@property (nonatomic , strong) Invoice              * invoice;
@property (nonatomic , copy) NSString              * orderType;
@property (nonatomic , copy) NSString              * invoiceType;
@property (nonatomic , copy) NSString              * invoiceValue;
@property (nonatomic , copy) NSString              * payValue;
@property (nonatomic , copy) NSString              * payMentType;

@property (nonatomic , copy) NSString              * payStatus;

@property (nonatomic , strong) NSArray<PayRecordList *>              * payRecordList;
@property (nonatomic , strong) NSArray<PayDetailList *>              * payDetailList;


@end
