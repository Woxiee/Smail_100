//
//  OrderDetailVC.m
//  MyCityProject
//
//  Created by Faker on 17/6/8.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "OrderDetailVC.h"
#import "OrderVModel.h"
#import "CloseReasonView.h"
#import "DefaultAdressCell.h"
#import "OrderGoodDetailCell.h"
#import "KX_ApprovalContentCell.h"
#import "GoodsCombinedCell.h"
#import "GoodSOrderCommonCell.h"
#import "OrderPayTypeCell.h"
#import "orderOtherInfo.h"
#import "OrderFootView.h"
#import "OrderServiewInfoCell.h"
#import "OrderWeekInfoCell.h"
#import "AttributeCell.h"
//#import "OrderMoneyVC.h"
//#import "ContractDetailVC.h"
#import "SendCommentsVC.h"

//#import "InvoiceDetailVC.h"
//#import "InvoiceOtherDetailVC.h"

@interface OrderDetailVC ()
@property (nonatomic, weak)  OrderFootView *footView;
@property (nonatomic, strong)  OrderDetailModel *detailModel;
@end

@implementation OrderDetailVC
static NSString *const defaultAdressCellID = @"DefaultAdressCellID";
static NSString *const orderGoodDetailCellID = @"OrderGoodDetailCellID";
static NSString * const ContenGeneralCellID = @"ContenGeneralCellID";
static NSString * const goodsCombinedCellID = @"goodsCombinedCellID";
static NSString *const goodSOrderCommonCell = @"GoodSOrderCommonCellID";
static NSString *const orderPayTypeCellID = @"OrderPayTypeCellID";
static NSString *const orderOtherInfoID = @"orderOtherInfoID";
static NSString *const orderServiewInfoCellID = @"orderServiewInfoCellID";
static NSString *const OrderWeekInfoCellID = @"OrderWeekInfoCellID";
static NSString * const cellID = @"cellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self requestNetWork];
}


#pragma mark - 得到网络数据
-(void)requestNetWork
{
    WEAKSELF;
    if (KX_NULLString(_orderID)) {
        _orderID = @"";
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
    [param setObject:_orderID forKey:@"orderId"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [OrderVModel getOrderDetailParam:param successBlock:^(NSArray <OrderDetailModel *>*dataArray, BOOL isSuccess) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isSuccess) {
            OrderDetailModel *model = dataArray[0];
            weakSelf.detailModel = model;


            [self.resorceArray addObject:@[@"地址"]];
            [self.resorceArray addObject:@[@"商品数据"]];
            [self.resorceArray addObject:@[@"买家留言"]];
            [self.resorceArray addObject:@[@"商品小计"]];

            if (_isDetection) {
                [self.resorceArray addObject:@[@"服务周期"]];
            }
            [self.resorceArray addObject: @[@"发票信息"]]; ///5
            [self.resorceArray addObject:@[@"付款信息"]];
            
            if (_isLease) {
                if (_detailModel.order.deposit && ![ _detailModel.order.deposit isEqualToString:@"0.00"]) {
                    [self.resorceArray addObject:@[@"押金"]]; ///5
                }
            }
            
//            if ([model.order.payStatus integerValue] == 1 ) {
                NSArray *payArr = @[@"已付款"];
                [self.resorceArray addObject:payArr];
//            }
        
       
            if ([model.order.payMentType integerValue] == 2) {
                NSArray *payArr = @[@"分期付款"];
                [self.resorceArray addObject:payArr];
            }
            
            [self.resorceArray addObject:@[@"订单信息"]];///8

            
            [weakSelf.tableView reloadData];

        }else{
            
        }

    }];

}

/// 处理订单操作
- (void)operationRequestUrl:(NSString *)url Param:(id)param
{
    WEAKSELF;
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [OrderVModel getOrderOperationUrl:url Param:param successBlock:^( BOOL isSuccess,NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isSuccess) {
            [weakSelf.view toastShow:@"操作成功~"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [weakSelf.view toastShow:message];
        }
        
    }];
    
}

