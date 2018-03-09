//
//  KX_BaseTabbarController.m
//  KX_Service
//
//  Created by mac on 16/8/8.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import "KX_BaseTabbarController.h"
#import "KX_Version.h"
#import "SuccessView.h"
#import "HomeMainVC.h"
#import "GoodsClassVC.h"
#import "MemberCenterMainVC.h"
#import "LoginVModel.h"
#import "OfflineVC.h"
#import "OnlineVC.h"

@interface KX_BaseTabbarController ()
@property(nonatomic,strong)NSMutableArray *classArr;
@property (nonatomic, strong) NSString *strakUrl;
@property (nonatomic, strong) NSString *isVersion;
@end

@implementation KX_BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfiguration];
}

/// 配置基础设置
- (void)setConfiguration
{
    _classArr = [[NSMutableArray alloc] init];
    //商城首页
    [self addSubViewControllerWithVC:@"HomeMainVC" norImage:@"shouye13@3x.png" selImage:@"shouye10@3x.png" title:@"首页"];
    //线上商城
    [self addSubViewControllerWithVC:@"OnlineVC" norImage:@"muban11@3x.png" selImage:@"muban10@3x.png" title:@"线上商城"];
    //线下商城
    [self addSubViewControllerWithVC:@"OfflineVC" norImage:@"muban12@3x.png" selImage:@"muban13@3x.png" title:@"线下商圈"];
    //购物车
    [self addSubViewControllerWithVC:@"ShoppingCarVC" norImage:@"muban14@3x.png" selImage:@"muban15@3x.png" title:@"购物车"];
    //会员中心
    [self addSubViewControllerWithVC:@"MemberCenterMainVC" norImage:@"muban16@3x.png" selImage:@"muban17@3x.png" title:@"账户"];
    self.selectedIndex = 0;//默认选择首页
//    if (![KX_UserInfo sharedKX_UserInfo].addressList) {
        [self getAllAddressList];
//    }
    /// 检查版本更新接口
    [self cheakVersonNeedUpdateRequest];
}



-(void)addSubViewControllerWithVC:(NSString *)vc norImage:(NSString *)norImage selImage:(NSString *) selImage title:(NSString *) title
{
    UIViewController *ddd = [[NSClassFromString(vc) alloc]init];
    UINavigationController *navController =  [[UINavigationController alloc]initWithRootViewController:ddd];
    [_classArr addObject:ddd];
    navController.tabBarItem.image = [[UIImage imageNamed:norImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navController.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    navController.tabBarItem.title = title;
    [navController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:DETAILTEXTCOLOR,NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    [navController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KMAINCOLOR,NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateSelected];

    [self addChildViewController:navController];
   
}



///检查请求更新
- (void)cheakVersonNeedUpdateRequest
{
    WEAKSELF
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:@"30",@"siteConfigId", nil];
    [BaseHttpRequest postWithUrl:@"/o/o_118" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if (error) {
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }else{
            NSDictionary *dataDic = [result valueForKey:@"data"];
            NSInteger state = [dataDic[@"state"] integerValue];
            if (state == 0) {
                NSString *accoutStr =  [[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"];
                if (![accoutStr isEqualToString:@"15200000000"]) {
                    if ([result[@"code"]integerValue ] == 000) {
                        self.isVersion = @"2";
                        
                        self.isVersion  = dataDic[@"obj"][@"configValue"];
                        if ([self.isVersion isEqualToString:@"0"]) {
                            //处理新版本功能
                            [self handelTheNewVerSion];
                        }
                
                    }
                    
                }
            }
        }
    }];
}

- (void)getAllAddressList
{
    [LoginVModel getUserAddressParam:nil SBlock:^(BOOL isSuccess ,NSArray *listArr) {
        if (isSuccess) {
            KX_UserInfo *userinfo = [KX_UserInfo sharedKX_UserInfo];
            userinfo.addressList = listArr;
            [[KX_UserInfo sharedKX_UserInfo] saveUserInfoToSanbox];
        }
    }];
}

#pragma mark -
#pragma mark - 处理新版本功能
-(void)handelTheNewVerSion
{
    WEAKSELF   //在登录的时候 isVersion ＝＝0或者空  那么久代表永不会提示升级
//    if ([self.isVersion isEqualToString:@"1.0"] || self.isVersion == nil)  return;
    [KX_Version kx_isNewVersionSuccess:^(NewVersionType newVersion, NSString *versionStr,NSString *strakUrl, NSString *releaseNotes) {
        if (newVersion == NewVersionTypeNeedUp) {
            weakSelf.strakUrl = strakUrl;
            NSString *versionTitle = @"有可用的新版本可更新";
            STRONGSELF
            //            NSString *cancle = [self.isVersion isEqualToString:@"1"]?@"忽略此版本":nil;
            NSString *cancle = @"忽略此版本";
            UIAlertView *aletView = [[UIAlertView alloc]initWithTitle:versionTitle message:releaseNotes delegate:strongSelf cancelButtonTitle:cancle
                                                    otherButtonTitles:@"更新", nil];
            [aletView show];
        }
        
        
    }];
    
}



#pragma mark -
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    NSLog(@"%ld",(long)buttonIndex);
    if(buttonIndex == 1 ){
        // 开始去更新
        NSURL * url = [NSURL URLWithString:self.strakUrl];//itunesURL = trackViewUrl的内容
        [[UIApplication sharedApplication] openURL:url];
    }
    
    
    
}

@end
