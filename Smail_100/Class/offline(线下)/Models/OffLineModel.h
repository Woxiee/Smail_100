//
//  OffLineModel.h
//  Smail_100
//
//  Created by Faker on 2018/3/18.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Banners;

@interface OffLineModel : NSObject
@property (nonatomic , copy) NSArray<Banners *>              * banners;
@property (nonatomic , copy) NSString              * district;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * distance;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * shop_image;
@property (nonatomic , copy) NSString              * comment_count;
@property (nonatomic , copy) NSString              * contact_phone;
@property (nonatomic , copy) NSString              * shop_id;
@property (nonatomic , copy) NSString              * shop_name;
@property (nonatomic , copy) NSString              * stars;
@property (nonatomic , copy) NSString              * province;
@end
