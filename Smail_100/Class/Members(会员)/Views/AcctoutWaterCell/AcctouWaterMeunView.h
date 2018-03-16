//
//  AcctouWaterMeunView.h
//  Smail_100
//
//  Created by ap on 2018/3/15.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcctouWaterMeunView : UIView
- (void)show;
@property (nonatomic, copy) void (^didClickCellBlock)(NSString *str, NSString *str1);

@end
