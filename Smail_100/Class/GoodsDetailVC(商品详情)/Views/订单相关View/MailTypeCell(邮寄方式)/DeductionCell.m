//
//  DeductionCell.m
//  Smile_100
//
//  Created by ap on 2018/3/7.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "DeductionCell.h"

@implementation DeductionCell
{
    __weak IBOutlet UIButton *stateBtn;
    
    __weak IBOutlet UITextField *numberTF;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    numberTF.delegate = self;
    
}


- (void)setUserInfo:(Userinfo *)userInfo
{
    _userInfo = userInfo;
    NSString *str = [NSString stringWithFormat:@"您有:%@积分,您下单积分不足时，可以用现金或者笑脸抵扣不足的积分或重新下单",_userInfo.point];
    NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(3, _userInfo.point.length) withColor:KMAINCOLOR withFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
    _integralLB.attributedText = attributedStr;
    
}



- (IBAction)didClickStateAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected =! btn.selected;
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL basic = [NSString cheakInputStrIsNumber:string];
    if(!basic)
    {
        //输入了非法字符
        return NO;
    }
    basic = [textField.text integerValue] >99999999? 1:0;
    if (basic) {
        textField.text =@"99999999";
        return YES;
    }
    return YES;
    
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
//    if ([textField.text isEqualToString:@""] || [textField.text isEqualToString:@"0"]) {
//        _numberTextField.text = @"1";
//        _model.buyCount = @"1";
//        _model.goodSCount =  1;
//
//    }else{
//        if ([_model.productInfo.param5 isEqualToString:@"1"]) {
//            _model.buyCount =  _numberTextField.text;
//            _model.goodSCount =  [ _numberTextField.text integerValue];
//
//        }else{
//            if ([textField.text integerValue] > [_model.productInfo.cargoNumber integerValue]) {
//                [self.window makeToast:[NSString stringWithFormat:@"库存不足，最多购买‘%@’件",_model.productInfo.cargoNumber]];
//                _numberTextField.text = [NSString stringWithFormat:@"%@",_model.productInfo.cargoNumber];
//
//            }
//            _model.buyCount =  _numberTextField.text;
//            _model.goodSCount =  [ _numberTextField.text integerValue];
//
//        }
//
//    }
    if (self.didChageJFNumberBlock) {
        self.didChageJFNumberBlock(textField.text);
    }
}


@end
