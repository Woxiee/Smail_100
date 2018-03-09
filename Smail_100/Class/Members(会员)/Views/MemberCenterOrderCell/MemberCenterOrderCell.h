//
//  MemberCenterOrderCell.h
//  MyCityProject
//
//  Created by Faker on 17/5/17.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DidClickOrderItemsBlock)(NSInteger index);
@interface MemberCenterOrderCell : UITableViewCell
@property (nonatomic, copy) DidClickOrderItemsBlock orderItemsBlock;
@end
