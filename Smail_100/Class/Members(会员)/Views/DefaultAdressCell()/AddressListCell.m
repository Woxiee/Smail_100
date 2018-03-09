//
//  AddressListCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/23.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "AddressListCell.h"

@implementation AddressListCell
{
    __weak IBOutlet UILabel *nameLB;
    
    __weak IBOutlet UILabel *telLB;
    
    __weak IBOutlet UILabel *detailLN;

    __weak IBOutlet UIView *lineView;
    
    __weak IBOutlet UIButton *btn1;
    
    __weak IBOutlet UIButton *editBtn;
    
    __weak IBOutlet UIButton *deleBtn;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
    [self setConfiguration];
    
}

/// 初始化视图
- (void)setup
{
    
}

/// 配置基础设置
- (void)setConfiguration
{
    nameLB.font = Font15;
    nameLB.textColor = TITLETEXTLOWCOLOR;

    telLB.font = Font15;
    telLB.textColor = TITLETEXTLOWCOLOR;
    
    detailLN.font = PLACEHOLDERFONT;
    detailLN.textColor = DETAILTEXTCOLOR;
    
    lineView.backgroundColor = LINECOLOR;
    [btn1 setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    [btn1 setTitleColor:KMAINCOLOR forState:UIControlStateSelected];

    [btn1 setTitle:@"设为默认" forState:UIControlStateNormal];
    
    [btn1 setImage:[UIImage imageNamed:@"zhanghuguanli10@3x.png"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"zhanghuguanli9@3x.png"] forState:UIControlStateSelected];
    [btn1 layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:5];

    [editBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setImage:[UIImage imageNamed:@"zhanghuguanli12@3x.png"] forState:UIControlStateNormal];
    [editBtn setImage:[UIImage imageNamed:@"4zhanghuguanli12@3x.png"] forState:UIControlStateSelected];
    [editBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:5];

    [deleBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    [deleBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleBtn setImage:[UIImage imageNamed:@"zhanghuguanli11@3x.png"] forState:UIControlStateNormal];
    [deleBtn setImage:[UIImage imageNamed:@"zhanghuguanli11@3x.png"] forState:UIControlStateSelected];
    [deleBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:5];

}

-(void)setModel:(GoodsOrderAddressModel *)model
{
    _model = model;
    nameLB.text = _model.contact_username;
    telLB.text = _model.contact_mobile;
   detailLN.text= [NSString stringWithFormat:@"%@%@%@%@",_model.province,_model.city,_model.district,_model.detail];
    if ([[NSString stringWithFormat:@"%@",_model.is_default] isEqualToString:@"Y"]) {
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
