//
//  UIWebView+ContenHight.m
//  MyCityProject
//
//  Created by Faker on 2017/9/22.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "UIWebView+ContenHight.h"

@implementation UIWebView (ContenHight)
/** 判断webView是否完全加载完数据 */
- (BOOL)isFinishLoading{
    NSString *readyState = [self stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete && !self.isLoading) {
        return YES;
    }else{
        return NO;
    }
}

@end
