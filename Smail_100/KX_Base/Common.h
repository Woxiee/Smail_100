//
//  Comment.h
//  zxmall
//
//  Created by mac on 15/6/16.
//  Copyright (c) 2015年 golvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>


typedef NS_ENUM(NSUInteger,OPENURLType) {
    OPENURLTypeWifi = 0,
    OPENURLTypSettings,
};

typedef void(^CallBackFunction)(NSDictionary *resultDic);

@interface Common : NSObject

//md5加密
+ (NSString *)md5HexDigest:(NSString*)input;

//转json字符串
+(NSString*)DataTOjsonString:(NSDictionary*)params;

//获取当前的网络状态
+(NSInteger)getCurrageNetWorkStatus;

 

//中文转拼音
+(NSString *)transformToPinyin:(NSString*)chinese;

//将手机号码 代换 ＊＊＊＊。。
+(NSString *)changeMobileHide:(NSString *)mobile;

//判读邮箱
+ (BOOL)isValidateEmail:(NSString *)Email;

+ (BOOL) isValidatePostCode:(NSString *) postCode;

//判断电话号码
+ (BOOL) isValidateMobile:(NSString *)mobileNum;
+ (BOOL) isValidatePwd:(NSString *)pwd;
+(BOOL)  isNullString:(NSString *)string;
/*  判断用户输入的密码是否符合规范，符合规范的密码要求：
 1. 长度大于8位
 2. 密码中必须同时包含数字和字母
 */
+(BOOL)judgePassWordLegal:(NSString *)pass;

//身份证号
+ (BOOL)isValidateIdentityCard: (NSString *)identityCard;
+ (BOOL)isPureFloat:(NSString*)string;
+ (BOOL)isPureInt:(NSString*)string;
+ (NSString *)chinaToUnicode:(NSString *)str;


/**
 *  根据坐标获取与当前位置的距离
 *
 *  @param location 位置
 *
 *  @return 
 */
//+ (NSString *)getDistanceBy:(CLLocation *)location;

//字符串去掉空格
+(NSString *)stringWithOutSpace:(NSString *)str;

/**
 *  微信支付
 */
+ (void)weChatPay:(NSString *) orderString;
//获取视图的上层的视图控制器
+ (UIViewController*)superViewController:(UIView *)view;
//data转字符串
+ (NSString *) dataToJSON:(id) param;
//颜色值转换
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

//颜色转图片
+ (UIImage *)imageWithSize:(CGSize )size color:(UIColor *)color;
//登录
+ (void)presentToLoginView:(UIViewController *)ctr;

//验证银行卡账号
+(BOOL)validateBankAccount:(NSString *)bankAccount;

//支付宝支付
+(void)aliPayMethod:(NSString *)orderStr;

/**支付宝调用*/
+ (void)alipay:(NSString*)orderStr callBack:(CallBackFunction)callBack;

//C端云信登录
+(void)IMLogin;

//B端云信登录
+(void)BIMLogin;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//保留两位小数
+(NSString *)stringToTwoPoint:(NSString *)stringIn;

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size;



//######控制跳转的＃＃＃＃＃
+(void)popToRootControllerIndex:(NSInteger )index viewController:(UIViewController*)viewController;


+(void)openURL:(OPENURLType)type;
@end
