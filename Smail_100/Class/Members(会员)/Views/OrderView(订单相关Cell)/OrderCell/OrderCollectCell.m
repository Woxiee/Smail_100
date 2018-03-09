//
//  OrderCollectCell.m
//  MyCityProject
//
//  Created by Faker on 17/6/7.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderCollectCell.h"
#import "OrderFootView.h"

@implementation OrderCollectCell
{
    UILabel *_titleLB;
    UILabel *_makeLB;
    UIView *_lineView1;
    UIImageView * _iconView;
    UILabel *_nameLB;
    UILabel *_timeLB;
    UILabel *_priceLB;

    UILabel *_attribute;
    UIView *_lineView2;
    
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
    
    
    _timeLB = [UILabel new];
    _timeLB.textColor = DETAILTEXTCOLOR1;
    _timeLB.font = Font12;
    _timeLB.textAlignment = NSTextAlignmentLeft;

    
    _attribute = [UILabel new];
    _attribute.textColor = DETAILTEXTCOLOR1;
    _attribute.font = Font12;
    
    _lineView2 = [UIView new];
    _lineView2.backgroundColor = LINECOLOR;
    

    
    _footView= [OrderFootView new];
    _footView.backgroundColor = [UIColor whiteColor];
    WEAKSELF;
    _footView.didClickOrderItemBlock = ^(NSString *title){
        if (weakSelf.DidClickOrderCellBlock) {
            weakSelf.DidClickOrderCellBlock(title);
        }
    };
    
    [self.contentView sd_addSubviews:@[_titleLB,_makeLB,_lineView1, _iconView,_nameLB,_priceLB,_attribute,_timeLB,_lineView2,_footView]];
    
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
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    _priceLB.sd_layout
    .topSpaceToView (_lineView1, margin)
    .rightEqualToView(_makeLB)
    .widthIs(100)
    .heightIs(17);
    
    _timeLB.sd_layout
    .topSpaceToView (_nameLB, 3)
    .leftEqualToView(_nameLB)
    .rightEqualToView(_makeLB)
    .heightIs(20);
    
    _attribute.sd_layout
    .leftEqualToView(_nameLB)
    .topSpaceToView (_timeLB,3)
    .rightEqualToView(_timeLB)
    .heightIs(17);
    
    _lineView2.sd_layout
    .topSpaceToView ( _iconView, margin-2)
    .rightSpaceToView(contentView, 0)
    .leftSpaceToView(contentView, 0)
    .heightIs(0.5);
    
    
    _footView.sd_layout
    .topSpaceToView (_lineView2, 0)
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
    _makeLB.text = _model.orderStatusTitle;
    if ([_model.orderStatus isEqualToString:@"6"] || [_model.orderStatus isEqualToString:@"0"] ) {
        _makeLB.textColor = DETAILTEXTCOLOR;
    }else{
        _makeLB.textColor = BACKGROUND_COLORHL;
    }
    _nameLB.text = _model.productName;
    _attribute.text = [NSString stringWithFormat:@"已参与 %@",_model.joinCount];;
    [ _iconView sd_setImageWithURL:[NSURL URLWithString:model.productImgPath] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    _timeLB.text = _model.joinTimeData;
//    _priceLB.text = [NSString stringWithFormat:@"￥%@", _model.price];
    [_nameLB setMaxNumberOfLinesToShow:2];
    _footView.showType = BuyShowType;
    _footView.model = _model;
    UIView *bottomView;
    bottomView = _footView;
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:0];
}


@end
