//
//  MyTeamListCell.m
//  Smile_100
//
//  Created by ap on 2018/2/24.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MyTeamListCell.h"




@implementation MyTeamListCell
{
    __weak IBOutlet UIView *lineView;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    lineView.backgroundColor = LINECOLOR;
}


@end
