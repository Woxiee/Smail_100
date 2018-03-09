//
//  ColumnCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/4.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "ColumnCell.h"

@implementation ColumnCell
{
    __weak IBOutlet UIImageView *iconImageView;

    __weak IBOutlet UILabel *titleLabel;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    titleLabel.font =  Font13;
    titleLabel.textColor = TITLETEXTLOWCOLOR;
}


- (void)setModel:(ItemContentList *)model
{
    _model = model;
    titleLabel.text = _model.itemTitle;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];

}

/// 配置基础设置
- (void)setConfiguration
{
    
}


@end
