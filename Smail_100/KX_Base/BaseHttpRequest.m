//
//  ZXBaseHttpRequest.m
//  zxmall
//
//  Created by mac on 15-6-2.
//  Copyright (c) 2015年 golvin. All rights reserved.
//
#import "BaseHttpRequest.h"
#import "AFURLSessionManager.h"
#import "NSData+Encrypt.h"
#import "NSDictionary+JPLogDictionary.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface BaseHttpRequest(){
    NSString* _interfaceURL;//接口地址
    NSDictionary* _params;//请求参数
}
@property (nonatomic, assign) RequestMethod method;//请求方式
@property (nonatomic,copy) RequestResult requestResult;
@property (nonatomic, copy) NSURLSessionDataTask *task;

@end

@implementation BaseHttpRequest

-(instancetype)initWithinterfaceURL:(NSString*)interfaceURL andmethod:(RequestMethod)method andParams:(NSDictionary*)params{
    if (self = [super init]) {
        _interfaceURL = interfaceURL;
        _method = method;
        _params = params;
    }
    return self;
}


-(void)sendHttpRequest{

    //以post方式进行数据获取
    [self postJSONWithUrl:[NSString stringWithFormat:@"%@%@",HEAD__URL,_interfaceURL] parameters:[self signParams:_params]];
}

-(void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters{
    
    //展示请求链接
    [self serializeURL:urlStr params:parameters httpMethod:@"POST"];
    //
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15;//设置超时时间
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //这个方法中实际上用了AFHTTPRequestSerializer中的requestWithMethod:方法
    _task = [manager POST:urlStr parameters:parameters constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *strdata = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
#ifdef DEBUG
        [self debug:strdata];
#endif
        
                       _requestResult(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        LOG(@"ERROR:(%ld)%@",(long)error.code,error.description)
        _requestResult(nil,error);
    }];
    [_task resume];
}


+(instancetype)postWithUrl:(NSString *)url andParameters:(id)paramter andRequesultBlock:(RequestResult)sBlock
{
    return [[self alloc] initPostWithUrl:url andParameters:paramter andRequesultBlock:sBlock];
}


- (instancetype)initPostWithUrl:(NSString *)url andParameters:(id)paramter andRequesultBlock:(RequestResult)sBlock
{
    _params = paramter;
    if ([self getCurrageNetWorkStatus] == 0) {
        //如果没有网络
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:LocalMyString(NOTICEMESSAGE)                                                                     forKey:NSLocalizedDescriptionKey];
        NSError* error = [NSError errorWithDomain:@"www.zxmall.com" code:404 userInfo:userInfo];
        sBlock(nil,error);
    }else{
        url = [NSString stringWithFormat:@"%@/api%@",HEAD__URL,url];
        _interfaceURL = url;
//        paramter =  [self signParams:_params];
        //展示请求链接
        [self serializeURL:url params:paramter httpMethod:@"POST"];
        //
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 15;//设置超时时间
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        //    这个方法中实际上用了AFHTTPRequestSerializer中的requestWithMethod:方法
        _task = [manager POST:url parameters:paramter constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
            NSString *strdata = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
#ifdef DEBUG
             [self debug:strdata];
#endif
            
            sBlock([strdata mj_JSONObject],nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            LOG(@"ERROR:(%ld)%@",(long)error.code,error.description)
            sBlock(nil,error);
        }];
        [_task resume];

    }
    return self;
}


/**
 *  上传图片的方法
 *
 *  @param block    成功回调
 */
+ (instancetype) requestUploadImage:(UIImage *)img Url:(NSString *)url  Params:(id)paramter  andFileContents:(NSString *)contents andBlock:(ImageUrlBlock)block
{
    return [[self alloc] uploadImage:img Url:url andBlock:block Params:paramter  andFileContents:contents];

}

#pragma mark - 上传图片
//图片上传
- (instancetype)uploadImage:(UIImage *)img Url:(NSString *)url andBlock:(ImageUrlBlock)block Params:(id)paramter  andFileContents:(NSString *)contents
{
    if (self == [super init]) {
        
        //[self sendGainFileServerURLRequestWith:img andPath:path andBlock:block];
        [self uploadWithImage:img Url:url andBlock:block Params:paramter andFileContents:contents];
    }
    return self;
}

