//
//  ChangeSexVC.h
//  ShiShi
//
//  Created by mac_KY on 17/3/3.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeSexVC : KX_BaseViewController

@property(nonatomic,strong)NSString *sex;

@property(nonatomic,copy)void (^selectDex)(NSString * sex);//1 = nan 2 = nv  3 = baomi

@end
