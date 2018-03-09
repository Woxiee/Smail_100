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

-(void)setModel:(OrderModel *)model
{
    _model = model;
    for(UIButton *subView in [self subviews])
    {
        [subView removeFromSuperview];
        
    }

    [_titleArr removeAllObjects];

    if (_model.bidKey) {
//        if ([_model.orderStatus  integerValue] == 1 ) {
//            [_titleArr addObject:@"取消订单"];
//        }
//        if ([_model.orderStatus  integerValue] == 2 && [_model.signStatus   integerValue] == 1  ) {
//            [_titleArr addObject:@"立即签约"];
//        }
//        if ([_model.orderStatus  integerValue] == 2 &&[_model.signStatus   integerValue] == 2  ) {
//            [_titleArr addObject:@"同意合同"];
//        }
        
        if ([_model.orderStatus   integerValue] >= 2  && [_model.signStatus    integerValue] >= 2 ) {
            [_titleArr addObject:@"合同详情"];
        }
//        if ([_model.orderStatus  integerValue] == 3 ) {
//            if (_showType == CheckShowType) {
//                [_titleArr addObject:@"发起服务"];
//            }else{
//                [_titleArr addObject:@"立即发货"];
//            }
//        }
//
//        if ([_model.orderStatus  integerValue] == 5 && ([_model.orderType intValue] == 3 || [_model.orderType intValue] == 4)) {
//            [_titleArr addObject:@"结束租赁"];
//        }
        
//        if ([_model.orderType  integerValue] == 6 && [_model.orderStatus  integerValue] >= 4) {
//            [_titleArr addObject:@"查看"];
//        }
        
//        if ([_model.orderStatus   integerValue] > 0  && [_model.isApplyClose   integerValue] == 1) {
//            [_titleArr addObject:@"确认撤单"];
//        }
        
       
        
//        if ([_model.orderStatus   integerValue] < 6  && [_model.isFronzen     integerValue] == 0 ) {
//            [_titleArr addObject:@"订单冻结"];
//        }
        
//        if ([_model.orderStatus   integerValue] < 6  && [_model.isFronzen     integerValue] == 1 ) {
//            [_titleArr addObject:@"解除冻结"];
//        }
//        [_titleArr removeAllObjects];
        if (_titleArr.count == 0) {
            [_titleArr addObject:@""];
        }
        ///// ---------------------------------
    }else{
        if ([_model.orderStatus   integerValue] == 4 &&  [_model.isReceipt  integerValue] == 0) {
            if ([_model.param2 isEqualToString:@"6"]) {
                [_titleArr addObject:@"确认服务"];
            }else{
                [_titleArr addObject:@"确认收货"];

            }
        }
        
        if ([_model.orderStatus integerValue] >=  2  && [_model.signStatus integerValue] >= 2) {
            [_titleArr addObject:@"合同详情"];
        }
    
      
        
    
     
        
      //  orderStatus >= 5 && payStatus > 0 && isComment == 0     发表评价
        if ([_model.orderStatus  integerValue] >=5  &&[_model.payStatus  integerValue] >0 && [_model.isComment  integerValue] == 0 && ![_model.param2 isEqualToString:@"10"]) {
            [_titleArr addObject:@"发表评价"];
        }
        
        if ([_model.orderStatus  integerValue] >=5  &&[_model.payStatus  integerValue] >0 && [_model.isComment  integerValue] == 1 && ![_model.param2 isEqualToString:@"10"]) {
            [_titleArr addObject:@"评价详情"];
        }
        
        
        if ([_model.param2 isEqualToString:@"3"] || [_model.param2 isEqualToString:@"4"]) {
            if ([_model.orderStatus integerValue] == 5 && [_model.isApplyFinish integerValue] == 0) {
                [_titleArr addObject:@"申请退租"];
            }
        }
        
        if ([_model.payStatus integerValue] <2 && [_model.payStatus integerValue] >= 0 && [_model.orderStatus integerValue] > 1) {
            [_titleArr addObject:@"付款"];
        }
        
        ///集采类型 没有退租
        if (![_model.param2 isEqualToString:@"9"] ) {
            
            if ([_model.orderStatus integerValue] == 1 ) {
                [_titleArr addObject:@"取消订单"];
            }
        }
        
        if (([_model.orderStatus integerValue] == 0 || [_model.orderStatus  integerValue] == 6) && [_model.groupOrderStatusByGroupOrder integerValue] != 100 && [_model.auctionOrderBySingUp integerValue] != 100) {
            [_titleArr addObject:@"删除订单"];
        }

        if (([_model.orderStatus integerValue]  >1  && [_model.orderStatus integerValue] <=3 && [_model.isApplyClose integerValue] == 0) || [_model.groupOrderStatus integerValue] == 100) {
            [_titleArr addObject:@"申请撤单"];
        }
        
        if ([_model.status integerValue] == 1) {
            [_titleArr addObject:@"取消参与"];
        }
        
        if (_titleArr.count == 0) {
            [_titleArr addObject:@""];
        }

    }
    

    if (_titleArr.count >0) {
        UIView *lastTopView = self;
//        NSSet *set = [NSSet setWithArray:_titleArr];

//        NSArray* reversedArray = [[[set allObjects] reverseObjectEnumerator] allObjects];
        for (int  i = 0; i<_titleArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = PLACEHOLDERFONT;
            [btn addTarget:self action:@selector(didClickOrderAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn layerForViewWith:3 AndLineWidth:1];
            [btn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];
            if ([_model.isFronzen integerValue] == 1) {
                [btn layerForViewWith:3 AndLineWidth:1];
                [btn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];

            }else{
                if ([_titleArr[i] isEqualToString:@"申请撤单"] || [_titleArr[i] isEqualToString:@"删除订单"] || [_titleArr[i] isEqualToString:@"取消订单"] ||[_titleArr[i] isEqualToString:@"申请退租"] ) {
                    [btn layerForViewWith:3 AndLineWidth:1];
                    [btn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];
                }
                else{
                    [btn layerWithRadius:3 lineWidth:0.5 color:BACKGROUND_COLORHL];
                    [btn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateNormal];
                }

            }
            [self addSubview:btn];
//            btn.sd_layout
//            .rightSpaceToView(lastTopView, 10)
//            .topSpaceToView(self, 12);
//            [btn setupAutoSizeWithHorizontalPadding:12 buttonHeight:30];
//            lastTopView = btn;
//            [self setupAutoHeightWithBottomView:lastTopView bottomMargin:10];
            if ([_titleArr[i] isEqualToString:@""]) {
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
