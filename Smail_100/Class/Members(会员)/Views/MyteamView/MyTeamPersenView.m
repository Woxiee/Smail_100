//
//  MyTeamPersenView.m
//  Smile_100
//
//  Created by ap on 2018/2/26.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MyTeamPersenView.h"

@implementation MyTeamPersenView
{
    NSMutableArray *_titleArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleArr = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor whiteColor];
        NSArray *numberArr = @[@"99",@"109",@"999                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ",@"99",@"109",@"999                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "];
        NSArray *btnImage = @[@"wodetuandui1@3x.png",@"wodetuandui2@3x.png",@"wodetuandui3@3x.png",@"wodetuandui1@3x.png",@"wodetuandui2@3x.png",@"wodetuandui3@3x.png"];

        NSArray *lineViewColor = @[RGB(64, 160, 239),RGB(65, 192, 144),RGB(235, 138, 24),RGB(64, 160, 239),RGB(65, 192, 144),RGB(235, 138, 24)];
        for (NSInteger i = 0; i < 6; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 6  * i + 15,10, SCREEN_WIDTH / 6 -30, 1.5)];
            lineView.backgroundColor = lineViewColor[i];
            [self addSubview:lineView];
            
          
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(SCREEN_WIDTH / 6 * i,5, SCREEN_WIDTH / 6, 50);
            button.tag = i;
            if (i == 2) {
                UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame),0, 0.5 ,self.height-15)];
                lineView1.backgroundColor = LINECOLOR;
                [self addSubview:lineView1];
            }
            [button setTitle:numberArr[i] forState:UIControlStateNormal];
            [button setImage:LOADIMAGE(btnImage[i]) forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = Font14;
            [button layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:5];
            [self addSubview:button];
            [_titleArr addObject:button];
            
        }
    }
    return self;
}

- (void)setModel:(MyteamModel *)model
{
    _model = model;
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    [dataList addObjectsFromArray:_model.count.reg_list];
    [dataList addObjectsFromArray:_model.count.pay_list];
    
    for (int i = 0; i<dataList.count; i++) {
        UIButton *btn = _titleArr[i];
        [btn setTitle:[NSString stringWithFormat:@" %@",dataList[i]] forState:UIControlStateNormal];

    }
    
}

@end
