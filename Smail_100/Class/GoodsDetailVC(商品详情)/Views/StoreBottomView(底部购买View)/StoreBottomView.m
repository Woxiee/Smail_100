//
//  StoreBottomView.m
//  ShiShi
//
//  Created by Faker on 17/3/7.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "StoreBottomView.h"

@implementation StoreBottomView
{
    UIButton *shouYeBtn;

    UIButton *meBtn;
    
    UIButton *cartBtn;
    
    UIButton *addCartBtn;
    
    UIButton *buyBtn;
    
    NSString *_type;
    

    __weak IBOutlet UIImageView *collectImageView;
    __weak IBOutlet UILabel *collectlB;
    
    __weak IBOutlet UILabel *label1; //企业
    __weak IBOutlet UILabel *label2; /// 联系方式
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
//        [self setup];
        [self setConfiguration];
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self setConfiguration];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame WithType:(NSString *)type
{
    if (self = [super initWithFrame:frame]) {
        
        _type = type;
        [self setup];
//        [self setConfiguration];
    }
    
    return self;
}


-(void)awakeFromNib
{
    [super awakeFromNib];
//    [self setConfiguration];
}
/// 初始化视图
- (void)setup
{
    [self layerForViewWith:0 AndLineWidth:0.5];
    
    shouYeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shouYeBtn.frame = CGRectMake(0, 0, 50, 50);
    [shouYeBtn addTarget:self action:@selector(didClickBottomViewAction:) forControlEvents:UIControlEventTouchUpInside];
    shouYeBtn.tag = 100;
//    shouYeBtn.backgroundColor = [UIColor redColor];
    [shouYeBtn setImage:[UIImage imageNamed:@"detailHomeIcon@2x.png"] forState:UIControlStateNormal];
    [shouYeBtn setTitle:@"首页" forState:UIControlStateNormal];
    shouYeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [shouYeBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    shouYeBtn.titleLabel.font =  Font11;
    [self addSubview:shouYeBtn];
    [shouYeBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:2];

    meBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    meBtn.frame = CGRectMake(CGRectGetMaxX(shouYeBtn.frame)-10, 0,  50, 50);
    [meBtn addTarget:self action:@selector(didClickBottomViewAction:) forControlEvents:UIControlEventTouchUpInside];
    meBtn.tag = 101;
    [meBtn setImage:[UIImage imageNamed:@"shouye12@3x.png"] forState:UIControlStateNormal];
    [meBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [meBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [meBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    [meBtn setTitleColor:KMAINCOLOR forState:UIControlStateSelected];
    meBtn.titleLabel.font =  KY_FONT(11);
    meBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:meBtn];
    [meBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:2];

    cartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cartBtn.frame = CGRectMake(CGRectGetMaxX(meBtn.frame)-10, 0,  60, 50);
    [cartBtn setImage:[UIImage imageNamed:@"detailcon1@2x.png"] forState:UIControlStateNormal];
    [cartBtn setTitle:@"购物车" forState:UIControlStateNormal];
    [cartBtn addTarget:self action:@selector(didClickBottomViewAction:) forControlEvents:UIControlEventTouchUpInside];
    cartBtn.tag = 102;
    [cartBtn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
    cartBtn.titleLabel.font =  Font11;
    [self addSubview:cartBtn];
    [cartBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:2];
//    [cartBtn sizeToFit];
    
    addCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addCartBtn.frame = CGRectMake(CGRectGetMaxX(cartBtn.frame), 0,  (SCREEN_WIDTH- CGRectGetMaxX(cartBtn.frame))/2, 50);
    [addCartBtn addTarget:self action:@selector(didClickBottomViewAction:) forControlEvents:UIControlEventTouchUpInside];
    addCartBtn.tag = 103;
    [addCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addCartBtn.titleLabel.font =  Font15;
    addCartBtn.backgroundColor = DETAILTEXTCOLOR1;
    [addCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    addCartBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:addCartBtn];

    buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(CGRectGetMaxX(addCartBtn.frame), 0, addCartBtn.mj_w, 50);
    [buyBtn addTarget:self action:@selector(didClickBottomViewAction:) forControlEvents:UIControlEventTouchUpInside];
    buyBtn.tag = 104;
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font =  Font15;
    buyBtn.backgroundColor = BACKGROUND_COLORHL;

    [self addSubview:buyBtn];

  
}


/// 配置基础设置
- (void)setConfiguration
{
    
    label1.textColor = DETAILTEXTCOLOR;
    label2.textColor = DETAILTEXTCOLOR;
    collectlB.textColor = DETAILTEXTCOLOR;
//    collectImageView.image = [UIImage imageNamed:@"goodsIcon3@3x.png"] ;

    
//    meBtn.titleLabel.font = Font13;
//    [meBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
//    
//    cartBtn.titleLabel.font = Font13;
//    [cartBtn setTitleColor:TITLETEXTLOWCOLOR forState:UIControlStateNormal];
//    
////    addCartBtn.titleLabel.font = Font15;
//    addCartBtn.backgroundColor = RGB(252, 174, 42);
//    [addCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
////    buyBtn.titleLabel.font = Font15;
//    buyBtn.backgroundColor = BACKGROUNDNOMAL_COLOR;
//    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];


}


- (void)setModel:(GoodSDetailModel *)model
{
    _model = model;
}


- (void)didClickBottomViewAction:(id)sender {
    if ([_model.onSale isEqualToString:@"0"]) {
        [self makeToast:@"该商品已下架~"];
        return;
    }
    
    UIButton *btn = (UIButton *)sender;
    if (_selectBlock) {
        _selectBlock(btn.tag - 100);
    }
}


//- (IBAction)didClickBottomViewAction:(id)sender {
//
//
//    if ([_model.onSale isEqualToString:@"0"]) {
//        [self makeToast:@"该商品已下架~"];
//        return;
//    }
//
//    UIButton *btn = (UIButton *)sender;
//    if (_selectBlock) {
//        _selectBlock(btn.tag - 100);
//    }
//
//}

- (void)setContenModel:(ItemContentList *)contenModel
{
    _contenModel = contenModel;
    if (KX_NULLString(_contenModel.coll_id)) {
        [meBtn setImage:[UIImage imageNamed:@"shouye11@3x.png"] forState:UIControlStateNormal];
        meBtn.selected = NO;
    }else{
        meBtn.selected = YES;
        [meBtn setImage:[UIImage imageNamed:@"shouye12@3x.png"] forState:UIControlStateNormal];

    }
}


//底部状态栏
- (void)showBottonWithLogTyoe:(BuyType)buyType withRzLogModel:(GoodSDetailModel *)model
{
   
        /// 0表示收藏了 为1的话表示没有收藏
    if ([model.collectResult isEqualToString:@"1"]) {
        collectImageView.image = [UIImage imageNamed:@"shouye11@3x.png"] ;
//        collectlB.textColor = BACKGROUND_COLORHL;
        addCartBtn.selected  = NO;

    }else{
        
        collectImageView.image = [UIImage imageNamed:@"shouye12@3x.png"] ;
//
//        collectlB.textColor = DETAILTEXTCOLOR;
        addCartBtn.selected  = YES;


    }
    

    if (buyType == NomalBuyType) {
        [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    }
   if (buyType == NomalLinkType){
        [buyBtn setTitle:@"立即租赁" forState:UIControlStateNormal];
    }
    
    if (buyType == NomalCollectType){
        [buyBtn setTitle:@"立即参与" forState:UIControlStateNormal];
    }
    if ([model.typeStr isEqualToString:@"6"]) {
        [buyBtn setTitle:@"立即订购" forState:UIControlStateNormal];
    }
    else{
    
    }
    
    
    

}


@end
