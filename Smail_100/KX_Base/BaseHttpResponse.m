//
//  ZXBaseHttpResponse.m
//  zxmall
//
//  Created by mac on 15-6-3.
//  Copyright (c) 2015年 golvin. All rights reserved.
//

#import "BaseHttpResponse.h"

@implementation BaseHttpResponse

- (id)initWithJsonData:(NSData *)jsonData{
    self = [super init];
    if (self)
    {
        if (jsonData) {
            NSError* error = nil;
            
            //转成json
//            
          //  LOG(@"🍎🍎🍎🍎\n resultStr=%@  \n🍎🍎🍎🍎",[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding]);
            //解析json
            id result =[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
            if (error == nil) {
                _dataFormatIsValue = YES;
            }else{
                _dataFormatIsValue = NO;
            }
            
            [self getData:result];
        }
    }
    return self;
}

//获取数据
-(void)getData:(id)data{
    if (_dataFormatIsValue) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            self.code = [data objectForKey:@"code"];
            self.message = [data objectForKey:@"message"];
        
        }else{
            self.code = @"111";
            self.message = LocalMyString(@"error.back.info.format");
        }
    }else{
        self.code = @"111";
        self.message = LocalMyString(@"error.back.info.format");
    }
}

-(id)initWithJsonDic:(NSDictionary *)jsonDic
{
    if (self = [super init]) {
        [self getData:jsonDic];
    }
    return self;
}
@end
