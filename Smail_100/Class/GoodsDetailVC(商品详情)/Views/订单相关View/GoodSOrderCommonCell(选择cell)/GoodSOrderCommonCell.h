//
//  GoodSOrderCommonCell.h
//  MyCityProject
//
//  Created by Faker on 17/5/22.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodSOrderCommonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *detailLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightWihtConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *markImageView;

@end
