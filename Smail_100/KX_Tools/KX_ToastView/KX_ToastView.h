//
//  KX_ToastView.h
//  KX_Service
//
//  Created by ac on 16/8/3.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KX_ToastView : UIView

+(instancetype)toastWithString:(NSString *)textStr;

- (void)finish;

@end
