//
//  GoodsCategoryCell.m
//  ShiShi
//
//  Created by mac_KY on 17/3/8.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "GoodsCategoryCell.h"

@implementation GoodsCategoryCell
{
    __weak IBOutlet UILabel *listNameLb;
    
    __weak IBOutlet UIView *lineView;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = BACKGROUND_COLOR;

}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *listNameLbs = [[UILabel alloc] initWithFrame:CGRectMake(12, 20,100 - 24, 20)];
        listNameLbs.font = Font15;
        listNameLbs.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:listNameLbs];
        [self.contentView showBadgeWithStyle:WBadgeStyleNumber value:0 animationType:WBadgeAnimTypeNone];

        listNameLb = listNameLbs;
        self.contentView.backgroundColor = BACKGROUND_COLOR;

    }
    return self;
}


-(void)setModel:(LeftCategory *)model
{
    _model = model;
 
    self.contentView.backgroundColor = BACKGROUND_COLOR;

    listNameLb.text = [NSString stringWithFormat:@"%@   ",model.name];
    listNameLb.textColor = model.select?TITLETEXTLOWCOLOR:DETAILTEXTCOLOR;
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.alpha = 1;
    //    lineView.hidden = YES;
    [self.contentView showBadgeWithStyle:WBadgeStyleNumber value:[_model.nums integerValue] animationType:WBadgeAnimTypeNone];
    self.contentView.badgeCenterOffset = CGPointMake(-25, 9);

    if (model.select) {
        listNameLb.textColor = [UIColor whiteColor];
        listNameLb.backgroundColor = KMAINCOLOR;
        [listNameLb layerForViewWith:4 AndLineWidth:0];
    }else{
        listNameLb.textColor = TITLETEXTLOWCOLOR;
        [listNameLb layerForViewWith:0 AndLineWidth:0];
        listNameLb.backgroundColor = BACKGROUND_COLOR;
    }
    
    
    
}

@end
