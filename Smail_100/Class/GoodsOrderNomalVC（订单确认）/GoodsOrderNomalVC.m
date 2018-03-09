//
//  GoodsOrderNomalVC.m
//  MyCityProject
//
//  Created by Faker on 17/5/22.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "GoodsOrderNomalVC.h"
#import "DefaultAdressCell.h"
#import "GoodSOrderCommonCell.h"
#import "GoodSOrderNomalCell.h"
#import "GoodsOrderVModel.h"
#import "KX_ApprovalContentCell.h"
#import "GoodsCombinedCell.h"
#import "AddressManageVC.h"
#import "SQActionSheetView.h"
#import "OrderCommitSuccessVC.h"
//#import "GoodsSelectTimeVC.h"
#import "OrdersPayTypeCell.h"
#import "OrderLinkTypeCell.h"
#import "CouponsVModel.h"


#import "MailTypeCell.h"
#import "DeductionCell.h"

@interface GoodsOrderNomalVC ()<UITableViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *orderPiceLB;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign)   NSInteger sectionCount;         /// 返回section数目
@property (nonatomic, strong)   NSMutableArray *addressArr;            /// 新增收货地址Arr
@property (nonatomic, strong)   NSArray *titleArr;              /// 返回section数目

@property (nonatomic, strong)   NSMutableArray *detailArr;             ///
@property (nonatomic, strong) GoodsOrderModel *orderModel;
@property (nonatomic, assign) NSInteger paySelectIndex;
@property (nonatomic, assign) BOOL  isValue;  /// 用来定位  新增收货地址是否有效


@property (nonatomic, strong)   NSString *invoiceTy;            ///发票选定

@end

@implementation GoodsOrderNomalVC
static NSString *const defaultAdressCellID = @"DefaultAdressCellID";
static NSString *const goodSOrderCommonCell = @"GoodSOrderCommonCellID";
static NSString *const goodSOrderNomalCellID = @"goodSOrderNomalCell";
static NSString * const ContenGeneralCellID = @"ContenGeneralCellID";
static NSString * const goodsCombinedCellID = @"goodsCombinedCellID";
static NSString * const MailTypeCellCellID = @"MailTypeCellCellID";
static NSString * const DeductionCellID = @"DeductionCellID";



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
    [self getGoodsOrderInfoRequest];

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self getDefaultAddressRequest];
    
}



/// 配置基础设置
- (void)setConfiguration
{

    self.title  = @"确认订单";
    _submitBtn.backgroundColor = KMAINCOLOR;
    _addressArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = BACKGROUND_COLOR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = BACKGROUND_COLOR;
    [_bottomView layerForViewWith:0 AndLineWidth:0.5];
    [self.tableView registerNib:[UINib nibWithNibName:@"DefaultAdressCell" bundle:nil] forCellReuseIdentifier:defaultAdressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodSOrderCommonCell" bundle:nil] forCellReuseIdentifier:goodSOrderCommonCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodSOrderNomalCell" bundle:nil] forCellReuseIdentifier:goodSOrderNomalCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"KX_ApprovalContentCell" bundle:nil] forCellReuseIdentifier:ContenGeneralCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsCombinedCell" bundle:nil] forCellReuseIdentifier:goodsCombinedCellID];
    
    [self.tableView registerClass:[MailTypeCell class] forCellReuseIdentifier:MailTypeCellCellID];

    [self.tableView registerNib:[UINib nibWithNibName:@"DeductionCell" bundle:nil] forCellReuseIdentifier:DeductionCellID];

}


/// 初始化视图
- (void)setup
{
    
}


#pragma mark = request
/// 获取新增收货地址
- (void)getDefaultAddressRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
    [GoodsOrderVModel getGoodsOrderAddressParam:param successBlock:^(NSArray<GoodsOrderAddressModel *> *dataArray,NSArray<GoodsOrderAddressModel *>*allDataArr,BOOL isSuccess) {
        if (isSuccess) {
            [_addressArr removeAllObjects];
            [_addressArr addObjectsFromArray:dataArray];
            _isValue = NO;
            if (!KX_NULLString(_model.addressID)) {
                for (GoodsOrderAddressModel *addressModel in allDataArr) {
                    if ([addressModel.addr_id isEqualToString:_model.addressID]) {
                        NSArray *arr = @[addressModel];
                        [weakSelf.resorceArray replaceObjectAtIndex:0 withObject:arr];
                        [weakSelf.addressArr addObjectsFromArray:arr];
                        _model.addressID = addressModel.addr_id;
                        _isValue = YES;
                        [weakSelf.tableView reloadData];
                        
                        break;
                    }
                }
                if (_isValue == NO) {
                    [_addressArr removeAllObjects];
                    weakSelf.model.addressID = @"";
                    [weakSelf.resorceArray  replaceObjectAtIndex:0  withObject:@[@"新增收货新增收货地址"]];
                    [weakSelf.tableView reloadData];
                }
            }
        }
        [weakSelf.resorceArray  replaceObjectAtIndex:0  withObject:@[@"新增收货新增收货地址"]];
        [weakSelf.tableView reloadData];
    }];
}



