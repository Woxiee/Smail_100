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


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
