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

@interface KX_BaseTabbarController ()<CLLocationManagerDelegate>
@property(nonatomic,strong)NSMutableArray *classArr;
@property (nonatomic, strong) NSString *strakUrl;
@property (nonatomic, strong) NSString *isVersion;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation KX_BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfiguration];
    [self startLocation];
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
//    [self cheakVersonNeedUpdateRequest];
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


//开始定位
- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        //        CLog(@"--------开始定位");
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        //控制定位精度,越高耗电量越
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        if ([[[UIDevice currentDevice]systemVersion] doubleValue] >8.0)
        {
            // 设置定位权限仅iOS8以上有意义,而且iOS8以上必须添加此行代码
            [self.locationManager requestAlwaysAuthorization];
        
            // [self.locationManager requestAlwaysAuthorization];//前后台同时定位
        }
        [self.locationManager requestWhenInUseAuthorization];
        if (@available(iOS 9.0, *)) {
            self.locationManager.allowsBackgroundLocationUpdates =YES;
        } else {
            // Fallback on earlier versions
        }

        [self.locationManager startUpdatingLocation];
    }
}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}


//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            NSLog(@"city = %@", city);
            
//            [self httpGetWeather:city];
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}


@end
