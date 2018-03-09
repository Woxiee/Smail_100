//
//  GoodsCollectTimeCell.h
//  MyCityProject
//
//  Created by Faker on 17/5/16.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodSDetailModel.h"

@interface GoodsCollectTimeCell : UITableViewCell
@property (nonatomic, strong) GroupBuyResult *model;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
