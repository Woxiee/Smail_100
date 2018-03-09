//
//  UIView+KX_ToastView.m
//  KX_Service
//
//  Created by ac on 16/8/3.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import "UIView+KX_ToastView.h"
#import <objc/runtime.h>

#define seconds 2.5

static const void *toastViewKey = &toastViewKey;

@implementation UIView (KX_ToastView)

/**
 *利用runtime 为类目添加属性
 */
- (KX_ToastView *)toastView
{
    id toastViewObject = objc_getAssociatedObject(self, &toastViewKey);
    return toastViewObject;
}

- (void)setToastView:(KX_ToastView *)toastView
{
    objc_setAssociatedObject(self, &toastViewKey,
                             toastView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//----end

- (void)toastShow:(NSString *)text;
{
    if (text == nil || text.length ==0) {
        return;
    }
    
    doInDispatchSerialWith(^{
        doInMain(^{
            [self toastWithString:text];
        });
        sleep(seconds);
        doInMain(^{
            [self.toastView finish];
        });
    });
}

- (KX_ToastView *) toastWithString:(NSString *)string
{
    KX_ToastView *toastView = [KX_ToastView toastWithString:string];
    self.toastView = toastView;
    return toastView;
    
}

@end