///订单信息 (限定：新机、配构件、二手设备、整机流转的出租、标准节共享的出租)
- (void)getGoodsOrderInfoRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_itemsModel.goods_id forKey:@"goods_id"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:@"" forKey:@"address_id"];
    if (_orderType == ShoppinCarType) {
        [param setObject:@"product" forKey:@"type"];
    }else{
        [param setObject:@"goods" forKey:@"type"];
    }
    [param setObject:_itemsModel.cartNum?_itemsModel.cartNum:@"1" forKey:@"goods_num"];



    [GoodsOrderVModel getGoodsOrderParam:param successBlock:^(NSArray<GoodsOrderModel *> *dataArray, BOOL isSuccess) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isSuccess) {
            if (weakSelf.resorceArray.count >0) {
                [weakSelf.resorceArray removeAllObjects];
            }
            if (dataArray.count > 0) {
                GoodsOrderModel *model = dataArray[0];
                weakSelf.orderModel = model;
                if (KX_NULLString(model.address.province)) {
                    weakSelf.model.addressID = @"";
                    [weakSelf.resorceArray addObject:@"新增收货地址"];

//                    [weakSelf.resorceArray insertObject:@[@"新增收货地址"] atIndex:0];
                }else{
                    [weakSelf.resorceArray addObject:@"新增收货地址"];

//                    [weakSelf.resorceArray insertObject:model.address atIndex:0];
                }
            }

     
            [weakSelf.resorceArray addObject:@"商品详情"];
            if ([weakSelf.orderModel.userinfo.point integerValue]>0) {
                [weakSelf.resorceArray addObject:@"积分抵扣"];

            }

            
            weakSelf.orderModel = dataArray[0];
            if (KX_NULLString(_model.noteConten)) {
                _model.noteConten = @"";
            }
   
            if ([_orderModel.allPoint integerValue] >0) {
                NSString *str1 =[NSString stringWithFormat:@"￥%@+%@",_orderModel.totalMoney,_orderModel.allPoint];
                NSString *str = [NSString stringWithFormat:@"合计：%@积分",str1];
                NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(3, str1.length) withColor:KMAINCOLOR withFont:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium]];
                weakSelf.orderPiceLB.attributedText =  attributedStr;
            }else{
                 weakSelf.orderPiceLB.text = [NSString stringWithFormat:@"合计：%@",_orderModel.totalMoney];
            }
           
            [weakSelf.tableView reloadData];

        }else{
        
        
        }
    }];

}



#pragma mark - UITaleViewDelegate and UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resorceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSString *str = self.resorceArray[section];
    if ([str isEqualToString:@"商品详情"]) {
        return _orderModel.seller.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    NSString *str = self.resorceArray[indexPath.section];
    
    if (indexPath.section == 0) {
        
        if (KX_NULLString(_orderModel.address.province)) {
            GoodSOrderCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderCommonCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLB.text = self.resorceArray[indexPath.section];
            cell.detailLB.text = @"";
            return cell;
        }else{
            DefaultAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultAdressCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.addressModel = _orderModel.address;
            return cell;
        }
    }
    else if (indexPath.section ==1){
        GoodSOrderNomalCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderNomalCellID forIndexPath:indexPath];
        cell.didChangeNumberBlock = ^(NSString *buyNumber){
            weakSelf.model.goodSCount = [buyNumber integerValue];
            [self getGoodsOrderInfoRequest];
        };
        cell.didChangeEmailTypeBlock = ^(NSInteger type) {
            // type  0 邮寄  1门店
            
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Seller *seller = _orderModel.seller[indexPath.row];
        cell.products = seller.products[indexPath.row];
        
        return cell;
    }

    else if (indexPath.section == 2){
        DeductionCell *cell = [tableView dequeueReusableCellWithIdentifier:DeductionCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.didChageJFNumberBlock = ^(NSString *buyNumber) {
            
        };
        cell.userInfo = _orderModel.userinfo;
        return cell;
        
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.resorceArray[indexPath.section];

     if ([str isEqualToString:@"新增收货地址"])
     {
         if (KX_NULLString(_orderModel.address.province)) {
             return 44;
         }
    
            return 82;
    }
     else if ([str isEqualToString:@"商品详情"])
     {
         return 235;
         
     }

     else if([str isEqualToString:@"积分抵扣"]){
         return 100;
     }
    return 0;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 2) {
        return 10;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1){
        return 50;
    }
    return 0;
}



- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH -10, 50)];
        headView.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = BACKGROUND_COLOR;
        [headView addSubview:lineView];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12, 44)];
        titleLB.textColor = TITLETEXTLOWCOLOR;
        titleLB.font = Font15;
        titleLB.textAlignment = NSTextAlignmentRight;
