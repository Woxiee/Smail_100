//
//  AgentPlatformVC.m
//  Smail_100
//
//  Created by ap on 2018/3/21.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AgentPlatformVC.h"
#import "AgentPlatfoemMainVC.h"

@interface AgentPlatformVC ()

@end

@implementation AgentPlatformVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    
}


#pragma mark - request
- (void)getRequestData
{
    
    
}

#pragma mark - private
- (void)setup
{
    self.title  = @"代理平台";
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    headView.backgroundColor = KMAINCOLOR;
    [self.view addSubview:headView];
    
    UIView *head1View = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), SCREEN_WIDTH, 60)];
    head1View.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:head1View];
    
    NSArray *listArr = @[@"推荐人数",@"本月营业额(元) ",@"总营业额(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "];
    NSArray *numberArr = @[@"8888",@"18888",@"888888                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "];

    for (NSInteger i = 0; i < 3; i++) {
        UILabel *numberLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, 10, SCREEN_WIDTH / 3, 20)];
        numberLB.text = numberArr[i];
        numberLB.font = [UIFont systemFontOfSize:22];
        numberLB.textColor = KMAINCOLOR;
        numberLB.textAlignment = NSTextAlignmentCenter;
        [head1View addSubview:numberLB];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, CGRectGetMaxY(numberLB.frame), SCREEN_WIDTH / 3, 20)];
        titleLB.text = listArr[i];
        titleLB.font = Font14;
        titleLB.textColor = DETAILTEXTCOLOR;;
        titleLB.textAlignment = NSTextAlignmentCenter;
        [head1View addSubview:titleLB];
        
    }
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(head1View.frame), SCREEN_WIDTH, 5)];
    lineView.backgroundColor = LINECOLOR;
    [self.view addSubview:lineView];

    
    UIView *head2View = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), SCREEN_WIDTH, 60)];
    head2View.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:head2View];
    
    NSArray *listArr1 = @[@"我的商家数",@"今日商家营业额(元) ",@"商家总营业额(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "];
    NSArray *numberArr2 = @[@"88",@"16666",@"88888                                                                                                                                                                                                                                                                                                                                                                                                                                                              "];
    for (NSInteger i = 0; i < 3; i++) {
        UILabel *numberLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, 10, SCREEN_WIDTH / 3, 20)];
        numberLB.text = numberArr2[i];
        numberLB.font = [UIFont systemFontOfSize:22];
        numberLB.textColor = KMAINCOLOR;
        numberLB.textAlignment = NSTextAlignmentCenter;
        [head2View addSubview:numberLB];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, CGRectGetMaxY(numberLB.frame), SCREEN_WIDTH / 3, 20)];
        titleLB.text = listArr1[i];
        titleLB.font = Font14;
        titleLB.textColor = DETAILTEXTCOLOR;;
        titleLB.textAlignment = NSTextAlignmentCenter;
        [head2View addSubview:titleLB];
        
    }
    
    UIView *headView3 =  [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(head2View.frame), SCREEN_WIDTH, 50)];
    headView3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView3];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(20, 5, 90, 20);
    [btn1 setImage:[UIImage imageNamed:@"bule_ju@3x.png"] forState:UIControlStateNormal];
    [btn1 setTitle:@"代理账号:" forState:UIControlStateNormal];
    [btn1 setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn1.titleLabel.font = Font14;
    [headView3 addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(20, CGRectGetMaxY(btn1.frame)+3, 90, 20);
    [btn2 setImage:[UIImage imageNamed:@"red_ju@3x.png"] forState:UIControlStateNormal];
    [btn2 setTitle:@"代理区域:" forState:UIControlStateNormal];
    [btn2 setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    btn2.titleLabel.font = Font14;
    btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [headView3 addSubview:btn2];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake( CGRectGetMaxX(btn2.frame), CGRectGetMaxY(btn1.frame)+3, SCREEN_WIDTH/2,20)];
    label1.text = @"广东省 深圳市 宝安区";
    label1.font = Font13;
    label1.textAlignment = NSTextAlignmentLeft;
    label1.textColor = KMAINCOLOR;
    [headView3 addSubview:label1];
    
    UIImageView *markImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"32@3x.png"]];
    markImageView.frame = CGRectMake(SCREEN_WIDTH - 25, (50 -14)/2, 8, 14);
    [headView3 addSubview:markImageView];    
    UIView *headView4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView3.frame) +10, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(headView3.frame) -10)];
    headView4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView4];
    
    
    NSArray *imageArray = @[@"hehuorenpingtai1@3x.png",@"hehuorenpingtai2@3x.png",@"hehuorenpingtai5@3x.png",@"wodetuandui3@3x.png",@"hehuorenpingtai4@3x.png",@"daili_set@3x.png",@"hehuorenpingtai3@3x.png",@"hehuorenpingtai5@3x.png",];
    NSArray *titleArray = @[@"团队管理",@"代理激励",@"兑换积分",@"合伙人列表",@"开通商家",@"商家审核",@"商家列表",@"使用帮助"];
    int btnW =  SCREEN_WIDTH/4;
    for (int i = 0; i<imageArray.count; i++) {
        NSInteger index = i % 4;
        NSInteger page = i / 4;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(SCREEN_WIDTH/4*index , page*75+ 25,
                                 btnW , 75)];
        
        btn.tag = 100 +i;
        [btn addTarget:self action:@selector(didClickItemsAction:) forControlEvents:UIControlEventTouchUpInside];
        [headView4 addSubview:btn];
        
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake((btnW-25)/2, 10, 25, 25)];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        [btn addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, btn.width, 20)];
        label.text = titleArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = Font14;
        [btn addSubview:label];
        
    }
}

- (void)setConfiguration
{
    
}


- (void)didClickItemsAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
        {
       
        }
            break;
        case 101:
        {
   
        }
            break;
        case 102:
        {
            
        }
            break;
        case 103:
        {
       
        }
            break;
        case 104:
        {
            
        }
            break;
            
        case 105:
        {
            
        }
            break;
        case 106:
        {
            AgentPlatfoemMainVC *VC = [[AgentPlatfoemMainVC alloc] init];
            
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 107:
        {
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - publice


#pragma mark - set & get



#pragma mark - delegate



@end
