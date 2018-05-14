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
@property (nonatomic, strong) NSArray       *contenArr;

@end

@implementation MySelectTeamView
{
    NSMutableArray *_titleArr;

}


- (instancetype)initWithFrame:(CGRect)frame
                   titleArray:(NSArray *)array andContenArr:(NSArray *)arrays{
    
    if (self = [super initWithFrame:frame]) {
        self.titleArray = array;
        self.count = array.count;
        _titleArr = [[NSMutableArray alloc] init];
        _contenArr = arrays;
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
//    headView.backgroundColor = BACKGROUNDNOMAL_COLOR;
    
    [self addSubview:headView];

    self.backgroundColor = [UIColor whiteColor];
//    NSArray *listArr = @[@"总推荐人数",@"总激活创客",@"I团队总业绩(元)                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH / self.count * i,5, SCREEN_WIDTH / self.count, 170);
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self addSubview:button];
        
        UILabel *numberLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / self.count * i, 30, SCREEN_WIDTH / self.count, 20)];
        numberLB.text = self.titleArray[i];
        numberLB.font = [UIFont systemFontOfSize:22];
        numberLB.textColor = KMAINCOLOR;
        numberLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:numberLB];
        [_titleArr addObject:numberLB];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / self.count * i, CGRectGetMaxY(numberLB.frame)+5, SCREEN_WIDTH / self.count, 20)];
        titleLB.text = _contenArr[i];
        titleLB.font =Font14;
        titleLB.textColor = DETAILTEXTCOLOR;
        titleLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLB];
        
    }
    
}

- (void)setDataList:(NSArray *)dataList
{
    _dataList = dataList;
    for (int i = 0; i<_dataList.count; i++) {
        UILabel *label = _titleArr[i];
        label.text =[NSString stringWithFormat:@"%@", dataList[i]];
    }
}



- (void)buttonAction:(UIButton *)sender
{
    
}

@end
