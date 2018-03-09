//
//  InvoiceCustomCell.h
//  MyCityProject
//
//  Created by Faker on 17/5/24.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvoiceModel.h"

typedef void(^DidClickInvoiceCustomBtnBlock)(NSInteger index, BOOL state);

@interface InvoiceCustomCell : UITableViewCell
@property (nonatomic, copy)  DidClickInvoiceCustomBtnBlock didClickBtnBlock;
@property (nonatomic, copy) InvoiceModel *model;
@end
