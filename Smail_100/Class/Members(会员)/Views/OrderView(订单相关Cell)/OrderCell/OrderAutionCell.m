//
//  OrderAutionCell.m
//  MyCityProject
//
//  Created by Faker on 17/6/7.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderAutionCell.h"
#import "OrderFootView.h"

@implementation OrderAutionCell
{
    UILabel *_titleLB;
    UILabel *_makeLB;
    UIView *_lineView1;
    UIImageView * _iconView;
    UILabel *_nameLB;
    UILabel *_priceLB;
    UILabel *_attribute;
    UIView *_lineView2;
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
    
    
    _attribute = [UILabel new];
    _attribute.textColor = DETAILTEXTCOLOR1;
    _attribute.numberOfLines =0;
    _attribute.font = Font12;
    
    
    _lineView2 = [UIView new];
    _lineView2.backgroundColor = LINECOLOR;
    
    
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
    
    [self.contentView sd_addSubviews:@[_titleLB,_makeLB,_lineView1, _iconView,_nameLB,_attribute,_lineView2,_relustLB,_lineView4,_footView]];
    
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
    

    _nameLB.sd_layout
    .leftSpaceToView( _iconView, margin - 2)
    .topSpaceToView (_lineView1, margin)
    .rightSpaceToView(contentView, 12)
    .autoHeightRatio(0);

    _attribute.sd_layout
    .topSpaceToView (_nameLB,margin )
    .leftEqualToView(_nameLB)
    .rightEqualToView(_nameLB)
    .autoHeightRatio(0);

    _lineView2.sd_layout
    .rightSpaceToView(contentView, 0)
    .leftSpaceToView(contentView, 0)
    .heightIs(0.5);
    
    
    
    _relustLB.sd_layout
    .topSpaceToView (_lineView2, margin)
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


- (void)setModel:(OrderModel *)model
{
    _model = model;
    
    _titleLB.text = _model.sellerCompName;
    _nameLB.text = _model.productName;
    _attribute.text = _model.param1;
    [ _iconView sd_setImageWithURL:[NSURL URLWithString:model.productImgPath] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    _relustLB.isAttributedContent = YES;
    _footView.showType = AuctionShowType;
    [_nameLB setMaxNumberOfLinesToShow:2];
    UIView *bottomView;

    if (_cellType == AutionCellOfferType) {
        NSString *str2 = [NSString stringWithFormat:@"￥%@",model.offerPrice];
        NSString *str3 =[NSString stringWithFormat:@"出价金额：%@",str2];
        NSAttributedString *attributedStr1 =  [str3 creatAttributedString:str3 withMakeRange:NSMakeRange(str3.length- str2.length, str2.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:16 weight:UIFontWeightThin]];
        _relustLB.attributedText = attributedStr1;
        _relustLB.isAttributedContent = YES;
        _makeLB.text = [NSString stringWithFormat:@"拍卖次数：%@",_model.auctionNumber];
        _attribute.text = @"";
        _lineView2.sd_layout.topSpaceToView ( _iconView, 10);
        _footView.sd_layout.heightIs(0);
        bottomView = _footView;
    }else{
        if ([_model.depositStatus integerValue] == 0 ) {
            _makeLB.text = @"未支付保证金";
            _makeLB.textColor = DETAILTEXTCOLOR;
        }
        else if ([_model.depositStatus integerValue] == 1)
        {
            _makeLB.text = @"已支付保证金";
        }
        else{
            _makeLB.text = @"已返回保证金";
            _makeLB.textColor = DETAILTEXTCOLOR;
        }
        NSString *str2 = [NSString stringWithFormat:@"￥%@",model.depositAmounts];
        NSString *str3 =[NSString stringWithFormat:@"保证金：%@",str2];
        NSAttributedString *attributedStr1 =  [str3 creatAttributedString:str3 withMakeRange:NSMakeRange(str3.length- str2.length, str2.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:16 weight:UIFontWeightThin]];
        _relustLB.attributedText = attributedStr1;
        _footView.model = _model;
        _lineView2.sd_layout.topSpaceToView ( _attribute, 10);

        _footView.sd_layout.heightIs(44);

        bottomView = _footView;
//        bottomView = _lineView4;

    }
    

    [self setupAutoHeightWithBottomView:bottomView bottomMargin:0];
}


-(void)setCellType:(AutionCellType)cellType
{
    _cellType = cellType;
    
}

@end
