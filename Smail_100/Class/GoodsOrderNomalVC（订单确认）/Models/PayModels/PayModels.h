//
//  PayModels.h
//  Smail_100
//
//  Created by Faker on 2018/3/10.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayModels : NSObject
@property (nonatomic , copy) NSString              * acctId;
@property (nonatomic , copy) NSString              * amount;
@property (nonatomic , copy) NSString              * keyWord;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * orderid;
@property (nonatomic , copy) NSString              * privatekey;
@property (nonatomic , copy) NSString              * callback;
@property (nonatomic , copy) NSString              * sign;
@property (nonatomic , copy) NSString              * nonce_str;
@property (nonatomic , copy) NSString              * trade_type;
@property (nonatomic , copy) NSString              * appid;

@property (nonatomic , copy) NSString              * privateKey;
@property (nonatomic , copy) NSString              * prepay_id;
@property (nonatomic , copy) NSString              * timestamp;


@end
