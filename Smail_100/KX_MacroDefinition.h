//
//  KX_MacroDefinition.h
//  KX_Service
//
//  Created by ac on 16/8/3.
//  Copyright © 2016年 Frank. All rights reserved.
//

#ifndef KX_MacroDefinition_h
#define KX_MacroDefinition_h

//公用日志打印LOG

#if DEBUG

#define LOG(FORMAT, ...) fprintf(stderr,"method : %s \n Line : %d \t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define LOG(...)
#endif

//13144843786    &  18565853465
/// qwe123
/// ----------------------接口所需---------------------------
//默认路径
#if DEBUG
//#define HEAD__URL @"http://192.168.2.110"  //蔡钊名
#define HEAD__URL @"http://39.108.4.18:6803"  //测试服务器
//#define HEAD__URL @"http://open.myjihui.com"  //正式服务器

#else
#define HEAD__URL @"http://open.myjihui.com"  //正式服务器
//#define HEAD__URL @"http://192.168.2.110"  //蔡钊名
//#define HEAD__URL @"http://open.myjihui.cn"  //测试服务器

#endif

/// ----------------------接口业务参数---------------------------
#define request_version  @"1.0.0"
#define request_token  @"888888"
#define request_mn  @"2"
#define request_channelId @"27"
#define request_uid @"123"
#define request_success_code @"000"
#define DEFAULTIMAGE @"10@3x.png"
#define DEFAULTIMAGEW @"moren2@3x.png"
#define DEFAULTIMAGEW2 @"moren@3x.png"

#define KYPageSize @"10"   //用于下啦刷新的控制下拉的属性
#define kMid @"51" //固定
#define kType @"1"

#define NOTICEMESSAGE @"亲～您的网络走丢了,请稍后再试!"

/// 这个是获取系统版本号
//#define KX_APPVERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define KX_APPVERSION @"1.0.0"
#define SystemVersion @"1.0.0"
// 提示过期   ～KYDeprecated("只写不具备读的功能");～


// 过期
#define KYDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead);
/// 获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

///强弱引用处理
#define WEAKSELF  typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

#define  WS(b_self)  typeof(self) __weak b_self = self;
//#define  WSS(s_self)  typeof(b_self) __strong s_self = b_self;
/// NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#define FIRSTLOGIN @"firstLogin"

#pragma mark ---- AppDelegate
//AppDelegate
#define APPDELEGATES (AppDelegate *)[[UIApplication sharedApplication] delegate];



/// ----------------------系统类---------------------------
///
#define IOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >=8.0 ? YES : NO)

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
/// AppStore地址
#define AppStoreAddress @"https://itunes.apple.com/us/app/kuai-xiao/id1160735796?mt=8"

/// 主题
#define DAY @"day"

#define NIGHT @"night"

/// 图片
#define LOADIMAGE(file) [UIImage imageNamed:file]

#define LocalMyString(key) NSLocalizedStringFromTable(key,@"Localizable", key)

///----------------------颜色类---------------------------
///  rgb颜色转换（16进制->10进制）
//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/// 带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
/// 获取RGB颜色
#define RGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)  RGBA(r,g,b,1.0f)

/// 背景色正常
#define BACKGROUND_COLOR  RGB(245, 245, 245)

/// 背景色灰亮
#define BACKGROUNDNOMAL_COLOR  RGB(238, 238, 238)

/// 背景色高亮 （红色）
#define BACKGROUND_COLORHL RGB(208 , 45, 37)


/// 背景色高亮 主色调
#define KMAINCOLOR RGB(226  , 12, 36)

/// 标题字体颜色 浅色黑
#define TITLETEXTLOWCOLOR  RGB(51, 51, 51)

/// 明细字体颜色（灰色）
#define DETAILTEXTCOLOR  RGB(134, 135, 136)

/// 明细字体颜色（浅灰色）
#define DETAILTEXTCOLOR1  RGB(153, 153, 153)


/// 其他色调
#define LINECOLOR RGB(240, 240, 240);

#define TITLE_COLOR RGB(53, 53, 53)
#define SUBTITLE_COLOR RGB(153, 153, 153)

#define MainColor  RGB(226  , 12, 36)
///----------------------字体类--------------------------
/// 标题类型字体大小

#define KY_FONT(a)[UIFont systemFontOfSize:a]

/// 顶部标题
#define TITLEFONT   KY_FONT(17)
/// 内容类型字体大小
#define CONTENFONT KY_FONT(16)

#define Font15 KY_FONT(15)
/// 提示类型字体大小
#define PLACEHOLDERFONT KY_FONT(14)
#define Font14 KY_FONT(14)

#define Font13 KY_FONT(13)

#define Font12 KY_FONT(12)

#define Font11 KY_FONT(11)



/// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375
/// 6 的比例
#define hScale ([UIScreen mainScreen].bounds.size.height) / 667
/// 6P 高度比例
#define KXHScale ([UIScreen mainScreen].bounds.size.height) /736

#define kScrollViewOriginY   (kHeaderViewHeight + kNavigationHeight - kNavigationHeight)
#define kMenuViewHeight      44
#define kHeaderViewHeight    260
#define kNavigationHeight    64

/// 判断字符是否为null
#define KX_NULLString(string) (!([string class] == [NSNull class]) && ((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil)||[string isEqualToString:@"<null>"] || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0))

///----------------------环信所用--------------------------
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"
#define IMUID @"9aa17190-b7a4-11e6-b93a-4de0df41df6f"


///----------------------数据持久化 KEY--------------------------
#define DEPARTMENTKRY @"DEPARTMENTKRY"   /// 写日志 左侧title


#endif /* KX_MacroDefinition_h */
