//
//  AllSet.m
//  Smail_100
//
//  Created by ap on 2018/3/16.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AllSet.h"
#import "SDImageCache.h"
#import "SDImageCacheConfig.h"

@interface AllSet ()
@property (weak, nonatomic) IBOutlet UILabel *versionLB;

@property (weak, nonatomic) IBOutlet UIView *checkView;

@property (weak, nonatomic) IBOutlet UIView *notictionView;
@property (weak, nonatomic) IBOutlet UISwitch *notictionSwift;
@property (weak, nonatomic) IBOutlet UIButton *cleanBtn;
@property (weak, nonatomic) IBOutlet UIView *aboutMeVeiw;
@property (weak, nonatomic) IBOutlet UIButton *outBtn;

@end

@implementation AllSet

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}


- (void)setup
{
    self.title = @"系统设置";
    _outBtn.backgroundColor = BACKGROUND_COLORHL;
    [_outBtn addTarget:self action:@selector(didClickOutAction) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    // 当前应用版本号码   int类型
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    _versionLB.text = [NSString stringWithFormat:@"版本号:%@",appCurVersion];
    _versionLB.textColor = DETAILTEXTCOLOR;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    float size = [self folderSizeAtPath:cachesDir];
    
    
    [_cleanBtn setTitle:[NSString stringWithFormat:@"%.2fM",size] forState:UIControlStateNormal];
    
    [_cleanBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
    
}

- (IBAction)didRemoveaction:(id)sender {
    SuccessView *successV = [[SuccessView alloc] initWithTrueCancleTitle:@"是否清楚缓存?" cancelTitle:@"取消" clickDex:^(NSInteger clickDex) {
        if (clickDex == 1) {
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [_cleanBtn setTitle:@"0.0M" forState:UIControlStateNormal];

            }];
            
        }}];
    [successV showSuccess];
    
   

}

- (IBAction)didClickOutAction:(id)sender {
}

- (void)didClickOutAction
{
//    //清除本地数据 返回登陆页面
    SuccessView *successV = [[SuccessView alloc] initWithTrueCancleTitle:@"是否需要退出登录?" cancelTitle:@"取消" clickDex:^(NSInteger clickDex) {
        if (clickDex == 1) {
            [[KX_UserInfo sharedKX_UserInfo] cleanUserInfoToSanbox];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }}];
    [successV showSuccess];

    
}

-(float)folderSizeAtPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path]) {
//        NSArray *childerFiles=[fileManager subpathsAtPath:path];
//        for (NSString *fileName in childerFiles) {
//            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
//            folderSize += [self fileSizeAtPath:absolutePath];
//        }
        // SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}


@end
