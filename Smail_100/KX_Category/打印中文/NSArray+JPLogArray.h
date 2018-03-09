//
//  NSArray+JPLogArray.h
//  KuaiCloud
//
//  Created by mac_JP on 16/12/20.
//  Copyright © 2016年 fec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JPLogArray)

/**
 此方法可直接打印中文 用于代码调试
 */
- (NSString *)JPLogArrayWithLocale:(id)locale;
@end
