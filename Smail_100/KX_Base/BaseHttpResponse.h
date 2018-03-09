//
//  ZXBaseHttpResponse.h
//  zxmall
//
//  Created by mac on 15-6-3.
//  Copyright (c) 2015年 golvin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kErrorCode @"000"

@interface BaseHttpResponse : NSObject

@property (nonatomic,assign)BOOL dataFormatIsValue;//判断返回的数据是否是json格式

@property (nonatomic,copy)NSString* code;
@property (nonatomic,copy)NSString* message;

- (id)initWithJsonData:(NSData *)jsonData;

/**
 *  获取数据
 *
 *  @param data 响应数据
 */
-(void)getData:(id)data;

//处理我门自己的数据
-(id)initWithJsonDic:(NSDictionary *)jsonDic;
@end
