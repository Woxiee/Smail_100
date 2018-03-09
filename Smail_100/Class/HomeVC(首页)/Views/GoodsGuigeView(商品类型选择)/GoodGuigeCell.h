//
//  GoodGuigeCell.h
//  ShiShi
//
//  Created by Faker on 17/3/9.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsScreenmodel.h"
#import "GoodSDetailModel.h"
@class AttrValue;
@interface GoodGuigeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) Values *model;
@property (nonatomic, strong) AttrValue *attrModel;


@end
