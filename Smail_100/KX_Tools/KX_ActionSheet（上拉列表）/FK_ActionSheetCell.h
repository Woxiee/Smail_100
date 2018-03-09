//
//  FK_ActionSheetCell.h
//  KX_SheetView
//
//  Created by Faker on 16/12/1.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface FK_ActionSheetCell : UITableViewCell

/**
 *  内容.
 */
@property (nonatomic, weak) UILabel *titleLabel;

/**
 *  Line.
 */
@property (nonatomic, weak) UIView *lineView;
@end
