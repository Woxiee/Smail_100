//
//  FinanciaCell.m
//  MyCityProject
//
//  Created by Faker on 17/6/12.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "FinanciaCell.h"

@implementation FinanciaCell
{
    __weak IBOutlet UILabel *ddhLB;

    __weak IBOutlet UILabel *sqssLB;
    __weak IBOutlet UIView *lineView1;
    __weak IBOutlet UILabel *rzlxLn;

    __weak IBOutlet UILabel *rzedLB;
    
    __weak IBOutlet UILabel *sqrLB;
    
    __weak IBOutlet UILabel *lxrLb;
    
    __weak IBOutlet UILabel *rzsjLB;
    
    
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
    rzsjLB.textColor = DETAILTEXTCOLOR;


    [cancelBtn layerForViewWith:1 AndLineWidth:0.5];
    [cancelBtn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];

}

-(void)setModel:(OrderModel *)model
{
    _model = model;
    ddhLB.text = [NSString stringWithFormat:@"订单号：%@",_model.applyCode];
    sqssLB.text = [NSString stringWithFormat:@"申请时间：%@",_model.createTime];

    NSString *str1 = [NSString stringWithFormat:@"%@",model.financeTypeName];
    NSString *str =[NSString stringWithFormat:@"融资类型：%@",str1];
    NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:TITLETEXTLOWCOLOR withFont:[UIFont systemFontOfSize:13 weight:UIFontWeightThin]];
    rzlxLn.attributedText = attributedStr;
    
    
    NSString *str2 = [NSString stringWithFormat:@"%@",model.amout];
    NSString *str3 =[NSString stringWithFormat:@"融资额度：%@",str2];
    NSAttributedString *attributedStr1 =  [str3 creatAttributedString:str3 withMakeRange:NSMakeRange(str3.length- str2.length, str2.length) withColor:TITLETEXTLOWCOLOR withFont:[UIFont systemFontOfSize:13 weight:UIFontWeightThin]];
    rzedLB.attributedText = attributedStr1;
    
   
    NSString *str4 = [NSString stringWithFormat:@"%@",model.linkman];
    NSString *str5 =[NSString stringWithFormat:@"申请人：%@",str4];
    NSAttributedString *attributedStr2 =  [str5 creatAttributedString:str5 withMakeRange:NSMakeRange(str5.length- str4.length, str4.length) withColor:TITLETEXTLOWCOLOR withFont:[UIFont systemFontOfSize:13 weight:UIFontWeightThin]];
    sqrLB.attributedText = attributedStr2;
    
    NSString *str6 = [NSString stringWithFormat:@"%@",model.moblie];
    NSString *str7 =[NSString stringWithFormat:@"联系方式：%@",str6];
    NSAttributedString *attributedStr3 =  [str7 creatAttributedString:str7 withMakeRange:NSMakeRange(str7.length- str6.length, str6.length) withColor:TITLETEXTLOWCOLOR withFont:[UIFont systemFontOfSize:13 weight:UIFontWeightThin]];
    lxrLb.attributedText = attributedStr3;
    
    
    NSString *str8 = [NSString stringWithFormat:@"%@",model.financeTime];
    NSString *str9 =[NSString stringWithFormat:@"融资时间：%@",str8];
    NSAttributedString *attributedStr4 =  [str9 creatAttributedString:str9 withMakeRange:NSMakeRange(str9.length- str8.length, str8.length) withColor:TITLETEXTLOWCOLOR withFont:[UIFont systemFontOfSize:13 weight:UIFontWeightThin]];
    rzsjLB.attributedText = attributedStr4;
    

}

- (IBAction)didClickBtn:(id)sender {
    
    if (self.DidClickCancelBlock) {
        self.DidClickCancelBlock();
    }
}

@end
