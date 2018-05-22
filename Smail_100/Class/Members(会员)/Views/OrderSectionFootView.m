//
//  OrderSectionFootView.m
//  Smail_100
//
//  Created by ap on 2018/3/14.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "OrderSectionFootView.h"
#import "OrderFootView.h"
#import "DQStarView.h"

@implementation OrderSectionFootView
{
    __weak IBOutlet UIView *lineView2;
    __weak IBOutlet UIView *lineView;
    __weak IBOutlet UILabel *contenLB;
        UIView *_footView;
    
    __weak IBOutlet UILabel *commLb;
    DQStarView *scoreImageView;
    
    __weak IBOutlet UILabel *countLb;
    UILabel *commlB;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    lineView.backgroundColor = LINECOLOR;
    contenLB.textColor = KMAINCOLOR;
    countLb.textColor = TITLETEXTLOWCOLOR;
    lineView2.backgroundColor = LINECOLOR;
    UIView *footVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 50, SCREEN_WIDTH, 50)];
    [self addSubview:footVeiw];
    _footView = footVeiw;
    
    _titleArr = [[NSMutableArray alloc] init];


}


- (void)setModel:(OrderModel *)model
{
    _model = model;
    NSString *allNumber = [NSString stringWithFormat:@"%@",_model.count];
    NSString *allPrice = [NSString stringWithFormat:@"¥%@",_model.price];
    NSString *allPoint = [NSString stringWithFormat:@"%@积分",_model.point];
    NSString *freights = [NSString stringWithFormat:@"%@快递费",_model.freight];
    NSMutableArray *infoArr = [[NSMutableArray alloc] init];
    if (_model.price.floatValue >0) {
        [infoArr addObject: allPrice];
    }
    
    if (_model.point.floatValue >0) {
        [infoArr addObject: allPoint];
    }
    
    if (_model.freight.floatValue >0) {
        [infoArr addObject: freights];
    }
    
    NSString *infoStr = [NSString stringWithFormat:@"%@",[infoArr componentsJoinedByString:@"+"]];

    NSAttributedString *attributedStr = [NSString attributeStringWithContent:infoStr keyWords:@[@"积分",@"快递费",@"¥"]];

    contenLB.attributedText = attributedStr;
    
    NSString *count = [NSString stringWithFormat:@"共%@件商品    合计:",allNumber];
    
    NSAttributedString *attributedStr1 = [NSString attributeStringWithContent:count keyWords:@[allNumber] color:KMAINCOLOR font:Font14];
    countLb.attributedText = attributedStr1;
    
    //    NSString *detailStr = @"共%@件商品   ";
    //
    //    NSMutableAttributedString *conten =(NSMutableAttributedString *)attributedStr;
    //    [conten addAttribute:NSFontAttributeName
    //                   value:[UIFont systemFontOfSize:14]
    //                   range:NSMakeRange(0, detailStr.length-1)];
    //
    //    [conten addAttribute:NSForegroundColorAttributeName value:DETAILTEXTCOLOR range:NSMakeRange(0 ,detailStr.length-1)];
    
    
    //    NSString *anotherString = [conten string];
    

    if ([_model.type isEqualToString:@"Shop"]) {
        scoreImageView = [[DQStarView alloc] initWithDQStarFrme:CGRectMake(10, 10, 100, 20) starTotal:5];
        [scoreImageView ShowDQStarScoreFunction:_model.stars.floatValue/20];
        scoreImageView.userInteractionEnabled = NO;
        [_footView addSubview:scoreImageView];
        
        commlB = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(scoreImageView.frame), SCREEN_WIDTH,15)];
        commlB.text = [NSString stringWithFormat: @"评论：%@",_model.comment];
        commlB.textColor = TITLETEXTLOWCOLOR;
        commlB.font = KY_FONT(12);
        [_footView addSubview:commlB];
        
        
        
        
    }else{
        if ([_model.paystatus isEqualToString:@"Pendding"] || [_model.paystatus isEqualToString:@"Preview"] || [_model.paystatus isEqualToString:@"Fail"]) {
            [_titleArr addObject:@"付款"];
        }
        
        
        if ([_model.paystatus isEqualToString:@"Complete"] && [_model.shipstatus isEqualToString:@"Delivery"] ) {
            
            [_titleArr addObject:@"确认收货"];
        }
        
        
        if ([_model.paystatus isEqualToString:@"Complete"] &&  [_model.comm_nums isEqualToString:@"0"]) {
            [_titleArr addObject:@"待评价"];
        }
        
        
        if ([_model.paystatus isEqualToString:@"Complete"] && [_model.paystatus isEqualToString:@"Waiting"] ) {
            [_titleArr addObject:@"申请售后"];
        }
        
        if ([_model.paystatus isEqualToString:@"Complete"] && [_model.shipstatus isEqualToString:@"Delivery"] ) {
            [_titleArr addObject:@"查看物流"];
        }
        
        if ([_model.paystatus isEqualToString:@"Pendding"] || [_model.paystatus isEqualToString:@"Preview"] || [_model.paystatus isEqualToString:@"Fail"]) {
            [_titleArr addObject:@"取消订单"];
        }
        
        
        
        if ([_model.paystatus isEqualToString:@"Complete"] &&  [_model.shipstatus isEqualToString:@"Waiting"] ) {
            [_titleArr addObject:@"提醒发货"];
        }
        
        UIView *lastTopView = self;
        
        if (_model.isShowBottow ) {
            [_titleArr removeAllObjects];
        }
        for (int  i = 0; i<_titleArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = PLACEHOLDERFONT;
            [btn addTarget:self action:@selector(didClickOrderAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn layerForViewWith:3 AndLineWidth:1];
            [btn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];
            if ([_titleArr[i] isEqualToString:@"申请售后"] || [_titleArr[i] isEqualToString:@"查看物流"] || [_titleArr[i] isEqualToString:@"取消订单"]  ) {
                [btn layerForViewWith:3 AndLineWidth:1];
                [btn setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
            }
            else{
                [btn layerWithRadius:3 lineWidth:0.5 color:BACKGROUND_COLORHL];
                [btn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateNormal];
            }
            [self addSubview:btn];
            
            
            btn.sd_layout
            .rightSpaceToView(lastTopView, 10)
            .topSpaceToView(self, 50)
            .widthIs(75)
            .heightIs(30);
            //        [btn setupAutoSizeWithHorizontalPadding:12 buttonHeight:30];
            lastTopView = btn;
            
        }
        
    }

   
}



- (void)didClickOrderAction:(UIButton *)sender
{
    if (_didClickItemBlock) {
        _didClickItemBlock(sender.titleLabel.text);
    }
    
}


@end
