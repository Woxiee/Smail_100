//
//  OrderSectionFooterView.h
//  Smail_100
//
//  Created by ap on 2018/4/10.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsOrderModel.h"

@interface OrderSectionFooterView : UIView <UITextFieldDelegate>
@property (nonatomic, strong)  GoodsOrderModel *model;
@property (nonatomic, copy) void(^didChangeEmailTypeBlock)(NSInteger type);
@property (nonatomic, strong) UILabel *titleLB3; 
@end
