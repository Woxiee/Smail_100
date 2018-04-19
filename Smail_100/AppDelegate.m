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
@interface AppDelegate ()<WXApiDelegate>
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

    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:KMAINCOLOR];
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
//    8780ece09fd44bcc5146c52aa0c8e2e7
    
    [WXApi registerApp:@"wx500ed907f1edd985" enableMTA:NO];

    
}

//9.0前的方法，为了适配低版本 保留
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
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
    }else
    {
        return [WXApi handleOpenURL:url delegate:self];

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
            if ([resultDic[@"resultStatus"] integerValue] == 9000) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTICEMEPAYMSG object:resultDic];
            }else{
                [self.window toastShow:@"支付操作未完成，请到订单管理继续完成支付！"];

            }
        }];
    }
    else{
         return  [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}



//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
-(void) onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                [self.window toastShow:@"支付成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTICEMEPAYMSG object:nil];
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                [self.window toastShow:@"支付操作未完成，请到订单管理继续完成支付！"];

                break;
            case -2:
                [self.window toastShow:@"支付操作未完成，请到订单管理继续完成支付！"];

                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
    }
}




@end
