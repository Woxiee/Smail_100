//
//  KYBaseCell.m
//  KYBaseCell
//
//  Created by mac_KY on 17/3/3.
//  Copyright © 2017年 mac_KY. All rights reserved.
//

#import "KYBaseCell.h"

@implementation KYBaseCell
{
    
    __weak IBOutlet UIView *rightView;
    __weak IBOutlet UIImageView *rightImageV;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated]; 
}

-(void)setBaseItem:(KYBaseCellItem *)baseItem
{
    _baseItem = baseItem;
    //判断样式
    if (baseItem.selectRightIcom.length>0) {
        [self loadSelectRightCell];//这个需要自定义比较特殊
         
    }else{
           [rightView removeFromSuperview];
    }
 
    if (baseItem.imgName.length>0) {
        self.imageView.image = [UIImage imageNamed:baseItem.imgName];
    }
    if (baseItem.title.length>0) {
        self.textLabel.text = baseItem.title;
    }
    if (baseItem.subTitle.length>0) {
        self.detailTextLabel.text  = baseItem.subTitle;
    }
    
}

-(void)loadSelectRightCell{
   
    //需要约束  xib
    rightImageV.image = [UIImage imageNamed:_baseItem.selectRightIcom];
   
    rightImageV.hidden = !_baseItem.cellSelect;
 
    
    
}



@end
