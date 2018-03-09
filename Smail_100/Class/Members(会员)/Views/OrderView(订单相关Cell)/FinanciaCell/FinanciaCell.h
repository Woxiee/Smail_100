//
//  FinanciaCell.h
//  MyCityProject
//
//  Created by Faker on 17/6/12.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface FinanciaCell : UITableViewCell
@property (nonatomic, strong) OrderModel *model;
@property (nonatomic, copy) void (^DidClickCancelBlock)();
@end
