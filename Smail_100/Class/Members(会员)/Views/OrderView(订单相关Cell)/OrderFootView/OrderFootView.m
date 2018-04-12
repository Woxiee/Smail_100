//
//  OrderFootView.m
//  MyCityProject
//
//  Created by Faker on 17/6/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderFootView.h"

@implementation OrderFootView
{
    NSMutableArray *_titleArr;

}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self setConfiguration];
    }
    
    return self;

}

/// 配置基础设置
- (void)setConfiguration
{
    _titleArr = [[NSMutableArray alloc] init];
}

/// 初始化视图
- (void)setup
{
    
}

-(void)setModel:(GoodsOrderModel *)model
{
    _model = model;
    for(UIButton *subView in [self subviews])
    {
        [subView removeFromSuperview];
        
    }
    [_titleArr removeAllObjects];

    if ([_model.paystatus isEqualToString:@"Pendding"] || [_model.paystatus isEqualToString:@"Preview"] || [_model.paystatus isEqualToString:@"Fail"]) {
        [_titleArr addObject:@"付款"];
    }
    
    if ([_model.paystatus isEqualToString:@"Complete"] && [_model.shipstatus isEqualToString:@"Delivery"] ) {
        [_titleArr addObject:@"确认收货"];
    }
    
    if ([_model.paystatus isEqualToString:@"Complete"] && _model.isDetail == NO) {
        [_titleArr addObject:@"查看详情"];
    }
    
    if ([_model.paystatus isEqualToString:@"Complete"] && [_model.paystatus isEqualToString:@"Waiting"] ) {
        [_titleArr addObject:@"申请售后"];
    }
    
    if ([_model.paystatus isEqualToString:@"Complete"] && [_model.paystatus isEqualToString:@"Delivery"] ) {
        [_titleArr addObject:@"查看物流"];
    }
    
    if ([_model.paystatus isEqualToString:@"Pendding"] || [_model.paystatus isEqualToString:@"Preview"] || [_model.paystatus isEqualToString:@"Fail"]) {
        [_titleArr addObject:@"取消订单"];
    }
    
    if ([_model.paystatus isEqualToString:@"Complete"] &&  [_model.shipstatus isEqualToString:@"Waiting"] ) {
        [_titleArr addObject:@"提醒发货"];
    }
    
    UIView *lastTopView = self;
    
    for (int  i = 0; i<_titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = PLACEHOLDERFONT;
        [btn addTarget:self action:@selector(didClickOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn layerForViewWith:3 AndLineWidth:1];
//
        [btn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];
        if ([_titleArr[i] isEqualToString:@"申请售后"] || [_titleArr[i] isEqualToString:@"查看物流"] || [_titleArr[i] isEqualToString:@"取消订单"] || [_titleArr[i] isEqualToString:@"提醒发货"] ) {
            [btn layerForViewWith:3 AndLineWidth:1];
            [btn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
        }
        else{
            [btn layerWithRadius:3 lineWidth:0.5 color:BACKGROUND_COLORHL];
            [btn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateNormal];
        }
        [self addSubview:btn];
        
//        if (i == 0) {
//              btn.frame = CGRectMake(SCREEN_WIDTH - 85, 0, 75, 30);
//        }else{
//            btn.frame = CGRectMake(SCREEN_WIDTH - 85 - 85, 0, 75, 30);
//        }
        
        btn.sd_layout
        .rightSpaceToView(lastTopView, 10)
        .topSpaceToView(self, 10)
        .widthIs(75)
        .heightIs(30);
        //        [btn setupAutoSizeWithHorizontalPadding:12 buttonHeight:30];
        lastTopView = btn;
        
    }

}


-(void)setAssetModel:(AssetModel *)assetModel
{
    _assetModel = assetModel;
    for(UIButton *subView in [self subviews])
    {
        [subView removeFromSuperview];
    }
    if (_titleArr.count >0) {
        [_titleArr removeAllObjects];
    }

    if ([_assetModel.applyState  integerValue] == 0) {
        [_titleArr addObject:@"申请估价"];
    }
    if ([_assetModel.applyState  integerValue] == 2) {
        [_titleArr addObject:@"付款"];
    }
    if ([_assetModel.applyState  integerValue] == 5) {
        [_titleArr addObject:@"申请授信"];
    }
     if ([_assetModel.applyState  integerValue] == 0 || [_assetModel.applyState  integerValue] == 3) {
        [_titleArr addObject:@"删除"];
        [_titleArr addObject:@"修改"];

    }
    if ([_assetModel.applyState  integerValue] == 3 ) {
        [_titleArr addObject:@"未通过"];
    }
    if (_titleArr.count == 0) {
        [_titleArr addObject:@""];
        
    }
    
    if (_titleArr.count >0) {
        UIView *lastTopView = self;
        NSArray* reversedArray = _titleArr;
        for (int  i = 0; i<reversedArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:reversedArray[i] forState:UIControlStateNormal];
            btn.titleLabel.font = PLACEHOLDERFONT;
            [btn addTarget:self action:@selector(didClickOrderAction:) forControlEvents:UIControlEventTouchUpInside];
            if ([reversedArray[i] isEqualToString:@"申请授信"] || [reversedArray[i] isEqualToString:@"申请估价"] ) {
                [btn layerWithRadius:3 lineWidth:0.5 color:BACKGROUND_COLORHL];
                [btn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateNormal];
            }
            else{
                [btn layerForViewWith:3 AndLineWidth:1];
                [btn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];
            }
            [self addSubview:btn];
            
//            btn.sd_layout
//            .rightSpaceToView(lastTopView, 10)
//            .topSpaceToView(self, 7);
//            [btn setupAutoSizeWithHorizontalPadding:12 buttonHeight:30];
//            lastTopView = btn;
//            [self setupAutoHeightWithBottomView:lastTopView bottomMargin:0];
            
            if (KX_NULLString(_titleArr[i])) {
                btn.sd_layout
                .rightSpaceToView(lastTopView, 0)
                .topSpaceToView(self, 0)
                .heightIs(0);
                [btn setupAutoSizeWithHorizontalPadding:0 buttonHeight:0];
                lastTopView = btn;
                [self setupAutoHeightWithBottomView:lastTopView bottomMargin:0];
                
                
            }else{
                btn.sd_layout
                .rightSpaceToView(lastTopView, 10)
                .topSpaceToView(self, 12);
                [btn setupAutoSizeWithHorizontalPadding:12 buttonHeight:30];
                lastTopView = btn;
                [self setupAutoHeightWithBottomView:lastTopView bottomMargin:10];
            }

        }
        
        
    }
}



-(void)setManagementModel:(ManagementModel *)managementModel
{
    _managementModel = managementModel;
    for(UIButton *subView in [self subviews])
    {
        [subView removeFromSuperview];
    }
    
    if ([_managementModel.status  integerValue] == 1) {
        [_titleArr removeAllObjects];
        [_titleArr addObject:@"查看供货单"];
        [_titleArr addObject:@"修改"];

        [_titleArr addObject:@"关闭"];


    }
    if ([_managementModel.status   integerValue] == 2) {
        [_titleArr removeAllObjects];
        [_titleArr addObject:@"查看供货单"];
        [_titleArr addObject:@"查看订单"];

    }
    
    if ([_managementModel.status  integerValue] == 3) {
        [_titleArr removeAllObjects];
//        [_titleArr addObject:@"查看供货单"];

//        [_titleArr addObject:@"关闭"];

    }

    if (_titleArr.count == 0) {
        [_titleArr addObject:@""];
        
    }
    
    if (_titleArr.count >0) {
        UIView *lastTopView = self;
        for (int  i = 0; i<_titleArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = PLACEHOLDERFONT;
            [btn addTarget:self action:@selector(didClickOrderAction:) forControlEvents:UIControlEventTouchUpInside];
            if ([_titleArr[i] isEqualToString:@"关闭"] || [_titleArr[i] isEqualToString:@"修改"]  || [_titleArr[i] isEqualToString:@"查看订单"] ) {
                [btn layerForViewWith:3 AndLineWidth:1];
                [btn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];
            }
            else{
                [btn layerWithRadius:3 lineWidth:0.5 color:BACKGROUND_COLORHL];
                [btn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateNormal];
            }
            [self addSubview:btn];
            
//            btn.sd_layout
//            .rightSpaceToView(lastTopView, 10)
//            .topSpaceToView(self, 7);
//            [btn setupAutoSizeWithHorizontalPadding:12 buttonHeight:30];
//            lastTopView = btn;
//            [self setupAutoHeightWithBottomView:lastTopView bottomMargin:0];
            
            
            if (KX_NULLString(_titleArr[i])) {
                btn.sd_layout
                .rightSpaceToView(lastTopView, 0)
                .topSpaceToView(self, 0)
                .heightIs(0);
                [btn setupAutoSizeWithHorizontalPadding:0 buttonHeight:0];
                lastTopView = btn;
                [self setupAutoHeightWithBottomView:lastTopView bottomMargin:0];
                
                
            }else{
                btn.sd_layout
                .rightSpaceToView(lastTopView, 10)
                .topSpaceToView(self, 12);
                [btn setupAutoSizeWithHorizontalPadding:12 buttonHeight:30];
                lastTopView = btn;
                [self setupAutoHeightWithBottomView:lastTopView bottomMargin:10];
            }
        }
    }
    
}

- (void)didClickOrderAction:(UIButton *)btn
{
    LOG(@"%@",btn.titleLabel.text);
    if (self.didClickOrderItemBlock) {
        self.didClickOrderItemBlock(btn.titleLabel.text);
    }
    
}

@end
