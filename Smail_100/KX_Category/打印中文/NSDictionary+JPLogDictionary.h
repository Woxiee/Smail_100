//
//  NSDictionary+JPLogDictionary.h
//  KuaiCloud
//
//  Created by mac_JP on 16/12/20.
//  Copyright © 2016年 fec. All rights reserved.
//这个类 仅用于调试用的  打包不需要用

#import <Foundation/Foundation.h>

@interface NSDictionary (JPLogDictionary)

/**
 此方法可直接打印中文 用于代码调试
 */
- (NSString *)JPLogDictionaryWithLocale:(id)locale;




/**
 自动生成属性的方法

 @param dict 字典专程模型需要的属性
 */

+ (void)createPropertyCodeWithDict:(NSDictionary *)dict;


@end
