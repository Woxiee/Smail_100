//
//  OrderCell.m
//  MyCityProject
//
//  Created by Faker on 17/6/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderCell.h"
#import "OrderFootView.h"

@implementation OrderCell
{
  
    UIImageView * _iconView;
    UILabel *_nameLB;
    UILabel *_priceLB;
    UILabel *_attribute;
    UIButton *_payBtn;
    UILabel *_numLB;
    UIView *_lineView2;

    UILabel *_timeLB;
    UIView *_lineView3;
//
//    UILabel *_relustLB;
//    UIView *_lineView4;
//
//    OrderFootView *_footView;
    NSMutableArray *_titleArr;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        [self setConfiguration];
    }
    return self;
    
}

/// 初始化视图
- (void)setup
{
    
    
    _lineView3= [UIView new];
    _lineView3.backgroundColor = LINECOLOR;
    
    
     _iconView = [UIImageView new];
//    [ _iconView layerForViewWith:2 AndLineWidth:1];
    
    _nameLB = [UILabel new];
    _nameLB.numberOfLines =2;
    _nameLB.textColor = TITLETEXTLOWCOLOR;
    _nameLB.font = Font15;
    
    _priceLB = [UILabel new];
    _priceLB.textColor = TITLETEXTLOWCOLOR;
    _priceLB.font = Font14;
    _priceLB.textAlignment = NSTextAlignmentLeft;

    _attribute = [UILabel new];
    _attribute.textColor = DETAILTEXTCOLOR;
    _attribute.font = Font13;
    
//    _payBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
//    [_payBtn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];
//    _payBtn.titleLabel.font = Font13;
//    _payBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [_payBtn layerForViewWith:2 AndLineWidth:0.5];
    
    _timeLB= [UILabel new];
    _timeLB.textColor = DETAILTEXTCOLOR;
    _timeLB.font = Font13;
    
    
    
    _numLB = [UILabel new];
    _numLB.textColor = KMAINCOLOR;
    _numLB.font = Font13;
    _numLB.textAlignment = NSTextAlignmentRight;

    _lineView2 = [UIView new];
    _lineView2.backgroundColor = LINECOLOR;

    WEAKSELF;
    [self.contentView sd_addSubviews:@[_lineView3, _iconView,_nameLB,_priceLB,_attribute,_timeLB,_numLB,_lineView2]];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _lineView3.sd_layout
    .topSpaceToView(contentView, 0)
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .heightIs(0.5);
    
     _iconView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView (contentView, margin)
    .widthIs(95)
    .heightIs(95);
    
    _nameLB.sd_layout
    .leftSpaceToView( _iconView, margin - 2)
    .topSpaceToView (contentView, margin)
    .rightSpaceToView(contentView, 50)
    .autoHeightRatio(0);
    
    _attribute.sd_layout
    .leftEqualToView(_nameLB)
    .topSpaceToView (_nameLB, margin/2)
    .rightEqualToView(_nameLB)
    .heightIs(17);
    
    
    _timeLB.sd_layout
    .topSpaceToView (_attribute, margin/2)
    .leftEqualToView(_nameLB)
    .rightEqualToView(_attribute)
    .heightIs(17);
  
    
    _priceLB.sd_layout
    .topSpaceToView (_timeLB,  margin/2)
    .leftEqualToView(_nameLB)
    .rightEqualToView(_attribute)
    .heightIs(17);
    
  
    
    _numLB.sd_layout
    .topEqualToView(_priceLB)
    .rightSpaceToView(contentView, margin)
    .minWidthIs(35)
    .heightIs(20);

    _lineView2.sd_layout
    .topSpaceToView(_numLB, 0)
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .heightIs(1);
    
}

/// 配置基础设置
- (void)setConfiguration
{
    _titleArr = [[NSMutableArray alloc] init];
}


- (void)setCellType:(OrderCellType)cellType
{
    _cellType = cellType;
}


