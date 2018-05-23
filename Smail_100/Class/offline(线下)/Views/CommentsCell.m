//
//  CommentsCell.m
//  GSD-App
//
//  Created by ap on 2018/3/27.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "CommentsCell.h"
#import "DQStarView.h"
@interface CommentsCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIButton *nameBtn;
@property (nonatomic, strong) DQStarView *starView;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *contenLb;
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation CommentsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}



- (void)setup
{

    
    _iconImageView = [UIImageView new];
    
    _nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nameBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    _nameBtn.titleLabel.font = KY_FONT(14);
    _nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;


    
    _starView = [[DQStarView alloc] initWithDQStarFrme:CGRectMake(10, 11, 100, 12) starTotal:5];
    _starView.starTotalCount = 5;
    _starView.userInteractionEnabled = NO;
    _starView.ShowStyle = DQStarShowStyleSingleClick;
    
    _timeLb = [UILabel new];
    _timeLb.font = Font12;
    _timeLb.textAlignment = NSTextAlignmentRight;
    _timeLb.textColor = DETAILTEXTCOLOR;
    
    _contenLb = [UILabel new];
    _contenLb.font = Font15;
    _contenLb.textAlignment = NSTextAlignmentLeft;
    _contenLb.textColor = DETAILTEXTCOLOR;
    
    _lineView = [UIView new];
    _lineView.backgroundColor = LINECOLOR;
    
   [self.contentView sd_addSubviews:@[_iconImageView,_nameBtn,_starView,_timeLb,_contenLb,_lineView]];
    
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    _iconImageView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin+3)
    .heightIs(44)
    .widthIs(44);
    [_iconImageView layerForViewWith:22 AndLineWidth:0];
    
    
    _timeLb.sd_layout
    .rightSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin+5)
    .heightIs(10)
    .widthIs(200);
    
    _nameBtn.sd_layout
    .leftSpaceToView(_iconImageView, margin -2)
    .topSpaceToView(contentView, margin)
    .rightSpaceToView(contentView , 100)
    .heightIs(15);

    
    
    _starView.sd_layout
    .leftSpaceToView(_iconImageView, margin -4)
    .topSpaceToView(_nameBtn, 3)
    .heightIs(12)
    .widthIs(100);

    _contenLb.sd_layout
    .leftEqualToView(_nameBtn)
    .topSpaceToView(_starView, 3)
    .rightSpaceToView(contentView,20)
    .autoHeightRatio(0);
    
    
    _lineView.sd_layout
    .leftSpaceToView(contentView,0)
    .topSpaceToView(_contenLb, 3)
    .rightSpaceToView(contentView,0)
    .heightIs(1);
}


- (void)setModel:(Comment *)model
{
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.avatar_url] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    [_nameBtn setTitle:_model.namestring forState:UIControlStateNormal];
    _timeLb.text = _model.ctime;
    [_starView ShowDQStarScoreFunction:[_model.stars floatValue]/20];
    _contenLb.text = _model.comment;
    [self setupAutoHeightWithBottomView:_lineView bottomMargin:10];

}

@end
