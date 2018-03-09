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
    
    __weak IBOutlet UILabel *postage;  /// 邮费

    __weak IBOutlet UIView *lineView2;
    
    __weak IBOutlet UIView *lineView3;
    
    __weak IBOutlet UIButton *title1Btn;
    
    __weak IBOutlet UIButton *title2Btn;
    
    __weak IBOutlet UIButton *title3Btn;
    
    __weak IBOutlet UIButton *title4Btn;
    
    __weak IBOutlet UIView *lineView;

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

    postage.textColor = KMAINCOLOR;
    
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

//-(void)setModel:(GoodSDetailModel *)model
//{
//    _model = model;
//    /// certification    1表示认证0表示未认证
//    if ([_model.mainResult.certification isEqualToString:@"1"]) {
//        certificationLabel.text = @"已认证";
//        nameLabel.text = [NSString stringWithFormat:@"                   %@",_model.mainResult.productName];
//    }else{
//        certificationLabel.hidden = YES;
//        nameLabel.text = _model.mainResult.productName;
//    }
//    productPriceLabel.text = [NSString stringWithFormat:@"￥%@",_model.showPirce];
//    if ([_model.param5 isEqualToString:@"1"]) {
//        numLabel.text  = @"库存充足";
// 
//    }else{
//        numLabel.text  = [NSString stringWithFormat:@"库存：%@",_model.cargoNumber];
//
//    }
//    [companyLabel  setTitle:_model.businessResult.busiCompName forState:UIControlStateNormal];
//
//    if (_model.mainResult.dizhi.count >0) {
//        Dizhi *dizhi = _model.mainResult.dizhi[0];
//        if ([_model.typeStr isEqualToString:@"3"] || [_model.typeStr isEqualToString:@"4"] || [_model.typeStr isEqualToString:@"5"]) {
//            [addressLabel setTitle:[NSString stringWithFormat:@"产品当前所在地：%@%@%@",dizhi.prov,dizhi.city,dizhi.area] forState:UIControlStateNormal];
// 
//        }
//        else{
//            [addressLabel setTitle:[NSString stringWithFormat:@"销售范围：%@%@%@",dizhi.prov,dizhi.city,dizhi.area] forState:UIControlStateNormal];
//
//        }
//    }
//
//    /// deliveryType    发货形式 1自提 2    发货
//    if ([_model.mainResult.deliveryType isEqualToString:@"1"]) {
//        pickUpLabel.text = @"自提";
//    }else{
//        pickUpLabel.text = @"发货";
//    }
//    
//    
//    if ([_model.mainResult.isDeposit isEqualToString:@"1"]) {
//        despoitLB.text = [NSString stringWithFormat:@"押金：￥%@", _model.mainResult.gepositPrice];
//    }else{
//        despoitContonsH.constant = 0;
//        despoitLB.hidden = YES;
//    }
//
//}

-(void)setModel:(ItemContentList *)model
{
    _model = model;
    nameLabel.text = _model.name;
    productPriceLabel.text = [NSString stringWithFormat:@"￥%@",_model.price];
    integralLB.text = [NSString stringWithFormat:@"送%@积分",_model.point];
    makeLB.text = [NSString stringWithFormat:@"赚￥%@",_model.point];

    numLabel.text = [NSString stringWithFormat:@"已出售:%@",_model.sale_num];
    postage.text = [NSString stringWithFormat:@"快递:￥%@",_model.sale_num];
    
}


///拨打电话
- (IBAction)didClickCollectBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (_clickCollectBlcok) {
//        _clickCollectBlcok(_model.businessResult.busiCompTel,btn.tag);
    }
}


@end
