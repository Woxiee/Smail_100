//
//  MyteamModel.h
//  Smail_100
//
//  Created by Faker on 2018/5/13.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Agent_location :NSObject
@property (nonatomic , copy) NSString              * province;
@property (nonatomic , copy) NSString              * city;
@property (nonatomic , copy) NSString              * district;
@property (nonatomic , copy) NSString              * street;



@end

@interface Agent :NSObject
@property (nonatomic , copy) NSString              * money;
@property (nonatomic , copy) NSString              * pay;
@property (nonatomic , copy) NSString              * reg;

@end

@interface Shop :NSObject
@property (nonatomic , copy) NSString              * money;
@property (nonatomic , copy) NSString              * month_money;
@property (nonatomic , copy) NSString              * count;
@property (nonatomic , copy) NSString              * today_money;

@end

@interface Content :NSObject
@property (nonatomic , copy) NSString              * msg;
@property (nonatomic , copy) NSString              * pinfo;

@property (nonatomic , copy) NSString              * status_count;
@property (nonatomic , copy) NSString              * username;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * mobile;



@property (nonatomic , copy) NSArray<Agent_location *>              * agent_location;

@end

@interface Count :NSObject
@property (nonatomic , copy) NSString              * money;
@property (nonatomic , copy) NSString              * pay;
@property (nonatomic , copy) NSString              * reg;

@property (nonatomic , copy) NSArray              * pay_list;
@property (nonatomic , copy) NSArray              * reg_list;


@property (nonatomic , strong) Agent              * agent;
@property (nonatomic , strong) Shop              * shop;

@end

@interface MyteamModel : NSObject
@property (nonatomic , copy) NSArray<Banners *>              * banners;
@property (nonatomic , strong) Content              * content;
@property (nonatomic , strong) Count              * count;
@property (nonatomic , copy) NSString              * user_id;


@end
