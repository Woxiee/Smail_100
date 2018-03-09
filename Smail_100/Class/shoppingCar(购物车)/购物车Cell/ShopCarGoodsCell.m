//
//  ShopCarGoodsCell.m
//  ShiShi
//
//  Created by ac on 16/3/28.
//  Copyright © 2016年 fec. All rights reserved.
//

#import "ShopCarGoodsCell.h"

@interface  ShopCarGoodsCell ()<UITextFieldDelegate>
@end

@implementation ShopCarGoodsCell
{
    UIButton *selectBtn;
    UILabel *priceLable;
    UILabel *name;
    UIImageView *headImage;
    UILabel *numberLable;
    UILabel *productLabel;
    int number ;
}

-  (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     //   [self setup];
//        [self setConfiguration];
    }
    
    return self;
}


/// 初始化视图
- (void)setup
{
    UIView *goodsView = [UIView new];
    goodsView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    [self.contentView addSubview:goodsView];
    
    selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(0, 35, 33, 50);
    [selectBtn setImage:[UIImage imageNamed:@"limitbuyBack.png"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"xuanzhe2.png"] forState:UIControlStateSelected];

    [selectBtn addTarget:self action:@selector(checkBtn:) forControlEvents:UIControlEventTouchUpInside];
    [goodsView addSubview:selectBtn];
    
    headImage = [[UIImageView alloc] init];
    headImage.frame = CGRectMake(41 , 15, 90, 90);
    [goodsView addSubview:headImage];
    
    name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame) +8, 7 , SCREEN_WIDTH -  CGRectGetMaxX(headImage.frame) +8 - 20, 36)];
    name.font = Font15;
    name.numberOfLines = 2;
    name.textColor = TITLETEXTLOWCOLOR;
    [goodsView addSubview:name];
    
    productLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame) +8, CGRectGetMaxY(name.frame)+10, name.width, 15)];
    productLabel.font = Font12;
    productLabel.textColor = DETAILTEXTCOLOR;
    [goodsView addSubview:productLabel];
    
    
    priceLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame) +8, CGRectGetMaxY(productLabel.frame)+10, name.width/2, 15)];
    priceLable.font = Font12;
    priceLable.textColor = KMAINCOLOR;
    [goodsView addSubview:priceLable];
    
    UIView *changeView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 105 ,CGRectGetMaxY(productLabel.frame)+5 , 90, 25)];
    [goodsView addSubview:changeView];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 25)];
    bgImageView.image = [UIImage imageNamed:@"goodsAdd.png"];
    bgImageView.userInteractionEnabled = YES;
    [changeView addSubview:bgImageView];
    
    
    UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleBtn.frame = CGRectMake(0, 0, 32.5,  25 );
    [deleBtn addTarget:self action:@selector(btnReduce:) forControlEvents:UIControlEventTouchUpInside];
    [changeView addSubview:deleBtn];

    
    numberLable = [[UILabel alloc] initWithFrame:CGRectMake(29.5, -0.5,33 ,25)];
    numberLable.textColor = TITLETEXTLOWCOLOR;
    numberLable.font =  PLACEHOLDERFONT;
    numberLable.textAlignment = NSTextAlignmentCenter;
    [changeView addSubview:numberLable];
    
    UIButton *chageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chageBtn.frame = CGRectMake(29.5, -0.5,33 ,25);
    chageBtn.backgroundColor = [UIColor clearColor];
    [chageBtn addTarget:self action:@selector(chageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [changeView addSubview:chageBtn];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(57.5, 0, 32.5,  25 );
    [addBtn addTarget:self action:@selector(btnAdd:) forControlEvents:UIControlEventTouchUpInside];
    [changeView addSubview:addBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 119.5, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor =  LINECOLOR;
    [goodsView addSubview:lineView];
    
}

/// 配置基础设置
- (void)setConfiguration
{
    
}


- (void)setGoodsModel:(OrderGoodsModel *)goodsModel{
    
    _goodsModel = goodsModel;
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIView *goodsView = [UIView new];
    goodsView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    [self.contentView addSubview:goodsView];
    
    selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(0, 35, 33, 50);
    [selectBtn setImage:[UIImage imageNamed:@"limitbuyBack.png"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"xuanzhe2.png"] forState:UIControlStateSelected];
    
    [selectBtn addTarget:self action:@selector(checkBtn:) forControlEvents:UIControlEventTouchUpInside];
    [goodsView addSubview:selectBtn];
    
    headImage = [[UIImageView alloc] init];
    headImage.frame = CGRectMake(41 , 15, 90, 90);
    [goodsView addSubview:headImage];
    
    name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame) +8, 7 , SCREEN_WIDTH -  CGRectGetMaxX(headImage.frame) +8 - 20, 36)];
    name.font = Font15;
    name.numberOfLines = 2;
    name.textColor = TITLETEXTLOWCOLOR;
    [goodsView addSubview:name];
    
    productLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame) +8, CGRectGetMaxY(name.frame)+10, name.width, 15)];
    productLabel.font = Font12;
    productLabel.textColor = DETAILTEXTCOLOR;
    [goodsView addSubview:productLabel];
    
    
    priceLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame) +8, CGRectGetMaxY(productLabel.frame)+10, name.width/2, 15)];
    priceLable.font = Font12;
    priceLable.textColor = KMAINCOLOR;
    [goodsView addSubview:priceLable];
    
    UIView *changeView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 105 ,CGRectGetMaxY(productLabel.frame)+5 , 90, 25)];
    [goodsView addSubview:changeView];
    
    //加号
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 25)];
    bgImageView.image = [UIImage imageNamed:@"goodsAdd.png"];
    bgImageView.userInteractionEnabled = YES;
    [changeView addSubview:bgImageView];
    
    
    UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleBtn.frame = CGRectMake(0, 0, 25,  25 );
    [deleBtn addTarget:self action:@selector(btnReduce:) forControlEvents:UIControlEventTouchUpInside];
    [changeView addSubview:deleBtn];
    
    numberLable = [[UILabel alloc] initWithFrame:CGRectMake(29.5, -0.5,33 ,25)];
    numberLable.textColor = TITLETEXTLOWCOLOR;
    numberLable.font =  PLACEHOLDERFONT;
    numberLable.textAlignment = NSTextAlignmentCenter;
    [changeView addSubview:numberLable];
    
    UIButton *chageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chageBtn.frame = CGRectMake(25, -0.5,40 ,25);
    chageBtn.backgroundColor = [UIColor clearColor];
    [chageBtn addTarget:self action:@selector(chageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [changeView addSubview:chageBtn];


    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(65, 0, 25,  25 );
    [addBtn addTarget:self action:@selector(btnAdd:) forControlEvents:UIControlEventTouchUpInside];
    [changeView addSubview:addBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 119, SCREEN_WIDTH, 1)];
    lineView.backgroundColor =  LINECOLOR;
    [goodsView addSubview:lineView];
    
    selectBtn.selected = (goodsModel.selectStatue.integerValue ==1);
    [headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",goodsModel.productLogo]] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    name.text = [NSString stringWithFormat:@"%@",goodsModel.productName];
    priceLable.text = [NSString stringWithFormat:@"￥%@",[Common stringToTwoPoint:goodsModel.productPrice]];
    number = [goodsModel.itemCount intValue];
    numberLable.text = goodsModel.itemCount;
    productLabel.text =[NSString stringWithFormat:@"%@",goodsModel.property];
    
    
    NSMutableArray *listArray = [NSMutableArray new];
   
    
    for (int i =0; i< listArray.count; i++) {
            MarketRuleList *listModel = listArray[i];
            UIView *goodsView = [UIView new];
            goodsView.frame = CGRectMake(0, 120*(i+1), SCREEN_WIDTH, 120);
            [self.contentView addSubview:goodsView];
            
            UIButton  *sendBtnTitle = [UIButton buttonWithType:UIButtonTypeCustom];
            sendBtnTitle.frame = CGRectMake(0, 35, 33, 50);
            sendBtnTitle.titleLabel.font = Font13;
            [sendBtnTitle setTitleColor:DETAILTEXTCOLOR forState:UIControlStateNormal];
            [sendBtnTitle setTitle:@" 促销" forState:UIControlStateNormal];
            [goodsView addSubview:sendBtnTitle];
            
            UIImageView   *iconImage = [[UIImageView alloc] init];
            iconImage.frame = CGRectMake(41 , 15, 90, 90);
            [goodsView addSubview:iconImage];
     


            UILabel   *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImage.frame) +8, 7 , SCREEN_WIDTH -  CGRectGetMaxX(iconImage.frame) +8 - 20, 36)];
            titleLabel.font = Font15;
            titleLabel.numberOfLines = 2;
            titleLabel.textColor = TITLETEXTLOWCOLOR;
            [goodsView addSubview:titleLabel];
        
           UILabel *productsLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImage.frame) +8, CGRectGetMaxY(titleLabel.frame)+10, name.width, 15)];
            productsLabel.font = Font12;
            productsLabel.textColor = DETAILTEXTCOLOR;
            [goodsView addSubview:productsLabel];
        
           UILabel  *pricesLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImage.frame) +8, CGRectGetMaxY(productsLabel.frame)+10, titleLabel.width/2, 15)];
            pricesLable.font = Font12;
            pricesLable.textColor = KMAINCOLOR;
            [goodsView addSubview:pricesLable];
            pricesLable.text = @"赠品";
            
            UIView *changeView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 105 ,CGRectGetMaxY(productsLabel.frame)+5 , 90, 25)];
            [goodsView addSubview:changeView];
            
            UILabel * numbersLable = [[UILabel alloc] initWithFrame:CGRectMake(29.5, -0.5,33 ,25)];
            numbersLable.textColor = TITLETEXTLOWCOLOR;
            numbersLable.font =  PLACEHOLDERFONT;
            numbersLable.textAlignment = NSTextAlignmentCenter;
            [changeView addSubview:numbersLable];
            [numbersLable layerForViewWith:0 AndLineWidth:0.5];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 119, SCREEN_WIDTH, 1)];
            lineView.backgroundColor =  LINECOLOR;
            [goodsView addSubview:lineView];
        }
}

- (void)btnReduce:(UIButton *)sender {
    
    if (_reduceBlock) {
        _reduceBlock(_goodsModel);
    }
}

- (void)btnAdd:(UIButton *)sender {
 
    if (_addBlock) {
        _addBlock(_goodsModel);
    }
}

- (void)chageBtnClick:(UIButton *)sender{
// jp 暂时不用
    if (_changeNumberBlock) {
        _changeNumberBlock(_goodsModel);
    }
}


- (void)checkBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    _goodsModel.selectStatue = sender.selected?@"1":@"0";

    if (_selectBlock) {
        _selectBlock(_goodsModel);
    }
}


@end
