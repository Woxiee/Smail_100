//
//  LevePartnerModel.h
//  Smail_100
//
//  Created by Faker on 2018/4/7.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemContentList.h"
#import "GoodsClassModel.h"


@class ItemContentList,Banners,Pay_method;



@interface List :NSObject
@property (nonatomic , strong) ItemContentList              * itemContentList;
@property (nonatomic , copy) NSString              * module;
@property (nonatomic , copy) NSString              * itemType;

@end
@interface LevePartnerModel : NSObject
@property (nonatomic , copy) NSArray<Banners *>              * banner;
@property (nonatomic , copy) NSString              * notice;
@property (nonatomic , copy) NSArray              * list;
@end
