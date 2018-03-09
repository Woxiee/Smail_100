//
//  GoodSDetailModel.h
//  MyCityProject
//
//  Created by Faker on 17/5/9.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Values;
@interface ExtAttrbuteShow :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * values;

@end
@interface Dizhi :NSObject
@property (nonatomic , copy) NSString              * prov;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * area;

@end
@interface AttrValue :NSObject
@property (nonatomic , copy) NSString              * attrValueMainID; /// 主属性ID
@property (nonatomic , copy) NSString              * attrValueMainName; /// 主属性标题

@property (nonatomic , copy) NSString              * attrValueId;
@property (nonatomic , copy) NSString              * attrValueName;
@property (nonatomic, assign) BOOL isSelect;

@end

@interface SKU :NSObject
@property (nonatomic , strong) NSArray<AttrValue *>              * attrValue;
@property (nonatomic , copy) NSString              * attrId;
@property (nonatomic , copy) NSString              * attrName;

@end

@interface ExtAttrbute :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * values;

@end


@interface BusinessResult :NSObject 
@property (nonatomic , copy) NSString              * busiCompPerson;
@property (nonatomic , copy) NSString              * busiCompCity;
@property (nonatomic , copy) NSString              * busiCompArea;
@property (nonatomic , copy) NSString              * busiCompProv;
@property (nonatomic , copy) NSString              * busiCompName;
@property (nonatomic , copy) NSString              * busiCompTel;
@property (nonatomic , copy) NSString              * userPhone;

@property (nonatomic , copy) NSString              * busiCompZone;
@property (nonatomic , copy) NSString              * busiCompFax;
@property (nonatomic , copy) NSString              * busiCompAddr;

@end



@interface Extetalon :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , strong) NSArray<Values *>              * values;

@end


@interface SubResult :NSObject
@property (nonatomic , strong) NSArray<NSString *>              * imgSrc;
@property (nonatomic , copy) NSString              * subIds;
@property (nonatomic , copy) NSString              * imgSrc_one;

@property (nonatomic , copy) NSString              * mainid;



@end

@interface GroupBuyPriceList :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * groupBuyId;
@property (nonatomic , copy) NSString              * minCount;
@property (nonatomic , copy) NSString              * maxCount;
@property (nonatomic , copy) NSString              * jcPrice;

@end

@interface GroupBuyResult :NSObject
@property (nonatomic , copy) NSString              * introduce;
@property (nonatomic , copy) NSString              * groupBuyName;
@property (nonatomic , strong) NSArray<GroupBuyPriceList *>              * groupBuyPriceList;
@property (nonatomic , copy) NSString              * endTime;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * joinCount;
@property (nonatomic , copy) NSString              * productCount;
@property (nonatomic , copy) NSString              * minSendTime;
@property (nonatomic , copy) NSString              * productId;
@property (nonatomic , copy) NSString              * property;
@property (nonatomic , copy) NSString              * startTime;
@property (nonatomic , copy) NSString              * marginPrice;

@end

@interface MainResult :NSObject
@property (nonatomic , copy) NSString              * param7;
@property (nonatomic , copy) NSString              * invoiceType;
@property (nonatomic , copy) NSString              * shortDesc;
@property (nonatomic , copy) NSString              * detailDesc;
@property (nonatomic , copy) NSString              * maxvalidityTime;
@property (nonatomic , copy) NSString              * goodsTime;
@property (nonatomic , copy) NSString              * secondHand;
@property (nonatomic , copy) NSString              * deliveryDay;
@property (nonatomic , copy) NSString              * param6;
@property (nonatomic , copy) NSString              * param1;
@property (nonatomic , copy) NSString              * brandName;
@property (nonatomic , copy) NSString              * deliveryType;
@property (nonatomic , copy) NSString              * transactionType;
@property (nonatomic , copy) NSString              * param8;
@property (nonatomic , copy) NSString              * companyName;
@property (nonatomic , copy) NSString              * productName;
@property (nonatomic , copy) NSString              * cName;
@property (nonatomic , copy) NSString              * certification;
@property (nonatomic , copy) NSString              * bid;
@property (nonatomic , copy) NSString              * one;
@property (nonatomic , copy) NSString              * two;
@property (nonatomic , copy) NSString              * three;
@property (nonatomic , copy) NSString              * fore;
@property (nonatomic , copy) NSString              * paymentTypeAll;

