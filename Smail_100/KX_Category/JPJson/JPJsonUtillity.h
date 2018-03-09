//
//  JPJsonUtillity.h
//  ChatDemo-UI3.0
//
//  Created by mac_JP on 16/12/2.
//  Copyright © 2016年 mac_JP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPJsonUtillity : NSObject




/**
 *
 */
+ (id)objectFromJSONString:(NSString *)jsonString;



/**
 *
 */
+ (NSString *)JSONStringFromObject:(id)object;

/**
 *
 */
+ (id)objectFromJSONData:(NSData *)jsonData;


@end
