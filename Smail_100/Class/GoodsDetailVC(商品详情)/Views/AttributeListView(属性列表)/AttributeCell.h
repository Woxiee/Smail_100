//
//  AttributeCell.h
//  MyCityProject
//
//  Created by Faker on 17/5/15.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "GoodSDetailModel.h"
@class Values;
@interface AttributeCell : UITableViewCell
@property (nonatomic, strong) ExtAttrbuteShow *model;
@property (nonatomic, strong) NSDictionary      *dataDic;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (nonatomic, strong) Dizhi  *dizhi;

@end
