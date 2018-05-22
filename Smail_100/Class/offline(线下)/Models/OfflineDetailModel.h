//
//  OfflineDetailModel.h
//  Smail_100
//
//  Created by Faker on 2018/4/6.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment :NSObject
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * comment_id;
@property (nonatomic , copy) NSString              * ctime;
@property (nonatomic , copy) NSString              * sort;
@property (nonatomic , copy) NSString              * user_id;
@property (nonatomic , copy) NSString              * is_anonymous;
@property (nonatomic , copy) NSString              * fid;
@property (nonatomic , copy) NSString              * comment;
@property (nonatomic , copy) NSString              * goods_id;
@property (nonatomic , copy) NSString              * avatar_url;


@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * stars;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * category_name;
@property (nonatomic , copy) NSString              * district;
@property (nonatomic , copy) NSString              * distance;
@property (nonatomic , copy) NSString              * shop_image;
@property (nonatomic , copy) NSString              * shop_id;
@property (nonatomic , copy) NSString              * nickname;



@end

@interface OfflineDetailModel : NSObject
@property (nonatomic , copy) NSString              * description;
@property (nonatomic , copy) NSString              * comment_count;
@property (nonatomic , copy) NSString              * qrcode;
@property (nonatomic , copy) NSString              * contact_phone;
@property (nonatomic , copy) NSString              * shop_name;
@property (nonatomic , copy) NSString              * ontime_scope;
@property (nonatomic , copy) NSString              * category_id;
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * business_info;
@property (nonatomic , copy) NSArray<Comment *>              * comment;
@property (nonatomic , copy) NSString              * user_id;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * stars;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * category_name;
@property (nonatomic , copy) NSString              * district;
@property (nonatomic , copy) NSString              * distance;
@property (nonatomic , copy) NSString              * shop_image;
@property (nonatomic , copy) NSString              * shop_id;
@property (nonatomic , copy) NSString              * present_point_perc;


@end
