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


- (void)setModel:(OfflineDetailModel *)model
{
    _model = model;
    storeLb.text = _model.shop_name;
//    _starImageView
    _commNumberLB.text = [NSString stringWithFormat:@"%@",_model.comment_count];
    addressLB.text = [NSString stringWithFormat:@"%@%@%@%@",_model.province,_model.city,_model.district,_model.address];
    distanceLB.text =  [NSString stringWithFormat:@"%@米",_model.distance];
    [findLb setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [findLb setTitle:@"到这里去" forState:UIControlStateNormal];
    findLb.titleLabel.font = KY_FONT(10);
    [findLb setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    [findLb layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:2];
    
    tellLB.text = _model.contact_phone;
    timeLB.text = [NSString stringWithFormat:@"营业时间: %@",@"08:00-23:00"];
    mianLb.text = _model.business_info;
    
    commentLb.text = [NSString stringWithFormat:@"%@人评价",_model.comment_count];
    if (_model.comment.count >0) {
        Comment *item = _model.comment[0];
        
        nameLb.text = @"测试";
        commTextLb.text = item.comment;
        comDate.text = item.ctime;
        
    }

    
    
}
- (IBAction)didClickInfoAction:(UIButton *)sender {
    if (self.didClickInfoCellBlock) {
        self.didClickInfoCellBlock(sender.tag - 100);
    }
    
}

@end
