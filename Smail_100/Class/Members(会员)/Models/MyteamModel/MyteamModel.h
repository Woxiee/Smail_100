//
//  MyteamModel.h
//  Smail_100
//
//  Created by Faker on 2018/5/13.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Content :NSObject
@property (nonatomic , copy) NSString              * msg;
@property (nonatomic , copy) NSString              * pinfo;

@end

@interface Count :NSObject
@property (nonatomic , copy) NSString              * money;
@property (nonatomic , copy) NSString              * pay;
@property (nonatomic , copy) NSString              * reg;

@end

@interface MyteamModel : NSObject
@property (nonatomic , copy) NSArray<Banners *>              * banners;
@property (nonatomic , strong) Content              * content;
@property (nonatomic , strong) Count              * count;
@property (nonatomic , copy) NSString              * user_id;


@end
