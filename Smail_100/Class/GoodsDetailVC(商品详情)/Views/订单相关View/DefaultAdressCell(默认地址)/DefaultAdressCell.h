//
//  DefaultAdressCell.h
//  ShiShi
//
//  Created by ac on 16/3/27.
//  Copyright © 2016年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsOrderAddressModel.h"
#import "OrderDetailModel.h"
#import "GoodsOrderModel.h"
@interface DefaultAdressCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *GoodCountLb;
@property (weak, nonatomic) IBOutlet UIImageView *markView;

@property (nonatomic, strong) GoodsOrderAddressModel  *model;
@property (nonatomic, strong) OrderDetailModel  *orderDetailModel;
@property (nonatomic, strong) Address  *addressModel;


@end