@property (nonatomic , copy) NSString              * unit;


@property (nonatomic , strong) NSArray<Dizhi *>              * dizhi;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * imgSrc_one;
@property (nonatomic , copy) NSString              * isDeposit; ///是否有租金（只有租赁商品由，其他没有）
@property (nonatomic , copy) NSString              * gepositPrice; ///（只有租赁商品由，其他没有）


@property (nonatomic , copy) NSString              * mainId;



@end

@interface ServiceResultMap :NSObject 
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * manuFactor;
@property (nonatomic , copy) NSString              * unit;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * bid;
@property (nonatomic , copy) NSString              * className;
@property (nonatomic , copy) NSString              * detailDesc;
@property (nonatomic , copy) NSString              * productName;
@property (nonatomic , copy) NSString              * area;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * shortDesc;
@property (nonatomic , copy) NSString              * telePhone;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * contacts;
@property (nonatomic , strong) NSArray<NSString *>              * imgSkuList;

@property (nonatomic , copy) NSString              * brandName;
@property (nonatomic , strong) NSArray<Dizhi *>              * dizhi;
@end

@interface GoodSDetailModel :NSObject
@property (nonatomic , copy) NSString              * mainId;
@property (nonatomic , copy) NSString              * bid;
@property (nonatomic , copy) NSString              * mid;

@property (nonatomic , copy) NSString              * payMentType;
@property (nonatomic , copy) NSString              * monthlyPayments;

@property (nonatomic , copy) NSString              * needBuyType;


@property (nonatomic , strong) NSArray<ExtAttrbuteShow *>              * extAttrbuteShow;
@property (nonatomic , strong) NSArray<SKU *>              * sKU;
@property (nonatomic , strong) NSArray<ExtAttrbute *>              * extAttrbute;
@property (nonatomic , strong) BusinessResult              * businessResult;
@property (nonatomic , strong) NSArray<Extetalon *>              * extetalon;
@property (nonatomic , strong) SubResult              * subResult;
@property (nonatomic , strong) MainResult              * mainResult;
@property (nonatomic , copy) NSString              * avgScore;
@property (nonatomic , copy) NSString              * collectResult; /// 是否收藏 是否收藏	0表示收藏了 为1的话表示没有收藏

@property (nonatomic , copy) NSString              * param3;
@property (nonatomic , copy) NSString              * param5;///param5	数量的限定，1表示无限的，0表示限定
@property (nonatomic , copy) NSString              * cargoNumber;
@property (nonatomic , copy) NSString              * onSale;
@property (nonatomic , copy) NSString              * subProductId;
@property (nonatomic , copy) NSString              * showPirce;
@property(nonatomic,copy) NSString  *propertys;      ///商品属性
@property (nonatomic, assign) NSInteger goodSCount;
@property (nonatomic , copy) NSString            * goodsSizeID;  /// 商品规格ID
///采集
@property (nonatomic , strong) GroupBuyResult              * groupBuyResult;
@property (nonatomic , strong) NSArray<NSString *>              * list3; /// 认证详情LIST

///商品详情webview 高度
@property (nonatomic , assign) float               webviewHeigh;

/// 付款方式
@property (nonatomic, strong) NSArray *payArr;



/// 求租 信息字段
@property (nonatomic , copy) NSString              * promulgator;
@property (nonatomic , copy) NSString              * isOwnweahip;
@property (nonatomic , copy) NSString              * isOverdue;


