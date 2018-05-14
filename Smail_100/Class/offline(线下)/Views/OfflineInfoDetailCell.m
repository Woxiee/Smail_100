//
//  OfflineInfoDetailCell.m
//  Smail_100
//
//  Created by ap on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "OfflineInfoDetailCell.h"
#import "DQStarView.h"
@implementation OfflineInfoDetailCell
{
    __weak IBOutlet UILabel *storeLb;
    
    __weak IBOutlet DQStarView *_starImageView;
    __weak IBOutlet UILabel *_commNumberLB;
    __weak IBOutlet UILabel *addressLB;
    __weak IBOutlet UILabel *distanceLB;
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
    

    __weak IBOutlet UILabel *jifePointLB;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUI];
}



- (void)setUI
{
    [lookBtn setTitleColor:KMAINCOLOR forState:UIControlStateNormal];
    [lookBtn layerWithRadius:6 lineWidth:1 color:KMAINCOLOR];
    [_findLb setImage:[UIImage imageNamed:@"xianxiashangjia7@3x.png"] forState:UIControlStateNormal];
    [_findLb setTitle:@"到这里去" forState:UIControlStateNormal];
    _findLb.titleLabel.font = KY_FONT(8);
    [_findLb setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    [_findLb layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:2];
    
//    distanceLB.textColor = TITLETEXTLOWCOLOR;
//    tellLB.textColor = TITLETEXTLOWCOLOR;
//    timeLB.textColor = TITLETEXTLOWCOLOR;

}


- (void)setModel:(OfflineDetailModel *)model
{
    _model = model;
    storeLb.text = _model.shop_name;
//    _starImageView
    addressLB.text = [NSString stringWithFormat:@"%@%@%@%@",_model.province,_model.city,_model.district,_model.address];
    float distance = _model.distance.floatValue/10000;
    if (_model.distance.floatValue >1000) {
        distanceLB.text =  [NSString stringWithFormat:@"%.2fkm",distance];
        
    }else{
        distanceLB.hidden = YES;
        distanceLB.text =  [NSString stringWithFormat:@"%@m",_model.distance];
    }
    
    
   
    tellLB.text = _model.contact_phone;
    
    timeLB.text = [NSString stringWithFormat:@"营业时间: %@",_model.ontime_scope];
    mianLb.text = _model.business_info;
    mianLb.textColor = DETAILTEXTCOLOR;
   _commNumberLB.text= [NSString stringWithFormat:@"%@评价",_model.comment_count];
    
    
    jifePointLB.text = [NSString stringWithFormat:@"赠送积分比例: %@",_model.ontime_scope];
    [_starImageView ShowDQStarScoreFunction:[_model.stars intValue]];
   
    
}

- (IBAction)didClickCallAction:(id)sender {
    SuccessView *successV = [[SuccessView alloc] initWithTrueCancleTitle:@"确定拨打商家电话吗?" cancelTitle:@"取消" clickDex:^(NSInteger clickDex) {
        if (clickDex == 1) {
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_model.contact_phone]]];
            
        }}];
    [successV showSuccess];
    
}


- (IBAction)didClickInfoAction:(UIButton *)sender {
    if (self.didClickInfoCellBlock) {
        self.didClickInfoCellBlock(sender.tag - 100);
    }
    
}

@end
