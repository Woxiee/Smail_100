//
//  GoodsDetailInfoCell.m
//  ShiShi
//
//  Created by Faker on 17/3/8.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "GoodsDetailInfoCell.h"

@implementation GoodsDetailInfoCell
{
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *productPriceLabel;

    __weak IBOutlet UILabel *makeLB;

    __weak IBOutlet UILabel *integralLB;
    
    __weak IBOutlet UILabel *numLabel;  /// 库存
    
    __weak IBOutlet UILabel *postage;  /// 快递费

    __weak IBOutlet UIView *lineView2;
    
    __weak IBOutlet UIView *lineView3;
    
    __weak IBOutlet UIButton *title1Btn;
    
    __weak IBOutlet UIButton *title2Btn;
    
    __weak IBOutlet UIButton *title3Btn;
    
    __weak IBOutlet UIButton *title4Btn;
    
    __weak IBOutlet UIView *lineView;
    
    __weak IBOutlet UIView *tagsView;
    __weak IBOutlet NSLayoutConstraint *tagsContraintsH;

    __weak IBOutlet UILabel *descLB;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
}


/// 配置基础设置
- (void)setConfiguration
{
    nameLabel.textColor = TITLETEXTLOWCOLOR;
    nameLabel.font = Font15;;
    
    productPriceLabel.textColor = BACKGROUND_COLORHL;
    
    makeLB.textColor = BACKGROUND_COLORHL;
    
    numLabel.textColor = DETAILTEXTCOLOR;
    numLabel.font = PLACEHOLDERFONT;
    
    integralLB.textColor = DETAILTEXTCOLOR1;
    
    lineView.backgroundColor = LINECOLOR;
    lineView2.backgroundColor = LINECOLOR;
    lineView3.backgroundColor = LINECOLOR;

    postage.textColor = DETAILTEXTCOLOR1;
    descLB.textColor = DETAILTEXTCOLOR1;
    [title1Btn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];
    [title2Btn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];
    [title3Btn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];
    [title4Btn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];

    
//
//    alertLabel.textColor = DETAILTEXTCOLOR1;
//
//    despoitLB.textColor = DETAILTEXTCOLOR;
//    despoitLB.font = PLACEHOLDERFONT;

}



-(void)setModel:(ItemContentList *)model
{
    _model = model;
    nameLabel.text = _model.name;
    productPriceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price];
    if ([_model.price floatValue] <=0) {
        productPriceLabel.hidden = YES;
    }
    if ([_model.earn_point intValue] == 0) {
        integralLB.hidden = YES;
    }
    if ([_model.earn_money intValue] == 0) {
        makeLB.hidden = YES;
    }
    if ([_model.freight floatValue] > 0) {
        postage.hidden = NO;
    }else{
        postage.hidden = YES;

    }
    integralLB.text = [NSString stringWithFormat:@"送%@积分",_model.earn_point];
    makeLB.text = [NSString stringWithFormat:@"赚¥%@",_model.earn_money];
    numLabel.text = [NSString stringWithFormat:@"已出售:%@",_model.sale_num];
    
    postage.text = [NSString stringWithFormat:@"快递:¥%@",_model.freight];
    descLB.text = _model.desc;
    NSInteger  tagCount = 0;
    NSInteger row = SCREEN_WIDTH/27;

    if (_model.tags.count >0 ) {
        tagsContraintsH.constant = 15;
        tagsView.hidden = NO;
        tagCount = _model.tags.count ;
    }
    else{
        tagsContraintsH.constant = 0;
        tagCount = 0;
        tagsView.hidden = YES;
    }
    
    if (_model.tags.count > row)
    {
        tagsContraintsH.constant = 30;
        tagsView.hidden = NO;
        tagCount= _model.tags.count;
    }
  
    
    for (int i= 0; i<tagCount; i++) {
        NSInteger index = i % row;
        NSInteger page = i / row;
        NSDictionary *dic = _model.tags[i];
        UILabel *lb = [[UILabel alloc] init];
        lb.frame = CGRectMake(index *27, page*18, 25, 15);
        lb.font =  KY_FONT(9);
        lb.textColor = [UIColor whiteColor];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = dic[@"title"];
        [lb layerForViewWith:4 AndLineWidth:0];
        lb.backgroundColor = [UIColor colorWithHexString:dic[@"color"]];
        [tagsView addSubview:lb];
    }
    
}


///拨打电话
- (IBAction)didClickCollectBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (_clickCollectBlcok) {
//        _clickCollectBlcok(_model.businessResult.busiCompTel,btn.tag);
    }
}


@end
