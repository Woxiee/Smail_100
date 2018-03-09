//
//  Comment.m
//  zxmall
//
//  Created by mac on 15/6/16.
//  Copyright (c) 2015年 golvin. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import <objc/message.h>
#import "Common.h" 
#import "LoginVC.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import "WXApi.h"
#define APPSCHEME @"globalmeitao"

@implementation Common

#pragma mark- md5 32位 加密
+ (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str,(CC_LONG) strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

#pragma mark- 转json字符串
+(NSString*)DataTOjsonString:(NSDictionary*)params
{
//    NSString *jsonString = nil;
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
////    if (! jsonData) {
////    }else {
//        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUnicodeStringEncoding];
////    }
////    return jsonString;
    NSString *dataString = @"";
    NSMutableString *jsonString = [NSMutableString new];
    [jsonString appendString:@"{"];
    for (NSString* key in [params keyEnumerator])
    {
        id val = [params objectForKey:key];
        if ([val isKindOfClass:[NSString class]]) {
            [jsonString appendString:@"\""];
            [jsonString appendString:key];
            [jsonString appendString:@"\""];
            [jsonString appendString:@":"];
            [jsonString appendString:@"\""];
            [jsonString appendString:val];
            [jsonString appendString:@"\","];
        }
    }
    if (jsonString.length > 1) {
        [jsonString deleteCharactersInRange:NSMakeRange(jsonString.length-1, 1)];
    }
    [jsonString appendString:@"}"];
    
    dataString = jsonString;
    return dataString;
    
}

#pragma mark- 获取当前的网络状态
+(NSInteger)getCurrageNetWorkStatus{
    
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

 

+(NSString *)changeMobileHide:(NSString *)mobile{
    if (![mobile isKindOfClass:[NSString class]]) {
        return @"";
    }
    NSString *tel  = [NSString stringWithString:mobile];
    if (tel && tel.length == 11) {
        tel = [tel stringByReplacingCharactersInRange:NSMakeRange(3, 5) withString:@"*****"];
       
    }
    return tel;
}

+(NSString *)transformToPinyin:(NSString*)chinese{
    NSMutableString *mutableString = [NSMutableString stringWithString:chinese];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return mutableString;
}

+ (BOOL)isValidateEmail:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}

+ (BOOL) isValidatePostCode:(NSString *) postCode{
    NSString *postCodeCheck = @"^[1-9][0-9]{5}$";
    NSPredicate *postCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",postCodeCheck];
    return [postCodeTest evaluateWithObject:postCode];
}

+ (BOOL) isValidateMobile:(NSString *)mobileNum
{
    NSString *MOBILE = @"^[1][3578]\\d{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];

    if (([regextestmobile evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//判断银行卡号
+(BOOL)validateBankAccount:(NSString *)bankAccount
{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[bankAccount length];
    int lastNum = [[bankAccount substringFromIndex:cardNoLength-1] intValue];
    
    bankAccount = [bankAccount substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [bankAccount substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

//身份证号
+ (BOOL)isValidateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0)
    {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:identityCard];
    
    
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag)
    {
        if(identityCard.length==18)
        {
            //将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            //用来保存前17位各自乖以加权因子后的总和
            
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++)
            {
                NSInteger subStrIndex = [[identityCard substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum+= subStrIndex * idCardWiIndex;
                
            }
            
            //计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            
            //得到最后一位身份证号码
            NSString * idCardLast= [identityCard substringWithRange:NSMakeRange(17, 1)];
            
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2)
            {
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
                {
                    return flag;
                }else
                {
                    flag =  NO;
                    return flag;
                }
            }else
            {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
                {
                    return flag;
                }
                else
                {
                    flag =  NO;
                    return flag;
                }
            }
        }
        else
        {
            flag =  NO;
            return flag;
        }
    }
    else
    {
        return flag;
    }

}
//判断字符串是否是整型

//字符串去掉空格
+(NSString *)stringWithOutSpace:(NSString *)str{
    if ([self isNullString:str]) {
        return @"";
    }
    NSString * newStr = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return newStr;
}

+ (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}


//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}
+ (BOOL)isValidatePwd:(NSString *)pwd{
    NSString *pwdCheck = @"^[0-9a-zA-Z]{6,16}$";
    NSPredicate *pwdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pwdCheck];
    return [pwdTest evaluateWithObject:pwd];
}
+(BOOL) isNullString:(NSString *)string
{

    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (string == nil) {
        return YES;
    }
    if ([string isEqualToString:@"<nill>"]||[string isEqualToString:@"<null>"]||[string isEqualToString:@""]||[string isEqualToString:@"(null)"]) {
        return YES;
    }
    return NO;
}

+ (NSString *)chinaToUnicode:(NSString *)str{
    
    NSUInteger length = [str length];
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++)
    {
        int _char = [str characterAtIndex:i];
        // 汉字范围 \u4e00-\u9fa5 (中文)
        if (_char >= 19968 && _char <= 171941) {
            [result appendFormat:@"\\u%x",[str characterAtIndex:i]];//转16进制
        }else{
            [result appendFormat:@"%c",[str characterAtIndex:i]];
        }
    }
    return result;
    
}
#if 0
+ (NSString *)getDistanceBy:(CLLocation *)location{
    
    // 百度坐标转化为地球坐标
    CLLocation *earthLocation = [location locationEarthFromBaidu];
    // 计算距离
    CLLocationDistance meters = [earthLocation distanceFromLocation:[Single sharedManager].currLocation];
    if (meters < 1000) {
        return [NSString stringWithFormat:@"%.0f米",meters];
    }else{
        CGFloat km = meters / 1000;
        return [NSString stringWithFormat:@"%.2f千米",km];
    }
}
// 支付宝
+ (void)alipay:(NSString*)orderStr callBack:(CallBackFunction) callBack;{
    
    if (orderStr != nil) {
        [[AlipaySDK defaultService] payOrder:orderStr fromScheme:APPSCHEME callback:^(NSDictionary *resultDic) {
            callBack(resultDic);
        }];
    }
}
+ (void)weChatPay:(NSString *) orderString{
    NSData *data = [orderString dataUsingEncoding:NSUTF8StringEncoding];
    id payInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    if ([payInfo isKindOfClass:[NSDictionary class]]) {
        
        NSString *appid = [payInfo valueForKey:@"appid"];
        NSString *mchid = [payInfo valueForKey:@"partnerid"];//商户id
        
        [WXApi registerApp:appid withDescription:@"demo 2.0"];
        
        PayReq *request = [[PayReq alloc] init];
        //这些数据是通过服务端进行了一次签名后返回的
        request.openID = appid;
        request.partnerId = mchid;
        request.prepayId= [payInfo valueForKey:@"prepayid"];
        request.package = [payInfo valueForKey:@"package"];
        request.nonceStr= [payInfo valueForKey:@"noncestr"];
        request.timeStamp = [[payInfo valueForKey:@"timestamp"] intValue];
        
        //进行二次签名(二次签名只是为了获取到sign)
        NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
        [signParams setObject:appid forKey:@"appid"];
        [signParams setObject:request.nonceStr forKey:@"noncestr"];
        [signParams setObject:request.package forKey:@"package"];
        [signParams setObject:mchid forKey:@"partnerid"];
        [signParams setObject:request.prepayId forKey:@"prepayid"];
        [signParams setObject:[payInfo valueForKey:@"timestamp"] forKey:@"timestamp"];
        //进行第二次签名
        NSString *appKey = [payInfo valueForKey:@"appKey"];
        //进行md5加密
        NSString *sign = [self createMd5Sign:signParams withAppKey:appKey];
        
        request.sign= sign;
        [WXApi sendReq:request];
        
    }
}

//创建package签名
+(NSString*) createMd5Sign:(NSMutableDictionary*)dict withAppKey:(NSString *) appKey
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
        
    }
    //添加key字段
    [contentString appendFormat:@"key=%@",appKey];//这个key是商户key
    
    //得到MD5 sign签名
    NSString *md5Sign =[self md5HexDigest:contentString];
    
    return md5Sign;
}

+ (UIViewController*)superViewController:(UIView *)view
{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
#endif

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    //去掉字符串前后两端的空格
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
//颜色转图片
+ (UIImage *)imageWithSize:(CGSize )size color:(UIColor *)color
{
    
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,1.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
//data转json
+ (NSString *) dataToJSON:(id) param{
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

+ (void)presentToLoginView:(UIViewController *)ctr{


    LoginVC *loginVc = [[LoginVC alloc]init];
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
    
    [ctr presentViewController:nav animated:YES completion:nil];

}





//string转json
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


//保留两位小数
+(NSString *)stringToTwoPoint:(NSString *)stringIn{
    CGFloat myFloat = [stringIn doubleValue];
    return [NSString stringWithFormat:@"%.2f",myFloat];
}

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size {
    CGRect rect = [string boundingRectWithSize:CGSizeMake(size.width, size.height)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

 
+(BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}




//######控制跳转的＃＃＃＃＃
+(void)popToRootControllerIndex:(NSInteger )index viewController:(UIViewController*)viewController
{
    viewController.tabBarController.tabBar.hidden = NO;
    viewController.tabBarController.selectedIndex = index;
    [viewController.navigationController popToRootViewControllerAnimated:YES];
}


+(void)openURL:(OPENURLType)type{
    
    switch (type) {
        case OPENURLTypeWifi:
        {
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]]; 
        } break;
        case OPENURLTypSettings:{
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }break;
            
        default:
            break;
    }
}
@end
