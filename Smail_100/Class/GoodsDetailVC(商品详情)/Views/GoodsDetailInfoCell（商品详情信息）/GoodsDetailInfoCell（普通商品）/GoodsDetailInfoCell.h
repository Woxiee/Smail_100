//
//  GoodsDetailInfoCell.h
//  ShiShi
//
//  Created by Faker on 17/3/8.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemContentList.h"
typedef void(^DidClickCollectBlock)(NSString *collectStr,NSInteger index);
@interface GoodsDetailInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@property (nonatomic, copy) DidClickCollectBlock  clickCollectBlcok;
@property (nonatomic, strong) ItemContentList *model;
@end
