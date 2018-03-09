//
//  GoodsCommonChooseView.m
//  ShiShi
//
//  Created by Faker on 17/3/13.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "GoodsCommonChooseView.h"

@interface GoodsCommonChooseView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *darkView;
@property (nonatomic, strong)  UIView *contenView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *typeStr;  ///选择类型
@end
@implementation GoodsCommonChooseView
static NSString *cellID = @"chooseViewCell";
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
        
    }
    return self;
}


/// 视图
- (void)setup
{
    UIView *darkView                = [[UIView alloc] init];
    darkView.userInteractionEnabled = YES;
    darkView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    darkView.backgroundColor        = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:darkView];
    self.darkView = darkView;
    
    UISwipeGestureRecognizer  *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheetView)];
    [darkView addGestureRecognizer:leftSwipeGestureRecognizer];
    
    /// 白色背景
    UIView *contenView = [[UIView alloc] init];
    contenView.backgroundColor = [UIColor whiteColor];
    contenView.frame = CGRectMake(SCREEN_WIDTH -40, 0, SCREEN_WIDTH-40, SCREEN_HEIGHT);
    [self addSubview:contenView];
    self.contenView = contenView;
    
    ///左按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(5, 15, 30, 20);
    [btn setImage:[UIImage imageNamed:@"backblock"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 100;
    [ self.contenView addSubview:btn];
    
    ///title
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake((self.contenView.width - 50)/2,15, 50, 15)];
    titleLabel.text = @"状态";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = PLACEHOLDERFONT;
    [self.contenView addSubview:titleLabel];
    
    ///右按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(self.contenView.width - 50, 7.5, 50, 30);
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightBtn addTarget:self action:@selector(didClickAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = PLACEHOLDERFONT;
    [rightBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    rightBtn.tag = 200;
    [ self.contenView addSubview:rightBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, self.contenView.width, 10)];
    lineView.backgroundColor = LINECOLOR;
    [ self.contenView addSubview:lineView];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), self.contenView.width, 45*self.
                                                                           
                                                                           dataArray.count)];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource      = self;
    tableView.delegate        = self;
    [self.contenView addSubview:tableView];
    self.tableView = tableView;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderChooseViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    [self.tableView reloadData];
   
    
}

#pragma mark Show
/**
 *  显示数据
 */
- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
//        CGRect bgRect =  weakSelf.darkView.frame;
        CGRect chooseMenuRect =  weakSelf.contenView.frame;
//        bgRect.origin.x -= SCREEN_WIDTH;
        chooseMenuRect  = CGRectMake(40, 0, SCREEN_WIDTH-40, SCREEN_HEIGHT);
//        weakSelf.darkView.frame = bgRect;
        weakSelf.contenView.frame = chooseMenuRect;
        
    }];
    
}


- (void)hiddenSheetView {
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
//        CGRect bgRect =  weakSelf.darkView.frame;
        CGRect chooseMenuRect =  weakSelf.contenView.frame;
//        bgRect.origin.x= SCREEN_WIDTH;
        chooseMenuRect  = CGRectMake(SCREEN_WIDTH +40, 0, SCREEN_WIDTH- 40, SCREEN_HEIGHT);
//        weakSelf.darkView.frame = bgRect;
        weakSelf.contenView.frame = chooseMenuRect;
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
    }];
}


/// 取消 确定
- (void)didClickAction:(UIButton *)btn
{
    [self hiddenSheetView];

    if (btn.tag == 100) {
        
    }else{
        if (_chooseSureBlock) {
            _chooseSureBlock(_typeStr);
        }
    }
}

- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = @[@"全部",@"好评",@"中评",@"差评",@"有图"];
    }
    return _dataArray;
}


#pragma mark -  UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
    OrderChooseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.titleLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.markImageView.hidden = NO;
    }
     */
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        
//    }else{
    /*
        NSArray *cellArray = [tableView visibleCells];
        for (OrderChooseViewCell *cell in cellArray) {
            cell.titleLabel.textColor = [UIColor blackColor];
            cell.markImageView.hidden = YES;
        }
    
        OrderChooseViewCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
        cell.markImageView.hidden = NO;
        _typeStr = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
//    }
     */
}

@end
