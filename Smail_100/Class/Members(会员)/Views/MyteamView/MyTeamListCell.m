//
//  MyTeamListCell.m
//  Smile_100
//
//  Created by ap on 2018/2/24.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MyTeamListCell.h"

@implementation MyTeamListCell
{
    __weak IBOutlet UIView *lineView;
    
    __weak IBOutlet UIImageView *logoImageView;
    
    __weak IBOutlet UILabel *nameLB;
    
    __weak IBOutlet UILabel *CKlb;
    __weak IBOutlet UILabel *tuijianLB;
    __weak IBOutlet UILabel *timeLB;
    
    __weak IBOutlet UILabel *jhLB;
    
    __weak IBOutlet UILabel *markLB;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    lineView.backgroundColor = LINECOLOR;
    [logoImageView layerForViewWith:30 AndLineWidth:0];
    nameLB.textColor = DETAILTEXTCOLOR;
}

- (void)setModel:(MyteamListModel *)model
{
    _model = model;
    
    [ logoImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:[UIImage imageNamed:@"6@3x.png"]];
    
    nameLB.text = [NSString stringWithFormat:@"%@",_model.nickname];
    
    CKlb.text = [NSString stringWithFormat:@"%@",_model.mobile];
    
    
    tuijianLB.text = [NSString stringWithFormat:@"推荐人账号: %@",_model.pid_mobile];
    
//    NSAttributedString *attributedStr =  [self attributeStringWithContent:moneyStr keyWords:@[@"+",@"快递费:",@"积分",@"¥"]];
//    self.selectView.LB_price.attributedText  = attributedStr;
    NSString *timeStr = [NSString stringWithFormat:@"注册时间: %@",_model.ctime];
     NSAttributedString *attributedStr =  [self attributeStringWithContent:timeStr keyWords:@[_model.ctime] color:TITLETEXTLOWCOLOR font:Font13 ];
    timeLB.attributedText = attributedStr;

    
    NSString *jhtimeStr = [NSString stringWithFormat:@"激活时间: %@",_model.last_paytime];;
    NSAttributedString *attributedStr1 =  [self attributeStringWithContent:jhtimeStr keyWords:@[_model.last_paytime] color:TITLETEXTLOWCOLOR font:Font13 ];
    jhLB.attributedText = attributedStr1;
//    jhLB.text = [NSString stringWithFormat:@"激活时间: %@",_model.last_paytime];
    
    if (_model.maker_level.integerValue == 1) {
        NSString * markStr = [NSString stringWithFormat:@"账户状态: %@",@"已激活"];
        NSAttributedString *attributedStr1 =  [self attributeStringWithContent:markStr keyWords:@[@"已激活"] color:KMAINCOLOR  font:Font13 ];
        markLB.attributedText = attributedStr1;
    }else{
        
        
        NSString * markStr = [NSString stringWithFormat:@"账户状态: %@",@"未激活"];
        NSAttributedString *attributedStr1 =  [self attributeStringWithContent:markStr keyWords:@[@"未激活"] color:TITLETEXTLOWCOLOR  font:Font13 ];
        markLB.attributedText = attributedStr1;

    }

}



- (NSAttributedString *)attributeStringWithContent:(NSString *)content keyWords:(NSArray *)keyWords color:(UIColor*)color font:(UIFont*)font
{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:content];
    
    if (keyWords) {
        
        [keyWords enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSMutableString *tmpString=[NSMutableString stringWithString:content];
            
            NSRange range=[content rangeOfString:obj];
            
            NSInteger location=0;
            
            while (range.length>0) {
                
                [attString addAttribute:(NSString*)NSForegroundColorAttributeName value:color range:NSMakeRange(location+range.location, range.length)];
                [attString addAttribute:NSFontAttributeName
                                  value:font
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
