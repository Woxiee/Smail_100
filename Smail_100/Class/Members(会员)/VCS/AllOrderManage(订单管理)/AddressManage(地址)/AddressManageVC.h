//
//  AddressManageVC.h
//  MyCityProject
//
//  Created by Faker on 17/5/22.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodSDetailModel.h"
#import "GoodsOrderAddressModel.h"
@interface AddressManageVC : KX_BaseViewController
@property (nonatomic, strong) GoodSDetailModel *model;
@property (nonatomic, strong) NSString  *isValue;
@property (nonatomic, copy) void(^didClickAddressCellBlock)(GoodsOrderAddressModel* model);
@end
