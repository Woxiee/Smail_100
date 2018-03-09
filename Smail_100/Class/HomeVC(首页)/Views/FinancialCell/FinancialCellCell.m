//
//  FinancialCellCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/4.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "FinancialCellCell.h"

@implementation FinancialCellCell
{
    __weak IBOutlet UIImageView *iconImageView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
   
}


-(void)setModel:(ColumnModel *)model
{
    _model = model;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.adImgUrl] placeholderImage:[UIImage imageNamed:DEFAULTIMAGEW]];
    
}
@end
