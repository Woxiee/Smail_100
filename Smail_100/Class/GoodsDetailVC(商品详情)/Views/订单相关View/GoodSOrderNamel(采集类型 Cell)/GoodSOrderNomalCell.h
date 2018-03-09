//
//  GoodSOrderNomalCell.h
//  MyCityProject
//
//  Created by Faker on 17/5/22.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsOrderModel.h"
typedef void(^DidChageNumberBlock)(NSString *buyNumber);
@interface GoodSOrderNomalCell : UITableViewCell
@property (nonatomic, strong)  GoodsOrderModel *model;
@property (nonatomic, copy) DidChageNumberBlock didChangeNumberBlock;

@property (weak, nonatomic) IBOutlet UIView *changeBgView;

@property (nonatomic, copy) void(^didChangeEmailTypeBlock)(NSInteger type);

@property (nonatomic, strong)  Products *products;

@end
