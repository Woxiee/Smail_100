//
//  GoodsCategoryCollectionHeader.m
//  ShiShi
//
//  Created by mac_KY on 17/3/8.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "GoodsCategoryCollectionHeader.h"

@interface GoodsCategoryCollectionHeader()
@property (weak, nonatomic) IBOutlet UIButton *headViewBtn;

@end

@implementation GoodsCategoryCollectionHeader


- (void)awakeFromNib {
    [super awakeFromNib];
    _titleLB.textColor = TITLETEXTLOWCOLOR;
    _titleLB.font = PLACEHOLDERFONT;
    self.backgroundColor = BACKGROUND_COLOR;
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
}

- (void)setModel:(Values *)model
{
    _model = model;
    _titleLB.text = model.name;
    
}


- (IBAction)didClickHeadBtn:(id)sender {
    if (_didClickHeadViewBtnBlock) {
        _didClickHeadViewBtnBlock(_indexPath.section);
    }
    
}




@end
