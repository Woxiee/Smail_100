//
//  CardManageVC.h
//  Smail_100
//
//  Created by ap on 2018/4/12.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardModel.h"

@interface CardManageVC : KX_BaseTableViewController
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, copy) void(^didClickCellBlock)(CardModel *model);
@end
