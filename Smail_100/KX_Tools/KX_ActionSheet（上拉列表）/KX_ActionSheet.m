//
//  KX_ActionSheet.m
//  KX_SheetView
//
//  Created by Faker on 16/12/1.
//  Copyright © 2016年 Faker. All rights reserved.
//


#import "KX_ActionSheet.h"
#import "Masonry.h"
#import "FK_ActionSheetCell.h"


#define FK_BUTTON_HIGHT        49.0f

#define FK_BUTTON_REDCOLOR            RGB(255, 10, 10)

#define FK_BUTTON_TITLE_FONT          [UIFont systemFontOfSize:14.0f]

#define FK_BUTTON_BUTTON_FONT         [UIFont systemFontOfSize:18.0f]

#define FK_ANIMATION_DURATION  0.3f

#define FK_DARK_OPACITY        0.3f

@interface KX_ActionSheet ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *otherButtonTitles;

@property (nonatomic, assign) CGSize titleTextSize;

@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, weak) UIVisualEffectView *blurEffectView;
@property (nonatomic, weak) UIView *darkView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *divisionView;
@property (nonatomic, weak) UIButton *cancelButton;

@property (nonatomic, weak) UIView *whiteBgView;

@property (nonatomic, weak) UIView *lineView;

@end
@implementation KX_ActionSheet

/**
 *  @param title             title
 *  @param cancelButtonTitle cancelButtonTitle
 *  @param clickedHandle      clickedHandle
 *  @param otherButtonTitles otherButtonTitles
 *
 *  @return An instance of KX_ActionSheet.
 */
+ (instancetype)sheetWithTitle:(NSString *)title
             cancelButtonTitle:(NSString *)cancelButtonTitle
                       clicked:(FKActionSheetClickedHandle)clickedHandle
             otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list titleList;
    id objectTag;
    NSMutableArray *tempOtherButtonTitles = nil;
    if(otherButtonTitles){
        tempOtherButtonTitles = [[NSMutableArray alloc] initWithObjects:otherButtonTitles, nil];
        va_start(titleList, otherButtonTitles);
        while ((objectTag = va_arg(titleList, id))){
            [tempOtherButtonTitles addObject:objectTag];
        }
        va_end(titleList);
    }

    return [[self alloc] initWithTitle:title
                     cancelButtonTitle:cancelButtonTitle
                               clicked:clickedHandle
                 otherButtonTitleArray:tempOtherButtonTitles];

}


/**
 *  @param title                 title
 *  @param clickedHandle          clickedHandle
 *  @param otherButtonTitleArray otherButtonTitleArray
 *
 *  @return An instance of KX_ActionSheet.
 */
+ (instancetype)sheetWithTitle:(NSString *)title
             cancelButtonTitle:(NSString *)cancelButtonTitle
                       clicked:(FKActionSheetClickedHandle)clickedHandle
         otherButtonTitleArray:(NSArray *)otherButtonTitleArray
{
    
    return [[self alloc] initWithTitle:title
                     cancelButtonTitle:cancelButtonTitle
                               clicked:clickedHandle
                 otherButtonTitleArray:otherButtonTitleArray];
}

/**
 *  @param title             title
 *  @param cancelButtonTitle cancelButtonTitle
 *  @param clickedHandle      clickedHandle
 *  @param otherButtonTitles otherButtonTitles
 *
 *  @return An instance of KX_ActionSheet.
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
                      clicked:(FKActionSheetClickedHandle)clickedHandle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    if(self = [super init]){
        va_list titleList;
        id objectTag;
        NSMutableArray *tempOtherButtonTitles = nil;
        if(otherButtonTitles){
            tempOtherButtonTitles = [[NSMutableArray alloc] initWithObjects:otherButtonTitles, nil];
            va_start(titleList, otherButtonTitles);
            while ((objectTag = va_arg(titleList, id))){
                [tempOtherButtonTitles addObject:objectTag];
            }
            va_end(titleList);
        }

        
    }
    return self;
}

/**
 *  Initialize an instance of KX_ActionSheet with title array (Block).
 *
 *  @param title                 title
 *  @param clickedHandle          clickedHandle
 *  @param otherButtonTitleArray otherButtonTitleArray
 *
 *  @return An instance of KX_ActionSheet.
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
                      clicked:(FKActionSheetClickedHandle)clickedHandle
        otherButtonTitleArray:(NSArray *)otherButtonTitleArray
{
    if (self = [super init]) {
        [self configuration];
        self.title             = title;
        self.cancelButtonTitle = cancelButtonTitle;
        self.clickedHandle     = clickedHandle;
        self.otherButtonTitles = otherButtonTitleArray;
        [self setup];

    }
   
    return self;
}

#pragma mark  Show
- (void)darkViewClicked {
    [self cancelButtonClicked];
}

- (void)cancelButtonClicked {
  
    if (self.clickedHandle) {
        self.clickedHandle(self, 0);
    }
    
    [self hideWithButtonIndex:0];
}

/**
 *  显示数据
 */
