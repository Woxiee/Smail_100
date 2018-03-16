//
//  GoodsCommonCell.h
//  ShiShi
//
//  Created by Faker on 17/3/22.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsOrderModel.h"
@interface GoodsCommonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodSCommentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *markImgeView;
@property (nonatomic, strong) GoodsOrderModel *orderModel;


@end
