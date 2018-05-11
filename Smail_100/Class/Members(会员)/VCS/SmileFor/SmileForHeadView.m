//
//  SmileForHeadView.m
//  Smail_100
//
//  Created by Faker on 2018/4/14.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "SmileForHeadView.h"

@implementation SmileForHeadView
{
    NSMutableArray *_titleList;
    NSMutableArray *_imgList;

}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    
//    NSArray *listArr = @[@"推荐人数",@"本月营业额(元) ",@"总营业额(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "];
//    NSArray *numberArr = @[@"8888",@"18888",@"888888                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "];
    _titleList = [[NSMutableArray alloc] init];
    _imgList = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i < 3; i++) {
        UILabel *numberLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, 15, SCREEN_WIDTH / 3, 20)];
        numberLB.font = [UIFont systemFontOfSize:20];
        numberLB.textColor = KMAINCOLOR;
        numberLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:numberLB];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * i, CGRectGetMaxY(numberLB.frame), SCREEN_WIDTH / 3, 20)];
        titleLB.font = Font14;
        titleLB.textColor = DETAILTEXTCOLOR;;
        titleLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLB];
        
        [_imgList addObject:numberLB];
        [_titleList addObject:titleLB];
        
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mj_h -1, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = LINECOLOR;
    
    [self addSubview:lineView];

}

- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
    NSArray *dataLlit = @[[NSString stringWithFormat:@"%@",_dataDic[@"sum"][@"today"]],[NSString stringWithFormat:@"%@", _dataDic[@"sum"][@"month"]],[NSString stringWithFormat:@"%@",_dataDic[@"sum"][@"all"]]];
    NSArray *titleList = @[@"今日兑换",@"本月兑换",@"总兑换"];
    if (!KX_NULLString(_shopID)) {
        titleList = @[@"今日营业额",@"本月营业额",@"总营业额"];
    }
    if (!KX_NULLString(_isWithdrawal)) {
        titleList = @[@"今日提现",@"本月提现",@"总提现"];

    }
    for (int i = 0; i<dataLlit.count; i++) {
        UILabel *numberLB = _imgList[i];
        numberLB.text = dataLlit[i];
        UILabel *titleLB = _titleList[i];
        titleLB.text = titleList[i];
    }
    
    
}

@end