- (void)show
{
    if (self.willPresentHandle) {
        self.willPresentHandle(self);
    }
    
    [self layoutIfNeeded];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        weakSelf.darkView.alpha = self.darkOpacity;
        weakSelf.darkView.userInteractionEnabled = !self.darkViewNoTaped;
        
        [weakSelf.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
        }];
        
        [weakSelf layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    
        if (weakSelf.didPresentHandle) {
            weakSelf.didPresentHandle(self);
        }
    }];

}

/// 基础配置
- (void)configuration
{
    self.titleFont              = FK_BUTTON_TITLE_FONT;
    self.buttonFont             = FK_BUTTON_BUTTON_FONT;
    self.titleColor             = RGB(111, 111, 111);
    self.buttonColor            = [UIColor blackColor];
    self.buttonHeight           = FK_BUTTON_HIGHT;
    self.animationDuration      = FK_ANIMATION_DURATION;
    self.darkOpacity            = FK_ANIMATION_DURATION;
    self.titleEdgeInsets        = UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f);
}

- (void)setup
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(keyWindow);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        CGFloat height =
        (self.title.length > 0 ? self.titleTextSize.height + 2.0f + (self.titleEdgeInsets.top + self.titleEdgeInsets.bottom) : 0) +
        (self.otherButtonTitles.count > 0 ? (self.canScrolling ? MIN(self.visibleButtonCount, self.otherButtonTitles.count) : self.otherButtonTitles.count) * self.buttonHeight : 0) +
        (self.cancelButtonTitle.length > 0 ? 5.0f + self.buttonHeight : 0);

        make.height.equalTo(@(height));
        make.bottom.equalTo(self).offset(height);
    }];
    self.bottomView = bottomView;


    
    UIView *darkView                = [[UIView alloc] init];
    darkView.alpha                  = 0;
    darkView.userInteractionEnabled = NO;
    darkView.backgroundColor        = RGB(46, 49, 50);//RGB(46, 49, 50)
    [self addSubview:darkView];
    [darkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).priorityLow();
        make.bottom.equalTo(bottomView.mas_top);
    }];
    self.darkView = darkView;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(darkViewClicked)];
    [darkView addGestureRecognizer:tap];

    UIView *whiteBgView         = [[UIView alloc] init];
    whiteBgView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:whiteBgView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bottomView);
    }];
    self.whiteBgView = whiteBgView;
    whiteBgView.hidden = NO;

    UILabel *titleLabel      = [[UILabel alloc] init];
    titleLabel.text          = self.title;
    titleLabel.font          = self.titleFont;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor     = self.titleColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(self.title.length > 0 ? self.titleEdgeInsets.top : 0);
        make.left.equalTo(bottomView).offset(self.titleEdgeInsets.left);
        make.right.equalTo(bottomView).offset(-self.titleEdgeInsets.right);
        
        CGFloat height = self.title.length > 0 ? self.titleTextSize.height + 2.0f : 0;  // Prevent omit
        make.height.equalTo(@(height));
    }];
    self.titleLabel = titleLabel;

    UITableView *tableView    = [[UITableView alloc] init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource      = self;
    tableView.delegate        = self;
    [bottomView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bottomView);
        make.top.equalTo(titleLabel.mas_bottom).offset(self.title.length > 0 ? self.titleEdgeInsets.bottom : 0);
        
        CGFloat height = self.otherButtonTitles.count * self.buttonHeight;
        make.height.equalTo(@(height));
    }];

    self.tableView = tableView;
    
    
    UIView *lineView  = [[UIView alloc] init];
    lineView.contentMode   = UIViewContentModeBottom;
    lineView.backgroundColor = [UIColor clearColor];
    lineView.clipsToBounds = YES;
    [bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bottomView);
        make.bottom.equalTo(tableView.mas_top);
        make.height.equalTo(@0.5f);
    }];

    self.lineView = lineView;
    self.lineView.hidden = !self.title || self.title.length == 0;

    UIView *divisionView         = [[UIView alloc] init];
    divisionView.alpha           = 0.8f;
    divisionView.backgroundColor = [UIColor blackColor];//RGB(150, 150, 150)
    [bottomView addSubview:divisionView];
    [divisionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bottomView);
        make.top.equalTo(tableView.mas_bottom);
        
        CGFloat height = self.cancelButtonTitle.length > 0 ? 5.0f : 0;
        make.height.equalTo(@(height));
    }];
    self.divisionView = divisionView;
    
    UIButton *cancelButton       = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.backgroundColor = [UIColor clearColor];
    cancelButton.titleLabel.font = self.buttonFont;
    [cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
    [cancelButton setTitleColor:self.buttonColor forState:UIControlStateNormal];

    [cancelButton addTarget:self
                     action:@selector(cancelButtonClicked)
           forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bottomView);
        make.bottom.equalTo(bottomView);
        
        CGFloat height = self.cancelButtonTitle.length > 0 ? self.buttonHeight : 0;
        make.height.equalTo(@(height));
    }];
    self.cancelButton = cancelButton;

}


