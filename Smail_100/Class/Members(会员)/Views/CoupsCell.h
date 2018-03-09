//
//  CoupsCell.h
//  MyCityProject
//
//  Created by Macx on 2018/1/31.
//  Copyright © 2018年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoupsCell : UITableViewCell
/**
 *  内容.
 */
@property (nonatomic, weak) UILabel *titleLabel;

/**
 *  Line.
 */
@property (nonatomic, weak) UIView *lineView;

/**
 *  标记.
 */
@property (nonatomic, weak)  UIImageView *cheakMarkView;
@end
