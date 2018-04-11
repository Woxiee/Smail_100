//
//  OrderSectionFootView.h
//  Smail_100
//
//  Created by ap on 2018/3/14.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
@interface OrderSectionFootView : UIView
@property (nonatomic, strong) OrderModel *model;
@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, copy) void(^didClickItemBlock)(NSString *title);


@end
