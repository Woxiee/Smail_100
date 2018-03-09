//
//  GoodGuigeCell.m
//  ShiShi
//
//  Created by Faker on 17/3/9.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "GoodGuigeCell.h"

@implementation GoodGuigeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = DETAILTEXTCOLOR;
    self.titleLabel.font = Font12;
}


- (void)setModel:(Values *)model
{
    _model = model;
    _titleLabel.text = _model.name;
    if (_model.isSelect ) {
        
        self.titleLabel.textColor = BACKGROUND_COLORHL;
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        [self.titleLabel layerWithRadius:2 lineWidth:0.5 color:BACKGROUND_COLORHL];

    }else{
        [self.titleLabel layerForViewWith:3 AndLineWidth:0];
        self.titleLabel.textColor = TITLETEXTLOWCOLOR;
        self.titleLabel.backgroundColor = RGB(238, 238, 238);


    }
}

- (void)setAttrModel:(AttrValue *)attrModel
{
    _attrModel = attrModel;
    
    _titleLabel.text = _attrModel.attrValueName;
    if (_attrModel.isSelect ) {
        
        self.titleLabel.textColor = BACKGROUND_COLORHL;
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        [self.titleLabel layerForViewWithRadius:3 AndLineWidth:1 AndColor:BACKGROUND_COLORHL];
        
    }else{
        
        [self.titleLabel layerForViewWith:3 AndLineWidth:0];
        self.titleLabel.textColor = TITLETEXTLOWCOLOR;
        self.titleLabel.backgroundColor = RGB(238, 238, 238);
        
        
    }
}
@end
