//
//  AttributeCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/15.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "AttributeCell.h"

@implementation AttributeCell
{
    __weak IBOutlet UIView *lineView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    _titleLabel.font = PLACEHOLDERFONT;
    _titleLabel.textColor = DETAILTEXTCOLOR;
    _detailLabel.font = PLACEHOLDERFONT;
    _detailLabel.textColor = DETAILTEXTCOLOR;
    lineView.backgroundColor = LINECOLOR;
}


-(void)setModel:(ExtAttrbuteShow *)model
{
    _model = model;
    _titleLabel.text = _model.name;
    _detailLabel.text = _model.values;
    if ([_model.name isEqualToString:@"适配机型"]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        self.accessoryType =  UITableViewCellAccessoryNone;
    }
}


-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    _titleLabel.text  = _dataDic[@"name"];
    _detailLabel.text  = _dataDic[@"values"];
    
}

-(void)setDizhi:(Dizhi *)dizhi
{
    _dizhi = dizhi;
    _titleLabel.text = [NSString stringWithFormat:@"%@%@%@",_dizhi.prov,dizhi.city,_dizhi.area];
}
@end
