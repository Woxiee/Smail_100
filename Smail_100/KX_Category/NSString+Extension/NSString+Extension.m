//
//  NSString+Extension.h
//
//  KX_Service
//
//  Created by Frank on 16/9/6.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/message.h>

#import <sys/utsname.h>
#define NUMBERS @"0123456789\n"
#define anHour  3600
#define aMinute 60
@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
     NSDictionary *attrs = @{NSFontAttributeName : font};
     return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (NSString *) throwExceptionString
{
     return self;
}

//不区分大小写是否包含某个字符
- (BOOL)containsStringWith:(NSString *)str
{
     if([self rangeOfString:str options:NSCaseInsensitiveSearch].location != NSNotFound)
     {
          return YES;
     }
     return NO;
}

//判断某个字符串包含某些特殊字符开头的，不区分大小写
- (BOOL) hasStringWithPrefix:(NSString *)aString
{
     NSRange range = [self rangeOfString:aString options:NSCaseInsensitiveSearch];
     
     //    LOG(@"NSRange: %@",NSStringFromRange(range));
     
     if (range.location == 0 && range.length == aString.length) {
          return YES;
     }
     return NO;
}

#pragma mark - 字符串转Json

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param dic JSON格式的字符串
 * @return 返回字典
 */
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
     NSError *parseError = nil;
     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
     return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

