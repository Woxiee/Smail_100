//
//  GoodsAuctionXYVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/27.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsAuctionXYVC.h"

@interface GoodsAuctionXYVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView     *webView;

@end

@implementation GoodsAuctionXYVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfiguration];
    [self setup];
    [self getGoodsDetailInfoRequest];
}

/// 配置基础设置
- (void)setConfiguration
{
//    if ([_agreementType isEqualToString:@"2"]) {
//        self.title = @"拍卖服务协议";
//    }
//    else if ([_agreementType isEqualToString:@"3"]) {
//        self.title = @"评估价协议";
//    }
//    else if ([_agreementType isEqualToString:@"4"]) {
//        self.title = @"保证金须知";
//    }
//
//    else{
//        self.title = @"机汇网用户注册协议";
//    }
}


#pragma mark - request
/// 拍卖协议
- (void)getGoodsDetailInfoRequest
{
    /// 1 注册协议|| ///2拍卖协议  ///3估价协议 ///4保证金须知
    WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    if ([_agreementType isEqualToString:@"1"]) {
        [param setObject:@"28" forKey:@"siteConfigId"];
    }
      else if ([_agreementType isEqualToString:@"2"]) {
        [param setObject:@"23" forKey:@"siteConfigId"];
    }
    
    else if ([_agreementType isEqualToString:@"3"]) {
        [param setObject:@"24" forKey:@"siteConfigId"];
    }

   else if ([_agreementType isEqualToString:@"4"]) {
       [param setObject:@"39" forKey:@"siteConfigId"];
   }
   
    [BaseHttpRequest postWithUrl:@"/o/o_118" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"拍卖协议 == %@",result);
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        //        NSString *msg = [result valueForKey:@"msg"];
        NSDictionary *dataDic = [result valueForKey:@"data"][@"obj"];
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            if (state == 0) {
                [weakSelf.webView loadHTMLString:result[@"data"][@"obj"][@"configValue"] baseURL:[NSURL URLWithString:HEAD__URL]];
            }
        }

    }];

    
}

/// 初始化视图
- (void)setup
{
    _webView = [[UIWebView alloc] init];
    _webView.frame =  CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT  - 64);
    _webView.delegate = self;
    [self.view addSubview:self.webView];
    NSURL* url = [NSURL URLWithString:_clickUrl?_clickUrl:@"http://www.baidu.com"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_webView loadRequest:request];//加载
   

}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.view toastShow:@"数据访问失败~"];
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}


/// 同意按钮
- (void)didClickSureBtn:(id)sender {
    if ([_agreementType isEqualToString:@"2"] ) {
       
    /// 评估价
    }else if ([_agreementType isEqualToString:@"3"] ) {
        if (_didClickComplteBlock) {
            _didClickComplteBlock();
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
 }


- (UIWebView *)webView
{
    if(!_webView){
        
          }
    return _webView;
}


@end
