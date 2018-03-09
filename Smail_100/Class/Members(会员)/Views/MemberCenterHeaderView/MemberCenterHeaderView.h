//
//  MemberCenterHeaderView.h
//  ShiShi
//
//  Created by lx on 16/3/15.
//  Copyright © 2016年 fec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberCenterHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *memberCenterBg;
@property (weak, nonatomic) IBOutlet UILabel *nickNeme;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property(nonatomic,strong) void(^ChangeHeadImage)(void);
@property (weak, nonatomic) IBOutlet UILabel *compangLB;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

+ (instancetype)membershipHeadView;

- (void)refreshInfo;
@end
