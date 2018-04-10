//
//  NewProductCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/4.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "NewProductCell.h"

@implementation NewProductCell
{
    __weak IBOutlet UIImageView *iconImageView;
    
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *detailLabel;
    
    __weak IBOutlet UILabel *moneyLabel;
    
    __weak IBOutlet UILabel *nyLB;
    
    __weak IBOutlet UILabel *shLB;
    
    __weak IBOutlet UILabel *getPericeLB;
    
    __weak IBOutlet UILabel *integralLB;
    
    __weak IBOutlet UILabel *sellLB;
    
    __weak IBOutlet UIView *tagsView;
    __weak IBOutlet NSLayoutConstraint *tagsContraintsH;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    titleLabel.font = PLACEHOLDERFONT;
    titleLabel.textColor = [UIColor blackColor];
    
    detailLabel.font = Font11;
    detailLabel.textColor = DETAILTEXTCOLOR1;
    
    moneyLabel.font = Font15;
    moneyLabel.textColor = KMAINCOLOR;
    
    nyLB.backgroundColor = BACKGROUND_COLOR;
    nyLB.textColor = DETAILTEXTCOLOR1;
    [nyLB layerForViewWith:2 AndLineWidth:0];
    shLB.backgroundColor = BACKGROUND_COLOR;
    shLB.textColor = DETAILTEXTCOLOR1;
    [shLB layerForViewWith:2 AndLineWidth:0];
    
    moneyLabel.textColor = KMAINCOLOR;
    getPericeLB.textColor = KMAINCOLOR;
    integralLB.textColor = DETAILTEXTCOLOR1;
    sellLB.textColor = DETAILTEXTCOLOR1;
    sellLB.font = Font14;
    
}


-(void)setModel:(ItemContentList *)model
{
    _model = model;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    titleLabel.text  = _model.itemTitle;
    detailLabel.text = _model.itemSubTitle;
//    NSString *str1 = [NSString stringWithFormat:@"%.2f",priceStr];
//    NSString *str =[NSString stringWithFormat:@"￥%@",str1];
//    NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:17 weight:UIFontWeightThin]];
//    _numberTextField.attributedText = attributedStr;
    if (_model.earn_point.floatValue >0) {
        
        NSString *moneyStr = [NSString stringWithFormat:@"￥%@+%@积分",_model.price,_model.earn_point];
        NSAttributedString *attributedStr =  [self attributeStringWithContent:moneyStr keyWords:@[@"积分"]];
//        NSAttributedString *attributedStr = [moneyStr creatAttributedString:moneyStr withMakeRange:NSMakeRange(0, moneyStr.length) withColor:KMAINCOLOR withFont:Font14];
        integralLB.hidden = NO;
        moneyLabel.attributedText  = attributedStr;

    }else{
        integralLB.hidden = YES;
        moneyLabel.text  =  [NSString stringWithFormat:@"￥%@",_model.price];
    }

    getPericeLB.text = [NSString stringWithFormat:@"赚￥%@",_model.earn_money];
    integralLB.text =[NSString stringWithFormat:@"送%@积分",_model.earn_point];
    sellLB.text = [NSString stringWithFormat:@"已出售:%@",_model.volume];
    NSInteger  tagCount = 0;
    if (_model.tags.count >0) {
        tagsContraintsH.constant = 15;
        tagsView.hidden = NO;
        tagCount = _model.tags.count ;
    }
    else{
        tagsContraintsH.constant = 0;
        tagCount = 0;
        tagsView.hidden = YES;
    }
    
    if (_model.tags.count >= 6)
    {
        tagsContraintsH.constant = 15;
        tagsView.hidden = NO;
        tagCount= 6;
    }
    else{
        tagsContraintsH.constant = 0;
        tagCount = 0;
        tagsView.hidden = YES;
    }
  
    for (int i= 0; i<tagCount; i++) {
        NSInteger index = i % 6;
        NSInteger page = i / 6;
        NSDictionary *dic = _model.tags[i];
        UILabel *lb = [[UILabel alloc] init];
        lb.frame = CGRectMake(index *27, page*18, 25, 15);
        lb.font =  KY_FONT(9);
        lb.textColor = [UIColor whiteColor];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = dic[@"title"];
        [lb layerForViewWith:4 AndLineWidth:0];
        lb.backgroundColor = [UIColor colorWithHexString:dic[@"color"]];
        [tagsView addSubview:lb];
    }

}

- (IBAction)didClckAddAction:(UIButton *)sender {
    if (self.didClickCellBlock) {
        self.didClickCellBlock(_model);
    }
    
}

 - (NSAttributedString *)attributeStringWithContent:(NSString *)content keyWords:(NSArray *)keyWords

{
    
    UIColor *color = KMAINCOLOR;
    
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