#pragma mark - pritave
- (CGSize)titleTextSize {
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width -
                             (self.titleEdgeInsets.left + self.titleEdgeInsets.right),
                             MAXFLOAT);
    
    NSStringDrawingOptions opts =
    NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSDictionary *attrs = @{NSFontAttributeName : self.titleFont};
    
    _titleTextSize =
    [self.title boundingRectWithSize:size
                             options:opts
                          attributes:attrs
                             context:nil].size;
    
    return _titleTextSize;
}

#pragma mark - Setter & Getter

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    
    self.titleLabel.text = title;
    
    [self updateTitleLabel];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(self.title.length > 0 ? self.titleEdgeInsets.bottom : 0);
    }];
    
    self.lineView.hidden = !self.title || self.title.length == 0;
}

- (void)setCancelButtonTitle:(NSString *)cancelButtonTitle {
    _cancelButtonTitle = [cancelButtonTitle copy];
    
    [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    [self updateCancelButton];
}




- (void)setTitleFont:(UIFont *)aTitleFont {
    _titleFont = aTitleFont;
    self.titleLabel.font = aTitleFont;
    [self updateBottomView];
    [self updateTitleLabel];
}

- (void)setButtonFont:(UIFont *)aButtonFont {
    _buttonFont = aButtonFont;
    self.cancelButton.titleLabel.font = aButtonFont;
    [self.tableView reloadData];
}



- (void)setTitleColor:(UIColor *)aTitleColor {
    _titleColor = aTitleColor;
    self.titleLabel.textColor = aTitleColor;
}

- (void)setButtonColor:(UIColor *)aButtonColor {
    _buttonColor = aButtonColor;
    [self.cancelButton setTitleColor:aButtonColor forState:UIControlStateNormal];
    [self.tableView reloadData];
}


- (void)setButtonHeight:(CGFloat)aButtonHeight {
    _buttonHeight = aButtonHeight;
    [self.tableView reloadData];
    [self updateBottomView];
    [self updateTableView];
    [self updateCancelButton];
}

- (NSInteger)cancelButtonIndex {
    return 0;
}

- (void)setScrolling:(BOOL)scrolling {
    _scrolling = scrolling;
    
    [self updateBottomView];
    [self updateTableView];
}

- (void)setVisibleButtonCount:(CGFloat)visibleButtonCount {
    _visibleButtonCount = visibleButtonCount;
    
    [self updateBottomView];
    [self updateTableView];
}

- (void)setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    _titleEdgeInsets = titleEdgeInsets;
    
    [self updateBottomView];
    [self updateTitleLabel];
    [self updateTableView];
}


- (void)setDestructiveButtonIndexSet:(NSSet *)destructiveButtonIndexSet {
    _destructiveButtonIndexSet = destructiveButtonIndexSet;
    if ([self lc_contains:0]) {
        [self.cancelButton setTitleColor:self.destructiveButtonColor forState:UIControlStateNormal];
    } else {
        [self.cancelButton setTitleColor:self.buttonColor forState:UIControlStateNormal];
    }
    
    
    [self.tableView reloadData];
}

- (void)setRedButtonIndexSet:(NSSet *)redButtonIndexSet {
    self.destructiveButtonIndexSet = redButtonIndexSet;
}

