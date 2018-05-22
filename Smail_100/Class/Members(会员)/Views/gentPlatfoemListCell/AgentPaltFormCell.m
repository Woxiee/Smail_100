//
//  AgentPaltFormCell.m
//  Smail_100
//
//  Created by ap on 2018/5/17.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AgentPaltFormCell.h"

@implementation AgentPaltFormCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        
    }
    
    return self;
}


/// 初始化视图
- (void)setup
{
    NSArray *imageArray = @[@"hehuorenpingtai1@3x.png",@"hehuorenpingtai2@3x.png",@"hehuorenIcon@2x.png",@"hehuorenpingtai4@3x.png",@"hehuorenpingtai3@3x.png",@"hehuorenpingtai5@3x.png",];
    NSArray *titleArray = @[@"团队管理",@"代理激励",@"合伙人列表",@"开通商家",@"商家列表",@"使用帮助"];
    if ([KX_UserInfo sharedKX_UserInfo].agent_level.integerValue == 3) {
        imageArray = @[@"hehuorenpingtai1@3x.png",@"hehuorenpingtai2@3x.png",@"hehuorenpingtai4@3x.png",@"hehuorenpingtai3@3x.png",@"hehuorenpingtai5@3x.png",];
      titleArray = @[@"团队管理",@"合伙人激励",@"开通商家",@"商家列表",@"使用帮助"];

    }
    int btnW =  SCREEN_WIDTH/4;
    for (int i = 0; i<imageArray.count; i++) {
        NSInteger index = i % 4;
        NSInteger page = i / 4;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(SCREEN_WIDTH/4*index , page*75+ 0,
                                 btnW , 75)];
        [btn setTitle: titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        btn.tag = 100 +i;
        [btn addTarget:self action:@selector(didClickItemsAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake((btnW-25)/2, 10, 25, 25)];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        [btn addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, btn.width, 20)];
        label.text = titleArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = TITLETEXTLOWCOLOR;
        label.font = Font14;
        [btn addSubview:label];
        
    }
    
    
}

/// 点击
- (void)didClickItemsAction:(UIButton *)sender
{
    if (self.didClickOrderItemsBlock) {
        self.didClickOrderItemsBlock(sender.titleLabel.text);
    }
}


@end
