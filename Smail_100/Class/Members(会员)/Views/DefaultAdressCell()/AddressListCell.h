//
//  AddressListCell.h
//  MyCityProject
//
//  Created by Faker on 17/5/23.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsOrderAddressModel.h"
typedef void(^DidClickAddressBtnBlock)(NSInteger index, BOOL state);
@interface AddressListCell : UITableViewCell
@property (nonatomic, strong)  GoodsOrderAddressModel *model;
@property (nonatomic, copy)  DidClickAddressBtnBlock didClickBtnBlock;

@end
