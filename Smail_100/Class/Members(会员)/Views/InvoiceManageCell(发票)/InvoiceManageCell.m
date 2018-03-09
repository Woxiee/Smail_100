//
//  InvoiceManageCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/24.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "InvoiceManageCell.h"

@implementation InvoiceManageCell
{
    __weak IBOutlet UILabel *nameLB;
    
    __weak IBOutlet UILabel *telLB;
    
    
    __weak IBOutlet UIView *lineView;
    
    __weak IBOutlet UIButton *btn1;
    
    __weak IBOutlet UIButton *editBtn;
    
    __weak IBOutlet UIButton *deleBtn;
    
    
    __weak IBOutlet UILabel *brankCode;
    
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
    
    brankCode.font = Font15;
    brankCode.textColor = TITLETEXTLOWCOLOR;

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
    nameLB.text = [NSString stringWithFormat:@"公司名称: %@",_model.invoiceTitle];
    if ([model.invoiceType isEqualToString:@"1"]) {
       telLB.text = @"增值税普通发票（纸质版）";
    }
    
    else{
        telLB.text = @"增值税普通发票（电子版）";
    }
    brankCode.text = [NSString stringWithFormat:@"纳税人识别号：%@",_model.ratepayerCode];
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
