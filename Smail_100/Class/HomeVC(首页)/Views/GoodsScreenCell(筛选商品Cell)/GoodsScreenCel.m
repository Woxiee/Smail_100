//
//  GoodsScreenCel.m
//  MyCityProject
//
//  Created by Faker on 17/5/6.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsScreenCel.h"
#import "GoodSDetailModel.h"
@implementation GoodsScreenCel
{
    __weak IBOutlet UIImageView *iconImageView;
    
    __weak IBOutlet UILabel *titleLabel;
    
    __weak IBOutlet UILabel *priceLabel;
    
    
    __weak IBOutlet UILabel *compangLabel;
    
    __weak IBOutlet UIImageView *markImageView;  /// 收藏界面才用到
    
    __weak IBOutlet UILabel *addressLabel;
    
    __weak IBOutlet NSLayoutConstraint *imageView1ConstrainsHight;
    __weak IBOutlet NSLayoutConstraint *imageView2ContrainsHight;
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfiguration];

}


/// 配置基础设置
- (void)setConfiguration
{
    titleLabel.font = Font15;
    
    priceLabel.font = PLACEHOLDERFONT;
    priceLabel.textColor = BACKGROUND_COLORHL;
    
    
    compangLabel.font = Font13;
    compangLabel.textColor = DETAILTEXTCOLOR;
    
    addressLabel.font = Font13;
    addressLabel.textColor = DETAILTEXTCOLOR;

}


-(void)setModel:(GoodsScreenListModel *)model
{
    _model = model;
    if (!_isCollect ) {
        markImageView.hidden = YES;
    }
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.full_path] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    /// 采集
    if (_cellShowType == GoodsScreenCellCollectType) {
        titleLabel.text = _model.groupBuyName;
        priceLabel.text = [NSString stringWithFormat:@"￥%@",_model.price];
        compangLabel.text = [NSString stringWithFormat:@"有效时间   %@之前",_model.endTime];
        addressLabel.text = [NSString stringWithFormat:@"已获得集采量 %@",_model.buyCount];
        markImageView.image = [UIImage imageNamed:@"61@3x.png"];
        imageView1ConstrainsHight.constant = 0;
        imageView2ContrainsHight.constant = 0;

        
    }
    /// 拍卖
    else if (_cellShowType == GoodsScreenCellAuctionType){
        markImageView.hidden = NO;

        titleLabel.text = _model.productName;
        NSString *str1 = [NSString stringWithFormat:@"￥%@",_model.dqPrice];
        NSString *str =[NSString stringWithFormat:@"当前价%@",str1];
        NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:15 weight:UIFontWeightThin]];
//        weakSelf.orderPiceLB.attributedText =  attributedStr;
        priceLabel.attributedText = attributedStr;
        compangLabel.text = [NSString stringWithFormat:@"出价次数 %@",_model.offerCount];
        if ([_model.status integerValue] == 1) {
            addressLabel.text = [NSString stringWithFormat:@"预计%@开始",_model.startTime];
            markImageView.image = [UIImage imageNamed:@"jijiangkaishi@3x.png"];
        }
        else if ([_model.status integerValue] == 2)
        {
            addressLabel.text = [NSString stringWithFormat:@"预计%@结束",_model.endTime];
            markImageView.image = [UIImage imageNamed:@"zhengzaijinxing@3x.png"];
        }
        else{
            addressLabel.text = @"已结束";
            markImageView.image = [UIImage imageNamed:@"yijingjieshu@3x.png"];
        }
        
        imageView1ConstrainsHight.constant = 0;
        imageView2ContrainsHight.constant = 0;
    }
    else{
        titleLabel.text = _model.productName;
        if (_cellShowType == GoodsScreenCellWholeType) {
            NSString *str1 = @"/月";
            NSString *str = [NSString stringWithFormat:@"￥%@%@",_model.formatDouble,str1];           NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:DETAILTEXTCOLOR withFont:[UIFont systemFontOfSize:15 weight:UIFontWeightThin]];
            //        weakSelf.orderPiceLB.attributedText =  attributedStr;
            priceLabel.attributedText  = attributedStr;
        }
        else if (_cellShowType == GoodsScreenCellDetectionType){
            priceLabel.text = [NSString stringWithFormat:@"￥%@",_model.price];
            markImageView.image = [UIImage imageNamed:@"60@3x.png"];
        }
        else{
            priceLabel.text =[NSString stringWithFormat:@"￥%@", _model.formatDouble];
        }
        compangLabel.text = _model.companyName;
        addressLabel.text = [NSString stringWithFormat:@"%@%@%@",_model.province,_model.city,_model.area];
    }

}


