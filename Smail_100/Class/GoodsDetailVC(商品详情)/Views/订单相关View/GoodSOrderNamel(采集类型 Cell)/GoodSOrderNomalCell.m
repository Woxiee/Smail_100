//
//  GoodSOrderNomalCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/22.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodSOrderNomalCell.h"

@interface GoodSOrderNomalCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;/// 数量TextField
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *detailLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *eamliView;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@property (weak, nonatomic) IBOutlet UIView *lineView3;

@end

@implementation GoodSOrderNomalCell
{
    UIButton *_shouYeBtn;
    UIButton *_meBtn;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];
    [self setup];

}


/// 初始化视图
- (void)setup
{
    
}


/// 配置基础设置
- (void)setConfiguration
{
    [_iconImageView layerForViewWith:2 AndLineWidth:0.5];
    _titleLB.font = Font15;
    _titleLB.textColor = TITLETEXTLOWCOLOR;
    
    _detailLB.font = Font12;
    _detailLB.textColor = DETAILTEXTCOLOR;
    
//    _priceLB.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    _priceLB.font = Font14;
    _priceLB.textColor = BACKGROUND_COLORHL;

    _number.textColor = BACKGROUND_COLORHL;
    
    _lineView1.backgroundColor = LINECOLOR;
    _lineView2.backgroundColor = LINECOLOR;
    _lineView3.backgroundColor = LINECOLOR;

    UILabel *titleLB  = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 44) title:@"配送方式" textColor:[UIColor blackColor] font:Font15];
    titleLB.textAlignment = NSTextAlignmentLeft;
    titleLB.textColor = TITLETEXTLOWCOLOR;
    [_eamliView addSubview:titleLB];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLB.frame), SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = LINECOLOR;
    [_eamliView addSubview:lineView];
    
    UIButton *shouYeBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    shouYeBtn.frame = CGRectMake(8, CGRectGetMaxY(lineView.frame),SCREEN_WIDTH/4 , 40);
    [shouYeBtn addTarget:self action:@selector(didClickEmailAction:) forControlEvents:UIControlEventTouchUpInside];
    shouYeBtn.tag = 100;
    shouYeBtn.selected = YES;
    [shouYeBtn setImage:[UIImage imageNamed:@"zhuce2@3x.png"] forState:UIControlStateNormal];
    [shouYeBtn setImage:[UIImage imageNamed:@"23@3x.png"] forState:UIControlStateSelected];
    [shouYeBtn setTitle:@"快递邮寄" forState:UIControlStateNormal];
    [shouYeBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];
    [shouYeBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    shouYeBtn.titleLabel.font =  Font15;
    [_eamliView addSubview:shouYeBtn];
    
    _shouYeBtn = shouYeBtn;
    
    UIButton *meBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    meBtn.frame = CGRectMake(CGRectGetMaxX(shouYeBtn.frame)  +40, CGRectGetMaxY(lineView.frame), SCREEN_WIDTH/4, 45);
    [meBtn addTarget:self action:@selector(didClickEmailAction:) forControlEvents:UIControlEventTouchUpInside];
    meBtn.tag = 101;
    [meBtn setImage:[UIImage imageNamed:@"zhuce2@3x.png"] forState:UIControlStateNormal];
    [meBtn setImage:[UIImage imageNamed:@"23@3x.png"] forState:UIControlStateSelected];
    [meBtn setTitle:@"门店自提" forState:UIControlStateNormal];
    [meBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    meBtn.titleLabel.font =  Font15;
    [meBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];
    [_eamliView addSubview:meBtn];
    _meBtn = meBtn;

}




- (void)setProducts:(Products *)products
{
    _products = products;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_products.img] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    _titleLB.text = _products.name;
    _detailLB.text = _products.spec?_products.spec:[NSString stringWithFormat:@"规格: %@",@"默认"];
    
    
//    _priceLB.text = [NSString stringWithFormat:@"¥%@",_products.price];
////    _products.point = @"22";
//    if ([_products.point integerValue] >0) {
////        NSString *allPrice = [NSString]
//        NSString *str = [NSString stringWithFormat:@"%@积分+¥%@",_products.point,_products.price];
//        NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(_products.point.length, 2) withColor:TITLETEXTLOWCOLOR withFont:Font13];
//        _priceLB.attributedText = attributedStr;
//    }
    
    NSMutableArray *priceArr = [[NSMutableArray alloc] init];
    if (_products.price.floatValue >0) {
        [priceArr addObject:[NSString stringWithFormat:@"¥%@",_products.price]];
    }
    if (_products.point.floatValue >0) {
        [priceArr addObject:[NSString stringWithFormat:@"%@ 积分",_products.point]];
    }
    NSString *allPrice = [priceArr componentsJoinedByString:@"+"];
    NSAttributedString *attributedString    =  [self attributeStringWithContent:allPrice keyWords:@[@" 积分",@"+"] fonts:Font11 color:KMAINCOLOR];
    
    _priceLB.attributedText = attributedString;    _number.text = [NSString stringWithFormat:@"*%@",_products.goods_nums];
    
    if (_model.isDetail) {
        _shouYeBtn.userInteractionEnabled = NO;
        _meBtn.userInteractionEnabled = NO;
    }
    
}

