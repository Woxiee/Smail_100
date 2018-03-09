//
//  GlobalExceptionProcess.m
//  KX_Service
//
//  Created by ac on 16/7/29.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import "GlobalExceptionProcess.h"

@implementation GlobalExceptionProcess

static GlobalExceptionProcess *instance;

+(id)allocWithZone:(struct _NSZone *)zone
{
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+(instancetype)globalException
{
    return [[self alloc] init];
}

/**
 *  @param block 执行代码块，如有异常则直接返回：
 *  @return 返回值：1没有异常 0有异常退出
 */
int throwExceptionWith(dispatch_block_t block)
{
    int result = 1;
    if (instance == nil) {
        [GlobalExceptionProcess globalException];
    }
    
    @try {
        block();
    }
    @catch (NSException *exception) {
        result = 0;
        LOG(@"异常了：%@",exception);
    }
    @finally {
        return result;
    }
    return result;
}

/**
 *  异常执行代码块
 *
 *  @param block          第一个代码块
 *  @param exceptionBlock 第二个代码块
 *  @param finalBlock     第三个代码块
 *  @param 说明：执行第一个代码块，如有异常则直接执行第二个代码块，否则不执行第二个块，不管是否有异常都会执行最后一个代码块
 */
void throwExceptionAndDoException(dispatch_block_t block, dispatch_block_t exceptionBlock,dispatch_block_t finalBlock)
{
    if (instance == nil) {
        [GlobalExceptionProcess globalException];
    }
    
    @try {
        block();
    }
    @catch (NSException *exception) {
            LOG(@"异常了：%@",exception);
        exceptionBlock();
    }
    @finally {
        finalBlock();
    }
}

/**
 *  异常执行代码块
 *
 *  @param block          第一个代码块
 *  @param exceptionBlock 第二个代码块
 *  @param 说明：执行第一个代码块，如有异常则直接执行第二个代码块，否则不执行第二个块
 */
void throwExceptionDoException(dispatch_block_t block, dispatch_block_t exceptionBlock)
{
    if (instance == nil) {
        [GlobalExceptionProcess globalException];
    }
    
    @try {
        block();
    }
    @catch (NSException *exception) {
        LOG(@"异常了：%@",exception);
        exceptionBlock();
    }
    @finally {
        
    }
}


@end
