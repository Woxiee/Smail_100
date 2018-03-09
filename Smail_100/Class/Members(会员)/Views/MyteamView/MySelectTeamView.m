//
//  MySelectTeamView.m
//  Smile_100
//
//  Created by Faker on 2018/2/21.
//  Copyright © 2018年 com.Smile100.wxApp. All rights reserved.
//

#import "MySelectTeamView.h"


@interface MySelectTeamView ()
@property (nonatomic,assign) NSInteger count;
@property (nonatomic, strong) NSArray       *titleArray;

@end

@implementation MySelectTeamView

- (instancetype)initWithFrame:(CGRect)frame
                   titleArray:(NSArray *)array{
    
    if (self = [super initWithFrame:frame]) {
        self.titleArray = array;
        self.count = array.count;
        [self setup];
    }
    return self;
}

- (void)setup
{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    headView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    [self addSubview:headView];

    self.backgroundColor = [UIColor whiteColor];
    NSArray *listArr = @[@"推荐人数",@"激活创客",@"I创客团队业绩(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH / self.count * i,10, SCREEN_WIDTH / self.count, 170);
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self addSubview:button];
        
        UILabel *numberLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / self.count * i, 30, SCREEN_WIDTH / self.count, 20)];
        numberLB.text = self.titleArray[i];
        numberLB.font = [UIFont systemFontOfSize:22];
        numberLB.textColor = KMAINCOLOR;
        numberLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:numberLB];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / self.count * i, CGRectGetMaxY(numberLB.frame), SCREEN_WIDTH / self.count, 20)];
        titleLB.text = listArr[i];
        titleLB.font =Font14;
        titleLB.textColor = DETAILTEXTCOLOR;
        titleLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLB];
        
    }
    
}

- (void)buttonAction:(UIButton *)sender
{
    
}

@end
