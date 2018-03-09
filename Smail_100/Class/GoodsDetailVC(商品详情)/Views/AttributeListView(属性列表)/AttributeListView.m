//
//  AttributeListView.m
//  MyCityProject
//
//  Created by Faker on 17/5/11.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "AttributeListView.h"
#import "AttributeCell.h"

@interface AttributeListView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;  /// 选择数据源
@property (nonatomic, weak) UIView *darkView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
@end


@implementation AttributeListView
static NSString * const cellID = @"cellID";

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setConfiguration];
    }
    return self;
}


/// 初始化视图
- (void)setup
{
    UIView *darkView                = [[UIView alloc] init];
    darkView.userInteractionEnabled = YES;
    darkView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    darkView.backgroundColor        = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:darkView];
    self.darkView = darkView;
    
    UITapGestureRecognizer  *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheetView)];
    [self.darkView addGestureRecognizer:tapGestureRecognizer];
    
     UIView *bottomView = [[UIView alloc] init];
    if (_dizhiArr.count >0) {
        bottomView.frame = CGRectMake(0, SCREEN_HEIGHT  -(_dizhiArr.count+1) *40, SCREEN_WIDTH,(_dizhiArr.count+1) *40);
 
    }else{
        bottomView.frame = CGRectMake(0, SCREEN_HEIGHT  -(_dataArray.count+1) *40, SCREEN_WIDTH,(_dataArray.count+1) *40);

    }

     bottomView.backgroundColor  = [UIColor whiteColor];
    [self addSubview:bottomView];
    self.bottomView = bottomView;

    UIButton *dissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dissBtn.frame = CGRectMake(SCREEN_WIDTH - 50 ,20 , 25, 25);
    [dissBtn setImage:[UIImage imageNamed:@"33@3x.png"] forState:UIControlStateNormal];
    [dissBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dissBtn addTarget:self action:@selector(hiddenSheetView) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:dissBtn];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH,_dizhiArr?_dizhiArr.count*40 : _dataArray.count*40) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 40.f;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bottomView addSubview:tableView];
    self.tableView = tableView;
    [ self.tableView  registerNib:[UINib nibWithNibName:@"AttributeCell" bundle:nil] forCellReuseIdentifier:cellID];

}


/// 配置基础设置
- (void)setConfiguration
{
    //    _count =1;    
}


/// 出现
- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    
    [keyWindow addSubview:self];
}

/// 消失
- (void)hiddenSheetView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        //        CGRect bgRect =  weakSelf.darkView.frame;
        //        CGRect chooseMenuRect =  weakSelf.contenView.frame;
        //        bgRect.origin.x= SCREEN_WIDTH;
        //        chooseMenuRect  = CGRectMake(SCREEN_WIDTH +40, 0, SCREEN_WIDTH- 40, SCREEN_HEIGHT);
        //        weakSelf.darkView.frame = bgRect;
        //        weakSelf.contenView.frame = chooseMenuRect;
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
    }];
}

#pragma mark - UITaleViewDelegate and UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dizhiArr.count > 0) {
        return _dizhiArr.count;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AttributeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dizhiArr.count > 0) {
        cell.dizhi = _dizhiArr[indexPath.row];
    }else{
        cell.model = self.dataArray[indexPath.row];

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ExtAttrbuteShow  *extAttrbute  = self.dataArray[indexPath.row];
    if ([extAttrbute.name isEqualToString:@"适配机型"]) {
        if (_didClickCellBlock) {
            _didClickCellBlock(extAttrbute.values);
            [self hiddenSheetView];
        }
        
    }
        

    
}


#pragma mark - get &set
-(void)setModel:(GoodSDetailModel *)model
{
    _model = model;
    self.dataArray = _model.extAttrbuteShow;
    [self setup];
    [self.tableView reloadData];
    
}

- (void)setExtAttrbuteArray:(NSArray *)extAttrbuteArray
{
    self.dataArray = extAttrbuteArray;
    [self setup];
    [self.tableView reloadData];

}

- (void)setDizhiArr:(NSArray *)dizhiArr
{
    _dizhiArr = dizhiArr;
    [self setup];
    [self.tableView reloadData];
}

-(NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSArray alloc] init];
    }
    return _dataArray;
}

@end
