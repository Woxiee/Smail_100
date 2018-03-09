//
//  KYCodeBtn.h
//  MyCityProject
//
//  Created by Faker on 17/7/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYCodeBtn : UIButton
//// 定时结束回调
-(void)timeRun:(void(^)(int count))timeBlock;
-(void)stopTime;

@end
