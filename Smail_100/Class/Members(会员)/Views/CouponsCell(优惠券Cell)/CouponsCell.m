//
//  CouponsCell.m
//  MyCityProject
//
//  Created by Macx on 2018/1/30.
//  Copyright © 2018年 Faker. All rights reserved.
//

#import "CouponsCell.h"

@implementation CouponsCell
{
    __weak IBOutlet UIImageView *couponsImgView;
    __weak IBOutlet UIImageView *bgImg;
    __weak IBOutlet UIButton *selectBtn;
    
    __weak IBOutlet UILabel *priceLB;
    
    __weak IBOutlet UILabel *titleLB;
    
    __weak IBOutlet UIImageView *markImageView;
    __weak IBOutlet UILabel *timeLB;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    priceLB.textColor = BACKGROUND_COLORHL;
    titleLB.textColor = TITLE_COLOR;
    timeLB.textColor = DETAILTEXTCOLOR;
}



- (void)setup{
}


- (void)setModel:(CouponsModel *)model
{
    _model = model;
    [couponsImgView sd_setImageWithURL:[NSURL URLWithString:_model.back_imgUrl] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
//    NSString *str1 = @"￥";
//    NSString *str =[NSString stringWithFormat:@"%@%@",str1,_model.fixedQuota];
//    NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str1.length,str.length- str1.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:25 weight:UIFontWeightMedium]];
//
//    priceLB.attributedText = attributedStr;
//
//    titleLB.text = _model.couponsName;
//    isGet    是否已领取（1、已领取  0、未领取）
//    isOver    已领完（1、已领完  0、未领完）
    
    markImageView.hidden = YES;

    timeLB.text = [NSString stringWithFormat:@"%@至%@",_model.useStartTime,_model.useEndTime];
    if ([_model.isOver  isEqualToString:@"1"]) {
        bgImg.image = [UIImage imageNamed:@"lingquanzhongxin6@3x.png"];
        markImageView.image = [UIImage imageNamed:@"lingquanzhongxin9@3x.png"];

    }else{
        if ([_model.isGet isEqualToString:@"1"]) {
            bgImg.image = [UIImage imageNamed:@"lingquanzhongxin7@3x.png"];
            markImageView.image = [UIImage imageNamed:@"lingquanzhongxin10@3x.png"];
            
        }else{
            bgImg.image = [UIImage imageNamed:@"lingquanzhongxin12@3x"];

        }
    }
    
//    _model.userTypes = @"2";
    if (!KX_NULLString(_model.userTypes)) {
        markImageView.hidden = YES;
        if ([_model.userTypes isEqualToString:@"0"]) {
            bgImg.image = [UIImage imageNamed:@"lingquanzhongxin6@3x.png"];
        }
        
        else if ([_model.userTypes isEqualToString:@"1"]) {
            bgImg.image = [UIImage imageNamed:@"youhuiquan2@3x.png"];
        }
        
       else if ([_model.userTypes isEqualToString:@"2"]) {
           bgImg.image = [UIImage imageNamed:@"youhuiquan1@3x.png"];
       }
        
    }

}

- (IBAction)didClickAction:(UIButton *)sender {
    
    if (_didClickVolumeBlock) {
        _didClickVolumeBlock(_model);
    }
}

@end
