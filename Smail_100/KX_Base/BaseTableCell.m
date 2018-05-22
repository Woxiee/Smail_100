//
//  BaseTableCell.m
//  BangYou
//
//  Created by BangYou on 2017/11/21.
//  Copyright © 2017年 李麒. All rights reserved.
//

#import "BaseTableCell.h"

@implementation BaseTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        
    }
    return self;
}

- (void)setup{};

@end