- (void)setSeller:(Seller *)seller
{
    _seller = seller;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_seller.img] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    _titleLB.text = _seller.name;
    _detailLB.text = _seller.spec?_seller.spec:[NSString stringWithFormat:@"规格: %@",@"默认"];
    _priceLB.text = [NSString stringWithFormat:@"¥%@",_seller.price];
    
    NSMutableArray *priceArr = [[NSMutableArray alloc] init];
    if (_seller.price.floatValue >0) {
        [priceArr addObject:[NSString stringWithFormat:@"¥%@",_seller.price]];
    }
    if (_seller.point.floatValue >0) {
        [priceArr addObject:[NSString stringWithFormat:@"%@ 积分",_seller.point]];
    }
    NSString *allPrice = [priceArr componentsJoinedByString:@"+"];

  NSAttributedString *attributedString    =  [self attributeStringWithContent:allPrice keyWords:@[@" 积分",@"+"] fonts:Font11 color:KMAINCOLOR];

    _priceLB.attributedText = attributedString;
//    //    _products.point = @"22";
//    if ([_seller.point integerValue] >0) {
//        //        NSString *allPrice = [NSString]
//        NSString *str = [NSString stringWithFormat:@"%@积分+¥%@",_seller.point,_seller.price];
//        NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(_seller.point.length, 2) withColor:TITLETEXTLOWCOLOR withFont:Font13];
//        _priceLB.attributedText = attributedStr;
//    }
    _number.text = [NSString stringWithFormat:@"*%@",_seller.goods_nums];
    
    if (_model.isDetail) {
        _shouYeBtn.userInteractionEnabled = NO;
        _meBtn.userInteractionEnabled = NO;
    }
}

/// 增加 减少BTN
- (IBAction)didClickChangeAction:(UIButton *)btn
{
    if (btn.tag == 100) {
        _model.goodSCount --;
        if (_model.goodSCount ==1 ||_model.goodSCount<1) {
            _model.goodSCount =1;
        }
    }
    
    else if (btn.tag == 101){
        _model.goodSCount ++;
    }
    if ([_model.productInfo.param5 isEqualToString:@"1"]) {
        
    }else{
        if (_model.goodSCount > [_model.productInfo.cargoNumber integerValue]) {
          [self.window makeToast:[NSString stringWithFormat:@"库存不足，最多购买‘%@’件",_model.productInfo.cargoNumber]];
            _numberTextField.text = [NSString stringWithFormat:@"%@",_model.productInfo.cargoNumber];
            _model.goodSCount = [_model.productInfo.cargoNumber integerValue];
        }
    }
    _numberTextField.text = [NSString stringWithFormat:@"%ld",(long)_model.goodSCount];
    _model.buyCount = [NSString stringWithFormat:@"%ld",(long)_model.goodSCount];
    if (self.didChangeNumberBlock) {
        self.didChangeNumberBlock(_model.buyCount );
    }

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
    if ([textField.text isEqualToString:@""] || [textField.text isEqualToString:@"0"]) {
         _numberTextField.text = @"1";
        _model.buyCount = @"1";
        _model.goodSCount =  1;

    }else{
        if ([_model.productInfo.param5 isEqualToString:@"1"]) {
            _model.buyCount =  _numberTextField.text;
            _model.goodSCount =  [ _numberTextField.text integerValue];
     
        }else{
            if ([textField.text integerValue] > [_model.productInfo.cargoNumber integerValue]) {
                [self.window makeToast:[NSString stringWithFormat:@"库存不足，最多购买‘%@’件",_model.productInfo.cargoNumber]];
                _numberTextField.text = [NSString stringWithFormat:@"%@",_model.productInfo.cargoNumber];
               
            }
            _model.buyCount =  _numberTextField.text;
            _model.goodSCount =  [ _numberTextField.text integerValue];

        }
       
    }
    if (self.didChangeNumberBlock) {
        self.didChangeNumberBlock( _numberTextField.text);
    }

}




- (void)didClickEmailAction:(UIButton*)sender
{
    if (sender.tag == 100) {
        _shouYeBtn.selected = YES;
        _meBtn.selected = NO;
    }
    else{
        _shouYeBtn.selected = NO;
        _meBtn.selected = YES;
    }
    
    if (_didChangeEmailTypeBlock) {
        _didChangeEmailTypeBlock(sender.tag - 100);
    }
}

- (NSAttributedString *)attributeStringWithContent:(NSString *)content keyWords:(NSArray *)keyWords fonts:(UIFont *)fonts color:(UIColor *)color
{
    __block  UIColor *colors = color;
    __block  UIFont *font = fonts;
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:content];
    
    if (keyWords) {
        
        [keyWords enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSMutableString *tmpString=[NSMutableString stringWithString:content];
            if ([obj isEqualToString:@"(包邮)"]) {
                colors = DETAILTEXTCOLOR;
            }else{
                colors = color;
            }
            //            if ( [obj containsString:@"¥"] || [obj containsString:@"积分"]|| [obj containsString:@"快递费"]) {
            //                font = KY_FONT(9);
            //            }else{
            //                font = fonts;
            //            }
            NSRange range=[content rangeOfString:obj];
            
            NSInteger location=0;
            while (range.length>0) {
                
                [attString addAttribute:(NSString*)NSForegroundColorAttributeName value:colors range:NSMakeRange(location+range.location, range.length)];
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
