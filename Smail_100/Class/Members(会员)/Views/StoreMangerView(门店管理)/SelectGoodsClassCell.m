//
//  SelectGoodsClassCell.m
//  Smail_100
//
//  Created by ap on 2018/3/20.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SelectGoodsClassCell.h"

@interface SelectGoodsClassCell ()
//@property (strong, nonatomic)  UILabel *titleLB;
//
//@property (strong, nonatomic)  UIImageView *markImagView;

@end

@implementation SelectGoodsClassCell
{
    
    __weak IBOutlet UILabel *titleLB;

    __weak IBOutlet UIImageView *markImagView;
//

}



- (void)awakeFromNib {
    [super awakeFromNib];
    titleLB.textColor = TITLETEXTLOWCOLOR;
}


//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 50, 50)];
//        _titleLB.font = KY_FONT(15);
//        _titleLB.textColor = TITLETEXTLOWCOLOR;
//        [self.contentView addSubview:_titleLB];
//    }
//    return self;
//}


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
