//
//  KYDateView.h
//  KYDateView
//
//  Created by mac_KY on 17/3/3.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYDateView : UIView


@property(nonatomic,strong)UIDatePicker *datePicker;


+(id)dateViewclickTrue:(void(^)(NSString *dateStr))clickTrueBlcok;

-(void)showDateView;


@end
