//
//  PaterModel.h
//  Smail_100
//
//  Created by 家朋 on 2018/5/16.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MyteamModel.h"

@interface PaterModel : NSObject
@property (nonatomic , copy) NSString              * idcard;
@property (nonatomic , copy) NSString              * ctime;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * user_id;
//@property (nonatomic , copy) NSArray<Agent_location *>              * agent_location;
@property (nonatomic , copy) NSString              * realname;
@property (nonatomic , copy) NSString              * emall;
@property (nonatomic , copy) NSArray             * agent_location_str;
@property (nonatomic , copy) NSString              * avatar_url;
@property (nonatomic , copy) NSString              * agent_level;

@property (nonatomic , copy) NSString              * codeID;
@property (nonatomic , copy) NSString              * maker_level;



@end
