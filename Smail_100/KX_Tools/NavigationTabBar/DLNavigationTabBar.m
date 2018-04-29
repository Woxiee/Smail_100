//
//  DLNavigationTabBar.m
//  DLNavigationTabBar
//
//  Created by FT_David on 2016/12/4.
//  Copyright © 2016年 FT_David. All rights reserved.
//

#import "DLNavigationTabBar.h"

@interface DLNavigationTabBar ()

@property (nonatomic, strong) UIView *sliderView;
@property(nonatomic,strong)NSMutableArray<UIButton *> *buttonArray;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,strong)UIButton *selectedButton;
@property (nonatomic,strong) UISegmentedControl *segmentedControl;
@end

@implementation DLNavigationTabBar


-(instancetype)initWithTitles:(NSArray *)titles
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)]) {
        self.buttonNormalTitleColor = [UIColor whiteColor];
        self.buttonSelectedTileColor =  [UIColor whiteColor];
        [self setSubViewWithTitles:titles];
    }
    return self;
}

-(void)setSubViewWithTitles:(NSArray *)titles
{
    self.buttonArray = [[NSMutableArray alloc] init];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:titles];
    segmentedControl.selectedSegmentIndex = 0;
//    segmentedControl.layer.cornerRadius = 10;
//    segmentedControl.clipsToBounds = YES;
    


    segmentedControl.tintColor = [UIColor whiteColor];
    [segmentedControl layerWithRadius:12 lineWidth:1 color:[UIColor whiteColor]];

//    segmentedControl.backgroundColor = KMAINCOLOR;
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal]; //正常
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateSelected]; //选中

    [segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:)forControlEvents:UIControlEventValueChanged];
    [self addSubview:segmentedControl];
    _segmentedControl = segmentedControl;
//    for (int buttonIndex = 0 ; buttonIndex < titles.count; buttonIndex++) {
//        NSString *titleString = titles[buttonIndex];
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn layerForViewWith:<#(CGFloat)#> AndLineWidth:<#(CGFloat)#>
//        [btn setTitleColor:self.buttonNormalTitleColor forState:UIControlStateNormal];
//        [btn setTitleColor:self.buttonSelectedTileColor forState:UIControlStateSelected];
//        [btn setTitleColor:self.buttonSelectedTileColor forState:UIControlStateHighlighted | UIControlStateSelected];
//        [btn setTitle:titleString forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
////        btn.backgroundColor = [UIColor redColor];
//        if(buttonIndex == 0) {btn.selected = YES; self.selectedButton = btn;};
//        [btn addTarget:self action:@selector(subButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
//        btn.tag = 100 + buttonIndex;
//        [self addSubview:btn];
//        [self.buttonArray addObject:btn];
//    }
    
//    self.sliderView = [[UIView alloc] init];
//    self.sliderView.backgroundColor = self.buttonSelectedTileColor;
//    [self addSubview:self.sliderView];
}

-(void)subButtonSelected:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    [self sliderViewAnimationWithButtonIndex:button.tag ];
    if (self.didClickAtIndex) {
        self.didClickAtIndex(button.tag );
    }
}

-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    if (self.didClickAtIndex) {
        self.didClickAtIndex(Index);
    }
}

-(void)scrollToIndex:(NSInteger)index
{
    _segmentedControl.selectedSegmentIndex = index;

//    self.selectedButton.selected = NO;
//    self.buttonArray[index].selected = YES;
//    self.selectedButton = self.buttonArray[index];
//    [self sliderViewAnimationWithButtonIndex:index];
    
}

-(void)sliderViewAnimationWithButtonIndex:(NSInteger)buttonIndex
{
    [UIView animateWithDuration:0.25 animations:^{
//        CGFloat buttonX = self.buttonArray[buttonIndex].center.x - (self.width /2);
//        self.sliderView.frame = CGRectMake(buttonX, self.frame.size.height - 2.0f, self.width - 4, 2);
    }];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _segmentedControl.frame = CGRectMake(SCREEN_WIDTH/4 -10 , 10,   SCREEN_WIDTH/2  , 25);
    _segmentedControl.center = self.center;
//    self.width =  self.frame.size.width / (self.buttonArray.count * 1.5);
//    CGFloat buttonWidth = self.frame.size.width / self.buttonArray.count - 40;
//    for (int buttonIndex = 0; buttonIndex < self.buttonArray.count; buttonIndex ++) {
//        self.buttonArray[buttonIndex].frame = CGRectMake(buttonIndex * buttonWidth +(self.frame.size.width - self.buttonArray.count*buttonWidth)/2 , 0, buttonWidth, 44);
//    }
//    CGFloat buttonX = self.buttonArray[0].center.x - self.width / 2;
//    self.sliderView.frame = CGRectMake(buttonX, self.frame.size.height - 2.0f, self.width - 4, 2);
}



@end