- (void)setSeller:(Seller *)seller
{
    _seller = seller;
    [ _iconView sd_setImageWithURL:[NSURL URLWithString:_seller.img] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    _nameLB.text = _seller.name;
    [_nameLB setMaxNumberOfLinesToShow:2];
    _attribute.text = _seller.spec;
    _timeLB.text = [NSString stringWithFormat:@"交易时间：  %@",_seller.ctime];
    _numLB.text = [NSString stringWithFormat:@"*%@",_seller.goods_nums];
    [self setupAutoHeightWithBottomView:_lineView2 bottomMargin:1];
    NSString *allNumber = [NSString stringWithFormat:@"%@",_seller.goods_nums];
    NSString *allPrice = [NSString stringWithFormat:@"￥%@",_seller.price];
    NSString *allPoint = [NSString stringWithFormat:@"%@",_seller.point];

    if ([_seller.point integerValue] >0) {
        NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@积分+%@",allPrice,allPoint]];
        //获取要调整颜色的文字位置,调整颜色
        NSRange range1=[[hintString string]rangeOfString:allNumber];
        [hintString addAttribute:NSForegroundColorAttributeName  value:KMAINCOLOR range:range1];
        
        NSRange range2=[[hintString string]rangeOfString:allPrice];
        [hintString addAttribute:NSForegroundColorAttributeName value:KMAINCOLOR range:range2];
        
        NSRange range3 =[[hintString string]rangeOfString:allPoint];
        [hintString addAttribute:NSForegroundColorAttributeName value:KMAINCOLOR range:range3];
        _priceLB.attributedText =hintString;
    }else{
        NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@",allPrice]];
   
        NSRange range2=[[hintString string]rangeOfString:allPrice];
        [hintString addAttribute:NSForegroundColorAttributeName value:KMAINCOLOR range:range2];
        
 
        _priceLB.attributedText =hintString;
    }

   
 


}

- (void)setModel:(OrderModel *)model
{
    _model = model;
    _nameLB.text = _model.productName;
    _attribute.text = _model.property;
    [ _iconView sd_setImageWithURL:[NSURL URLWithString:model.productImgPath] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    if (KX_NULLString(_model.price)) {
        if (!KX_NULLString(_model.sumAmout)) {
            _priceLB.text = [NSString stringWithFormat:@"￥%@",_model.sumAmout];
        }else{
            _priceLB.text = @"";
        }
    }else{
        _priceLB.text = [NSString stringWithFormat:@"￥%@",_model.price];
    }
    _numLB.text = [NSString stringWithFormat:@"x%@",_model.buyCount];
    if ([_model.payMentType isEqualToString:@"1"] ) {
        [_payBtn setTitle:@"直接付款" forState:UIControlStateNormal];
    }
    else if ([_model.payMentType isEqualToString:@"2"] )
    {
        [_payBtn setTitle:@"分期付款" forState:UIControlStateNormal];
    }
    
    else if ([_model.payMentType isEqualToString:@"3"] )
    {
        [_payBtn setTitle:@"先用后付" forState:UIControlStateNormal];
    }
    else if ([_model.payMentType isEqualToString:@"4"] ){
        [_payBtn setTitle:@"融资租赁" forState:UIControlStateNormal];
    }else{
        _payBtn.hidden = YES;
    }
    [_payBtn setupAutoSizeWithHorizontalPadding:6 buttonHeight:22];

     NSString *str1 = [NSString stringWithFormat:@"￥%@",_model.sumAmout];
     NSString *str = @"";
    if ([_model.param2 isEqualToString:@"10"]) {
       str =  [NSString stringWithFormat:@"共%@件，合计：%@",_model.buyCount,str1];
    }
    else{
        str =  [NSString stringWithFormat:@"小计：%@",str1];
    }
//    NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:16 weight:UIFontWeightThin]];
//    _totalLB.attributedText = attributedStr;

//    NSString *str2 = [NSString stringWithFormat:@"￥%@",_model.orderPay];
//    NSString *str3 =[NSString stringWithFormat:@"已支付金额：%@",str2];
//    NSAttributedString *attributedStr1 =  [str3 creatAttributedString:str3 withMakeRange:NSMakeRange(str3.length- str2.length, str2.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:16 weight:UIFontWeightThin]];
//    _relustLB.attributedText = attributedStr1;
    
    
//    if (_cellType == CheckOrderCellType) {
//        _footView.showType = CheckShowType;
//    }
//    else if (_cellType == BuyOrderCellType){
//        _footView.showType = BuyShowType;
//    }
//    _footView.model = _model;

    UIView *bottomView;
    bottomView = _priceLB;
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:0];
}



@end
