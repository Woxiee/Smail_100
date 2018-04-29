//
//  ItemContentList.h
//  Smile_100
//
//  Created by Faker on 2018/2/8.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodSDetailModel.h"




@interface Pay_method :NSObject
@property (nonatomic , copy) NSString              * alipay;
@property (nonatomic , copy) NSString              * coins_air_money;
@property (nonatomic , copy) NSString              * coins_money;
@property (nonatomic , copy) NSString              * point;
@property (nonatomic , copy) NSString              * wxpay;
@property (nonatomic , copy) NSString              * phone_money;



@end

@interface ItemContentList : NSObject

@property (nonatomic , copy) NSString              * clickType;
@property (nonatomic , copy) NSArray              * tags;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * notice_link;
@property (nonatomic , copy) NSString              * desc;
@property (nonatomic , copy) NSString              * freight;
@property (nonatomic , copy) NSString              * valid_time;
@property (nonatomic , copy) NSString              * freight_msg;


@property (nonatomic , copy) NSString              * itemRecommendedLanguage;
@property (nonatomic , copy) NSString              * volume;
@property (nonatomic , copy) NSString              * earn_money;
@property (nonatomic , copy) NSString              * itemTitle;
@property (nonatomic , copy) NSString              * itemBackgroundImageUrl;
@property (nonatomic , copy) NSString              * imageUrl;
@property (nonatomic , copy) NSString              * clickUrl;
@property (nonatomic , copy) NSString              * itemSubTitle;
@property (nonatomic , copy) NSString              * itemSubscript;
@property (nonatomic , copy) NSString              * earn_point;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , strong) Pay_method              * pay_method;
@property (nonatomic , copy) NSString              * goods_id;
@property (nonatomic , copy) NSString              * point;
@property (nonatomic , copy) NSString              * volume_month;
@property (nonatomic , copy) NSString              * store_nums;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * sale_num;
@property (nonatomic , copy) NSString              * content_link;
@property (nonatomic , copy) NSString              * coll_id;

@property (nonatomic , copy) NSString              * cartNum;
@property (nonatomic , copy) NSString              * comment;
@property (nonatomic , copy) NSString              * goodsSizeID;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * next_time;
@property (nonatomic , copy) NSString              * next_msg;

@property (nonatomic , copy) NSString              * spec;

@property (nonatomic , copy) NSString              * showType; ///话费兑换用到字段


@end

@interface ItemInfoList :NSObject
@property (nonatomic , copy) NSArray<ItemContentList *>              * itemContentList;
@property (nonatomic , copy) NSString              * module;
@property (nonatomic , copy) NSString              * itemType;
@property (nonatomic , strong) ItemContentList             * itemContent;
@property (nonatomic , strong) NSArray<SKU *>    * spec;
@property(nonatomic,copy) NSString  *propertys;      ///商品属性
@property (nonatomic , copy) NSString            * goodsSizeID;  /// 商品规格ID
@property (nonatomic, assign) NSInteger goodSCount; /// 购买数量


@end

