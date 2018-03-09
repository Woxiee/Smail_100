//
//  OrderMoneyCell.h
//  MyCityProject
//
//  Created by Faker on 17/6/10.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface OrderMoneyCell : UITableViewCell
@property (nonatomic, strong) PayRecordList *model;
@property (nonatomic, strong) PayDetailList *payDetailList;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end
