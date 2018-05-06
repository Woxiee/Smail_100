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
    titleLabel.font = Font13;
    titleLabel.textColor = [UIColor blackColor];
    
    detailLabel.font = Font11;
    detailLabel.textColor = DETAILTEXTCOLOR1;
    
    moneyLabel.font = KY_FONT(16   );
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
    sellLB.font = Font13;
    
}


-(void)setModel:(ItemContentList *)model
{
    _model = model;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    titleLabel.text  = _model.itemTitle;
    detailLabel.text = _model.itemSubTitle;
    NSMutableArray *priceArr = [[NSMutableArray alloc] init];
    if (_model.price.floatValue >0) {
        [priceArr addObject:[NSString stringWithFormat:@"¥%@",_model.price]];
    }
    if (_model.point.floatValue >0) {
        [priceArr addObject:[NSString stringWithFormat:@"%@ 积分",_model.point]];
    }
    NSString *allPrice = [priceArr componentsJoinedByString:@"+"];
    if (_model.earn_money.floatValue >0) {
        NSString *getMoney = [NSString stringWithFormat:@"赚¥%@",_model.earn_money];
        NSString *moneyStr = [NSString stringWithFormat:@"%@ %@",allPrice,getMoney];
        NSAttributedString *attributedStr =  [self attributeStringWithContent:moneyStr keyWords:@[getMoney,@"+",@" 积分",@"¥"]];
        moneyLabel.attributedText  = attributedStr;

    }else{
        NSAttributedString *attributedStr =  [self attributeStringWithContent:allPrice keyWords:@[@"+",@"积分",@"¥"]];
        moneyLabel.attributedText  = attributedStr;
    }
    
    
    if (_model.earn_point.floatValue >0) {
        integralLB.hidden = NO;
    }else{
        integralLB.hidden = YES;
    }

    integralLB.text =[NSString stringWithFormat:@"送%@积分",_model.earn_point];
    sellLB.text = [NSString stringWithFormat:@"已出售:%@",_model.volume];
    NSInteger  tagCount = 0;
    if (_model.tags.count >0) {
        tagsContraintsH.constant = 15;
        tagsView.hidden = NO;
        tagCount = _model.tags.count ;
    }
    
    if (_model.tags.count >= 6)
    {
        tagsContraintsH.constant = 15;
        tagsView.hidden = NO;
        tagCount= 6;
    }

    if (_model.tags.count == 0) {
        tagsContraintsH.constant = 0;
        tagCount = 0;
        tagsView.hidden = YES;
    }

    for(UIView *subv in [tagsView subviews])
    {
        [subv removeFromSuperview];
    }
    
    for (int i= 0; i<tagCount; i++) {
        NSInteger index = i % 6;
        NSInteger page = i / 6;
        NSDictionary *dic = _model.tags[i];
        UILabel *lb = [[UILabel alloc] init];
        lb.frame = CGRectMake(index *27, page*18, 25, 15);
        lb.font =  KY_FONT(9);
        [lb layerForViewWith:3 AndLineWidth:0];
        lb.textColor = [UIColor whiteColor];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = dic[@"title"];
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
                                value:Font12
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
