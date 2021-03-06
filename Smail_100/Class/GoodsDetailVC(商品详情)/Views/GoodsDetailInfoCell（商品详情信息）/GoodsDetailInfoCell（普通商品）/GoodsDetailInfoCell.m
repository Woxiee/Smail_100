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
    productPriceLabel.font = KY_FONT(16);
//     [UIFont fontWithName:@"Helvetica-Bold" size:16]
    makeLB.textColor = BACKGROUND_COLORHL;
    
    numLabel.textColor = DETAILTEXTCOLOR;
    numLabel.font = Font13;
    
    integralLB.textColor = DETAILTEXTCOLOR;
    
    lineView.backgroundColor = LINECOLOR;
    lineView2.backgroundColor = LINECOLOR;
    lineView3.backgroundColor = LINECOLOR;

    postage.textColor = DETAILTEXTCOLOR;
    descLB.textColor = DETAILTEXTCOLOR;
    [title1Btn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    [title2Btn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    [title3Btn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    [title4Btn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];

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
    
    NSMutableArray *priceArr = [[NSMutableArray alloc] init];
    if (_model.price.floatValue >0) {
        [priceArr addObject:[NSString stringWithFormat:@"¥%@",_model.price]];
    }
    if (_model.point.floatValue >0) {
        [priceArr addObject:[NSString stringWithFormat:@"%@积分",_model.point]];
    }
    if (_model.earn_money.floatValue >0) {
        [priceArr addObject:[NSString stringWithFormat:@"      赚¥%@",_model.earn_money]];

    }
//    NSString *getMoney = [NSString stringWithFormat:@"  赚¥%@",_model.earn_money] ;
    NSString *allPrice = [priceArr componentsJoinedByString:@"+"];
    allPrice = [allPrice stringByReplacingOccurrencesOfString:@"+      赚" withString:@"   赚"];
    allPrice = [allPrice stringByReplacingOccurrencesOfString:@".00" withString:@""];

    NSAttributedString *attributedStr =  [self attributeStringWithContent:allPrice keyWords:@[@"+",@"积分",@"¥"]];
    productPriceLabel.attributedText  = attributedStr;
//    if (_model.earn_money.floatValue >0) {
//        NSString *getMoney = ;
//        NSString *moneyStr = [NSString stringWithFormat:@"%@ %@",allPrice,getMoney];
//
//
//    }else{
//        productPriceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price];
//    }
    
    if (_model.earn_point.floatValue >0) {
        integralLB.text = [NSString stringWithFormat:@"送%@积分",_model.earn_point];
    }
    
    if (_model.freight.floatValue >0) {
        postage.text = [NSString stringWithFormat:@"快递:¥%@",_model.freight];
    }else{
        if (KX_NULLString(_model.freight_msg)) {
            postage.text  = @"快递:包邮";
        }else{
            postage.text = [NSString stringWithFormat:@"快递:%@",_model.freight_msg];
        }
    }
    
    numLabel.text = [NSString stringWithFormat:@"已出售:%@",_model.sale_num];
    
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
        [lb layerForViewWith:3 AndLineWidth:0];
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


- (NSAttributedString *)attributeStringWithContent:(NSString *)content keyWords:(NSArray *)keyWords
{
    UIColor *color = KMAINCOLOR;
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:content];
    
    if (keyWords) {
        
        [keyWords enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSMutableString *tmpString=[NSMutableString stringWithString:content];
            
            NSRange range=[content rangeOfString:obj];
            
            NSInteger location=0;
            
            while (range.length>0) {
                
                [attString addAttribute:(NSString*)NSForegroundColorAttributeName value:color range:NSMakeRange(location+range.location, range.length)];
                [attString addAttribute:NSFontAttributeName
                                  value:Font11
                                  range:range];
                
                location+=(range.location+range.length);
                
                NSString *tmp= [tmpString substringWithRange:NSMakeRange(range.location+range.length, content.length-location)];
                
                tmpString=[NSMutableString stringWithString:tmp];
                
                range=[tmp rangeOfString:obj];
            }
        }];
    }
    return attString;
}


@end
