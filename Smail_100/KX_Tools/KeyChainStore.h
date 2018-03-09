//
//  KeyChainStore.h
//  KX_Service
//
//  Created by Frank on 16/9/13.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKeyData:(NSString *)service;
@end
