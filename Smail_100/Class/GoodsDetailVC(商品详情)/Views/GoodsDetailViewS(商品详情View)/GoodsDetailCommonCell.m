//
//  GoodsDetailCommonCell.m
//  ShiShi
//
//  Created by Faker on 17/3/10.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "GoodsDetailCommonCell.h"
#import "SDWeiXinPhotoContainerView.h"

@implementation GoodsDetailCommonCell
{
    UILabel *_nameLable;                               //姓名
    UIImageView *_scoreView;                           //已完成评分状态
    UILabel *_dateLabel;                               //时间
    UIView *_lineView;                                  //线
    UILabel *_contenLabel;                             //评价内容
    UILabel *_scoreLabel;                             //评分值

    

    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];

    }
    return self;
}

/// 初始化视图
- (void)setup
{
    _nameLable = [UILabel new];
    _nameLable.font = [UIFont systemFontOfSize:15];
    _nameLable.textColor = DETAILTEXTCOLOR;
    
    _contenLabel = [UILabel new];
    _contenLabel.font = PLACEHOLDERFONT;
    _contenLabel.textColor = TITLETEXTLOWCOLOR;
  
    _scoreView = [UIImageView new];
    
    _scoreLabel = [UILabel new];
    _scoreLabel.font = Font13;
    _scoreLabel.textColor = TITLETEXTLOWCOLOR;
  
    _dateLabel = [UILabel new];
    _dateLabel.textColor = DETAILTEXTCOLOR;
    _dateLabel.font = Font13;
    
    _lineView = [UIView new];
    _lineView.backgroundColor = LINECOLOR;
    
    NSArray *views = @[_nameLable,_dateLabel,_scoreView,_scoreLabel,_lineView,_contenLabel];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 12;

    _nameLable.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin)
    .rightSpaceToView(contentView, margin)
    .heightIs(18);
    
    _contenLabel.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_nameLable, margin)
    .rightEqualToView(_nameLable)
    .autoHeightRatio(0);
    
    _scoreView.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_contenLabel, margin *2)
    .widthIs(100)
    .heightIs(margin +4);
    
    _scoreLabel.sd_layout
    .leftSpaceToView(_scoreView,margin/2)
    .topEqualToView(_scoreView)
    .widthIs(61)
    .heightIs(margin +5);
    
    _dateLabel.sd_layout
    .rightSpaceToView(contentView, margin)
    .topEqualToView(_scoreView)
    .heightIs(18);
    [_dateLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _lineView.sd_layout
    .leftSpaceToView(contentView,0)
    .rightSpaceToView(contentView, 0)
    .topSpaceToView(_dateLabel , margin +3)
    .heightIs(0.5);
 
}

-(void)setModel:(CommentModel *)model
{
    _model = model;
    NSArray *starArray = @[@"star1",@"star2",@"star3",@"star4",@"star5"];
    _nameLable.text = _model.nickName;
    if (KX_NULLString(_model.target1)) {
        _model.target1 = @"1";
    }
    _scoreView.image = [UIImage imageNamed:[starArray objectAtIndex:[_model.target1 intValue] - 1]];
    _dateLabel.text = _model.createTimeData;
    _contenLabel.text  =_model.commentContent;
    _scoreLabel.text = [NSString stringWithFormat:@"%@.0分",_model.target1];
     UIView *bottomView;
    bottomView = _lineView;
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:0];

}

/// 查看更多
- (void)didClickMoreInfoAction
{
    if (_didClickMoreBtnBlock) {
        _didClickMoreBtnBlock();
    }

}

@end
