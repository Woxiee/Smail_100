//
//  KCWebView.m
//  KCJSTOOCDemo
//
//  Created by mac_JP on 17/1/6.
//  Copyright © 2017年 mac_JP. All rights reserved.
//

#import "KCWebView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "KCWebProgress.h"
@interface KCWebView ()<UIWebViewDelegate>

@property(nonatomic,copy)KCWebViewStateBlock webStateBlock;
@property (strong, nonatomic) JSContext *context;
@property(nonatomic,weak)KCWebProgress *webProgress;
@end

@implementation KCWebView

-(id)initWithFrame:(CGRect)frame loadUrl:(NSString *)urlString StateBlock:(KCWebViewStateBlock)KCWebViewStateBlock{
    if (self = [super initWithFrame:frame]) {
      
         self.webStateBlock = KCWebViewStateBlock;
        [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
        self.delegate = self;
    }
    return self;
}

#pragma mark -
#pragma mark - 设置进度条的颜色
/**
 设置进度条的颜色
 
 @param viewController 在哪一个controller上面设置
 @param color 进度条的颜色
 */
-(void)setProgressByController:(UIViewController *)viewController color:(UIColor *)color
{
    KCWebProgress *webProgress = [[KCWebProgress alloc]initWithColor:color];
     webProgress.frame = CGRectMake(0, 42, SCREEN_WIDTH, 2);
    [viewController.navigationController.navigationBar.layer addSublayer:webProgress];
    self.webProgress = webProgress;
    
}
#pragma mark -
#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   
    //解析js的传输数据
    // URL: mc://mcvc?class=KCGoodCategoryVC&showtype=push&dataString=MCstring&jsid=888888
    NSString *jsString = [NSString stringWithFormat:@"%@",request];
    if ([jsString containsString:@"class"]) {
        //只要包含class那么不能load该url
        if ([jsString containsString:@"?"]) {
            NSArray *jsArr = [jsString componentsSeparatedByString:@"?"];
                //过滤 ？
            NSString *lastString = [jsArr lastObject];
            if ([lastString containsString:@"&"]) {
                NSArray *deArr = [lastString componentsSeparatedByString:@"&"];
                    //过滤 &
                NSString *classString = nil;
                NSString *transmitString =nil;
                for (NSString *needString in deArr) {
                    //的到最终的数据
                    if ([needString containsString:@"class="]) {
                       classString = [needString stringByReplacingOccurrencesOfString:@"class=" withString:@""];
                    }
                    
                    if ([needString containsString:@"jsid="]) {
                      NSString *jsid   = [needString stringByReplacingOccurrencesOfString:@"jsid=" withString:@""];
                        //过滤 " " "}“	__NSCFString *	@"jsid=888888 }"
                        if ([jsid containsString:@" }"]) {
                              transmitString = [jsid stringByReplacingOccurrencesOfString:@" }" withString:@""];
                        }else
                        {
                            transmitString = jsid;
                        }
                      
                    }
                }
         
                //通过代理传输数据
                if (_kcDelegate &&[_kcDelegate respondsToSelector:@selector(jsActionToClass:transmit:)]) {
                    [_kcDelegate jsActionToClass:classString transmit:transmitString];
                }
            }
        }
        
        return NO;
    }
    if (_webStateBlock) {
        _webStateBlock(KCWebViewStateTypeStartLoad);
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{

    [self.webProgress startLoad];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (_webStateBlock) {
        _webStateBlock(KCWebViewStateTypeLoadSuccess);
    }
    [self.webProgress finishedLoadWithError:nil];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (_webStateBlock) {
        _webStateBlock(KCWebViewStateTypeLoadFail);
    }
      [self.webProgress finishedLoadWithError:error];
}



-(void)dealloc{
    [_webProgress closeTimer];
    [_webProgress removeFromSuperlayer];
    _webProgress = nil;
    
}
@end