//        _orderModel.totalMoney = @"12333";
//        _orderModel.allPoint  = @"20";
        
        NSString *str1 = @"共";
        NSString *str2 = [NSString stringWithFormat:@"￥%ld",_orderModel.seller.count];
        NSString *str3 = [NSString stringWithFormat:@"共%@件商品       小计:",str2];
        NSString *str4 = [NSString stringWithFormat:@"%@%@",str3,_orderModel.totalMoney];
        
        NSString *str6 = [NSString stringWithFormat:@"+%@积分",_orderModel.allPoint];
        
        if ([_orderModel.allPoint integerValue] >0) {
            NSString *str7 = [NSString stringWithFormat:@"%@%@",str4,str6];
            NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str7];
            [attriString addAttribute:NSForegroundColorAttributeName
                                value:KMAINCOLOR
                                range:NSMakeRange(str1.length,str2.length)];
            [attriString addAttribute:NSForegroundColorAttributeName
                                value:KMAINCOLOR
                                range:NSMakeRange(str3.length,str6.length)];
            
            [attriString addAttribute:NSForegroundColorAttributeName
                                value:KMAINCOLOR
                                range:NSMakeRange(str4.length+1,_orderModel.allPoint.length)];
            titleLB.attributedText = attriString;
            
        }else{
            NSString *str7 = [NSString stringWithFormat:@"%@%@",str4,str6];
            NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str7];
            [attriString addAttribute:NSForegroundColorAttributeName
                                value:KMAINCOLOR
                                range:NSMakeRange(str1.length,str2.length)];
            [attriString addAttribute:NSForegroundColorAttributeName
                                value:KMAINCOLOR
                                range:NSMakeRange(str3.length,str6.length)];
            
            titleLB.attributedText = attriString;
            
        }
        
        [headView addSubview:titleLB];
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView1.backgroundColor = LINECOLOR;
        [headView addSubview:lineView1];
        
        return headView;
    }
    else{
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH -10, 50)];
        headView.backgroundColor = BACKGROUND_COLOR;
        return headView;

        //        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1
    }
    return nil;
}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//   
//    return <#expression#>
//}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
        if (indexPath.section == 0) {
            AddressManageVC *VC = [[AddressManageVC alloc] init];
            VC.model = _model;
            VC.didClickAddressCellBlock = ^(GoodsOrderAddressModel* model){
               weakSelf.model.addressID = model.id;
            };
            [self.navigationController pushViewController:VC animated:YES];
        }
        else if (indexPath.section == 1){
//            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (indexPath.section == 4){
            if (indexPath.row == 0) {
                
            }
            else {
                [self showPaySheetView];
            }
        } 

}




#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.tag == 200) {
        _model.noteConten = textView.text;

    }
    else{
        _detailArr[textView.tag - 100] = textView.text;

    }
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

#pragma mark - KYDatePickerDelegate
-(void)selectDate:(NSString *)date
{
    
}



#pragma mark - private
- (void)showPaySheetView
{
    WEAKSELF;
    
    SQActionSheetView *sheetView = [[SQActionSheetView alloc]initWithTitle:@"选择付款方式" buttons:_model.payArr buttonClick:^(NSInteger buttonIndex,NSString *title) {
        
        if ([title isEqualToString:@"直接付款"]) {
            weakSelf.model.payTypeID =@"1";
        }
        if ([title isEqualToString:@"分期付款"]) {
            weakSelf.model.payTypeID =@"2";
        }
        
        if ([title isEqualToString:@"先用后付"] || [title isEqualToString:_model.monthlyPayments]) {
            weakSelf.model.payTypeID =@"3";
        }
        
        if ([title isEqualToString:@"融资租赁"]) {
            weakSelf.model.payTypeID =@"4";
        }
        weakSelf.model.payTypeTitle = title;
        weakSelf.paySelectIndex = buttonIndex;

        
    }];
    sheetView.oldSelectIndex = _paySelectIndex;
    [sheetView showView];
    
}


- (IBAction)submitBtn:(id)sender {
    
}



@end
