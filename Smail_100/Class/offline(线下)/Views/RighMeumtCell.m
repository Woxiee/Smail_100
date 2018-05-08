//
//  RighMeumtCell.m
//  Smail_100
//
//  Created by ap on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "RighMeumtCell.h"

@implementation RighMeumtCell
{
    __weak IBOutlet UILabel *priceLable;
    __weak IBOutlet UIImageView *headImage;
    __weak IBOutlet UILabel *nameLable;
    
    __weak IBOutlet UIButton *reduceBtn;
    __weak IBOutlet UIButton *addBtn;
    
    __weak IBOutlet UITextField *countTf;
    
    __weak IBOutlet UILabel *jfLb;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    nameLable.textColor = TITLETEXTLOWCOLOR;
    //    goodCommom.textColor = DETAILTEXTCOLOR;
    priceLable.textColor = KMAINCOLOR;
    countTf.userInteractionEnabled = YES;
    [countTf layerWithRadius:0 lineWidth:1 color:KMAINCOLOR];
    jfLb.textColor = DETAILTEXTCOLOR;

    reduceBtn.backgroundColor = KMAINCOLOR;
    addBtn.backgroundColor = KMAINCOLOR;
}

- (IBAction)addToShoppingCar:(UIButton *)sender {
    
    if (_cellAdd) {
        _cellAdd(_model);
    }
}

- (IBAction)clickreduceToShoppingCar:(id)sender {
    
    if (_cellReduce) {
        _cellReduce(_model);
    }
}

-(void)clickInput{
    
    if (_cellInputText) {
        _cellInputText(_model);
    }
    
}

- (IBAction)chageBtnClick:(UIButton *)sender{
    // jp 暂时不用
    if (_cellInputText) {
        _cellInputText(_model);
    }
}



- (void)setModel:(OrderGoodsModel *)model
{
    _model = model;
    nameLable.text = _model.productName;
    [headImage sd_setImageWithURL:[NSURL URLWithString:_model.productLogo] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
  priceLable.text = [NSString stringWithFormat:@"¥%@",_model.productPrice];
    
    NSAttributedString *attributedStr =  [self attributeStringWithContent: priceLable.text  keyWords:@[@"+",@"积分",@"¥"]];
    priceLable.attributedText  = attributedStr;

    if (_model.point.floatValue <=0) {
        jfLb.hidden = YES;
    }
    jfLb.text = [NSString stringWithFormat:@"送%@积分",_model.point];
  
    countTf.text = _model.itemCount;
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
