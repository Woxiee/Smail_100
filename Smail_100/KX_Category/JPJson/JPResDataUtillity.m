//
//  JPResDataUtillity.m
//  ChatDemo-UI3.0
//
//  Created by mac_JP on 16/12/2.
//  Copyright © 2016年 mac_JP. All rights reserved.
//

#import "JPResDataUtillity.h"

#import "JPJsonUtillity.h"

NSString *types;

@implementation JPResDataUtillity
+ (id)dictionaryWithData:(id)data
{
    NSDictionary *attributes = nil;
    @try {
        attributes = [JPJsonUtillity objectFromJSONData:data];
    }
    @catch(NSException *exception) {
        NSLog(@"%s [Line %d] JSON转换NSDictionary数据格式有误!-->\n%@", __PRETTY_FUNCTION__, __LINE__, exception);
    }
    
    @finally {}
    if (attributes == nil) {
        NSLog(@"JSON转换NSDictionary数据格式有误!");
    }
    
    return attributes;
}

 

+ (id)dictionaryWithString:(id)string
{
    NSDictionary *attributes = nil;
    
    @try {
        attributes = [JPJsonUtillity objectFromJSONString:string];
    }
    @catch(NSException *exception) {
        NSLog(@"%s [Line %d] JSON转换NSDictionary数据格式有误!-->\n%@", __PRETTY_FUNCTION__, __LINE__, exception);
    }
    @finally {}
    if (attributes == nil) {
        NSLog(@"XML转换NSDictionary数据格式有误!");
    }
    return attributes;
}

 


@end
