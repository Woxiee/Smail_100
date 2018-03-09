//
//  GoodsSameFootView.m
//  MyCityProject
//
//  Created by Faker on 17/5/19.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsSameFootView.h"

@implementation GoodsSameFootView
{

    __weak IBOutlet UILabel *titlleLB;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    titlleLB.textColor = DETAILTEXTCOLOR;
    
}

@end
