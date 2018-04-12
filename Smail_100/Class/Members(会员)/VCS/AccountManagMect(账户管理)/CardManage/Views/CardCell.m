//
//  CardCell.m
//  Smail_100
//
//  Created by ap on 2018/4/12.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "CardCell.h"

@implementation CardCell
{
    __weak IBOutlet UILabel *nameLB;
    
    __weak IBOutlet UILabel *codelb;
    
    __weak IBOutlet UIButton *setDeflutBtn;
    
    __weak IBOutlet UIButton *deleteBtn;
}


- (void)awakeFromNib {
    [super awakeFromNib];
  
}





@end
