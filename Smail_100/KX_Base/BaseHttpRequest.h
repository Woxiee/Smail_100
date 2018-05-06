//
//  ZXBaseHttpRequest.h
//  zxmall
//
//  Created by mac on 15-6-2.
//  Copyright (c) 2015年 golvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

typedef enum{
    kPOST,
    kGET
}RequestMethod;

typedef void(^RequestResult)(id result, NSError *error);
typedef void(^PostSuccessBlock)( id responseObject);
typedef void(^PostFailBlock)(NSError *error);
typedef void (^ImageUrlBlock)(NSString *imageName);

typedef void (^ImageUrlInfoBlock)(NSString *imageName,NSString *code);

@interface BaseHttpRequest : NSObject
@property (nonatomic,copy) ImageUrlBlock imageBlock;
@property (nonatomic,copy) ImageUrlInfoBlock imageInfoBlock;


//构造方法
-(instancetype)initWithinterfaceURL:(NSString*)interfaceURL andmethod:(RequestMethod)method andParams:(NSDictionary*)params;


//取消请求
- (void)cancel;


+(instancetype)postWithUrl:(NSString *)url andParameters:(id)paramter andRequesultBlock:(RequestResult)sBlock;


/**
 *  上传图片的方法
 *
 *  @param block    成功回调
 */
+ (instancetype) requestUploadImage:(UIImage *)img Url:(NSString *)url Params:(id)paramter andFileContents:(NSString *)contents andBlock:(ImageUrlBlock)block;

- (instancetype) requestUploadImageList:(NSArray *)listArr Url:(NSString *)url Params:(id)paramter andBlock:(ImageUrlInfoBlock)block;


@end
