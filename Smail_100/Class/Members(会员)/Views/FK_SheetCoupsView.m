//
//  FK_SheetCoupsView.m
//  MyCityProject
//
//  Created by Macx on 2018/1/30.
//  Copyright © 2018年 Faker. All rights reserved.
//

#import "FK_SheetCoupsView.h"
#import "CoupsCell.h"

@interface FK_SheetCoupsView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *darkView;

@property (nonatomic, weak) UIView *bottomView;
@end

@implementation FK_SheetCoupsView



+ (instancetype)sheetWithFrame:(CGRect)rect
                       clicked:(KYActionSheetClickedHandle)clickedHandle
         otherButtonTitleArray:(NSArray *)otherButtonTitleArray
{
    return [[self alloc] initWithFrame:rect clicked:clickedHandle otherButtonTitleArray:otherButtonTitleArray];
}




- (instancetype)initWithFrame:(CGRect)rect
                      clicked:(KYActionSheetClickedHandle)clickedHandle
        otherButtonTitleArray:(NSArray *)otherButtonTitleArray
{
    if (self = [super init]) {
        [self configuration];
        self.frame = rect;
        self.clickedHandle     = clickedHandle;
        self.otherButtonTitleArray = otherButtonTitleArray;
        [self setup];
    }
    
    return self;
}

#pragma mark Show
/**
 *  显示数据
 */
- (void)show
{
    [self layoutIfNeeded];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGFloat height;
        if (self.otherButtonTitleArray.count > 12) {
            height = self.frame.size.height;
        }else{
            height = self.otherButtonTitleArray.count * self.buttonHeight;
        }
        weakSelf.tableView.sd_layout
        .topSpaceToView(self, 0)
        .heightIs(height);
        if (_isCustom) {
            weakSelf.bottomView.sd_layout
            .topSpaceToView(weakSelf.tableView,0)
            .leftEqualToView(self)
            .rightEqualToView(self)
            .heightIs(45);
        }
        
        
        
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}
/**
 *  hidden the instance of KX_ActionSheet.
 */
- (void)hiddenSheetView
{
    [self cancelButtonClicked];
}

- (void)darkViewClicked {
    [self cancelButtonClicked];
}


- (void)cancelButtonClicked {
    
    if (self.clickedHandle) {
        self.clickedHandle(1000,0);
    }
    
    [self hideWithButtonIndex:1000];
}

- (void)hideWithButtonIndex:(NSInteger)buttonIndex {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.tableView.sd_layout
        .topSpaceToView(self, 0)
        .heightIs(0);
        if (_isCustom) {
            weakSelf.bottomView.sd_layout
            .topSpaceToView(self, 0)
            .heightIs(0);
            
        }
        
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
        
    }];
}

/// 视图
- (void)setup
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    UIView *darkView                = [[UIView alloc] init];
    darkView.userInteractionEnabled = YES;
    darkView.backgroundColor        = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self addSubview:darkView];
    self.darkView = darkView;
    
    self.darkView.sd_layout
    .leftSpaceToView(self, 0)
    .topSpaceToView(self, 0)
    .widthIs(self.frame.size.width)
    .heightIs(self.frame.size.height);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(darkViewClicked)];
    [self.darkView addGestureRecognizer:tap];
    
    
    UITableView *tableView    = [[UITableView alloc] init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource      = self;
    tableView.delegate        = self;
    [self addSubview:tableView];
    self.tableView = tableView;
    self.tableView .sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(self.frame.size.height);
    
    
    
    
}

/// 默认设置
- (void)configuration
{
    self.titleStateType = TableViewCellTitleStateTypeCenter;
    self.buttonHeight           = 49;
    self.animationDuration      = 0.3;
    self.buttonFont             =  [UIFont systemFontOfSize:16.0f];
    self.buttonColor            = [UIColor blackColor];
    self.oldSelectIndex         = 0;
    self.otherButtonTitleArray  = nil;
    
}


