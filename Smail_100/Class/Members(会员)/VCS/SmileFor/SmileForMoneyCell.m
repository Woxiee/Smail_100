//
//  SmileForMoneyCell.m
//  Smail_100
//
//  Created by ap on 2018/4/13.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SmileForMoneyCell.h"

@implementation SmileForMoneyCell
{
    
    
    __weak IBOutlet UILabel *moneyLB;
    
    __weak IBOutlet UITextField *textTF;
    
    __weak IBOutlet UILabel *detailLB;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    textTF.delegate = self;
    moneyLB.text = [KX_UserInfo sharedKX_UserInfo].money;
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    textTF.placeholder = [_dataDic objectForKey:@"input_msg"];
    
    detailLB.text = [NSString stringWithFormat:@"%@",[NSString filterHTML:_dataDic[@"msg"]]];
    detailLB.textColor = DETAILTEXTCOLOR;
//    detailLB.text = @"awdaw";
//
//textTF.text = [NSString filterHTML:_dataDic[@"msg"]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if(_didClickValueBlock){
        _didClickValueBlock(textField.text);
    }
}


@end
