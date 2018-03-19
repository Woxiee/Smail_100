//
//  OfflineInfoDetailCell.m
//  Smail_100
//
//  Created by ap on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "OfflineInfoDetailCell.h"

@implementation OfflineInfoDetailCell
{
    __weak IBOutlet UILabel *storeLb;
    __weak IBOutlet  UIImageView *_starImageView;
    __weak IBOutlet UILabel *_commNumberLB;
    __weak IBOutlet UILabel *addressLB;
    __weak IBOutlet UILabel *distanceLB;
    __weak IBOutlet UIButton *findLb;
    __weak IBOutlet UILabel *tellLB;
    __weak IBOutlet UILabel *timeLB;
    __weak IBOutlet UIButton *lookBtn;
    __weak IBOutlet UILabel *mianLb;
    __weak IBOutlet UILabel *commentLb;
    __weak IBOutlet UIButton *commentBtn;
    
    
    __weak IBOutlet UIImageView *iconImageView;
    __weak IBOutlet UILabel *nameLb;
    __weak IBOutlet UILabel *comDate;
    __weak IBOutlet UIImageView *gradeImageView;
    __weak IBOutlet UILabel *commTextLb;
    
    
    __weak IBOutlet UIView *_lineView;
    __weak IBOutlet UIView *_lineView1;
    __weak IBOutlet UIView *_lineView2;
    __weak IBOutlet UIView *_lineView3;
    __weak IBOutlet UIView *_lineView4;
    __weak IBOutlet UIView *_lineView5;
    __weak IBOutlet UIView *_lineView6;
    __weak IBOutlet UIView *_lineView7;
    __weak IBOutlet UIView *_lineView8;
    

}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUI];
}



- (void)setUI
{
    [lookBtn setTitleColor:KMAINCOLOR forState:UIControlStateNormal];
    [lookBtn layerWithRadius:6 lineWidth:1 color:KMAINCOLOR];
    
}


- (void)setModel:(OffLineModel *)model
{
    _model = model;
    
    
}
- (IBAction)didClickInfoAction:(UIButton *)sender {
    if (self.didClickInfoCellBlock) {
        self.didClickInfoCellBlock(sender.tag - 100);
    }
    
}

@end
