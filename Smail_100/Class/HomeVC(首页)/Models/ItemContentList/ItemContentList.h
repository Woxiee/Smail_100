//
//  ItemContentList.h
//  Smile_100
//
//  Created by Faker on 2018/2/8.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Pay_method :NSObject
@property (nonatomic , copy) NSString              * alipay;
@property (nonatomic , copy) NSString              * coins_air_money;
@property (nonatomic , copy) NSString              * coins_money;
@property (nonatomic , copy) NSString              * point;
@property (nonatomic , copy) NSString              * wxpay;

@end

@interface ItemContentList : NSObject
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

@property (nonatomic , copy) NSString              * cartNum;
@property (nonatomic , copy) NSString              * comment;


@end

@interface ItemInfoList :NSObject
@property (nonatomic , copy) NSArray<ItemContentList *>              * itemContentList;
@property (nonatomic , copy) NSString              * module;
@property (nonatomic , copy) NSString              * itemType;
@property (nonatomic , strong) ItemContentList             * itemContent;

@end