- (void) uploadWithImage:(UIImage *)img  Url:(NSString *)url  andBlock:(ImageUrlBlock)block Params:(id)paramter andFileContents:(NSString *)contents
{
    self.imageBlock = block;
    
    
    NSString *returnName = @"file";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    
    NSData *imageData = UIImageJPEGRepresentation(img, 0.3);
    url = [NSString stringWithFormat:@"%@/api%@",HEAD__URL,url];
    _interfaceURL = url;
    _params = paramter;
    
    [manager POST:_interfaceURL parameters:paramter constructingBodyWithBlock:^(id  _Nonnull formData) {
        [formData appendPartWithFileData :imageData name:returnName fileName:returnName mimeType:@"multipart/form-data"];
        }
         progress:^(NSProgress * _Nonnull uploadProgress) {
             NSLog(@"uploadProgress = %@",uploadProgress);
         }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"responseObject = %@, task = %@",responseObject,task);
              NSString *strdata = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
#ifdef DEBUG
              [self debug:strdata];
#endif
              NSDictionary *dic = [strdata mj_JSONObject];
        
              NSInteger status = [dic[@"code"] integerValue];
              if (status == 0) {
                  self.imageBlock(dic[@"data"]);
              }
              
              
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
          }];

}

- (instancetype)requestUploadImageList:(NSArray *)listArr Url:(NSString *)url Params:(id)paramter andBlock:(ImageUrlInfoBlock)block
{
    
    if (self == [super init]) {
        
        //[self sendGainFileServerURLRequestWith:img andPath:path andBlock:block];
        [self uploadWithImageList:listArr Url:url  Params:paramter andBlock:block];
    }
    return self;
}


- (void) uploadWithImageList:(NSArray *)listArr Url:(NSString *)url Params:(id)paramter   andBlock:(ImageUrlInfoBlock)block
{
    self.imageInfoBlock = block;
    
    
    NSString *returnName = @"file";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    
    url = [NSString stringWithFormat:@"%@/api%@",HEAD__URL,url];
    _interfaceURL = url;
    _params = paramter;
    
    [manager POST:_interfaceURL parameters:paramter constructingBodyWithBlock:^(id  _Nonnull formData) {
        for (int i = 0; i < listArr.count; i++) {
            UIImage *img = listArr[i];
            NSData *imageData = UIImageJPEGRepresentation(img, 0.3);
            if (i==0) {
                [formData appendPartWithFileData :imageData name:@"file[idcard_image]" fileName:@"file[idcard_image]" mimeType:@"multipart/form-data"];
            }
            else if (i == 1){
                [formData appendPartWithFileData :imageData name:@"file[idcard_image_back]" fileName:@"file[idcard_image_back]" mimeType:@"multipart/form-data"];
            }
            else{
                [formData appendPartWithFileData :imageData name:@"file[people_image]" fileName:@"file[people_image]" mimeType:@"multipart/form-data"];
            }

        }

    }
         progress:^(NSProgress * _Nonnull uploadProgress) {
             NSLog(@"uploadProgress = %@",uploadProgress);
         }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"responseObject = %@, task = %@",responseObject,task);
              NSString *strdata = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
#ifdef DEBUG
              [self debug:strdata];
#endif
              NSDictionary *dic = [strdata mj_JSONObject];
              
              NSInteger status = [dic[@"code"] integerValue];
              if (status == 0) {
                  self.imageInfoBlock(dic[@"msg"],dic[@"code"]);
              }else{
                  self.imageInfoBlock(dic[@"msg"],dic[@"code"]);

              }
              
              
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
          }];
}


-(void)debug:(NSString *)strdata{
    
    NSArray *allkeys = [_params allKeys];
    NSString *paramUrl = @"";
    for (NSString *akey in allkeys) {
        NSString *aValue = [_params valueForKey:akey];
        paramUrl = [NSString stringWithFormat:@"%@&%@=%@",paramUrl,akey,aValue];
    }
    NSString *resultURL = [NSString stringWithFormat:@"%@%@",_interfaceURL,paramUrl];

    LOG(@"🍎🍎🍎🍎🍎🍎🍎🍎\n _interfaceURL==%@ \n🍎🍎\n_params ==_params%@ \n🍎🍎🍎🍎请求网络得到的数据＝＝ \n%@ 🍎🍎🍎🍎🍎🍎🍎",resultURL,_params,[[strdata mj_JSONObject] JPLogDictionaryWithLocale:[strdata mj_JSONObject]])
    
//    //模型自动转换 只针对list
//    if ([[strdata mj_JSONObject] isKindOfClass:[NSDictionary class]] && [[strdata mj_JSONObject][@"data"][@"list"] isKindOfClass:[NSArray class]]) {
//        NSArray *arr =[strdata mj_JSONObject][@"data"][@"list"];
//
//     
//        if (arr.count>0) {
//            NSDictionary *dic = arr.firstObject;
//            [NSDictionary createPropertyCodeWithDict:dic];
//        }
//    }
}

