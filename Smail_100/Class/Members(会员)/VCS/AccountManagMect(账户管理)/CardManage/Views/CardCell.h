//
//  CardCell.h
//  Smail_100
//
//  Created by ap on 2018/4/12.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardModel.h"
@interface CardCell : UITableViewCell

@property (nonatomic, strong) CardModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void(^didClickItemBlcok)(CardModel *model, NSInteger index);
@end