///替换html 字段
+ (NSString *)filterHTML:(NSString *)str
{
     NSScanner * scanner = [NSScanner scannerWithString:str];
     NSString * text = nil;
     while([scanner isAtEnd]==NO)
     {
          //找到标签的起始位置
          [scanner scanUpToString:@"<" intoString:nil];
          //找到标签的结束位置
          [scanner scanUpToString:@">" intoString:&text];
          //替换字符
          str  =  [str  stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
     }
     
     return str;
}

/// 处理<br> 字段
+(NSString *)replaceAbnormalStr:(NSString *)str
{
     if (![str NullString]) {
          str = [str  stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
     }
     return str;
}

/**
 判断是否是空字符 包含@“”
 
 @return 是返回YES
 */
- (BOOL)NullString
{
     if (self.class == [NSNull class]) {
          return YES;
     }else if([self isEqualToString:@""]){
          return YES;
     }
     
     return NO;
     
}

+ (NSString *)timeStr:(NSString *)sendTime
{
     NSDate *currentDate = [NSDate date];
     
     // 获取当前时间的年、月、日
      NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
     [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
     return [dateFormat stringFromDate:currentDate];
}

/*!
 * @brief inputStr 传递输入的 str
 *
 * @return 返回BOOL yes 表示是数字
 */
+ (BOOL)cheakInputStrIsNumber:(NSString *)inputStr
{
     NSCharacterSet *cs;
     cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
     NSString *filtered = [[inputStr componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
     BOOL isNumber = [inputStr isEqualToString:filtered];
     return isNumber;
}


/**
 * @brief inputStr 传递输入的 str
 *
 * @return 返回BOOL yes 表示是空格
 */
+ (BOOL)cheakInputStrIsBlankSpace:(NSString *)inputStr
{
     if (!inputStr) {
          return YES;
     }
     else {
          NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
          NSString *trimedString = [inputStr stringByTrimmingCharactersInSet:set];
          if ([trimedString length] == 0) {
               return YES;
          } else {
               return NO;
          }
     }
}

/**
 * @brief value 传递输入的 str
 *  valfontue 传递输入的 字体大小
 *  size      拓展范围
 * @return 返回BOOL yes 表示是空格
 */
+ (CGSize)heightForString:(NSString *)value  fontSize:(UIFont *)font WithSize:(CGSize)size
{
     NSDictionary *attribute = @{NSFontAttributeName: font};
     CGSize retSize = [value boundingRectWithSize:size
                                          options:\
                       NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
     return retSize;
}



/*!
 * @startDay 表示开始时间
 * @endDay   表示结束时间
 *  return    yes 表示 结束时间大于开始时间
 */
+ (BOOL)compareOneDay:(NSString *)startDay withAnotherDay:(NSString *)endDay
{
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

     NSDate *dateA = [dateFormatter dateFromString:startDay];
     NSDate *dateB = [dateFormatter dateFromString:endDay];
    if (dateA == nil || dateB == nil) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd "];
        NSDate *dateA = [dateFormatter dateFromString:startDay];
        NSDate *dateB = [dateFormatter dateFromString:endDay];
        NSComparisonResult result = [dateA compare:dateB];
        /// NSOrderedDescending 过去
        if (result == NSOrderedDescending) {
            return NO;
        }
        /// NSOrderedSame 当前
        else if (result == NSOrderedSame){
            return YES;
        }
        /// NSOrderedAscending 未来
        else if (result == NSOrderedAscending){
            return YES;
        }

    }

     NSComparisonResult result = [dateA compare:dateB];
     /// NSOrderedDescending 未来
     if (result == NSOrderedDescending) {
          return NO;
     }
     /// NSOrderedSame 当前
     else if (result == NSOrderedSame){
          return YES;
     }
     /// NSOrderedAscending 过去
     else if (result == NSOrderedAscending){
          return YES;
     }
     return YES;
}


//获取当地时间
//获取当地时间
+ (NSString *)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}


/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param dic JSON格式的字符串
 * @return 返回字典
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
     NSError *parseError = nil;
     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
     return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



/*!
 * @brief 转换特殊字体
 * @param str 要转换的字体
 * @param range 要转换的字体长度
 * @param color 要转换的字体颜色
 * @param font 要转换的字体大小
 * @return 返回 NSAttributedString类型字体
 */
- (NSAttributedString *)creatAttributedString:(NSString *)str withMakeRange:(NSRange)range withColor:(UIColor *)color withFont:(UIFont *)font
{
     NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
     [attrStr addAttribute:NSFontAttributeName
                     value:font
                     range:range];
     
     [attrStr addAttribute:NSForegroundColorAttributeName
                     value:color
                     range:range];
     return attrStr;
     
}

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
     mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
     if (mobile.length != 11)
     {
          return NO;
     }else{
          /**
           * 移动号段正则表达式
           */
          NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
          /**
           * 联通号段正则表达式
           */
          NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
          /**
           * 电信号段正则表达式
           */
          NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
          NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
          BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
          NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
          BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
          NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
          BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
          
          if (isMatch1 || isMatch2 || isMatch3) {
               return YES;
          }else{
               return NO;
          }
     }
}
+ (NSString*)weekDayStr:(NSString *)format
{
     NSString *weekDayStr = nil;
     
     NSDateComponents *comps = [[NSDateComponents alloc] init];
     
     NSString *str = [self description];
     if (str.length >= 10) {
          NSString *nowString = [str substringToIndex:10];
          NSArray *array = [nowString componentsSeparatedByString:@"-"];
          if (array.count == 0) {
               array = [nowString componentsSeparatedByString:@"/"];
          }
          if (array.count >= 3) {
               int year = (int)[[array objectAtIndex:0] integerValue];
               int month = (int)[[array objectAtIndex:1] integerValue];
               int day = (int)[[array objectAtIndex:2] integerValue];
               [comps setYear:year];
               [comps setMonth:month];
               [comps setDay:day];
          }
     }
     
     NSCalendar *gregorian = [[NSCalendar alloc]
                              initWithCalendarIdentifier:NSGregorianCalendar];
     NSDate *_date = [gregorian dateFromComponents:comps];
     NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
     int week = (int)[weekdayComponents weekday];
     week ++;
     switch (week) {
          case 1:
               weekDayStr = @"星期日";
               break;
          case 2:
               weekDayStr = @"星期一";
               break;
          case 3:
               weekDayStr = @"星期二";
               break;
          case 4:
               weekDayStr = @"星期三";
               break;
          case 5:
               weekDayStr = @"星期四";
               break;
          case 6:
               weekDayStr = @"星期五";
               break;
          case 7:  
               weekDayStr = @"星期六";  
               break;  
          default:  
               weekDayStr = @"";  
               break;  
     }  
     return weekDayStr;  
}


+ (NSString *)stringWithTimeStamp:(NSNumber *)timeStamp {
     //获取当前时间
     NSDate *currentDate = [NSDate date];
     //将当前时间转化为时间戳
     NSTimeInterval currentDateStamp = [currentDate timeIntervalSince1970] + 8 * anHour;
     //将传入的参数转化为时间戳
     double dateStamp = [timeStamp doubleValue] + 8 * anHour;
     //计算时间间隔，即当前时间减去传入的时间
     double interval = currentDateStamp - dateStamp;
     //获取当前时间的小时单位（24小时制）
     NSDateFormatter *formatter = [NSDateFormatter new];
     [formatter setDateFormat:@"H"];
     int nowHour = [[formatter stringFromDate:currentDate] intValue];
     //获取当前时间的分钟单位
     NSDateFormatter *minFormatter = [NSDateFormatter new];
     [minFormatter setDateFormat:@"m"];
     int nowMinute = [[minFormatter stringFromDate:currentDate] intValue];
     //今天0点的时间戳
     double todayZeroClock = currentDateStamp - anHour * nowHour - aMinute * nowMinute;
     //时间格式化，为输出做准备
     NSDateFormatter *outputFormat = [NSDateFormatter new];
     [outputFormat setDateFormat:@"M月d日"];
     //进行条件判断，满足不同的条件返回不同的结果
     if (interval < 30 * aMinute) {
          //在30分钟之内
          return @"刚刚";
     } else if (todayZeroClock - dateStamp > 24 * anHour) {
          //已经超过两天以上
          return [outputFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:dateStamp]];
     } else if (todayZeroClock - dateStamp > 0) {
          //已经超过一天（昨天）
          return @"昨天";
     } else if (interval < anHour) {
          //一个小时之内
          return [NSString stringWithFormat:@"%.0f分钟前", (currentDateStamp - dateStamp) / aMinute];
     } else {
          //今天之内
          return [NSString stringWithFormat:@"%.0f小时前", (currentDateStamp - dateStamp) / anHour];
     }
}

+(NSString*)deviceVersion
{
     // 需要#import "sys/utsname.h"
     struct utsname systemInfo;
     uname(&systemInfo);
     NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
     
     //iPhone
     if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
     if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
     if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
     if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
     if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
     if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
     if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
     if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
     if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
     if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
     if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
     if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
     if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
     
     return deviceString;
}

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

/// js  适配问题
+ (instancetype)getJSWithScreentWidth:(CGFloat) width{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"webviewDeal.js" ofType:nil];
    
    NSString *js = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    return [NSString stringWithFormat:@"%@\nautoSizeFit(%@);",js,[NSString stringWithFormat:@"%.2f",width-15]];
}


///对中文转码
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


/// 对比两个字符串是否相同  无视大小写
+ (BOOL)codeCompareWithTheOne:(NSString *)oneStr wihTwo:(NSString*)TwoStr
{
    BOOL result = [oneStr caseInsensitiveCompare:TwoStr] == NSOrderedSame;
    NSLog(@"result:%d",result);
    return result;
}


/// 校验密码信息
+ (NSString*)isOrNoPasswordStyle:(NSString *)passWordName
{
    
    NSString * message;
    if (passWordName.length<6) {
        message=@" 密码不能少于6位，请您重新输入";
    }
    
    else if (passWordName.length>20)
    {
        message=@"密码最大长度为20位，请您重新输入";
    }
    
//    else if ([self fkTheillegalCharacter:passWordName])
//        
//    {
//        message=@"密码由6-20字母加数字或特殊字符组成，不含空格";
//        
//    }
    
//    else if (![self fkPassWordLegal:passWordName])
//    {
//
//        message=@"密码由6-20字母加数字或特殊字符组成，不含空格";
//
//    }
//
    return message;
    
}

/// 特殊字符校验
/// yes  则有
/// NO   则无
+(BOOL)fkTheillegalCharacter:(NSString *)content{
    
    //提示标签不能输入特殊字符
    
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    
    if (![emailTest evaluateWithObject:content]) {
        
        return YES;
        
    }
    
    return NO;
    
}

+(BOOL)fkPassWordLegal:(NSString *)pass{
    BOOL result ;
    // 判断长度大于6位后再接着判断是否同时包含数字和大小写字母
//// .8~20位同时包含数字和大小写字母 (?![0-9A-Z]+$)(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$
    /// 2.8~20位同时包含数字和字母 ^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$
    NSString * regex =@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:pass];
    return result;
}



@end
