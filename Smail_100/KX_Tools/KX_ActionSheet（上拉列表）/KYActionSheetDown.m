//
//  KYActionSheetDown.m
//  CRM
//
//  Created by Frank on 17/1/7.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "KYActionSheetDown.h"
#import "KYActionSheetDownCell.h"
#define FK_BUTTON_HIGHT        49.0f
#define FK_ANIMATION_DURATION  0.3f
#define FK_BUTTON_BUTTON_FONT         [UIFont systemFontOfSize:16.0f]
#define FK_BUTTON_REDCOLOR            RGB(255, 10, 10)

@interface KYActionSheetDown ()<UITableViewDataSource, UITableViewDelegate>
//@property (nonatomic, strong) NSArray *otherButtonTitles;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *darkView;

@property (nonatomic, weak) UIView *bottomView;



@end

@implementation KYActionSheetDown
/**
 *  @param rect                     rect
 *  @param clickedHandle          clickedHandle
 *  @param otherButtonTitleArray otherButtonTitleArray
 *
 *  @return An instance of KX_ActionSheet.
 */
+ (instancetype)sheetWithFrame:(CGRect)rect
                       clicked:(KYActionSheetClickedHandle)clickedHandle
         otherButtonTitleArray:(NSArray *)otherButtonTitleArray
{
    return [[self alloc] initWithFrame:rect clicked:clickedHandle otherButtonTitleArray:otherButtonTitleArray];
}

/**
 *  Initialize an instance of KX_ActionSheet with title array (Block).
 *
 *  @param rect                     rect
 *  @param clickedHandle            clickedHandle
 *  @param otherButtonTitleArray    otherButtonTitleArray
 *
 *  @return An instance of KX_ActionSheet.
 */
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
    self.buttonHeight           = FK_BUTTON_HIGHT;
    self.animationDuration      = FK_ANIMATION_DURATION;
    self.buttonFont             = FK_BUTTON_BUTTON_FONT;
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
    KYActionSheetDownCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[KYActionSheetDownCell alloc] initWithStyle:UITableViewCellStyleDefault
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
            for (KYActionSheetDownCell *cell in cellArray) {
                cell.titleLabel.textColor = [UIColor blackColor];
                cell.cheakMarkView.hidden = YES;
            }
            KYActionSheetDownCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
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
