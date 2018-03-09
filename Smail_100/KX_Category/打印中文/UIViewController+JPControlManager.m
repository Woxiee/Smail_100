//
//  UIViewController+JPControlManager.m
//  ShiShi
//
//  Created by mac_KY on 17/4/19.
//  Copyright © 2017年 fec. All rights reserved.
//UINavigationController


#import "UIViewController+JPControlManager.h"

@implementation UIViewController (JPControlManager)

+(void)load
{
  
    //为咯项目的生命周期控制 将自定义两个方法替换原生的方法   KYviewWillAppear－－viewWillAppear  KYviewWillDisappear－－viewWillDisappear
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method KYviewWillAppear = class_getInstanceMethod(self, @selector(KYviewWillAppear:));
        method_exchangeImplementations(viewWillAppear, KYviewWillAppear);
        
        Method viewWillDisappear = class_getInstanceMethod(self, @selector(viewWillDisappear:));
        Method KYViewWillDisappear = class_getInstanceMethod(self, @selector(KYviewWillDisappear:));
        method_exchangeImplementations(viewWillDisappear, KYViewWillDisappear);
 
});

}

//-(void)dealloc
//{
//    if ([self isKindOfClass:[UINavigationController class]] ||[self isKindOfClass:[UICompatibilityInputViewController class]])       return;
//    //self.navigationController.viewControllers
//    LOG(@"/n💣💣💣💣💣页面销毁销毁销毁 KY008 = %@", NSStringFromClass([self class]));
//}

-(void)KYviewWillDisappear:(BOOL)animated
{
    [self KYviewWillDisappear:animated];
    if ([self isKindOfClass:[UINavigationController class]])       return;
    LOG(@"/n🍎🍌🍎🍌🍎🍌🍎🍌页面 消失消失viewWillDisappear KY008 = %@",  NSStringFromClass([self class]));
}
-(void)KYviewWillAppear:(BOOL)animated{
    
    [self KYviewWillAppear:animated];
    if ([self isKindOfClass:[UINavigationController class]])       return;
    LOG(@"/n🍎🍌🍎🍌🍎🍌🍎🍌页面 展示展示viewWillAppear KY008= %@",NSStringFromClass([self class]));
}

-(void)setTitleViewCenter{
    
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                     initWithTitle:@""
                                                     style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:nil];
    }
}

@end