- (void)setDestructiveButtonColor:(UIColor *)aDestructiveButtonColor {
    _destructiveButtonColor = aDestructiveButtonColor;
    if ([self lc_contains:0]) {
        [self.cancelButton setTitleColor:self.destructiveButtonColor forState:UIControlStateNormal];
    } else {
        [self.cancelButton setTitleColor:self.buttonColor forState:UIControlStateNormal];
    }
    
    
    [self.tableView reloadData];
}

- (NSSet *)redButtonIndexSet {
    return self.destructiveButtonIndexSet;
}

- (BOOL)lc_contains:(int)num {
    BOOL contains = NO;
    for (NSNumber *setNum in self.destructiveButtonIndexSet) {
        if ([setNum intValue] == num) {
            contains = YES;
            break;
        }
    }
    return contains;
}

#pragma mark - Update Views

- (void)updateBottomView {
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat height = (self.title.length > 0 ? self.titleTextSize.height + 2.0f + (self.titleEdgeInsets.top + self.titleEdgeInsets.bottom) : 0) + (self.otherButtonTitles.count > 0 ? (self.canScrolling ? MIN(self.visibleButtonCount, self.otherButtonTitles.count) : self.otherButtonTitles.count) * self.buttonHeight : 0) + (self.cancelButtonTitle.length > 0 ? 5.0f + self.buttonHeight : 0);
        make.height.equalTo(@(height));
    }];
}


- (void)updateTitleLabel {
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).offset(self.title.length > 0 ? self.titleEdgeInsets.top : 0);
        make.left.equalTo(self.bottomView).offset(self.titleEdgeInsets.left);
        make.right.equalTo(self.bottomView).offset(-self.titleEdgeInsets.right);
        
        CGFloat height = self.title.length > 0 ? self.titleTextSize.height + 2.0f : 0;  // Prevent omit
        make.height.equalTo(@(height));
    }];
}

- (void)updateTableView {
    if (!self.canScrolling) {
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(self.otherButtonTitles.count * self.buttonHeight));
            make.top.equalTo(self.titleLabel.mas_bottom).offset(self.title.length > 0 ? self.titleEdgeInsets.bottom : 0);
        }];
    } else {
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(MIN(self.visibleButtonCount, self.otherButtonTitles.count) * self.buttonHeight));
            make.top.equalTo(self.titleLabel.mas_bottom).offset(self.title.length > 0 ? self.titleEdgeInsets.bottom : 0);
        }];
    }
}

- (void)updateCancelButton {
    [self.divisionView mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat height = self.cancelButtonTitle.length > 0 ? 5.0f : 0;
        make.height.equalTo(@(height));
    }];
    
    [self.cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat height = self.cancelButtonTitle.length > 0 ? self.buttonHeight : 0;
        make.height.equalTo(@(height));
    }];
}


- (void)hideWithButtonIndex:(NSInteger)buttonIndex {
  
    if (self.willDismissHandle) {
        self.willDismissHandle(self, buttonIndex);
    }
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        weakSelf.darkView.alpha = 0;
        weakSelf.darkView.userInteractionEnabled = NO;
        
        [weakSelf.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            CGFloat height = (self.title.length > 0 ? self.titleTextSize.height + 2.0f + (self.titleEdgeInsets.top + self.titleEdgeInsets.bottom) : 0) + (self.otherButtonTitles.count > 0 ? (self.canScrolling ? MIN(self.visibleButtonCount, self.otherButtonTitles.count) : self.otherButtonTitles.count) * self.buttonHeight : 0) + (self.cancelButtonTitle.length > 0 ? 5.0f + self.buttonHeight : 0);
            make.bottom.equalTo(self).offset(height);
        }];
        
        [weakSelf layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
        
        if (weakSelf.didDismissHandle) {
            weakSelf.didDismissHandle(self, buttonIndex);
        }
    }];
}

#pragma mark -  UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.otherButtonTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"KF_ActionSheetCell";
    FK_ActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FK_ActionSheetCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:cellID];
    }
    
    cell.titleLabel.font      = self.buttonFont;
    
    cell.titleLabel.text = self.otherButtonTitles[indexPath.row];
    if (_destructiveButtonIndexSet) {
        if ([self lc_contains:(int)indexPath.row + 1]) {
            cell.titleLabel.textColor = self.destructiveButtonColor;
        } else {
            cell.titleLabel.textColor = self.buttonColor;
        }
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.buttonHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.clickedHandle) {
        self.clickedHandle(self, indexPath.row + 1);
    }
    
    [self hideWithButtonIndex:indexPath.row + 1];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.canScrolling) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
}

@end
