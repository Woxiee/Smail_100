//
//  MeOrderGoodsCell.m
//  Smile_100
//
//  Created by ap on 2018/2/27.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MeOrderGoodsCell.h"

@implementation MeOrderGoodsCell
{
    __weak IBOutlet UIImageView *imageView;
    
    __weak IBOutlet UILabel *titleLB;
    
    __weak IBOutlet UILabel *pirceLB;
    
    __weak IBOutlet UILabel *timeLB;
    
    __weak IBOutlet UILabel *numberLB;
}


- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setup
{
    pirceLB.textColor = KMAINCOLOR;
    numberLB.textColor = KMAINCOLOR;
}

@end
