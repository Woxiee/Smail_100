//
//  MeChantOrderModel.h
//  Smail_100
//
//  Created by Faker on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeChantOrderModel : NSObject
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * volume;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * stock;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * shop_id;
@property (nonatomic , copy) NSString              * pict_url;
@property (nonatomic , copy) NSString              * sub_category_id;
@property (nonatomic , copy) NSString              * goods_id;
@end
