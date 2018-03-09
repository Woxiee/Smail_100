//
//  HomeHeaderView.h
//  ShiShi
//
//  Created by ac on 16/3/24.
//  Copyright © 2016年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLCountDownView.h"
#import "ItemContentList.h"

@interface HomeHeaderView : UICollectionReusableView
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

//@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (nonatomic, copy) void(^didClickMoreBtnBlock)();
//@property (weak, nonatomic) IBOutlet FLCountDownView *timeView;
//@property (weak, nonatomic) IBOutlet UILabel *detailLB;
//@property (nonatomic, strong) ItemContentList *model;



@end
