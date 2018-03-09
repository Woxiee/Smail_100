//
//  GoodsDetailCommonCell.h
//  ShiShi
//
//  Created by Faker on 17/3/10.
//  Copyright © 2017年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
typedef void(^DidClickMroreBtnBlock)();
@interface GoodsDetailCommonCell : UITableViewCell
@property (nonatomic, strong) CommentModel *model;
@property (nonatomic, copy) DidClickMroreBtnBlock didClickMoreBtnBlock;


@end
