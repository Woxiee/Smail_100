//
//  SelectGoodsClassCell.m
//  Smail_100
//
//  Created by ap on 2018/3/20.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SelectGoodsClassCell.h"
@implementation SelectGoodsClassCell
{
    
    __weak IBOutlet UILabel *titleLB;
    
    __weak IBOutlet UIImageView *markImagView;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
}



- (void)setModel:(ChildModel *)model
{
    _model = model;
    titleLB.text = _model.name;
    if (_model.isSelect) {
        markImagView.hidden = NO;
        
    }else{
        markImagView.hidden =  YES;

    }
}

@end
