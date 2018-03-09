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
    UILabel *_titleLB;
    UILabel *_makeLB;
    UIView *_lineView1;
    UIImageView * _iconView;
    UILabel *_nameLB;
    UILabel *_priceLB;
    UILabel *_attribute;
    UIButton *_payBtn;
    UILabel *_numLB;
    UIView *_lineView2;

    UILabel *_totalLB;
    UIView *_lineView3;

    UILabel *_relustLB;
    UIView *_lineView4;
    
    OrderFootView *_footView;
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
    _titleLB = [UILabel new];
    _titleLB.textColor = DETAILTEXTCOLOR;
    _titleLB.font = PLACEHOLDERFONT;
    
    _makeLB = [UILabel new];
    _makeLB.textColor = BACKGROUND_COLORHL;
    _makeLB.font = PLACEHOLDERFONT;
    _makeLB.textAlignment = NSTextAlignmentRight;
    
    _lineView1 = [UIView new];
    _lineView1.backgroundColor = LINECOLOR;
    
     _iconView = [UIImageView new];
    [ _iconView layerForViewWith:2 AndLineWidth:1];
    
    _nameLB = [UILabel new];
    _nameLB.numberOfLines =2;
    _nameLB.textColor = DETAILTEXTCOLOR;
    _nameLB.font = Font15;
    
    _priceLB = [UILabel new];
    _priceLB.textColor = BACKGROUND_COLORHL;
    _priceLB.font = Font15;
    _priceLB.textAlignment = NSTextAlignmentRight;

    _attribute = [UILabel new];
    _attribute.textColor = DETAILTEXTCOLOR1;
    _attribute.font = Font12;
    
    _payBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [_payBtn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];
    _payBtn.titleLabel.font = Font13;
    _payBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_payBtn layerForViewWith:2 AndLineWidth:0.5];
    
    
    _numLB = [UILabel new];
    _numLB.textColor = DETAILTEXTCOLOR1;
    _numLB.font = Font12;
    _numLB.textAlignment = NSTextAlignmentRight;


    _lineView2 = [UIView new];
    _lineView2.backgroundColor = LINECOLOR;
    
    _totalLB = [UILabel new];
    _totalLB.textColor = DETAILTEXTCOLOR;
    _totalLB.font = PLACEHOLDERFONT;
    _totalLB.textAlignment = NSTextAlignmentRight;

    _lineView3 = [UIView new];
    _lineView3.backgroundColor = LINECOLOR;
    
    
    _relustLB = [UILabel new];
    _relustLB.textColor = DETAILTEXTCOLOR;
    _relustLB.font = PLACEHOLDERFONT;
    _relustLB.textAlignment = NSTextAlignmentRight;


    _lineView4 = [UIView new];
    _lineView4.backgroundColor = LINECOLOR;
    
    _footView= [OrderFootView new];
    _footView.backgroundColor = [UIColor whiteColor];
    WEAKSELF;
    _footView.didClickOrderItemBlock = ^(NSString *title){
        if (weakSelf.DidClickOrderCellBlock) {
            weakSelf.DidClickOrderCellBlock(title);
        }
    };
    
    [self.contentView sd_addSubviews:@[_titleLB,_makeLB,_lineView1, _iconView,_nameLB,_priceLB,_attribute,_payBtn,_numLB,_lineView2,_totalLB,_lineView3,_relustLB,_lineView4,_footView]];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 12;
    
    _titleLB.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView (contentView, margin+3)
    .rightSpaceToView(contentView, 50)
    .heightIs(17);
    
    _makeLB.sd_layout
    .topEqualToView(_titleLB)
    .rightSpaceToView(contentView, margin)
    .widthIs(100)
    .heightIs(17);
    
    _lineView1.sd_layout
    .topSpaceToView (_titleLB, margin+3)
    .rightSpaceToView(contentView, 0)
    .leftSpaceToView(contentView, 0)
    .heightIs(0.5);
    
     _iconView.sd_layout
    .leftEqualToView(_titleLB)
    .topSpaceToView (_lineView1, margin-2)
    .widthIs(65)
    .heightIs(60);
    
 
    
    _priceLB.sd_layout
    .topSpaceToView (_lineView1, margin)
    .rightEqualToView(_makeLB)
    .widthIs(100)
    .heightIs(17);
    
    _nameLB.sd_layout
    .leftSpaceToView( _iconView, margin - 2)
    .topSpaceToView (_lineView1, margin)
    .rightSpaceToView(_priceLB, 12)
    .autoHeightRatio(0);
    
    _payBtn.sd_layout
    .topSpaceToView (_priceLB, 4)
    .rightEqualToView(_makeLB);
    
    _numLB.sd_layout
    .topSpaceToView (_payBtn, 2)
    .rightEqualToView(_makeLB)
    .minWidthIs(35)
    .heightIs(20);
    
    _lineView2.sd_layout
    .topSpaceToView ( _iconView, margin-2)
    .rightSpaceToView(contentView, 0)
    .leftSpaceToView(contentView, 0)
    .heightIs(0.5);
    
    _attribute.sd_layout
    .leftEqualToView(_nameLB)
    .bottomSpaceToView (_lineView2,margin )
    .rightEqualToView(_nameLB)
    .heightIs(17);
    
    _totalLB.sd_layout
    .topSpaceToView (_lineView2, margin)
    .rightSpaceToView(contentView, margin)
    .leftSpaceToView(contentView, margin)
    .heightIs(17);
    
    _lineView3.sd_layout
    .topSpaceToView (_totalLB, margin)
    .rightSpaceToView(contentView, 0)
    .leftSpaceToView(contentView, 0)
    .heightIs(0.5);
    
    _relustLB.sd_layout
    .topSpaceToView (_lineView3, margin)
    .rightSpaceToView(contentView, margin)
    .leftSpaceToView(contentView, margin)
    .heightIs(17);
    
    _lineView4.sd_layout
    .topSpaceToView (_relustLB, margin)
    .rightSpaceToView(contentView, 0)
    .leftSpaceToView(contentView, 0)
    .heightIs(0.5);
    
    _footView.sd_layout
    .topSpaceToView (_lineView4, 0)
    .rightSpaceToView(contentView, 0)
    .leftSpaceToView(contentView, 0);
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


- (void)setModel:(OrderModel *)model
{
    _model = model;
    
    _titleLB.text = _model.sellerCompName;
    _makeLB.text = _model.orderStatusTitle;
    if ([_model.orderStatus isEqualToString:@"6"] || [_model.orderStatus isEqualToString:@"0"] ) {
        _makeLB.textColor = DETAILTEXTCOLOR;
    }else{
        _makeLB.textColor = BACKGROUND_COLORHL;
    }
    
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
    NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:16 weight:UIFontWeightThin]];
    _totalLB.attributedText = attributedStr;

    NSString *str2 = [NSString stringWithFormat:@"￥%@",_model.orderPay];
    NSString *str3 =[NSString stringWithFormat:@"已支付金额：%@",str2];
    NSAttributedString *attributedStr1 =  [str3 creatAttributedString:str3 withMakeRange:NSMakeRange(str3.length- str2.length, str2.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:16 weight:UIFontWeightThin]];
    _relustLB.attributedText = attributedStr1;
    
    [_nameLB setMaxNumberOfLinesToShow:2];
    
    if (_cellType == CheckOrderCellType) {
        _footView.showType = CheckShowType;
    }
    else if (_cellType == BuyOrderCellType){
        _footView.showType = BuyShowType;
    }
    _footView.model = _model;

    UIView *bottomView;
    bottomView = _footView;
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:0];
}



@end