/// 初始化视图
- (void)setup
{
    self.title = @"订单详情";
    WEAKSELF;
    self.tableView.tableFooterView = [UIView new];//默认设置为空
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BACKGROUND_COLOR;
    OrderFootView *footView = [[OrderFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    footView.backgroundColor = [UIColor whiteColor];
    self.footView = footView;
    self.footView.model = _model;
    self.footView.didClickOrderItemBlock = ^(NSString *title){
        [weakSelf operationOrderWithTitle:title OrderModel:_model];
    };
    self.tableView.tableFooterView = footView;
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DefaultAdressCell" bundle:nil] forCellReuseIdentifier:defaultAdressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderGoodDetailCell" bundle:nil]
    forCellReuseIdentifier:orderGoodDetailCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"KX_ApprovalContentCell" bundle:nil] forCellReuseIdentifier:ContenGeneralCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsCombinedCell" bundle:nil] forCellReuseIdentifier:goodsCombinedCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodSOrderCommonCell" bundle:nil] forCellReuseIdentifier:goodSOrderCommonCell];

    [self.tableView registerNib:[UINib nibWithNibName:@"OrderPayTypeCell" bundle:nil] forCellReuseIdentifier:orderPayTypeCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"orderOtherInfo" bundle:nil] forCellReuseIdentifier:orderOtherInfoID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderServiewInfoCell" bundle:nil] forCellReuseIdentifier:orderServiewInfoCellID];

    [self.tableView registerNib:[UINib nibWithNibName:@"OrderWeekInfoCell" bundle:nil] forCellReuseIdentifier:OrderWeekInfoCellID];

    [ self.tableView  registerNib:[UINib nibWithNibName:@"AttributeCell" bundle:nil] forCellReuseIdentifier:cellID];


}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resorceArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *title =   self.resorceArray[indexPath.section][indexPath.row];
    if ([title isEqualToString:@"地址"]) {
        DefaultAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultAdressCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderDetailModel = _detailModel;
        cell.markView.hidden = YES;
        return cell;
    }
    else if ([title isEqualToString:@"商品数据"]){
        OrderGoodDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:orderGoodDetailCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _detailModel;
        return cell;
    }
    else if ([title isEqualToString:@"买家留言"]){
        KX_ApprovalContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ContenGeneralCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = @"买家留言: ";
        cell.titleLabel.textColor = TITLETEXTLOWCOLOR;
        cell.contenTextView.tag = 200;
        cell.contenTextView.userInteractionEnabled = NO;
        cell.contenTextView.text = _detailModel.order.buyerRemarks;
        cell.contenTextView.myPlaceholder = @"";
        cell.contenTextView.textColor = DETAILTEXTCOLOR;
        return cell;
    }
    
    else if ([title isEqualToString:@"商品小计"]){
        GoodsCombinedCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCombinedCellID];
        NSString *str1 = [NSString stringWithFormat:@"￥%@",_detailModel.order.sumAmout];
        NSString *str =[NSString stringWithFormat:@"共%@件商品，小计：%@",_detailModel.order.buyCount,str1];
        NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:17 weight:UIFontWeightThin]];
        cell.titleLB.attributedText = attributedStr;
        return cell;
    }
    
    else if ([title isEqualToString:@"服务周期"]){
        OrderServiewInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:orderServiewInfoCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _detailModel;
        return cell;
    }
    
    else if ([title isEqualToString:@"发票信息"]){
        GoodSOrderCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderCommonCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLB.text = self.resorceArray[indexPath.section][indexPath.row];
        cell.titleLB.textColor = TITLETEXTLOWCOLOR;
        cell.detailLB.text = _detailModel.invoiceValue;
        return cell;
    }
    
    else if ([title isEqualToString:@"付款信息"]){
    
        if (_isLease) {
            OrderWeekInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderWeekInfoCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = _detailModel;
            return cell;
        }else{
            OrderPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:orderPayTypeCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = _detailModel;
            return cell;
        }
       

    }
    else if ([title isEqualToString:@"押金"]){

        AttributeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.textColor = TITLETEXTLOWCOLOR;
        cell.titleLabel.text = self.resorceArray[indexPath.section][indexPath.row];
        cell.detailLabel.textAlignment = NSTextAlignmentRight;
        cell.detailLabel.text =  [NSString stringWithFormat:@"￥%@",_detailModel.order.deposit];
        return cell;

    }
    else if ([title isEqualToString:@"已付款"]){
        GoodSOrderCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderCommonCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLB.textColor = TITLETEXTLOWCOLOR;
        
        cell.titleLB.text = self.resorceArray[indexPath.section][indexPath.row];
        cell.detailLB.text = [NSString stringWithFormat:@"￥%@",_detailModel.order.orderPay];
        return cell;
    }
    
    else if ([title isEqualToString:@"分期付款"]){
        GoodSOrderCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderCommonCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLB.textColor = TITLETEXTLOWCOLOR;
        
        cell.titleLB.text = self.resorceArray[indexPath.section][indexPath.row];
        cell.detailLB.text = [NSString stringWithFormat:@"￥%@",_detailModel.order.orderPay];
        return cell;
    }
    
    else if ([title isEqualToString:@"订单信息"]){
        orderOtherInfo *cell = [tableView dequeueReusableCellWithIdentifier:orderOtherInfoID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _detailModel;
        return cell;
    }
    /*
    if (_isDetection) {
        /// 租赁类型
        OrderDetailModel *model = self.resorceArray[0][0];
        if (indexPath.section == 0) {
            DefaultAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultAdressCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.orderDetailModel = model;
            cell.markView.hidden = YES;
            return cell;
        }
        
        else if (indexPath.section ==1){
            OrderGoodDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:orderGoodDetailCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }
        
        else if (indexPath.section ==2){
            KX_ApprovalContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ContenGeneralCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"买家留言: ";
            cell.titleLabel.textColor = TITLETEXTLOWCOLOR;
            cell.contenTextView.tag = 200;
            cell.contenTextView.userInteractionEnabled = NO;
            cell.contenTextView.text = model.order.buyerRemarks;
            cell.contenTextView.myPlaceholder = @"";
            cell.contenTextView.textColor = DETAILTEXTCOLOR;
            return cell;
        }
        
        else if (indexPath.section == 3){
            GoodsCombinedCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCombinedCellID];
            NSString *str1 = [NSString stringWithFormat:@"￥%@",model.order.sumAmout];
            NSString *str =[NSString stringWithFormat:@"共%@件商品，小计：%@",model.order.buyCount,str1];
            NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:17 weight:UIFontWeightThin]];
            cell.titleLB.attributedText = attributedStr;
            return cell;
        }
        else if (indexPath.section == 4){
            OrderServiewInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:orderServiewInfoCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }
        
        else if (indexPath.section == 5){
            GoodSOrderCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderCommonCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLB.text = self.resorceArray[indexPath.section][indexPath.row];
            cell.titleLB.textColor = TITLETEXTLOWCOLOR;
            cell.detailLB.text = model.invoiceValue;
            return cell;
        }
        
        else if (indexPath.section == 6){
            OrderPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:orderPayTypeCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }

        else if (indexPath.section == 7){
            GoodSOrderCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderCommonCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLB.textColor = TITLETEXTLOWCOLOR;
            
            cell.titleLB.text = self.resorceArray[indexPath.section][indexPath.row];
            cell.detailLB.text = [NSString stringWithFormat:@"￥%@",model.order.orderPay];
            return cell;
        }
        
        else if (indexPath.section == 8){
            orderOtherInfo *cell = [tableView dequeueReusableCellWithIdentifier:orderOtherInfoID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }

    }
    if (_isLease) {
        /// 租赁类型
        OrderDetailModel *model = self.resorceArray[0][0];
        if (indexPath.section == 0) {
            DefaultAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultAdressCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.orderDetailModel = model;
            cell.markView.hidden = YES;
            return cell;
        }
        
        else if (indexPath.section ==1){
            OrderGoodDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:orderGoodDetailCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }
        
        else if (indexPath.section ==2){
            KX_ApprovalContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ContenGeneralCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"买家留言: ";
            cell.titleLabel.textColor = TITLETEXTLOWCOLOR;
            cell.contenTextView.tag = 200;
            cell.contenTextView.userInteractionEnabled = NO;
            cell.contenTextView.text = model.order.buyerRemarks;
            cell.contenTextView.myPlaceholder = @"";
            cell.contenTextView.textColor = DETAILTEXTCOLOR;
            return cell;
        }
        
        else if (indexPath.section == 3){
            GoodsCombinedCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCombinedCellID];
            NSString *str1 = [NSString stringWithFormat:@"￥%@",model.order.sumAmout];
            NSString *str =[NSString stringWithFormat:@"共%@件商品，小计：%@",model.order.buyCount,str1];
            NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:17 weight:UIFontWeightThin]];
            cell.titleLB.attributedText = attributedStr;
            return cell;
        }
        
        else if (indexPath.section == 4){
            GoodSOrderCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderCommonCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLB.text = self.resorceArray[indexPath.section][indexPath.row];
            cell.titleLB.textColor = TITLETEXTLOWCOLOR;
            cell.detailLB.text = model.invoiceValue;
            return cell;
        }
        
        else if (indexPath.section == 5){
            OrderWeekInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderWeekInfoCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }
        else if (indexPath.section == 6){
            AttributeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.textColor = TITLETEXTLOWCOLOR;
            cell.titleLabel.text = self.resorceArray[indexPath.section][indexPath.row];
            cell.detailLabel.textAlignment = NSTextAlignmentRight;
            cell.detailLabel.text =  [NSString stringWithFormat:@"￥%@",model.order.deposit];
            return cell;
        }
        
        else if (indexPath.section == 7){
            GoodSOrderCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderCommonCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLB.textColor = TITLETEXTLOWCOLOR;
            
            cell.titleLB.text = self.resorceArray[indexPath.section][indexPath.row];
            cell.detailLB.text = [NSString stringWithFormat:@"￥%@",model.order.orderPay];
            return cell;
        }
        
        else if (indexPath.section == 8){
            orderOtherInfo *cell = [tableView dequeueReusableCellWithIdentifier:orderOtherInfoID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }

    }
    
    /// 购买商品类型
    else{
        OrderDetailModel *model = self.resorceArray[0][0];
        if (indexPath.section == 0) {
            DefaultAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultAdressCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.orderDetailModel = model;
            cell.markView.hidden = YES;
            return cell;
        }
        
        else if (indexPath.section ==1){
            OrderGoodDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:orderGoodDetailCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }
        
        else if (indexPath.section ==2){
            KX_ApprovalContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ContenGeneralCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"买家留言: ";
            cell.titleLabel.textColor = TITLETEXTLOWCOLOR;
            cell.contenTextView.tag = 200;
            cell.contenTextView.userInteractionEnabled = NO;
            cell.contenTextView.text = model.order.buyerRemarks;
            cell.contenTextView.myPlaceholder = @"";
            cell.contenTextView.textColor = DETAILTEXTCOLOR;
            return cell;
        }
        
        else if (indexPath.section == 3){
            GoodsCombinedCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCombinedCellID];
            NSString *str1 = [NSString stringWithFormat:@"￥%@",model.order.sumAmout];
            NSString *str =[NSString stringWithFormat:@"共%@件商品，小计：%@",model.order.buyCount,str1];
            NSAttributedString *attributedStr =  [str creatAttributedString:str withMakeRange:NSMakeRange(str.length- str1.length, str1.length) withColor:BACKGROUND_COLORHL withFont:[UIFont systemFontOfSize:17 weight:UIFontWeightThin]];
            cell.titleLB.attributedText = attributedStr;
            return cell;
        }
        
        else if (indexPath.section == 4){
            GoodSOrderCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderCommonCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLB.text = self.resorceArray[indexPath.section][indexPath.row];
            cell.titleLB.textColor = TITLETEXTLOWCOLOR;
            cell.detailLB.text = model.invoiceValue;
            return cell;
        }
        
        else if (indexPath.section == 5){
            OrderPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:orderPayTypeCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }
        
        else if (indexPath.section == 6){
            GoodSOrderCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderCommonCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLB.textColor = TITLETEXTLOWCOLOR;
            
            cell.titleLB.text = self.resorceArray[indexPath.section][indexPath.row];
            cell.detailLB.text = [NSString stringWithFormat:@"￥%@",model.order.orderPay];
            return cell;
        }
        
        else if (indexPath.section == 7){
            orderOtherInfo *cell = [tableView dequeueReusableCellWithIdentifier:orderOtherInfoID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }

    }
  */
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title =   self.resorceArray[indexPath.section][indexPath.row];
    if ([title isEqualToString:@"地址"]) {
         return 82;
    }
    else if ([title isEqualToString:@"商品数据"]){
           return 82;
    }
    else if ([title isEqualToString:@"买家留言"]){
        CGSize contentSize;
        contentSize = [NSString heightForString:_detailModel.order.buyerRemarks fontSize:[UIFont systemFontOfSize:15.f] WithSize:CGSizeMake( SCREEN_WIDTH - 100, 500)];
        
        if (contentSize.height < 16) {
            contentSize.height = 14;
        }else{
            contentSize.height = contentSize.height ;
        }
        return  contentSize.height +30;
    }
    
    else if ([title isEqualToString:@"商品小计"]){
         return  44;
    }
    
    else if ([title isEqualToString:@"服务周期"]){
        return 176;

    }
    
    else if ([title isEqualToString:@"发票信息"]){
        return  44;
    }
    
    else if ([title isEqualToString:@"付款信息"]){
        if (_isLease) {
            return 122;
        }
         return 75;
    }
    else if ([title isEqualToString:@"押金"]){
            return  44;
    }
    else if ([title isEqualToString:@"已付款"]){
            return  44;
    }
    
    else if ([title isEqualToString:@"分期付款"]){
            return  44;
    }
    
    else if ([title isEqualToString:@"订单信息"]){
           return 90;
    }
//    if (_isLease ) {
//        if (indexPath.section == 0) {
//            return 82;
//        }
//        else if (indexPath.section == 1)
//        {
//            return 82;
//        }
//        
//        else if (indexPath.section == 2)
//        {
//            OrderDetailModel *model = self.resorceArray[0][0];
//            
//            CGSize contentSize;
//            contentSize = [NSString heightForString:model.order.buyerRemarks fontSize:[UIFont systemFontOfSize:15.f] WithSize:CGSizeMake( SCREEN_WIDTH - 100, 500)];
//            
//            if (contentSize.height < 16) {
//                contentSize.height = 14;
//            }else{
//                contentSize.height = contentSize.height ;
//            }
//            return  contentSize.height +30;
//            
//        }
//        else if (indexPath.section == 5)
//        {
//            return 90;
//        }
//        
//        else if (indexPath.section == 8)
//        {
//            return 90;
//        }
//        return 44;
//    }
//    else if (_isDetection){
//        if (indexPath.section == 0) {
//            return 92;
//        }
//        else if (indexPath.section == 1)
//        {
//            return 82;
//        }
//        
//        else if (indexPath.section == 2)
//        {
//            OrderDetailModel *model = self.resorceArray[0][0];
//            
//            CGSize contentSize;
//            contentSize = [NSString heightForString:model.order.buyerRemarks fontSize:[UIFont systemFontOfSize:15.f] WithSize:CGSizeMake( SCREEN_WIDTH - 100, 500)];
//            
//            if (contentSize.height < 16) {
//                contentSize.height = 14;
//            }else{
//                contentSize.height = contentSize.height ;
//            }
//            return  contentSize.height +30;
//            
//        }
//        else if (indexPath.section == 4)
//        {
//            return 133;
//        }
//        else if (indexPath.section == 6)
//        {
//            return 70;
//        }
//        
//        else if (indexPath.section == 8)
//        {
//            return 90;
//        }
//        return 44;
//
//    }
//    
//    else{
//        if (indexPath.section == 0) {
//            return 92;
//        }
//        else if (indexPath.section == 1)
//        {
//            return 82;
//        }
//        
//        else if (indexPath.section == 2)
//        {
//            OrderDetailModel *model = self.resorceArray[0][0];
//            
//            CGSize contentSize;
//            contentSize = [NSString heightForString:model.order.buyerRemarks fontSize:[UIFont systemFontOfSize:15.f] WithSize:CGSizeMake( SCREEN_WIDTH - 100, 500)];
//            
//            if (contentSize.height < 16) {
//                contentSize.height = 14;
//            }else{
//                contentSize.height = contentSize.height ;
//            }
//            return  contentSize.height +30;
//            
//        }
//        else if (indexPath.section == 5)
//        {
//            return 70;
//        }
//        
//        else if (indexPath.section == 7)
//        {
//            return 90;
//        }
//        return 44;
//    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2 || section == 3) {
        return 0;
    }
    else if (section == 0){
        return 43;
    }
    else if (section == 1){
        return 50;
    }
    return 10;

}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OrderDetailModel *model = _detailModel;

    if (section == 0) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43)];
        headView.backgroundColor = [UIColor clearColor];
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12, 43)];
        titleLB.textColor = BACKGROUND_COLORHL;
        titleLB.font = Font15;
        titleLB.text = model.order.orderStatusTitle;
        [headView addSubview:titleLB];
        return headView;
    }
    else if (section == 1) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        headView.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        lineView.backgroundColor = BACKGROUND_COLOR;
        [headView addSubview:lineView];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, SCREEN_WIDTH - 12, 44)];
        titleLB.textColor = DETAILTEXTCOLOR;
        titleLB.font = Font15;
        titleLB.text = model.order.sellerCompName;
        [headView addSubview:titleLB];
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView1.backgroundColor = LINECOLOR;
        [headView addSubview:lineView1];
        
        return headView;
    }
    return nil;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *title = self.resorceArray[indexPath.section][indexPath.row];
    if ([title isKindOfClass:[NSString class]]) {
        if ([title isEqualToString:@"发票信息"]) {
//            if (![model.invoiceValue isEqualToString:@"不开发票"]) {
            
//            }
            
            if ([_detailModel.invoiceType integerValue]  == 0) {
            }
            else if ([_detailModel.invoiceType integerValue]  == 1)
            {
//                InvoiceOtherDetailVC * VC = [[InvoiceOtherDetailVC alloc] init];
//                VC.model = _detailModel;
//                [self.navigationController pushViewController:VC animated:YES];

            }
            else if ([_detailModel.invoiceType integerValue]  == 2)
            {
//                InvoiceDetailVC * VC = [[InvoiceDetailVC alloc] init];
//                VC.model = _detailModel;
//                [self.navigationController pushViewController:VC animated:YES];

            }
            else if ([_detailModel.invoiceType integerValue]  == 3)
            {
//                InvoiceOtherDetailVC * VC = [[InvoiceOtherDetailVC alloc] init];
//                VC.model = _detailModel;
//                [self.navigationController pushViewController:VC animated:YES];
            }
            
        
        }
        else if ([title isEqualToString:@"已付款"])
        {
//            OrderMoneyVC * VC = [[OrderMoneyVC alloc] init];
//            VC.resorceArray = (NSMutableArray *)_detailModel.payRecordList;
//            VC.model = _detailModel;
//            [self.navigationController pushViewController:VC animated:YES];
        }
        
        else if ([title isEqualToString:@"分期付款"])
        {
//            OrderMoneyVC * VC = [[OrderMoneyVC alloc] init];
//            VC.orderMoneyType = InstallmenGoodsOrdertType;
//
//            VC.resorceArray = (NSMutableArray *)_detailModel.payDetailList;
//            VC.model = _detailModel;
//            [self.navigationController pushViewController:VC animated:YES];
        }
   
    }
}

