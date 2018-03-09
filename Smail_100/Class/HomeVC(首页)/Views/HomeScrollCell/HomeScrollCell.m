//
//  HomeScrollCell.m
//  ShiShi
//
//  Created by ac on 16/3/24.
//  Copyright © 2016年 fec. All rights reserved.
//homeHeadImage.jpg

#import "HomeScrollCell.h"
#import "SDCycleScrollView.h"
#import "SMKCycleScrollView.h"

@interface HomeScrollCell()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SMKCycleScrollView *advertisView;

@end

@implementation HomeScrollCell
{
    __weak IBOutlet SDCycleScrollView *cycleView;

}
static NSString *homePageCellID = @"homePageCellID";

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

/// 初始化视图
- (void)setup
{
    cycleView.autoScrollTimeInterval = 3.5;
    cycleView.delegate = self;
    cycleView.currentPageDotColor = KMAINCOLOR;
//    _advertisView.frame = CGRectMake(84,6 ,self.width - 24, 35);
    _advertisView.titleColor = TITLETEXTLOWCOLOR;
    _advertisView.titleFont = PLACEHOLDERFONT;
    [_advertisView setSelectedBlock:^(NSInteger index, NSString *title) {
        NSLog(@"%zd-----%@",index,title);
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectCycleScrollViewItemAtIndex:)]) {
            [_delegate didSelectCycleScrollViewItemAtIndex:index+1000];
        }

    }];


}


/// 赋值
- (void)setModelArray:(NSMutableArray *)modelArray{
    cycleView.hidden = NO;
    cycleView.placeholderImage = [UIImage imageNamed:DEFAULTIMAGEW];
    _modelArray = modelArray;
    if (_modelArray !=  nil ) {
        cycleView.imageURLStringsGroup = _modelArray;
    }else{
        cycleView.localizationImageNamesGroup = @[@"10@3x.png",@"11@3x.png",@"10@3x.png",@"11@3x.png"];
    }
}

/// 赋值
- (void)setHomePageCellData:(NSMutableArray *)homePageCellData
{
    _homePageCellData = homePageCellData;
}


- (void)setNewsList:(NSMutableArray *)newsList
{
    _newsList = newsList;
    NSMutableArray *titleList  = [[NSMutableArray alloc] init];
    for (ColumnModel *model in _newsList) {
        [titleList addObject:model.seoTitle];
    }
    _advertisView.titleArray = titleList;

}



#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    LOG(@"点击了第%ld张图片",(long)index);
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectCycleScrollViewItemAtIndex:)]) {
        [_delegate didSelectCycleScrollViewItemAtIndex:index];
    }
}



///点击公告事件
- (IBAction)didClickBtn:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectCycleScrollViewItemAtIndex:)]) {
        [_delegate didSelectCycleScrollViewItemAtIndex:sender.tag];
    }
    
}

@end