#pragma mark - set & get
- (void)setIsCustom:(BOOL)isCustom
{
    _isCustom = isCustom;
    if (_isCustom) {
        UIView *bottomView = [[UIView alloc] init];
        //    WithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), SCREEN_WIDTH, 45)
        bottomView.backgroundColor = [UIColor whiteColor];
        [bottomView layerForViewWith:0 AndLineWidth:0.5];
        [self addSubview:bottomView];
        
        self.bottomView = bottomView;
        self.bottomView.sd_layout
        .topSpaceToView( self.tableView ,0)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(45);
        
        UIButton *restBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [restBtn setTitle:@"重置" forState:UIControlStateNormal];
        [restBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
        restBtn.titleLabel.font = Font15;
        [restBtn addTarget:self action:@selector(didClickRestAction:) forControlEvents:UIControlEventTouchUpInside];
        restBtn.backgroundColor = [UIColor whiteColor];
        restBtn.tag = 100;
        [self.bottomView addSubview:restBtn];
        
        restBtn.sd_layout
        .topEqualToView(self.bottomView)
        .leftEqualToView(self.bottomView)
        .widthIs(SCREEN_WIDTH/2)
        .heightIs(45);
        
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font = Font15;
        sureBtn.tag = 101;
        [sureBtn addTarget:self action:@selector(didClickRestAction:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.backgroundColor = BACKGROUND_COLORHL;
        [self.bottomView addSubview:sureBtn];
        
        sureBtn.sd_layout
        .topEqualToView(restBtn)
        .leftSpaceToView(restBtn,0)
        .widthIs(SCREEN_WIDTH/2)
        .heightIs(45);
        
    }
    
    
}


- (void)setScrolling:(BOOL)scrolling {
    _scrolling = scrolling;
    
}

- (void)setTitleStateType:(TableViewCellTitleStateType)titleStateType
{
    _titleStateType = titleStateType;
    
}

- (void)setOldSelectIndex:(NSInteger)oldSelectIndex
{
    _oldSelectIndex = oldSelectIndex;
    
}

- (void)setOtherButtonTitleArray:(NSArray *)otherButtonTitleArray
{
    _otherButtonTitleArray = otherButtonTitleArray;
    //    if (_otherButtonTitleArray) {
    //        self.tableView.sd_layout.heightIs(_otherButtonTitleArray.count*FK_BUTTON_HIGHT);
    //    }
    if (_otherButtonTitleArray.count >12) {
        self.scrolling = YES;
    }
    [self.tableView reloadData];
}
#pragma mark -  UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.otherButtonTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"KYActionSheetDownCell";
    CoupsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CoupsCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:cellID];
    }
    cell.titleLabel.font      = self.buttonFont;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.titleLabel.text = self.otherButtonTitleArray[indexPath.row];
    cell.titleLabel.textColor = self.buttonColor;
    if (self.titleStateType == TableViewCellTitleStateTypeLeft) {
        cell.titleLabel.textAlignment = NSTextAlignmentLeft;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.row == _oldSelectIndex ){
        cell.titleLabel.textColor = BACKGROUND_COLORHL;
        cell.cheakMarkView.hidden = NO;
    }else{
        cell.titleLabel.textColor = DETAILTEXTCOLOR;
        cell.cheakMarkView.hidden = YES;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.buttonHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_isCustom==NO) {
        if (self.clickedHandle) {
            self.clickedHandle(indexPath.row,0);
        }
        if (self.titleStateType == TableViewCellTitleStateTypeLeft) {
            NSArray *cellArray = [tableView visibleCells];
            for (CoupsCell *cell in cellArray) {
                cell.titleLabel.textColor = [UIColor blackColor];
                cell.cheakMarkView.hidden = YES;
            }
            CoupsCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
            if (self.titleStateType == TableViewCellTitleStateTypeLeft) {
                cell.titleLabel.textColor = BACKGROUND_COLORHL;
                cell.cheakMarkView.hidden = NO;
            }else
            {
                cell.cheakMarkView.hidden = YES;
            }
            
        }
        
        [self hideWithButtonIndex:indexPath.row];
    }else{
        
        _oldSelectIndex =indexPath.row;
        [self.tableView reloadData];
        
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.canScrolling) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
}


#pragma mark - pritave
- (void)didClickRestAction:(UIButton*)sender
{
    
    if (self.clickedHandle) {
        self.clickedHandle(_oldSelectIndex,sender.tag);
    }
    
    [self hideWithButtonIndex:_oldSelectIndex];
    
}

@end
