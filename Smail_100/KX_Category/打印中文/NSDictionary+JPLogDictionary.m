//
//  NSDictionary+JPLogDictionary.m
//  KuaiCloud
//
//  Created by mac_JP on 16/12/20.
//  Copyright © 2016年 fec. All rights reserved.
//

#import "NSDictionary+JPLogDictionary.h"

#import "NSArray+JPLogArray.h"

@implementation NSDictionary (JPLogDictionary)


- (NSString *)JPLogDictionaryWithLocale:(id)locale
{
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
        id value= self[key];
        if ([value isKindOfClass:[NSDictionary class]]) {
           NSString *dicStr =  [value JPLogDictionaryWithLocale:value];
         [str appendFormat:@"\t \"%@\" = %@,\n",key, dicStr];
        }
        
       else if ([value isKindOfClass:[NSArray class]]) {
            NSString *arrS = [value JPLogArrayWithLocale:value];
             [str appendFormat:@"\t \"%@\" = %@,\n",key, arrS];
        }
        else
        {
             [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
        }
       
    }
    [str appendString:@"}"];
    
    return str;
}



/**
 自动生成属性的方法
 
 @param dic 字典专程模型需要的属性
 */
// NSTaggedPointerString;

+ (void)createPropertyCodeWithDict:(NSDictionary *)dict
{
    
    NSMutableString *strM = [NSMutableString string];
    
    // 遍历字典isa	Class	__NSCFString	0x0000000110c1e4a0
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull propertyName, id  _Nonnull value, BOOL * _Nonnull stop) {
        NSString *code;
        
      if ([value isKindOfClass:NSClassFromString(@"__NSCFArray")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",propertyName]
            ;
            // JP
//            if ([value isKindOfClass:[NSArray class]] && [value count]>0) {
//                    [NSDictionary createPropertyCodeWithDict:value[0]];
//            }
        
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",propertyName]
            ;
            //JP
           // [NSDictionary createPropertyCodeWithDict:value];
            
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString * %@;",propertyName]
            ;
            
        }else   if ([value isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@;",propertyName]
            ;
        }else{
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@;",propertyName]
            ;
        }
        [strM appendFormat:@"\n%@",code];
        
    }];
    
    NSLog(@"%@",strM);
    
    
}

@end