- (void)setCollectModel:(GoodsScreenListModel *)collectModel
{
    _collectModel = collectModel;
    if (!_isCollect ) {
        markImageView.hidden = YES;
    }
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_collectModel.mainResult.imgSrc_one] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    /// 采集
    if (_cellShowType == GoodsScreenCellCollectType) {
        markImageView.image = [UIImage imageNamed:@"61@3x.png"];

        titleLabel.text = _collectModel.mainResult.productName;
        priceLabel.text = [NSString stringWithFormat:@"￥%@",_collectModel.mainResult.price];
        compangLabel.text = [NSString stringWithFormat:@"有效时间   %@",_collectModel.endTime];
        addressLabel.text = [NSString stringWithFormat:@"已参与人数  %@",_collectModel.joinCount];
        
    }

    else{
        titleLabel.text = _collectModel.mainResult.productName;
        if (_cellShowType == GoodsScreenCellNomalType) {
            markImageView.image = [UIImage imageNamed:@"61@3x.png"];
            priceLabel.text = [NSString stringWithFormat:@"￥%@",_collectModel.mainResult.price];
            compangLabel.text = _collectModel.businessResult.busiCompName;
        }
        
        else if (_cellShowType == GoodsScreenCellDetectionType){
            markImageView.image = [UIImage imageNamed:@"60@3x.png"];
            priceLabel.text = [NSString stringWithFormat:@"￥%@",_collectModel.mainResult.price];

            compangLabel.text = [NSString stringWithFormat:@"%@",_collectModel.businessResult.busiCompName];
        }
        
        else if (_cellShowType == GoodsScreenCellWholeType){
            markImageView.image = [UIImage imageNamed:@"62@3x.png"];
            priceLabel.text = [NSString stringWithFormat:@"￥%@",_collectModel.mainResult.price];

            compangLabel.text = [NSString stringWithFormat:@"%@",_collectModel.businessResult.busiCompName];
            
        }

        addressLabel.text = [NSString stringWithFormat:@"%@%@%@",_collectModel.businessResult.busiCompProv,_collectModel.businessResult.busiCompCity,_collectModel.businessResult.busiCompArea];
    }

}


- (void)setHistoryModel:(HistoryModel *)historyModel
{
    _historyModel = historyModel;
    markImageView.hidden = YES;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_historyModel.param1] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];

    if ([_historyModel.productType isEqualToString:@"9"]) {
        titleLabel.text = _historyModel.param2;
        priceLabel.text = [NSString stringWithFormat:@"￥%@",_historyModel.param3];
        compangLabel.text = [NSString stringWithFormat:@"有效时间   %@之前",_collectModel.endTime];
        addressLabel.text = [NSString stringWithFormat:@"已参与人数  %@",_collectModel.buyCount];

    }else{
        titleLabel.text = _historyModel.param2;
        priceLabel.text = [NSString stringWithFormat:@"￥%@",_historyModel.param3];
        compangLabel.text = _historyModel.param4;
        addressLabel.text = _historyModel.param5;
    }
    
}



-(void)setCellShowType:(GoodsScreenCellType)cellShowType
{
    _cellShowType = cellShowType;
}

@end
