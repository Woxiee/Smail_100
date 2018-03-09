//
//  GoodsCategoryCollectionHeader.h
//  ShiShi
//
//  Created by mac_KY on 17/3/8.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsClassModel.h"
@interface GoodsCategoryCollectionHeader : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (nonatomic, strong) Values *model;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void(^didClickHeadViewBtnBlock)(NSInteger index);
@property (weak, nonatomic) IBOutlet UIImageView *markImageView;

@end
