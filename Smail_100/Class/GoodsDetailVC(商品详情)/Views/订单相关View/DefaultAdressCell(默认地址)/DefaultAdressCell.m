//
//  DefaultAdressCell.m
//  ShiShi
//
//  Created by ac on 16/3/27.
//  Copyright © 2016年 fec. All rights reserved.
//

#import "DefaultAdressCell.h"

@implementation DefaultAdressCell

{
    __weak IBOutlet UILabel *adressDetail;
    __weak IBOutlet UILabel *phoneNum;
    __weak IBOutlet UILabel *notDefaultName;

    __weak IBOutlet NSLayoutConstraint *addressContenWidth;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    notDefaultName.textColor = TITLETEXTLOWCOLOR;
    notDefaultName.font = Font15;

    adressDetail.textColor = TITLETEXTLOWCOLOR;
    adressDetail.font = PLACEHOLDERFONT;
    
    phoneNum.textColor = TITLETEXTLOWCOLOR;
    phoneNum.font = PLACEHOLDERFONT;
}


- (void)setModel:(GoodsOrderAddressModel *)model
{
    _model = model;
    notDefaultName.text = [NSString stringWithFormat:@"联系人:%@",_model.contact_username];
    phoneNum.text = _model.contact_mobile;
    adressDetail.text = [NSString stringWithFormat:@"收货地址:%@%@%@",_model.province,_model.city,_model.district];
}


-(void)setOrderDetailModel:(OrderDetailModel *)orderDetailModel
{
    _orderDetailModel = orderDetailModel;
    notDefaultName.text = [NSString stringWithFormat:@"联系人:%@",_orderDetailModel.order.buyerName];
    phoneNum.text = _orderDetailModel.order.buyerPhone;
    adressDetail.text = [NSString stringWithFormat:@"收货地址:%@",_orderDetailModel.order.buyerAddress];
    addressContenWidth.constant = 0;

}

- (void)setAddressModel:(Address *)addressModel
{
    _addressModel = addressModel;
    notDefaultName.text = [NSString stringWithFormat:@"收货人:%@",_addressModel.contact_username];
    phoneNum.text = _addressModel.contact_mobile;
    adressDetail.text = [NSString stringWithFormat:@"收货地址:%@%@%@%@",_addressModel.province,_addressModel.city,_addressModel.district,_addressModel.detail];
//    addressContenWidth.constant = 0;
}

@end
