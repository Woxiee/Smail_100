//
//  NSData+Encrypt.h
//  hopaby
//
//  Created by mac on 15/12/18.
//  Copyright © 2015年 FEC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encrypt)

//DES加密
+ (NSData *)desEncrypt:(NSData *) data;//使用默认的key//加密
//DES解密
+ (NSData *)desDecrypt:(NSData *) data;//使用默认的key解密
//DES加密
+ (NSData *)desEncrypt:(NSData *)data WithKey:(NSString *)key;
//DES解密
+ (NSData *)desDecrypt:(NSData *)data WithKey:(NSString *)key;



//Base64加密
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;

//Base64解密
+ (NSData*) base64Decode:(NSString *)string;
@end
