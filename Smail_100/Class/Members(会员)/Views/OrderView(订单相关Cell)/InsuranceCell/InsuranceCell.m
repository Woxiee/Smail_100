//
//  InsuranceCell.m
//  MyCityProject
//
//  Created by Faker on 17/6/12.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "InsuranceCell.h"

@implementation InsuranceCell
{

    __weak IBOutlet UILabel *ddhLB;
    
    __weak IBOutlet UILabel *sqssLB;
    __weak IBOutlet UIView *lineView1;
    __weak IBOutlet UILabel *rzlxLn;
    
    __weak IBOutlet UILabel *rzedLB;
    
    __weak IBOutlet UILabel *sqrLB;
    
    __weak IBOutlet UILabel *lxrLb;
        
    __weak IBOutlet UILabel *linkLB;
    
    __weak IBOutlet UILabel *linkTelLB;
    
    __weak IBOutlet UIView *lineView2;
    __weak IBOutlet UIButton *cancelBtn;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];

}

/// 配置基础设置
- (void)setConfiguration
{
    ddhLB.textColor = DETAILTEXTCOLOR;
    sqssLB.textColor = DETAILTEXTCOLOR;
    lineView1.backgroundColor = LINECOLOR;
    lineView2.backgroundColor = LINECOLOR;
    
    rzlxLn.textColor = DETAILTEXTCOLOR;
    rzedLB.textColor = DETAILTEXTCOLOR;
    sqrLB.textColor = DETAILTEXTCOLOR;
    lxrLb.textColor = DETAILTEXTCOLOR;
    
    linkLB.textColor = DETAILTEXTCOLOR;
    linkTelLB.textColor = DETAILTEXTCOLOR;
    [cancelBtn layerForViewWith:1 AndLineWidth:0.5];
    [cancelBtn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];
    
}

-(void)setModel:(OrderModel *)model
{
    _model = model;
    ddhLB.text = [NSString stringWithFormat:@"订单号：%@",_model.applyCode];
    sqssLB.text = [NSString stringWithFormat:@"申请时间：%@",_model.createTime];
    
    NSString *str1 = [NSString stringWithFormat:@"%@",model.machineType];
    NSString *str =[NSString stringWithFormat:@"商品机型: %@",str1];
    NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:TITLETEXTLOWCOLOR withFont:[UIFont systemFontOfSize:13 weight:UIFontWeightThin]];
    rzlxLn.attributedText = attributedStr;
    
    
    NSString *str2 = [NSString stringWithFormat:@"%@",model.brandName];
    NSString *str3 =[NSString stringWithFormat:@"品牌：%@",str2];
    NSAttributedString *attributedStr1 =  [str3 creatAttributedString:str3 withMakeRange:NSMakeRange(str3.length- str2.length, str2.length) withColor:TITLETEXTLOWCOLOR withFont:[UIFont systemFontOfSize:13 weight:UIFontWeightThin]];
    rzedLB.attributedText = attributedStr1;
    
    
    NSString *str4 = [NSString stringWithFormat:@"%@",model.insuranceTypeName];
    NSString *str5 =[NSString stringWithFormat:@"投保类型: %@",str4];
    NSAttributedString *attributedStr2 =  [str5 creatAttributedString:str5 withMakeRange:NSMakeRange(str5.length- str4.length, str4.length) withColor:TITLETEXTLOWCOLOR withFont:[UIFont systemFontOfSize:13 weight:UIFontWeightThin]];
    sqrLB.attributedText = attributedStr2;
    
    NSString *str6 = [NSString stringWithFormat:@"%@",model.num];
    NSString *str7 =[NSString stringWithFormat:@"数量：%@",str6];
    NSAttributedString *attributedStr3 =  [str7 creatAttributedString:str7 withMakeRange:NSMakeRange(str7.length- str6.length, str6.length) withColor:TITLETEXTLOWCOLOR withFont:[UIFont systemFontOfSize:13 weight:UIFontWeightThin]];
    lxrLb.attributedText = attributedStr3;
    
    linkLB.text = [NSString stringWithFormat:@"申请人：%@",model.linkman];
    
    linkTelLB.text = [NSString stringWithFormat:@"联系方式：%@",model.moblie];
}

- (IBAction)didClickBtn:(id)sender {
    
    if (self.DidClickCancelBlock) {
        self.DidClickCancelBlock();
    }
}


@end
