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
    __weak IBOutlet UIImageView *bgImageView;
    __weak IBOutlet UILabel *nameLB;
    
    __weak IBOutlet UILabel *codelb;
    
    __weak IBOutlet UIButton *setDeflutBtn;
    
    __weak IBOutlet UIButton *deleteBtn;
}




- (void)awakeFromNib {
    [super awakeFromNib];
  
}


- (void)setModel:(CardModel *)model
{
    _model = model;
    nameLB.text = _model.bank_name;
    
    codelb.text = _model.bank_account;
    if ([_model.is_default isEqualToString:@"Y"]) {
        [setDeflutBtn setImage:[UIImage imageNamed:@"zhanghuguanli9@3x.png"] forState:UIControlStateNormal];

    }else{
        [setDeflutBtn setImage:[UIImage imageNamed:@"zhanghuguanli19@3x.png"] forState:UIControlStateNormal];

    }
    
    
    
}


- (IBAction)didSetDefBtn:(id)sender {
    
    if (self.didClickItemBlcok) {
        self.didClickItemBlcok(_model, 0);
    }
}


- (IBAction)deleteBtn:(id)sender {
    self.didClickItemBlcok(_model, 1);

}


- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
     int i = indexPath.section%4 ;
    NSArray  *imageList = @[@"zhanghuguanli13@3x.png",@"zhanghuguanli14@3x.png",@"zhanghuguanli15@3x.png",@"zhanghuguanli16@3x.png"];
    
    bgImageView.image = [UIImage imageNamed:imageList[i]];
}



@end
