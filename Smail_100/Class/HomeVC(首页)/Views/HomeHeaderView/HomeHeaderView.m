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
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIView *lineView1;


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
    
    _lineView1.backgroundColor = LINECOLOR;
//    _timeView.timestamp = 3421123/1000;
    _timeView.backgroundColor = [UIColor clearColor];
    _timeView.hidden = YES;

}


-(void)setModel:(ItemContentList *)model
{
    _model = model;
    _detailLB.text = @"";
//    _detailLB.text = _model.next_msg;
//    _timeView.timestamp = [_model.next_time integerValue]/1000;
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
