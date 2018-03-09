//
//  InsuranceCellCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/4.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "InsuranceCellCell.h"

@implementation InsuranceCellCell
{
    __weak IBOutlet UIImageView *iconImageView;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(ColumnModel *)model
{
    _model = model;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.adImgUrl] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];

}
@end