#pragma mark- 进行网络加密
-(NSDictionary *)signParams:(NSDictionary*)params{
    //LOG(@"🍎🍎🍎🍎\n 参数:%@ \n🍎🍎🍎🍎",params);
    
    //1.拼接param参数
    NSMutableDictionary *paramsM = [NSMutableDictionary dictionary];
    [paramsM setObject:request_uid forKey:@"u"];//合作商标识
    [paramsM setObject:request_version forKey:@"v"];//当前版本号

    //3.重新组合params并对value进行uinicode编码
    for (NSString *key in params.allKeys) {
        id obj = [params objectForKey:key];
        NSString *value = @"";
        if ([obj isKindOfClass:[NSString class]]) {
            value = [NSString chinaToUnicode:obj];//对value进行unicode编码
        }else{
            value = obj;
        }
        
        [paramsM setObject:value forKey:key];
    }
    
    //2.对key进行排序
    NSArray *keyArr = [paramsM.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    //4.进行si的拼接
    NSMutableString* siStr = [NSMutableString new];
    for (NSString *key in keyArr) {
        [siStr appendFormat:@"%@=%@",key,[paramsM objectForKey:key]];
    }

    //5.进行si的MD5签名和pa的DES+Base64加密
    //请求签名
//    NSString *paStr = [Common DataTOjsonString:paramsM];//将参数转成json字符串
    NSString *paStr = [self dataToJSON:paramsM];
    NSData *data = [paStr dataUsingEncoding:NSUTF8StringEncoding];//先将参数转二进制
    NSDictionary *dict = @{@"si":[NSString md5HexDigest:siStr],//签名使用MD5加密
                         @"pa":[[NSData desEncrypt:data] base64EncodedString]};//DES+Base64
    return dict;
}

- (NSString *) dataToJSON:(NSDictionary *) param{
    if (param) {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:param options:0 error:&error];
        if (error) {
            return @"";
        }else{
            return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    }else{
        return @"";
    }
}

#pragma mark- 获取imei
- (NSString *) imei
{
    NSUUID* uuid = [[UIDevice currentDevice] identifierForVendor];
    return [uuid UUIDString];
}

#pragma mark- 获取时间戳
-(NSString*) time_stamp
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];
    return timeSp;
}

#pragma mark- 展式请求的地址及其参数
- (void)serializeURL:(NSString *)baseURL params:(NSDictionary *)params httpMethod:(NSString *)httpMethod
{
    
    NSURL* parsedURL = [NSURL URLWithString:baseURL];
    NSString* queryPrefix = parsedURL.query ? @"&" : @"?";
    
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [params keyEnumerator])
    {
        NSString* escaped_value = [params objectForKey:key];
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
    }
    NSString* query = [pairs componentsJoinedByString:@"&"];
    
}

#pragma mark- 取消请求
- (void)cancel{
    if (_task != nil) {
        [_task cancel];
    }
}

#pragma mark- 获取当前的网络状态
- (NSInteger)getCurrageNetWorkStatus{
    
    NSInteger type = 0;
    
    struct sockaddr_storage zeroAddress;
    bzero(&zeroAddress,sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);
    zeroAddress.ss_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL,(struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability,&flags);
    CFRelease(defaultRouteReachability);
    //如果不能获取连接标志，则不能连接网络，直接返回
    if(!didRetrieveFlags){
        return 0;
        
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable)!=0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired)!=0);
    if(!isReachable || needsConnection) {
        return 0;
        
    }
    // 网络类型判断
    if((flags & kSCNetworkReachabilityFlagsConnectionRequired)== 0){
        type = 4;
        
    }
    if(((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||(flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0) { if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0){
        type = 4;
        
    }}
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) ==kSCNetworkReachabilityFlagsIsWWAN) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
            NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;if (currentRadioAccessTechnology) {if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
                type = 3;
            } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]) {
                type = 1;
                
            } else {
                type = 2;
                
            }}}
        else {if((flags & kSCNetworkReachabilityFlagsReachable) == kSCNetworkReachabilityFlagsReachable) {if ((flags & kSCNetworkReachabilityFlagsTransientConnection) == kSCNetworkReachabilityFlagsTransientConnection) {if((flags & kSCNetworkReachabilityFlagsConnectionRequired) == kSCNetworkReachabilityFlagsConnectionRequired) {
            type = 1;
            
        } else {
            type = 2;
            
        }
            
        }
            
        }
            
        }
        
    }
    return type;
}
@end
