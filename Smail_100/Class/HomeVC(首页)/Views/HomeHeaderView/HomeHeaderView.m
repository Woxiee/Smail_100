//
//  HomeHeaderView.m
//  ShiShi
//
//  Created by ac on 16/3/24.
//  Copyright © 2016年 fec. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView ()
//@property (weak, nonatomic) IBOutlet UIButton *titleBtn;

@property (weak, nonatomic) IBOutlet FLCountDownView *timeView;
@property (weak, nonatomic) IBOutlet UILabel *detailLB;
@property (nonatomic, strong) ItemContentList *model;
@property (weak, nonatomic) IBOutlet UIView *lineView;



@end



@implementation HomeHeaderView



- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    _titleLabel.textColor = KMAINCOLOR;
     [_moreBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    [_moreBtn setImage:[UIImage imageNamed:@"shouye30@3x.png"] forState:UIControlStateNormal];
    [_moreBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:3];
    _lineView.backgroundColor = LINECOLOR;
    _timeView.timestamp = 3421123/1000;

}

-(void)setModel:(ItemContentList *)model
{
    _model = model;
//    [imgeView sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
//    titleLB.text = _model.clickUrl;
//    priceLb.text = _model.itemTitle;
//    oldPriceLB.text = _model.itemSubTitle;
    
    _detailLB.text = @"离20点场还剩";
    _timeView.timestamp = 3421123/1000;

}



- (IBAction)didClickMoreBtn:(UIButton *)sender {
    if (self.didClickMoreBtnBlock) {
        self.didClickMoreBtnBlock();
    }
}


- (void)stopTimer
{
    [_timeView stop];
}

@end
