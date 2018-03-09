//
//  ChangeToNewMobile.h
//  ShiShi
//
//  Created by mac_KY on 17/3/14.
//  Copyright © 2017年 fec. All rights reserved.
//绑定手机的最后一步

#import <UIKit/UIKit.h>

@interface ChangeToNewMobile : KX_BaseViewController

@property (nonatomic,strong)NSString *mobile;

@property (nonatomic,strong)NSString *oldCode;
@property (nonatomic,strong)NSString *imageCode;
@property (nonatomic,strong)NSString *md5Str;
@end
