//
//  JPDbg.h
//  KuaiCloud
//
//  Created by mac_JP on 16/12/20.
//  Copyright © 2016年 fec. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSArray+JPLogArray.h"

#import "NSDictionary+JPLogDictionary.h"



@interface JPDbg : NSObject

 

/**
 *  把服务器返回的NSString数据进行处理,默认是JSON数据  NSDate-->NSDictionary
 */
+ (NSDictionary *)dictionaryWithData:(id)data;


/**
 *  把服务器返回的NSString数据进行处理,默认是JSON数据  string-->NSDictionary
 */
+ (NSDictionary *)dictionaryWithString:(id)string;


@end
