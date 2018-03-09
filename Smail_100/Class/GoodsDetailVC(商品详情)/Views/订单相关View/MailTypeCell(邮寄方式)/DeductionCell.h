//
//  DeductionCell.h
//  Smile_100
//
//  Created by ap on 2018/3/7.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsOrderModel.h"

@interface DeductionCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *jifenTf;
@property (weak, nonatomic) IBOutlet UILabel *integralLB;

@property (nonatomic, copy) void(^didChageJFNumberBlock)(NSString *buyNumber);
@property (nonatomic, copy) Userinfo *userInfo;


@end
