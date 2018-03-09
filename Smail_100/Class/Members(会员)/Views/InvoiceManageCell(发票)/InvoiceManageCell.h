//
//  InvoiceManageCell.h
//  MyCityProject
//
//  Created by Faker on 17/5/24.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvoiceModel.h"
typedef void(^DidClickInvoiceBtnBlock)(NSInteger index, BOOL state);

@interface InvoiceManageCell : UITableViewCell
@property (nonatomic, copy)  DidClickInvoiceBtnBlock didClickBtnBlock;
@property (nonatomic, copy) InvoiceModel *model;
@end
