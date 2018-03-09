//
//  UIView+KX_ToastView.h
//  KX_Service
//
//  Created by ac on 16/8/3.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KX_ToastView.h"
@interface UIView (KX_ToastView)
@property (nonatomic, weak) KX_ToastView *toastView;
- (void)toastShow:(NSString *)text;
@end
