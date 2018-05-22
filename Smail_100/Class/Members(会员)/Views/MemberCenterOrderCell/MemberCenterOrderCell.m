//
//  MemberCenterOrderCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/17.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "MemberCenterOrderCell.h"

@implementation MemberCenterOrderCell
{
    NSMutableArray *titleList;
    
}
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

    titleList = [NSMutableArray new];
    NSArray *imageArray = @[@"gerenzhongxin3@3x.png",@"gerenzhongxin4@3x.png",@"gerenzhongxin5@3x.png",@"gerenzhongxin6@3x.png",@"gerenzhongxin7@3x.png",@"gerenzhongxin8@3x.png",@"gerenzhongxin9@3x.png",@"gerenzhongxin10@3x.png",];
    NSArray *titleArray = @[@"商城订单",@"线下订单",@"购物车",@"我的收藏",@"商家中心",@"创客微店",@"代理平台",@"我的团队"];
    if (KX_NULLString( [KX_UserInfo sharedKX_UserInfo].agent_level) || [[KX_UserInfo sharedKX_UserInfo].agent_level isEqualToString:@"2"]) {
        
    }
    else{
        titleArray =  @[@"商城订单",@"线下订单",@"购物车",@"我的收藏",@"商家中心",@"创客微店",@"合伙人平台",@"我的团队"];
    }
    int btnW =  SCREEN_WIDTH/4;

    for (int i = 0; i<imageArray.count; i++) {
        NSInteger index = i % 4;
        NSInteger page = i / 4;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(SCREEN_WIDTH/4*index , page*75,
                                  btnW , 75)];

        btn.tag = 100 +i;
        [btn addTarget:self action:@selector(didClickItemsAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake((btnW-25)/2, 10, 25, 25)];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        [btn addSubview:imageView];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, btn.width, 20)];
        label.text = titleArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = Font12;
        [btn addSubview:label];
        
        [titleList addObject:label];
   }
    
//    for (int i = 0; i<3; i++) {
//        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, btnW*i, SCREEN_WIDTH, 1)];
//        lineView1.backgroundColor = LINECOLOR;
//
//        [self addSubview:lineView1];
//        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake( btnW+btnW*i, 0, 1, btnW*2)];
//        lineView2.backgroundColor = LINECOLOR;
//        [self addSubview:lineView2];
//
//    }


}

/// 点击
- (void)didClickItemsAction:(UIButton *)sender
{
    if (self.orderItemsBlock) {
        self.orderItemsBlock(sender.tag - 100);
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    NSArray *titleArrays = @[@"商城订单",@"线下订单",@"购物车",@"我的收藏",@"商家中心",@"创客微店",@"代理平台",@"我的团队"];
    if (KX_NULLString( [KX_UserInfo sharedKX_UserInfo].agent_level) || [[KX_UserInfo sharedKX_UserInfo].agent_level isEqualToString:@"2"]) {
        
    }
    else{
        titleArrays =  @[@"商城订单",@"线下订单",@"购物车",@"我的收藏",@"商家中心",@"创客微店",@"合伙人平台",@"我的团队"];
    }
    for (int i = 0; i<titleList.count; i++) {
        UILabel *lb = titleList[i];
        lb.text = titleArrays[i];
    }
   
    
}



@end
