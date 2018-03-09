//
//  InvoiceCustomCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/24.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "InvoiceCustomCell.h"

@implementation InvoiceCustomCell
{
    __weak IBOutlet UILabel *nameLB;
    
    __weak IBOutlet UILabel *telLB;
    
    __weak IBOutlet UILabel *nameLB1;
    
    __weak IBOutlet UILabel *telLB1;
    
    __weak IBOutlet UILabel *detailLN;
    
    __weak IBOutlet UIView *lineView;
    
    __weak IBOutlet UIButton *btn1;
    
    __weak IBOutlet UIButton *editBtn;
    
    __weak IBOutlet UIButton *deleBtn;
    
    __weak IBOutlet UILabel *label3;
    
    __weak IBOutlet UILabel *label6;
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];

}


/// 配置基础设置
- (void)setConfiguration
{
    nameLB.font = Font15;
    nameLB.textColor = TITLETEXTLOWCOLOR;
    
    telLB.font = Font15;
    telLB.textColor = BACKGROUND_COLORHL;
    
    nameLB1.font = Font15;
    nameLB1.textColor = TITLETEXTLOWCOLOR;
    
    telLB1.font = Font15;
    telLB1.textColor = TITLETEXTLOWCOLOR;
    
    detailLN.font = PLACEHOLDERFONT;
    detailLN.textColor = TITLETEXTLOWCOLOR;
    
    label3.font = Font15;
    label3.textColor = TITLETEXTLOWCOLOR;
    
    label6.font = Font15;
    label6.textColor = TITLETEXTLOWCOLOR;
    
    lineView.backgroundColor = LINECOLOR;
    [btn1 setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    [btn1 setTitle:@"设为默认" forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"2@3x.png"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"3@3x.png"] forState:UIControlStateSelected];
    [btn1 layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:5];
    
    [editBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setImage:[UIImage imageNamed:@"4@3x.png"] forState:UIControlStateNormal];
    [editBtn setImage:[UIImage imageNamed:@"4@3x.png"] forState:UIControlStateSelected];
    [editBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:5];
    [deleBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    [deleBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleBtn setImage:[UIImage imageNamed:@"5@3x.png"] forState:UIControlStateNormal];
    [deleBtn setImage:[UIImage imageNamed:@"5@3x.png"] forState:UIControlStateSelected];
    [deleBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:5];
    
}


- (void)setModel:(InvoiceModel *)model
{
    _model = model;
    nameLB.text = [NSString stringWithFormat:@"公司名称：%@",_model.invoiceTitle];
    telLB.text = @"增值税专用发票";
    nameLB1.text = [NSString stringWithFormat:@"银行开户行：%@",_model.depositBank];
    label3.text = [NSString stringWithFormat:@"银行账户：%@",_model.depositAccount];
    
    telLB1.text  =[NSString stringWithFormat:@"纳税人识别号：%@",_model.ratepayerCode];
 
    detailLN.text  =[NSString stringWithFormat:@"地址：%@",_model.address];
       label6.text = [NSString stringWithFormat:@"电话：%@",_model.telephone];
    if ([_model.param1 isEqualToString:@"1"]) {
        btn1.selected = YES;
    }else{
        btn1.selected = NO;
    }

    
}


- (IBAction)didClickAddressBtn:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    if (_didClickBtnBlock) {
        if (btn.selected) {
            _didClickBtnBlock(btn.tag - 100, YES);
        }else{
            _didClickBtnBlock(btn.tag - 100, NO );
            
        }
    }
}
@end
