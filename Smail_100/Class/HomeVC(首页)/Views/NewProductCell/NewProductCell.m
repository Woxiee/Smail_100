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
    getPericeLB.text = [NSString stringWithFormat:@"赚￥%@",_model.earn_point];
    integralLB.text =[NSString stringWithFormat:@"送%@积分",_model.earn_point];
    sellLB.text = [NSString stringWithFormat:@"已出售:%@",_model.store_nums];


//    if (_model.keyWordList.count >=2) {
//        shLB.text = _model.keyWordList[0];
//        nyLB.text = _model.keyWordList[1];
//        shLB.hidden = NO;
//        nyLB.hidden = NO;
//
//    }
//    else if (_model.keyWordList.count >0 && _model.keyWordList.count <2){
//        nyLB.text = _model.keyWordList[0];
//        shLB.hidden = YES;
//        nyLB.hidden = NO;
//    }
//    else {
        shLB.hidden = YES;
        nyLB.hidden = YES;
//    }
//    
//    for (NSString *str in _model.keyWordList) {
//        if (KX_NULLString(str)) {
//            shLB.hidden = YES;
//            nyLB.hidden = YES;
//        }
//    }
}


@end
