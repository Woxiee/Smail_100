//
//  OrderModel.h
//  MyCityProject
//
//  Created by Faker on 17/6/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
@property (nonatomic , copy) NSString              * contractId;
@property (nonatomic , copy) NSString              * orderStatusTitle;
@property (nonatomic , copy) NSString              * isComment;
@property (nonatomic , copy) NSString              * productName;
@property (nonatomic , copy) NSString              * payMentType;
@property (nonatomic , copy) NSString              * buyCount;
@property (nonatomic , copy) NSString              * isApplyClose;
@property (nonatomic , copy) NSString              * payStatus;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * signStatus;
@property (nonatomic , copy) NSString              * param2;
@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic , copy) NSString              * orderStatus;
@property (nonatomic , copy) NSString              * orderPay;
@property (nonatomic , copy) NSString              * productImgPath;
@property (nonatomic , copy) NSString              * property;
@property (nonatomic , copy) NSString              * subId;
@property (nonatomic , copy) NSString              * sumAmout;
@property (nonatomic , copy) NSString              * sellerCompName;
@property (nonatomic , copy) NSString              * comment;
@property (nonatomic , copy) NSString              * orderType;
@property (nonatomic , copy) NSString              * isFronzen;
@property (nonatomic , copy) NSString              * isReceipt;
@property (nonatomic , copy) NSString              * buyerUid;

@property (nonatomic , copy) NSString              * groupOrderStatus;

@property (nonatomic , copy) NSString              * groupOrderStatusByGroupOrder;

@property (nonatomic , copy) NSString              * isApplyFinish;

/// 集采
@property (nonatomic , copy) NSString              * joinCount;
@property (nonatomic , copy) NSString              * joinTimeData;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * groupId;

///拍卖
@property (nonatomic , copy) NSString              * depositAmounts;
@property (nonatomic , copy) NSString              * depositStatus;
@property (nonatomic , copy) NSString              * auctionNumber;
@property (nonatomic , copy) NSString              * offerPrice;

@property (nonatomic , copy) NSString              * param1;
@property (nonatomic , copy) NSString              * auctionId;
@property (nonatomic , copy) NSString              * auctionOrderBySingUp;

/// 金融
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * machineType;
@property (nonatomic , copy) NSString              * applyCode;
@property (nonatomic , copy) NSString              * brandName;
@property (nonatomic , copy) NSString              * num;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * insuranceTypeName;

/// 保险
@property (nonatomic , copy) NSString              * moblie;
@property (nonatomic , copy) NSString              * financeTypeName;
@property (nonatomic , copy) NSString              * linkman;
@property (nonatomic , copy) NSString              * financeTime;
@property (nonatomic , copy) NSString              * amout;

@property (nonatomic , assign) BOOL              bidKey;  /// 1  供应商订单   0购买订单

@end