@property (nonatomic , copy) NSString              * deliveryArea;
@property (nonatomic , copy) NSString              * deliveryCity;
@property (nonatomic , copy) NSString              * deliveryProv;
@property (nonatomic , copy) NSString              * deliveryAddr;


@property (nonatomic , copy) NSString              * telephone;
@property (nonatomic , copy) NSString              * remaek;
@property (nonatomic , copy) NSString              * manufactor;
@property (nonatomic , copy) NSString              * hopePrice;
@property (nonatomic , copy) NSString              * productImg;
@property (nonatomic , copy) NSString              * needBuyName;
@property (nonatomic , copy) NSString              * bName;
@property (nonatomic , copy) NSString              * productType;


@property (nonatomic , copy) NSString              * companyName;
@property (nonatomic , copy) NSString              * needCount;
@property (nonatomic , copy) NSString              * hopeSendTime;
@property (nonatomic , copy) NSString              * createTime;
@property (nonatomic , copy) NSString              * kzNumberName;
@property (nonatomic , copy) NSString              * cName;
@property (nonatomic , copy) NSString              * contacts;
@property (nonatomic , copy) NSString              * isCertificates;
@property (nonatomic , copy) NSString              * certificatesStr; ///  认证信息 显示字段


@property (nonatomic , strong) ServiceResultMap              * serviceResultMap;


/// 拍卖字段
@property (nonatomic , copy) NSString              * joinResultState;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * detailDesc;
@property (nonatomic , copy) NSString              * baomingCount;
@property (nonatomic , copy) NSString              * kzAuctionRemindId;
@property (nonatomic , copy) NSString              * kzAuctionRemindStatus;


@property (nonatomic , copy) NSString              * bondQuota;
@property (nonatomic , copy) NSString              * endTime;
@property (nonatomic , copy) NSString              * minAddPrice;
@property (nonatomic , copy) NSString              * dqPrice;
@property (nonatomic , copy) NSString              * offerCount;
@property (nonatomic , copy) NSString              * joinCount;
@property (nonatomic , copy) NSString              * needBuyId;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * blPrice;
@property (nonatomic , strong) NSArray<NSString *>              * imgList;
@property (nonatomic , copy) NSString              * delayPeriod;
@property (nonatomic , copy) NSString              * timestamp;
@property (nonatomic , copy) NSString              * scPrice;
@property (nonatomic , copy) NSString              * auctionNumber;
@property (nonatomic , copy) NSString              * qpPrice;
@property (nonatomic , copy) NSString              * startTime;
@property (nonatomic , copy) NSString              * auctionProductName;
@property (nonatomic , copy) NSString              * remindCount;
@property (nonatomic, copy) NSString              *multipleN;
@property (nonatomic, copy) NSString              *findCompanyName;
@property (nonatomic, copy) NSString              *userName;
@property (nonatomic, copy) NSString              *offerPrice;
@property (nonatomic, copy) NSString              *top;


/// 备注 订单界面所用
@property (nonatomic , copy) NSString              * noteConten;
@property (nonatomic , assign) float                  cellHgiht;
@property (nonatomic , copy) NSString                  *invoiceID; /// 开票字段ID
@property (nonatomic , copy) NSString                  *invoiceTitle; /// 开票字段

@property (nonatomic , copy) NSString                  *pickUpGoodsID; /// 提货ID

@property (nonatomic , copy) NSString                  *payTypeTitle; /// 付款字段
@property (nonatomic , copy) NSString                  *payTypeID; /// 付款字段ID

@property (nonatomic , copy) NSString                  *addressID; /// 地址ID

@property (nonatomic , copy) NSString                  *leaseStartTime; /// 开始时间
@property (nonatomic , copy) NSString                  *leaseEndTime; /// 结束时间


@property (nonatomic , copy) NSString                  *typeStr; /// 商品类型


@end