//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


#pragma mark - private
///处理订单所有状态
- (void)operationOrderWithTitle:(NSString *)title OrderModel:(OrderModel *)model
{
    if (model.bidKey) {
//        ContractDetailVC *VC = [[ContractDetailVC alloc] init];
//        VC.contractId = model.contractId;
//        VC.model = model;
//        VC.isHidden = YES;
//        [self.navigationController pushViewController:VC animated:YES];
        //        SuccessView *successV = [[SuccessView alloc] initWithTrueCancleTitle:@"前往机汇网电脑端订单管理界面进行操作\n网址www.myjihui.com" cancelTitle:@"" clickDex:^(NSInteger clickDex) {
        //            if (clickDex == 1) {
        //
        //            }}];
        //        [successV showSuccess];
        return;
    }
    else if([model.isFronzen integerValue] == 1){
        SuccessView *successV = [[SuccessView alloc] initWithTrueCancleTitle:@"该订单已冻结~" cancelTitle:@"" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                
            }}];
        [successV showSuccess];
        return;
        
    }
    WEAKSELF;
    __block NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
    if (KX_NULLString(model.orderId)) {
        model.orderId = @"";
    }
    if ([title isEqualToString:@"取消订单"]) {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
        [param setObject:model.orderId forKey:@"orderId"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].uid forKey:@"uid"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].bid forKey:@"bid"];
        
        
        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"取消订单后将自动关闭\n  是否确认取消订单" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [weakSelf operationRequestUrl:@"/o/o_087" Param:param];
            }}];
        [successV showSuccess];
    }
    else if ([title isEqualToString:@"取消参与"])
    {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
        [param setObject:model.groupId forKey:@"groupId"];
        
        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"取消参与后将自动关闭\n  是否确认取消参与" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [weakSelf operationRequestUrl:@"/o/o_116" Param:param];
            }}];
        [successV showSuccess];
    }
    else if ([title isEqualToString:@"付款"])
    {
        SuccessView *successV = [[SuccessView alloc] initWithTrueCancleTitle:@"前往机汇网电脑端订单管理界面付款\n网址www.myjihui.com" cancelTitle:@"" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                
            }}];
        [successV showSuccess];
        
    }
    else if ([title isEqualToString:@"确认收货"] )
    {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
        [param setObject:model.orderId forKey:@"orderId"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].aid  forKey:@"aid"];
        
        NSString *titleStr;
        //        if (!_isLease) {
        //            titleStr = @"确认收货并商家同意后，订单将自动完成";
        //        }else{
        //            titleStr = @"确认收货后，订单将进入在租状态，\n请确认是否收到商品?";
        //        }
        titleStr = @"请确认是否收货？";
        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:titleStr clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [weakSelf  operationRequestUrl:@"/o/o_089" Param:param];
            }}];
        [successV showSuccess];
    }
    
    else if ([title isEqualToString:@"确认服务"] )
    {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
        [param setObject:model.orderId forKey:@"orderId"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].aid  forKey:@"aid"];
        
        NSString *titleStr;
        titleStr = @"确认服务并商家同意后，订单将自动完成";
        
        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:titleStr clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [weakSelf  operationRequestUrl:@"/o/o_089" Param:param];
            }}];
        [successV showSuccess];
    }
    
    else if ([title isEqualToString:@"删除订单"])
    {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
        [param setObject:model.orderId forKey:@"orderId"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];
        
        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"删除订单后将自动关闭\n  是否确认取消订单" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [weakSelf operationRequestUrl:@"/o/o_092" Param:param];
            }}];
        [successV showSuccess];
        
    }
    else if ([title isEqualToString:@"合同详情"])
    {
        
//        ContractDetailVC *VC = [[ContractDetailVC alloc] init];
//        VC.contractId = model.contractId;
//        VC.model = model;
//        [self.navigationController pushViewController:VC animated:YES];
        
    }
    else if ([title isEqualToString:@"发表评价"])
    {
        SendCommentsVC *VC = [[SendCommentsVC alloc] init];
        VC.model = model;
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if ([title isEqualToString:@"评价详情"])
    {
        SendCommentsVC *VC = [[SendCommentsVC alloc] init];
        VC.model = model;
        VC.commeType = ShowTypeType;
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if ([title isEqualToString:@"申请撤单"])
    {
        CloseReasonView *closeReasonView = [[CloseReasonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) Title:@"关闭理由" andTitle1:@"卖家审核通过后，订单将会自动关闭"];
        closeReasonView.didClickReasonBlock = ^(NSString *str){
            [param setObject:str forKey:@"closeReason"];
            [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
            [param setObject:model.orderId forKey:@"orderId"];
            [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];
            
            [weakSelf operationRequestUrl:@"/o/o_091" Param:param];
        };
        [closeReasonView show];
    }
    
    else if ([title isEqualToString:@"申请退租"])
    {
        CloseReasonView *closeReasonView = [[CloseReasonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) Title:@"退租理由" andTitle1:@"租赁方结束租赁后，订单将会自动关闭"];
        closeReasonView.didClickReasonBlock = ^(NSString *str){
            [param setObject:str forKey:@"closeReason"];
            [param setObject:model.orderId forKey:@"orderId"];
            [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];
            
            [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
            
            [weakSelf operationRequestUrl:@"/o/o_090" Param:param];
        };
        [closeReasonView show];
    }
    else if ([title isEqualToString:@"同意合同"])
    {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName  forKey:@"mNickname"];
        [param setObject:model.contractId forKey:@"contractId"];
        [param setObject:model.orderId forKey:@"orderId"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].aid  forKey:@"aid"];
        
        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"同意后，将按照合同约定执行，请\n确认是否同意" clickDex:^(NSInteger clickDex) {
            if (clickDex == 1) {
                [weakSelf operationRequestUrl:@"/o/o_088" Param:param];
            }}];
        [successV showSuccess];
    }
    
    
}



@end
