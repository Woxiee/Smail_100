//
//  NSArray+JPLogArray.m
//  KuaiCloud
//
//  Created by mac_JP on 16/12/20.
//  Copyright © 2016年 fec. All rights reserved.
//

#import "NSArray+JPLogArray.h"

#import "NSDictionary+JPLogDictionary.h"
@implementation NSArray (JPLogArray)


- (NSString *)JPLogArrayWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSString *ArrS = [obj JPLogDictionaryWithLocale:obj];
            [str appendFormat:@"\t%@, \n", ArrS];
        }else if([obj isKindOfClass:[NSArray class]]){
           NSString *ss = [obj JPLogArrayWithLocale:obj];
          [str appendFormat:@"\t%@, \n", ss];
        }
    }
    
    [str appendString:@")"];
    
    return str;
}
@end
