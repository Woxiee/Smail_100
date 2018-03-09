//
//  TopScreenView.m
//  MyCityProject
//
//  Created by Faker on 17/5/5.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "TopScreenView.h"

@interface  TopScreenView ()
@property (nonatomic, strong) NSMutableArray  *titleKeyArr; //// 记录ID
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation TopScreenView
{
    UIButton *_selectBtn;  /// 选择的btn
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        /// 配置基础设置
        [self setConfiguration];
        [self setup];
    }
    return self;
}




- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        /// 配置基础设置
        [self setConfiguration];
        /// 初始化视图
        [self setup];
    }
    return self;
}

/// 配置基础设置
- (void)setConfiguration
{
    self.backgroundColor = [UIColor whiteColor];
    _titleArray = [[NSMutableArray alloc] init];
    
    _titleKeyArr = [[NSMutableArray alloc] init];
}

/// 初始化视图
- (void)setup
{

    [_titleArray addObject:@"全部分类"];
    [_titleArray addObject:@"价格排序"];
    [_titleArray addObject:@"销售优先"];
    [_titleArray addObject:@"时间排序"];
    
    /// 初始化视图
//
    for (int i = 0; i<_titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH / _titleArray.count *i, 0, SCREEN_WIDTH / _titleArray.count, 45);
        btn.tag = 100 + i;
        btn.timeInterVal = 0;
        btn.titleLabel.font = PLACEHOLDERFONT;
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        //设置button正常状态下的标题颜色
        [btn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
        [btn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateSelected];
        if (_topScreenType == TopScreenOtherType) {
            
        }else{
            [btn setImage:[UIImage imageNamed:@"29@3x.png"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"28@3x.png"] forState:UIControlStateSelected];
        }
       [btn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
        [btn addTarget:self action:@selector(clickIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
}

/// 点击事件
- (void)clickIndex:(UIButton *)sender
{
//    if (_topScreenType == TopScreenOtherType) {
        //    //
//    }

//    sender.selected = NO;
//    if(sender!= _selectBtn){
//        _selectBtn.selected=NO;
//        _selectBtn = sender;
//    }
//    _selectBtn.selected=YES;
//    NSString *titleKey =  _titleKeyArr[sender.tag - 100];
    sender.selected = !sender.selected;

    NSString *title=  _titleArray[sender.tag - 100];

    if (self.selectTopIndexBlock) {
        self.selectTopIndexBlock(sender.tag - 100 , @"",title);
    }
}



/**
 *  还原设置
 */
/**
 *  还原设置
 */
- (void)defaultTopSreenView:(NSInteger)index
{
    UIButton *btn = [self viewWithTag:100+index];
    btn.selected = NO;
}


#pragma mark - get &set
-(void)setModel:(GoodsScreenmodel *)model
{
    _model = model;
    /// TopScreenOtherType 采集显示数据
    if (_topScreenType == TopScreenOtherType) {
        
        if (!KX_NULLString(_model.titleDic[@"itemsTypeDetail3"])) {
            [_titleArray addObject:_model.titleDic[@"itemsTypeDetail3"]]; /// 默认排序
            [_titleKeyArr addObject:@"itemsTypeDetail3"]; /// 默认排序
        }
        
        if (!KX_NULLString(_model.titleDic[@"priceMoreDetail3"])) {
            [_titleArray addObject:_model.titleDic[@"priceMoreDetail3"]];  /// 参与最多
            [_titleKeyArr addObject:@"priceMoreDetail3"];/// 参与最多

        }
        
        if (!KX_NULLString(_model.titleDic[@"payTypeDetail3"])) {
            [_titleArray addObject:_model.titleDic[@"payTypeDetail3"]];   /// 最新发布
            [_titleKeyArr addObject:@"payTypeDetail3"];                    /// 最新发布
        }
        
        if (!KX_NULLString(_model.titleDic[@"dealTypeDetail3"])) {
            [_titleArray addObject:_model.titleDic[@"dealTypeDetail3"]]; /// 价格最低
            [_titleKeyArr addObject:@"dealTypeDetail3"];                  /// 价格最低

        }
    
        if (!KX_NULLString(_model.titleDic[@"orderTypeDetail3"])) {
            [_titleArray addObject:_model.titleDic[@"orderTypeDetail3"]]; /// 价格最高
            [_titleKeyArr addObject:@"orderTypeDetail3"];                  ///价格最高

        }
        
    }else{
        if (!KX_NULLString(_model.itemsTypeDetailTitle)) {
            [_titleArray addObject:_model.itemsTypeDetailTitle];
            [_titleKeyArr addObject:@"itemsTypeDetailTitle"];                  ///商品类型
        }
        if (!KX_NULLString(_model.payTypeDetailTitle)) {
            [_titleArray addObject:_model.payTypeDetailTitle];
            [_titleKeyArr addObject:@"payTypeDetailTitle"];                  ///付款方式
        }
        
        
        
        if (!KX_NULLString(_model.payTypeDetailTitle1)) {
            [_titleKeyArr addObject:@"payTypeDetailTitle1"];                  ///租赁类型标题名称

            [_titleArray addObject:_model.payTypeDetailTitle1];
        }

        
        if (!KX_NULLString(_model.dealTypeDetailTitle)) {
            [_titleArray addObject:_model.dealTypeDetailTitle];
            [_titleKeyArr addObject:@"dealTypeDetailTitle"];                  ///交易类型

        }
        if (!KX_NULLString(_model.payTypeDetailTitle2)) {
            [_titleArray addObject:_model.payTypeDetailTitle2];
            [_titleKeyArr addObject:@"payTypeDetailTitle2"];                  ///payTypeDetai	拍卖状态
        }
        
        if (!KX_NULLString(_model.dealTypeDetailTitle1)) {
            [_titleArray addObject:_model.dealTypeDetailTitle1];   /// 开拍时间标题名称
            [_titleKeyArr addObject:@"dealTypeDetailTitle1"];                  ///开拍时间标题名称
        }
        
        if (!KX_NULLString(_model.dealTypeDetailTitle2)) {
            [_titleArray addObject:_model.dealTypeDetailTitle2];   /// 开拍时间标题名称
            [_titleKeyArr addObject:@"dealTypeDetailTitle2"];                  ///开拍时间标题名称
        }
        
        
        
        if (!KX_NULLString(_model.orderTypeDetailTitle)) {
            [_titleArray addObject:_model.orderTypeDetailTitle];
            [_titleKeyArr addObject:@"orderTypeDetailTitle"];                  ///默认排序
        }
        
    }
    [_titleArray addObject:@"全部分类"];
    [_titleArray addObject:@"价格排序"];
    [_titleArray addObject:@"销售优先"];
    [_titleArray addObject:@"时间排序"];

    /// 初始化视图
    [self setup];
}


- (void)setTopScreenType:(TopScreenenSelectType)topScreenType
{
    _topScreenType = topScreenType;
  
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
  
    _selectIndex = selectIndex;
//    NSArray *btnArry =
    UIButton *btn = [self viewWithTag:100 +_selectIndex];
    [btn setTitle:_btnTitle forState:UIControlStateNormal];
    [btn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:2];
    btn.selected = YES;

}
@end
