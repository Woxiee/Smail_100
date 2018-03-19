//
//  RighMeumtCell.m
//  Smail_100
//
//  Created by ap on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "RighMeumtCell.h"

@implementation RighMeumtCell
{
    __weak IBOutlet UILabel *seleNum;
    __weak IBOutlet UILabel *priceLable;
    __weak IBOutlet UIImageView *headImage;
    __weak IBOutlet UILabel *nameLable;
    
    __weak IBOutlet UIButton *reduceBtn;
    __weak IBOutlet UIButton *addBtn;
    __weak IBOutlet UILabel *countLb;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    nameLable.textColor = TITLETEXTLOWCOLOR;
    //    goodCommom.textColor = DETAILTEXTCOLOR;
    priceLable.textColor = KMAINCOLOR;
    seleNum.textColor = DETAILTEXTCOLOR;
    countLb.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickInput)];
    [countLb addGestureRecognizer:tap];}

- (IBAction)addToShoppingCar:(UIButton *)sender {
    
    if (_cellAdd) {
        _cellAdd();
    }
}

- (IBAction)clickreduceToShoppingCar:(id)sender {
    
    if (_cellReduce) {
        _cellReduce();
    }
}

-(void)clickInput{
    
    if (_cellInputText) {
        _cellInputText();
    }
    
}

@end
