//
//  LineOffGoodsCell.m
//  Smile_100
//
//  Created by ap on 2018/3/6.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "LineOffGoodsCell.h"

@implementation LineOffGoodsCell
{
    __weak IBOutlet UILabel *titleLB;
    __weak IBOutlet UIImageView *scoreImageView;
    
    __weak IBOutlet UILabel *storeLb;
    
    __weak IBOutlet UILabel *distanceLB;
    
    __weak IBOutlet UILabel *telLb;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}


- (void)setup
{
    storeLb.textColor = DETAILTEXTCOLOR;
    telLb.textColor = DETAILTEXTCOLOR;
    distanceLB.textColor = DETAILTEXTCOLOR;
}



@end
