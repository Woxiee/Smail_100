//
//  RighMeumtCell.m
//  Smail_100
//
//  Created by ap on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "RighMeumtCell.h"

@implementation RighMeumtCell
{
    __weak IBOutlet UILabel *priceLable;
    __weak IBOutlet UIImageView *headImage;
    __weak IBOutlet UILabel *nameLable;
    
    __weak IBOutlet UIButton *reduceBtn;
    __weak IBOutlet UIButton *addBtn;
    
    __weak IBOutlet UITextField *countTf;
    
    __weak IBOutlet UILabel *jfLb;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    nameLable.textColor = TITLETEXTLOWCOLOR;
    //    goodCommom.textColor = DETAILTEXTCOLOR;
    priceLable.textColor = KMAINCOLOR;
    countTf.userInteractionEnabled = NO;
    [countTf layerWithRadius:0 lineWidth:1 color:KMAINCOLOR];
    jfLb.textColor = DETAILTEXTCOLOR;

    
    
}

- (IBAction)addToShoppingCar:(UIButton *)sender {
    
    if (_cellAdd) {
        _cellAdd(_model);
    }
}

- (IBAction)clickreduceToShoppingCar:(id)sender {
    
    if (_cellReduce) {
        _cellReduce(_model);
    }
}

-(void)clickInput{
    
    if (_cellInputText) {
        _cellInputText(_model);
    }
    
}


- (void)setModel:(OrderGoodsModel *)model
{
    _model = model;
    nameLable.text = _model.productName;
    [headImage sd_setImageWithURL:[NSURL URLWithString:_model.productLogo] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
  priceLable.text = [NSString stringWithFormat:@"￥%@",_model.productPrice];
    if (_model.point.floatValue <=0) {
        jfLb.hidden = YES;
    }
    jfLb.text = [NSString stringWithFormat:@"送%@积分",_model.point];
  
    countTf.text = _model.itemCount;
}

@end
