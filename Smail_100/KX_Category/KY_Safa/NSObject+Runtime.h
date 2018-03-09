//
//  NSObject+Runtime.h
//  JCatchCrash
//
//  Created by mac_KY on 2017/7/12.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

void showAlertMasse(NSString *message);

+ (void)addMethod:(SEL)methodSel methodImp:(SEL)methodImp;

+ (void)swapMethod:(SEL)originMethod currentMethod:(SEL)currentMethod;


+ (void)swapClassMethod:(SEL)originMethod currentMethod:(SEL)currentMethod;




@end
