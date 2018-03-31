//
//  NewProductCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/4.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "NewProductCell.h"

@implementation NewProductCell
{
    __weak IBOutlet UIImageView *iconImageView;
    
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *detailLabel;
    
    __weak IBOutlet UILabel *moneyLabel;
    
    __weak IBOutlet UILabel *nyLB;
    
    __weak IBOutlet UILabel *shLB;
    
    __weak IBOutlet UILabel *getPericeLB;
    
    __weak IBOutlet UILabel *integralLB;
    
    __weak IBOutlet UILabel *sellLB;
    
    __weak IBOutlet UIView *tagsView;
    __weak IBOutlet NSLayoutConstraint *tagsContraintsH;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    titleLabel.font = PLACEHOLDERFONT;
    titleLabel.textColor = [UIColor blackColor];
    
    detailLabel.font = Font11;
    detailLabel.textColor = DETAILTEXTCOLOR1;
    
    moneyLabel.font = Font15;
    moneyLabel.textColor = KMAINCOLOR;
    
    nyLB.backgroundColor = BACKGROUND_COLOR;
    nyLB.textColor = DETAILTEXTCOLOR1;
    [nyLB layerForViewWith:2 AndLineWidth:0];
    shLB.backgroundColor = BACKGROUND_COLOR;
    shLB.textColor = DETAILTEXTCOLOR1;
    [shLB layerForViewWith:2 AndLineWidth:0];
    
    moneyLabel.textColor = KMAINCOLOR;
    getPericeLB.textColor = KMAINCOLOR;
    integralLB.textColor = DETAILTEXTCOLOR1;
    sellLB.textColor = DETAILTEXTCOLOR1;

    
}


-(void)setModel:(ItemContentList *)model
{
    _model = model;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    titleLabel.text  = _model.itemTitle;
    detailLabel.text = _model.itemSubTitle;
    moneyLabel.text = [NSString stringWithFormat:@"￥%@",_model.price];
    getPericeLB.text = [NSString stringWithFormat:@"赚￥%@",_model.earn_money];
    integralLB.text =[NSString stringWithFormat:@"送%@积分",_model.earn_point];
    sellLB.text = [NSString stringWithFormat:@"已出售:%@",_model.store_nums];
    if (_model.tags.count >0) {
        tagsContraintsH.constant = 20;
        tagsView.hidden = NO;
    }else{
        tagsContraintsH.constant = 0;
        tagsView.hidden = YES;
    }
    
    for (int i= 0; i<_model.tags.count; i++) {
        NSDictionary *dic = _model.tags[i];
        UILabel *lb = [[UILabel alloc] init];
        lb.frame = CGRectMake(27*i, 0, 25, 13);
        lb.font =  KY_FONT(9);
        lb.textColor = [UIColor whiteColor];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = dic[@"title"];
        [lb layerForViewWith:4 AndLineWidth:0];
        lb.backgroundColor = [UIColor colorWithHexString:dic[@"color"]];
        [tagsView addSubview:lb];
    }

}

- (IBAction)didClckAddAction:(UIButton *)sender {
    if (self.didClickCellBlock) {
        self.didClickCellBlock(_model);
    }
    
}



@end
