//
//  GoodSOrderCommonCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/22.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodSOrderCommonCell.h"

@implementation GoodSOrderCommonCell
{

    
    
    __weak IBOutlet UIView *lineView;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    _titleLB.textColor= DETAILTEXTCOLOR;
    _titleLB.font = PLACEHOLDERFONT;
    
    _detailLB.textColor= DETAILTEXTCOLOR;
    _detailLB.font = PLACEHOLDERFONT;
    
    lineView.backgroundColor = LINECOLOR;
}

@end
