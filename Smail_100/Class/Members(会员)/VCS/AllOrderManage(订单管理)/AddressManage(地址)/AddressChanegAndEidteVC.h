//
//  AddressChanegAndEidteVC.h
//  MyCityProject
//
//  Created by Faker on 17/5/23.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsOrderAddressModel.h"

typedef NS_ENUM(NSInteger, BChooseType) {
    BAddType,
    BEdiType
};
@interface AddressChanegAndEidteVC : KX_BaseViewController
@property(nonatomic,strong) GoodsOrderAddressModel * model;
@property (nonatomic, strong) NSArray  *addressArr;
@property(nonatomic,assign) BChooseType bChooseType;

@end
