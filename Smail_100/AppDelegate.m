//
//  AppDelegate.m
//  Smile_100
//
//  Created by Faker on 2018/2/3.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "AppDelegate.h"
#import "KX_BaseTabbarController.h"
#import "KX_BaseNavController.h"

@interface AppDelegate ()
@property (nonatomic, strong) KX_BaseTabbarController *tabbarVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = BACKGROUND_COLOR;
    [[KX_UserInfo sharedKX_UserInfo] loadUserInfoFromSanbox];
    KX_BaseTabbarController *tabbarVC = [[KX_BaseTabbarController alloc] init];
    self.window.rootViewController = tabbarVC;
    self.tabbarVC = tabbarVC;
    [self setConfiguration];
    [_window makeKeyAndVisible];
    return YES;
}

/// 配置基础设置
- (void)setConfiguration
{
   
    //iqkeyboard
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;//这个是点击空白区域键盘收缩的开关
    manager.enableAutoToolbar = YES;//这个是它自带键盘工具条开关
    
    
//    UIColor * colors = [UIColor whiteColor];
//    NSDictionary * dict= [NSDictionary dictionaryWithObjectsAndKeys:colors,NSForegroundColorAttributeName,nil];
//    [UINavigationBar appearance].titleTextAttributes  = dict;
//    [UINavigationBar appearance].tintColor = colors;
//
//    [[UINavigationBar appearance]  setBackgroundImage:[UIImage
//                                                       imageNamed:@"Navigation_BackgroundImage"] forBarMetrics:UIBarMetricsDefault];
//    [UINavigationBar appearance].barStyle = UIBarStyleBlackOpaque;//设置不要透明 图片没有不要透明纸
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:KMAINCOLOR];
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [self.window toastShow:@"支付成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTICEMEPAYMSG object:resultDic];
        }];
    }
    return YES;
}

@end
