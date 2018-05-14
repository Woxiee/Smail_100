//
//  MyRecommendCell.m
//  Smile_100
//
//  Created by ap on 2018/2/26.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MyRecommendCell.h"

@interface MyRecommendCell ()
@property (weak, nonatomic) IBOutlet UILabel *title1LB;

@property (weak, nonatomic) IBOutlet UILabel *title2LB;

@property (weak, nonatomic) IBOutlet UIButton *RommendBtn;
@end

@implementation MyRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _title1LB.textColor = DETAILTEXTCOLOR;
    _title2LB.textColor = DETAILTEXTCOLOR;
    [_RommendBtn setTitleColor:KMAINCOLOR forState:UIControlStateNormal];

    [_RommendBtn layerWithRadius:8 lineWidth:1 color:KMAINCOLOR];
    
    
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
}


- (IBAction)didClickAction:(id)sender {
    
}

- (void)setModel:(MyteamModel *)model
{
    _model = model;
    _title1LB.text = _model.content.msg;

    _title2LB.text = [NSString stringWithFormat:@"您的推荐人是: %@",_model.content.pinfo];
    
    
    
}
@end
