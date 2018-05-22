//
//  MyRecommendCell.m
//  Smile_100
//
//  Created by ap on 2018/2/26.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MyRecommendCell.h"

@interface MyRecommendCell ()
@property (weak, nonatomic) IBOutlet UILabel *title1LB;

@property (weak, nonatomic) IBOutlet UILabel *title2LB;

@property (weak, nonatomic) IBOutlet UIButton *RommendBtn;
@end

@implementation MyRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _title1LB.textColor = DETAILTEXTCOLOR;
    _title2LB.textColor = DETAILTEXTCOLOR;
    [_RommendBtn setTitleColor:KMAINCOLOR forState:UIControlStateNormal];

    [_RommendBtn layerWithRadius:6 lineWidth:1 color:KMAINCOLOR];
    
    
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
}


- (IBAction)didClickAction:(id)sender {
    
}

- (void)setModel:(MyteamModel *)model
{
    _model = model;
    _title1LB.text = _model.content.msg;

    
    NSString * markStr = [NSString stringWithFormat:@"您的推荐人是: %@",_model.content.pinfo];
    NSAttributedString *attributedStr1 =  [self attributeStringWithContent:markStr keyWords:@[_model.content.pinfo] color:TITLETEXTLOWCOLOR  font:Font14];
    _title2LB.attributedText = attributedStr1;
    
    
    
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
