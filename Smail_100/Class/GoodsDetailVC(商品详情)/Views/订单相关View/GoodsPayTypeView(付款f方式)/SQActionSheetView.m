//
//  SQActionSheetView.m
//  JHTDoctor
//
//  Created by yangsq on 2017/5/23.
//  Copyright © 2017年 yangsq. All rights reserved.
//

#import "SQActionSheetView.h"

#import "KYActionSheetDownCell.h"
#import "SQActionSheetModel.h"
#define Margin  6
#define ButtonHeight  45
#define TitleHeight   45
#define LineHeight    0.5

@interface SQActionSheetView ()<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) UIView *containerToolBar;
@property (nonatomic, assign) CGFloat toolbarH;
@property (nonatomic, strong) UIImageView *markimageView;
@property (nonatomic, strong) NSString *btnTitle;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) NSMutableArray *otherButtonTitleArray;
@end

@implementation SQActionSheetView

- (id)initWithTitle:(NSString *)title buttons:(NSArray <NSString *>*)buttons buttonClick:(void(^)(NSInteger buttonIndex,NSString *title))block
{
    if (self = [super init]) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        _buttons = buttons;
        _otherButtonTitleArray = [[NSMutableArray alloc] init];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _toolbarH = buttons.count*(ButtonHeight)+(buttons.count>1?Margin:0)+(title.length?TitleHeight:0);
        
        _containerToolBar = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame),CGRectGetWidth(self.frame),_toolbarH)];
        _containerToolBar.clipsToBounds = YES;

        CGFloat buttonMinY = 0;
        [buttons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SQActionSheetModel *model  = [[SQActionSheetModel alloc] init];
            if (self.selectType == RadioCellSelectType) {
                if(idx == _oldSelectIndex ){
                    model.isSelect = YES;
                }
                model.tag = idx;
                model.title = obj;
            }
            [_otherButtonTitleArray addObject:model];
        }];

        [_otherButtonTitleArray removeLastObject];
        if (title.length) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), TitleHeight)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = Font15;
            label.textColor = TITLETEXTLOWCOLOR;
            label.text = title;
            label.backgroundColor = [UIColor whiteColor];
            [_containerToolBar addSubview:label];
            buttonMinY = TitleHeight;
        }
        UITableView *tableView    = [[UITableView alloc] init];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.dataSource      = self;
        tableView.delegate        = self;
        tableView.scrollEnabled = NO;
        tableView.frame = CGRectMake(0, buttonMinY, CGRectGetWidth(self.frame), (ButtonHeight+LineHeight)*_otherButtonTitleArray.count+2);
        [_containerToolBar addSubview:tableView];
        self.tableView = tableView;

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = BACKGROUND_COLORHL;
        [button setTitle:buttons[buttons.count-1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:Font15];
        button.frame = CGRectMake(0, CGRectGetMaxY(tableView.frame), CGRectGetWidth(self.frame), ButtonHeight);
        [button addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
        [_containerToolBar addSubview:button];
        _btnTitle = @"";
        _index = -1;
        self.buttonClick = block;

        [self.tableView reloadData];
    }
    
    
    return self;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissView];
}

- (void)buttonTouch:(UIButton *)button{
    if (self.selectType == RadioCellSelectType) {
        for (SQActionSheetModel *model in _otherButtonTitleArray) {
            if (model.isSelect) {
                self.buttonClick(model.tag,model.title);
                break;
            }
        }
    }
    else{
        NSMutableArray *listArr = [[NSMutableArray alloc] init];
        for (SQActionSheetModel *model in _otherButtonTitleArray) {
            if (model.isSelect) {
                [listArr addObject:model.title];
            }
        }
        
        NSString *title = [listArr componentsJoinedByString:@","];
            if (self.buttonClick) {
                self.buttonClick(-100,title);
            }
    }

    [self dismissView];
    
}


- (void)showView{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:_containerToolBar];

    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        _containerToolBar.transform = CGAffineTransformMakeTranslation(0, -_toolbarH);
        self.alpha = 1;

    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)dismissView{
    [UIView animateWithDuration:0.3 animations:^{
        _containerToolBar.transform = CGAffineTransformIdentity;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_containerToolBar removeFromSuperview];
    }];
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
    cell.titleLabel.font      = Font15;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    SQActionSheetModel *modle = _otherButtonTitleArray[indexPath.row];
    cell.titleLabel.text = modle.title;

    if (modle.isSelect) {
        cell.titleLabel.textColor = BACKGROUND_COLORHL;
        cell.cheakMarkView.hidden = NO;
    }else{
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.cheakMarkView.hidden = YES;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ButtonHeight+LineHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.selectType == RadioCellSelectType) {
        for (SQActionSheetModel *modle in _otherButtonTitleArray) {
            modle.isSelect = NO;
        }
        
        SQActionSheetModel *modle = _otherButtonTitleArray[indexPath.row];
        modle.isSelect = YES;
    }
    else{
        SQActionSheetModel *modle = _otherButtonTitleArray[indexPath.row];
        modle.isSelect =! modle.isSelect;
    }
    
    [self.tableView reloadData];
    
}



-(void)setOldSelectIndex:(NSInteger)oldSelectIndex
{
    _oldSelectIndex = oldSelectIndex;
    [_otherButtonTitleArray removeAllObjects];

    [_buttons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SQActionSheetModel *model  = [[SQActionSheetModel alloc] init];
        if (self.selectType == RadioCellSelectType) {
            if(idx == _oldSelectIndex ){
                model.isSelect = YES;
            }
            model.tag = idx;
            model.title = obj;
        }
        [_otherButtonTitleArray addObject:model];
    }];
    [self.tableView reloadData];

    
}

@end
