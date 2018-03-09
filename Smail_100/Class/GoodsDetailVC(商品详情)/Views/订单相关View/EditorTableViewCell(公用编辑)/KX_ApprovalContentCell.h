//
//  KX_ApprovalContentCell.h
//  KX_Service
//
//  Created by kechao wu on 16/9/6.
//  Copyright © 2016年 Faker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KX_TextView.h"
@interface KX_ApprovalContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet KX_TextView *contenTextView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
