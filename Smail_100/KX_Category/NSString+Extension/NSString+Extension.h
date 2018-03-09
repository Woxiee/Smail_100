//
//  NSString+Extension.h
//
//  KX_Service
//
//  Created by Frank on 16/9/6.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)
/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
- (NSString *) throwExceptionString;

//不区分大小写是否包含某个字符
- (BOOL)containsStringWith:(NSString *)str;

//判断某个字符串包含某些特殊字符开头的，不区分大小写
- (BOOL) hasStringWithPrefix:(NSString *)aString;

///处理h5类型字符串
+(NSString *)filterHTML:(NSString *)str;

/// 处理<br> 字段
+(NSString *)replaceAbnormalStr:(NSString *)str;

/**
 判断是否是空字符 包含@“”
 
 @return 是返回YES
 */
- (BOOL)NullString;



/**
 *  返回格式化后的时间
 *
 *  @param sendTime 时间戳
 */
+ (NSString *)timeStr:(NSString *)sendTime;


/**
 * @brief inputStr 传递输入的 str
 *
 * @return 返回BOOL yes 表示是数字
 */
+ (BOOL)cheakInputStrIsNumber:(NSString *)inputStr;

/**
 * @brief inputStr 传递输入的 str
 *
 * @return 返回BOOL yes 表示是空格
 */
+ (BOOL)cheakInputStrIsBlankSpace:(NSString *)inputStr;

/*!
 * @brief 计算字体大小
 * @param font 字体大小
 * @param value 内容
 * @param size 限制宽高
 *
 * @return 返回 float
 */
+ (CGSize)heightForString:(NSString *)value  fontSize:(UIFont *)font WithSize:(CGSize)size;

/*!
 * @startDay 表示开始时间
 * @endDay   表示结束时间
 * @return   YES 表示过去
 */
+(BOOL)compareOneDay:(NSString *)startDay withAnotherDay:(NSString *)endDay;


//获取当地时间
+ (NSString *)getCurrentTime;


/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param dic JSON格式的字符串
 * @return 返回字典
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;


/*!
 * @brief 转换特殊字体
 * @param str 要转换的字体
 * @param range 要转换的字体长度
 * @param color 要转换的字体颜色
 * @param font 要转换的字体大小
 * @return 返回 NSAttributedString类型字体
 */
- (NSAttributedString *)creatAttributedString:(NSString *)str withMakeRange:(NSRange)range withColor:(UIColor *)color withFont:(UIFont *)font;

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;

//判断给出日期是周几
+ (NSString*)weekDayStr:(NSString *)format;

//时间戳转化成时间
+ (NSString *)stringWithTimeStamp:(NSNumber *)timeStamp;

//获取设备信息
+(NSString*)deviceVersion;

#pragma mark- md5 32位 加密
+ (NSString *)md5HexDigest:(NSString*)input;


/// js  适配问题
+ (instancetype)getJSWithScreentWidth:(CGFloat) width;

/// 中文转码
+ (NSString *)chinaToUnicode:(NSString *)str;



/// 对比两个字符串是否相同  无视大小写
+ (BOOL)codeCompareWithTheOne:(NSString *)oneStr wihTwo:(NSString*)TwoStr;

/// 校验密码信息
+ (NSString*)isOrNoPasswordStyle:(NSString *)passWordName;


/// 特殊字符校验
/// yes  则有
/// NO   则无
+(BOOL)fkTheillegalCharacter:(NSString *)content;
@end
