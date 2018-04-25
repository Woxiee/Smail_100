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
    
    __weak IBOutlet UILabel *titleLB;
    
    __weak IBOutlet UILabel *titleLB1;
    __weak IBOutlet UILabel *moneyLB;
    
    __weak IBOutlet UITextField *textTF;
    
    __weak IBOutlet UILabel *detailLB;
    
    
    __weak IBOutlet UIButton *allBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    textTF.delegate = self;
    [allBtn setTitleColor:KMAINCOLOR forState:UIControlStateNormal];
    [allBtn layerWithRadius:6 lineWidth:0.5 color:KMAINCOLOR];
    allBtn.hidden = YES;
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    moneyLB.text = [KX_UserInfo sharedKX_UserInfo].money;

    textTF.placeholder = [_dataDic objectForKey:@"input_msg"];
    
    detailLB.text = [NSString stringWithFormat:@"%@",[NSString filterHTML:_dataDic[@"msg"]]];
    detailLB.textColor = DETAILTEXTCOLOR;
//    detailLB.text = @"awdaw";
//
//textTF.text = [NSString filterHTML:_dataDic[@"msg"]];
    if (!KX_NULLString(_showType)) {
        moneyLB.text = [NSString stringWithFormat:@"%@",_dataDic[@"shop_balance"]];

        titleLB.attributedText = [self attributeStringWithContent:[NSString stringWithFormat:@"当前可提现营业额(元)\n(让利后的营业额)"] keyWords:@[@"(让利后的营业额)"]];
        titleLB1.attributedText = [self attributeStringWithContent:[NSString stringWithFormat:@"商家营业额:\n(让利后的营业额)"] keyWords:@[@"(让利后的营业额)"]];
        allBtn.hidden = NO;
    }
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(_didClickValueBlock){
        _didClickValueBlock(textField.text);
    }
}


- (IBAction)didAllsubmitAction:(id)sender {
    [textTF resignFirstResponder];
    if (!KX_NULLString(_showType)) {
      textTF.text = [NSString stringWithFormat:@"%@",_dataDic[@"shop_balance"]];
    }else{
        textTF.text =  [KX_UserInfo sharedKX_UserInfo].money;

    }
    
}



- (NSAttributedString *)attributeStringWithContent:(NSString *)content keyWords:(NSArray *)keyWords
{
    UIColor *color = DETAILTEXTCOLOR;
    
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
