//
//  JPResDataUtillity.h
//  ChatDemo-UI3.0
//
//  Created by mac_JP on 16/12/2.
//  Copyright © 2016年 mac_JP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DataType){
    DataTypeJson,
    DataTypeXml
    
};


@interface JPResDataUtillity : NSObject

@property (nonatomic)   DataType     dataType ; //Defaut is DataTypeJson;

+ (NSDictionary *)dictionaryWithData:(id)data;


/**
 *  把服务器返回的NSString数据进行处理,默认是JSON数据
 *
 *         string NSString格式数据
 *
 *  @return NSDictionary字典类型
 */
+ (NSDictionary *)dictionaryWithString:(id)string;

 
@end
