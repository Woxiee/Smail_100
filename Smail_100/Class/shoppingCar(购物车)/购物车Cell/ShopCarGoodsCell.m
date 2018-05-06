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
    UILabel *jifeLB;
}

-  (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
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
    
    
    [selectBtn setImage:[UIImage imageNamed:@"zhuce2@3x.png"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"23@3x.png"] forState:UIControlStateSelected];
    
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
    
    
    priceLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame) +8, CGRectGetMaxY(productLabel.frame)+10, SCREEN_WIDTH - CGRectGetMaxX(headImage.frame) -8-100 , 15)];
    priceLable.font = Font15;
    priceLable.textColor = KMAINCOLOR;
    [goodsView addSubview:priceLable];
    
//
//    jifeLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceLable.frame), CGRectGetMaxY(productLabel.frame)+10, name.width/2, 15)];
//    jifeLB.font = Font15;
//    jifeLB.textAlignment = NSTextAlignmentLeft;
//    jifeLB.textColor = DETAILTEXTCOLOR;
//    [goodsView addSubview:jifeLB];
    
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
    
  
}

/// 配置基础设置
- (void)setConfiguration
{
    
}


- (void)setGoodsModel:(OrderGoodsModel *)goodsModel{
    
    _goodsModel = goodsModel;
    selectBtn.selected = (goodsModel.selectStatue.integerValue ==1);
    [headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",goodsModel.productLogo]] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    name.text = [NSString stringWithFormat:@"%@",goodsModel.productName];
//    [NSString]

//    priceLable.text =[NSString stringWithFormat:@"¥%@",goodsModel.productPrice];
    
    number = [goodsModel.itemCount intValue];
    numberLable.text = goodsModel.itemCount;
    productLabel.text =[NSString stringWithFormat:@"%@",goodsModel.property];
//    if ([goodsModel.point intValue] >0) {
//        NSString *str1 = [NSString stringWithFormat:@"%@",_goodsModel.point];
//        NSString *str =[NSString stringWithFormat:@"+%@积分",str1];
//        NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(1, str1.length) withColor:BACKGROUND_COLORHL withFont:Font15];
//        jifeLB.attributedText = attributedStr;
//
//    }
    
    
    NSMutableArray *priceArr = [[NSMutableArray alloc] init];
    if (goodsModel.productPrice.floatValue >0) {
        [priceArr addObject:[NSString stringWithFormat:@"¥%@",goodsModel.productPrice]];
    }
    if (goodsModel.point.floatValue >0) {
        [priceArr addObject:[NSString stringWithFormat:@"%@ 积分",goodsModel.point]];
    }
    NSString *allPrice = [priceArr componentsJoinedByString:@"+"];
    NSAttributedString *attributedStr =  [self attributeStringWithContent:allPrice keyWords:@[@" 积分"]];
//    moneyLabel.attributedText  = attributedStr;

    priceLable.attributedText  = attributedStr;

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
//    _goodsModel.selectStatue = sender.selected?@"1":@"0";

    if (_selectBlock) {
        _selectBlock(_goodsModel);
    }
}

- (NSAttributedString *)attributeStringWithContent:(NSString *)content keyWords:(NSArray *)keyWords
{
    UIColor *color = KMAINCOLOR;
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:content];
    
    if (keyWords) {
        
        [keyWords enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSMutableString *tmpString=[NSMutableString stringWithString:content];
            
            NSRange range=[content rangeOfString:obj];
            
            NSInteger location=0;
            
            while (range.length>0) {
                
                [attString addAttribute:(NSString*)NSForegroundColorAttributeName value:color range:NSMakeRange(location+range.location, range.length)];
                [attString addAttribute:NSFontAttributeName
                                  value:Font11
                                  range:range];
                
                location+=(range.location+range.length);
                
                NSString *tmp= [tmpString substringWithRange:NSMakeRange(range.location+range.length, content.length-location)];
                
                tmpString=[NSMutableString stringWithString:tmp];
                
                range=[tmp rangeOfString:obj];
            }
        }];
    }
    return attString;
}


@end
