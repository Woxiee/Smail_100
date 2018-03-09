//
//  JPJsonUtillity.m
//  ChatDemo-UI3.0
//
//  Created by mac_JP on 16/12/2.
//  Copyright © 2016年 mac_JP. All rights reserved.
//

#import "JPJsonUtillity.h"

@implementation JPJsonUtillity

+ (id)objectFromJSONString:(NSString *)jsonString
{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self objectFromJSONData:jsonData];
}

+ (id)objectFromJSONData:(NSData *)jsonData
{
    NSError *error = nil;
    id      result = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    if ([result isKindOfClass:[NSArray class]]) {
        LOG(@"此解析数据为:🍎🍎🍎  数组  🍎🍎🍎");
    }
    else{
        LOG(@"此解析数据为:🍎🍎🍎  字典  🍎🍎🍎");
    }
    if (error) {
        LOG(@"%s %@", __FUNCTION__, error);
        return nil;
    }
    
    return result;
}

+ (NSString *)JSONStringFromObject:(id)object
{
    /**
     NSJSONSerialization提供了将JSON数据转换为Foundation对象（一般都是NSDictionary和NSArray）和Foundation对象转换为JSON数据（可以通过调用isValidJSONObject来判断Foundation对象是否可以转换为JSON数据）
     *  判断对象是否可以转换为json数据
     */
    if ([NSJSONSerialization isValidJSONObject:object]) {
        
        NSError *error = nil;
        NSData  *result = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
        
        if (error) {
            LOG(@"%s %@", __FUNCTION__, error);
            return nil;
        }
        
        NSString *resultString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        
#if !__has_feature(objc_arc)
        [resultString autorelease];
#endif
        
        return resultString;
    }
    else
    {
        return nil;
    }
}
@end
