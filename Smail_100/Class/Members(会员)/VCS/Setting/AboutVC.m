//
//  AboutVC.m
//  MyCityProject
//
//  Created by mac_KY on 17/5/26.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "AboutVC.h"
#import "KCWebView.h"
#import "HomeVModel.h"
#import "ColumnModel.h"
#import "GoodsScreenVmodel.h"
#import "GoodsScreenListModel.h"
@interface AboutVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView  *webView;
@end

@implementation AboutVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadComment];

   [self setup];
    [self loadNavItem];
}

-(id)initWithWebUrl:(NSString *)url
{
    if (self = [super init]) {
        _webUrl = url;
    }
    return self;
}
#pragma mark - 常数设置
-(void)loadComment
{
    self.title = @"关于我们";
    
   
}



-(void)loadNavItem
{
    WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@"32" forKey:@"siteConfigId"];
    [GoodsScreenVmodel getProbuilListParam:param WithDataList:^(NSArray *dataArray, BOOL success) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (success) {
            if (success) {
                GoodsScreenListModel *model = dataArray[0];
                [_webView loadHTMLString:model.configValue baseURL:[NSURL URLWithString:HEAD__URL]];
            }
        }else{
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }
    }];
}


/// 初始化视图
- (void)setup
{
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    
    [self.view addSubview:self.webView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.view toastShow:@"数据访问失败~"];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
#pragma mark - 点击事件

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIWebView *)webView
{
    if(!_webView){
        _webView = [[UIWebView alloc] init];
        _webView.frame =  CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT -64);
        _webView.delegate = self;
    }
    return _webView;
}



@end
