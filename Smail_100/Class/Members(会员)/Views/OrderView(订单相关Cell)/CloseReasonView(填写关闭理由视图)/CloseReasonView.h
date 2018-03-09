//
//  CloseReasonView.h
//  MyCityProject
//
//  Created by Faker on 17/6/7.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloseReasonView : UIView
@property (nonatomic, copy) void(^didClickReasonBlock)(NSString *str);
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title andTitle1:(NSString *)title1;

- (void)show;

@end
