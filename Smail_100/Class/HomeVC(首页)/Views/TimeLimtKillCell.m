//
//  TimeLimtKillCell.m
//  Smile_100
//
//  Created by Faker on 2018/2/9.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "TimeLimtKillCell.h"
#import "FLCountDownView.h"
@interface TimeLimtKillCell ()
//@property (nonatomic, strong) ItemContentList *model;
@property (weak, nonatomic) IBOutlet FLCountDownView *timeView;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@end

@implementation TimeLimtKillCell
{
    
    __weak IBOutlet UILabel *TitleLB;
    __weak IBOutlet UIImageView *imgview1;
    
    __weak IBOutlet UIImageView *imgView2;
    
    __weak IBOutlet UIImageView *imgView3;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    TitleLB.textColor = KMAINCOLOR;
    [_moreBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    [_moreBtn setImage:[UIImage imageNamed:@"shouye30@3x.png"] forState:UIControlStateNormal];
    [_moreBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:1];
    _timeView.timestamp = 3421123/1000;
    _timeView.isLoast = YES;

}


- (void)setModelArray:(NSArray *)modelArray
{
    _modelArray = modelArray;
    if (_modelArray.count <3) return;
    [imgview1 sd_setImageWithURL:[NSURL URLWithString:_modelArray[0]] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    [imgView2 sd_setImageWithURL:[NSURL URLWithString:_modelArray[1]] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    [imgView3 sd_setImageWithURL:[NSURL URLWithString:_modelArray[2]] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];

}



@end
