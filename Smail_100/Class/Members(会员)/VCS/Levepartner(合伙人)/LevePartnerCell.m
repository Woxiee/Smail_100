//
//  LevePartnerCell.m
//  Smail_100
//
//  Created by Faker on 2018/4/7.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "LevePartnerCell.h"

@implementation LevePartnerCell
{
    
    __weak IBOutlet UIImageView *logoImageView;
    __weak IBOutlet UILabel *titleLb;
    
    __weak IBOutlet UIView *tagsView;
    __weak IBOutlet NSLayoutConstraint *tagsViewConshightContens;
    
    __weak IBOutlet UILabel *pirceLB;
    
    __weak IBOutlet UILabel *jfLB;
    
    __weak IBOutlet UILabel *saleLB;
    __weak IBOutlet UIButton *delegateBtn;
    __weak IBOutlet UIView *lineView;
    
    
}





- (void)awakeFromNib {
    [super awakeFromNib];
    pirceLB.textColor = KMAINCOLOR;
    jfLB.textColor = TITLETEXTLOWCOLOR;
    saleLB.textColor = DETAILTEXTCOLOR1;
    [delegateBtn setTitle:@"立即成为合伙人 >" forState:UIControlStateNormal];
    [delegateBtn layerForViewWith:8 AndLineWidth:0];
    [delegateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    delegateBtn.backgroundColor = KMAINCOLOR;
    lineView.backgroundColor = LINECOLOR;
}

- (void)setItemContentList:(ItemContentList *)itemContentList
{
    _itemContentList = itemContentList;
    [logoImageView sd_setImageWithURL:[NSURL URLWithString:_itemContentList.imageUrl] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    titleLb.text = _itemContentList.itemTitle;

    if ([_itemContentList.earn_point floatValue] <= 0) {
        jfLB.hidden = YES;
    }
    pirceLB.text = [NSString stringWithFormat:@"¥%@",_itemContentList.price];
    
    jfLB.text = [NSString stringWithFormat:@"送%@积分",_itemContentList.earn_point];
    
    saleLB.text = [NSString stringWithFormat:@"已售出: %@",_itemContentList.store_nums];
    
    if (_itemContentList.showType.integerValue == 2) {
        saleLB.text = [NSString stringWithFormat:@"已兑换: %@",_itemContentList.volume];
        [delegateBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    }
        
}

- (IBAction)delegateAction:(id)sender {
    if (_didClickItemBlock) {
        _didClickItemBlock(_itemContentList.goods_id);
    }
    
}

@end
