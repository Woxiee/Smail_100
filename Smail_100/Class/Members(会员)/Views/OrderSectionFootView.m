//
//  OrderSectionFootView.m
//  Smail_100
//
//  Created by ap on 2018/3/14.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "OrderSectionFootView.h"
#import "OrderFootView.h"

@implementation OrderSectionFootView
{
    __weak IBOutlet UIView *lineView2;
    __weak IBOutlet UIView *lineView;
    __weak IBOutlet UILabel *contenLB;
        UIView *_footView;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    lineView.backgroundColor = LINECOLOR;
    contenLB.textColor = TITLETEXTLOWCOLOR;
    lineView2.backgroundColor = LINECOLOR;
    UIView *footVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 50, SCREEN_WIDTH, 50)];
    [self addSubview:footVeiw];
    _footView = footVeiw;
    
    _titleArr = [[NSMutableArray alloc] init];
    [_titleArr addObject:@"付款"];
    [_titleArr addObject:@"取消订单"];

}


- (void)setModel:(OrderModel *)model
{
    _model = model;
    NSString *allNumber = [NSString stringWithFormat:@"%@",_model.count];
    NSString *allPrice = [NSString stringWithFormat:@"￥%@",_model.price];
    NSString *allPoint = [NSString stringWithFormat:@"%@",_model.point];
    
    if ([_model.point integerValue] >0) {
        NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"共%@件商品   合计:%@+%@积分",allNumber,allPrice,allPoint]];
        //获取要调整颜色的文字位置,调整颜色
        NSRange range1=[[hintString string]rangeOfString:allNumber];
        [hintString addAttribute:NSForegroundColorAttributeName  value:KMAINCOLOR range:range1];
        
        NSRange range2=[[hintString string]rangeOfString:allPrice];
        [hintString addAttribute:NSForegroundColorAttributeName value:KMAINCOLOR range:range2];
        
        NSRange range3 =[[hintString string]rangeOfString:allPoint];
        [hintString addAttribute:NSForegroundColorAttributeName value:KMAINCOLOR range:range3];
        contenLB.attributedText =hintString;
    }else{
        NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"共%@件商品   合计:%@",allNumber,allPrice]];
        //获取要调整颜色的文字位置,调整颜色
        NSRange range1=[[hintString string]rangeOfString:allNumber];
        [hintString addAttribute:NSForegroundColorAttributeName  value:KMAINCOLOR range:range1];
        
        NSRange range2=[[hintString string]rangeOfString:allPrice];
        [hintString addAttribute:NSForegroundColorAttributeName value:KMAINCOLOR range:range2];
        
        
        contenLB.attributedText =hintString;
    }


    UIView *lastTopView = self;

    for (int  i = 0; i<_titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = PLACEHOLDERFONT;
        [btn addTarget:self action:@selector(didClickOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn layerForViewWith:3 AndLineWidth:1];
        [btn setTitleColor:DETAILTEXTCOLOR1 forState:UIControlStateNormal];
        if ([_titleArr[i] isEqualToString:@"申请撤单"] || [_titleArr[i] isEqualToString:@"删除订单"] || [_titleArr[i] isEqualToString:@"取消订单"] ||[_titleArr[i] isEqualToString:@"申请退租"] ) {
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



- (void)didClickOrderAction:(UIButton *)sender
{
    
    
}

@end
