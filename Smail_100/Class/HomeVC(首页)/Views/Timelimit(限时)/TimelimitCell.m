//
//  TimelimitCell.m
//  Smile_100
//
//  Created by Faker on 2018/2/9.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "TimelimitCell.h"

@implementation TimelimitCell
{
    
    __weak IBOutlet UIImageView *imgeView;
    
    __weak IBOutlet UILabel *titleLB;
    
    __weak IBOutlet UILabel *priceLb;
    
    __weak IBOutlet UILabel *oldPriceLB;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
//    [self setup];
    [self setConfiguration];
}


- (void)setConfiguration
{
    self.backgroundColor = [UIColor whiteColor];
    priceLb.textColor = KMAINCOLOR;
    oldPriceLB.textColor = TITLETEXTLOWCOLOR;
}



-(void)setModel:(ItemContentList *)model
{
    _model = model;
    [imgeView sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    titleLB.text = [NSString stringWithFormat:@"%@",_model.clickUrl];
    priceLb.text = [NSString stringWithFormat:@"%@积分",_model.earn_point];
    if ([_model.itemSubTitle intValue] >0) {
        oldPriceLB.hidden = NO;
    }
    else{
        oldPriceLB.hidden = YES;
    }
    oldPriceLB.text = [NSString stringWithFormat:@"+￥%@",_model.itemSubTitle];
}


@end
