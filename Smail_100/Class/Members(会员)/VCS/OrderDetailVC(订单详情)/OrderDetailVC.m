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
#import "GoodSOrderNomalCell.h"

#import "SendCommentsVC.h"
#import "MailTypeCell.h"
#import "DeductionCell.h"
#import "GoodsCommonCell.h"


@interface OrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak)  OrderFootView *footView;
@property (nonatomic, strong)  OrderDetailModel *detailModel;

@property (nonatomic, strong) GoodsOrderModel *orderModel;
@property (nonatomic, strong) UITableView *tableView;
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

static NSString * const MailTypeCellCellID = @"MailTypeCellCellID";
static NSString * const DeductionCellID = @"DeductionCellID";
static NSString *const goodSOrderNomalCellID = @"goodSOrderNomalCell";

static NSString *const goodsCommonCellID = @"GoodsCommonCellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setConfiguration];
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
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_model.orderno forKey:@"orderno"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [OrderVModel getOrderDetailParam:param successBlock:^(NSArray <GoodsOrderModel *>*dataArray, BOOL isSuccess) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isSuccess) {
            if (weakSelf.resorceArray.count >0) {
                [weakSelf.resorceArray removeAllObjects];
            }
            if (dataArray.count > 0) {
                GoodsOrderModel *model = dataArray[0];
                weakSelf.orderModel = model;
            }

            weakSelf.orderModel.address.contact_username =  @"测试";
            weakSelf.orderModel.address.detail =  @"detail";
            weakSelf.orderModel.address.city =  @"city";
            weakSelf.orderModel.address.addr_id =  @"addr_id";
            weakSelf.orderModel.address.contact_mobile =  @"contact_mobile";
            weakSelf.orderModel.address.province =  @"province";
            weakSelf.orderModel.address.district =  @"district";

            weakSelf.orderModel.isDetail = YES;
            [weakSelf.resorceArray addObject:@"新增收货地址"];
            [weakSelf.resorceArray addObject:@"商品详情"];
            [weakSelf.resorceArray addObject:@"积分抵扣"];
            [weakSelf.resorceArray addObject:@"订单信息"];

        
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
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 40) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 44.f;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    OrderFootView *footView = [[OrderFootView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40 - 64, SCREEN_WIDTH, 40)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view  addSubview:footView];
    self.footView = footView;
    
    self.footView.didClickOrderItemBlock = ^(NSString *title){
        [weakSelf operationOrderWithTitle:title OrderModel:_model];
    };
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DefaultAdressCell" bundle:nil] forCellReuseIdentifier:defaultAdressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderGoodDetailCell" bundle:nil]
    forCellReuseIdentifier:orderGoodDetailCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"KX_ApprovalContentCell" bundle:nil] forCellReuseIdentifier:ContenGeneralCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsCombinedCell" bundle:nil] forCellReuseIdentifier:goodsCombinedCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodSOrderCommonCell" bundle:nil] forCellReuseIdentifier:goodSOrderCommonCell];

    
    [self.tableView registerNib:[UINib nibWithNibName:@"orderOtherInfo" bundle:nil] forCellReuseIdentifier:orderOtherInfoID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderServiewInfoCell" bundle:nil] forCellReuseIdentifier:orderServiewInfoCellID];

    [self.tableView registerNib:[UINib nibWithNibName:@"OrderWeekInfoCell" bundle:nil] forCellReuseIdentifier:OrderWeekInfoCellID];

    [ self.tableView  registerNib:[UINib nibWithNibName:@"AttributeCell" bundle:nil] forCellReuseIdentifier:cellID];


}

/// 配置基础设置
- (void)setConfiguration
{
    [self.tableView registerNib:[UINib nibWithNibName:@"DefaultAdressCell" bundle:nil] forCellReuseIdentifier:defaultAdressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodSOrderCommonCell" bundle:nil] forCellReuseIdentifier:goodSOrderCommonCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodSOrderNomalCell" bundle:nil] forCellReuseIdentifier:goodSOrderNomalCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"KX_ApprovalContentCell" bundle:nil] forCellReuseIdentifier:ContenGeneralCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsCombinedCell" bundle:nil] forCellReuseIdentifier:goodsCombinedCellID];
    
    [self.tableView registerClass:[MailTypeCell class] forCellReuseIdentifier:MailTypeCellCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DeductionCell" bundle:nil] forCellReuseIdentifier:DeductionCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderPayTypeCell" bundle:nil] forCellReuseIdentifier:orderPayTypeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsCommonCell" bundle:nil] forCellReuseIdentifier:goodsCommonCellID];

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
    
    WEAKSELF;
    NSString *str = self.resorceArray[indexPath.section];
    if (indexPath.section == 0) {
        DefaultAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultAdressCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.addressModel = _orderModel.address;
        cell.markView.hidden = YES;
        return cell;

    }
    else if (indexPath.section ==1){
        GoodSOrderNomalCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSOrderNomalCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Seller *seller = _orderModel.seller[indexPath.row];
        cell.products = seller.products[indexPath.row];
        return cell;
    }
    
    else if (indexPath.section == 2){
        GoodsCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCommonCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.titleLabel.text = str;
        cell.orderModel = _orderModel;
        cell.titleLabel.textColor = TITLETEXTLOWCOLOR;
        cell.markImgeView.hidden = YES;
        return cell;
    }
    
    else{
        OrderPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:orderPayTypeCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.didChageJFNumberBlock = ^(NSString *buyNumber) {
//        };
//        cell.userInfo = _orderModel.userinfo;
        cell.model = _orderModel;

        return cell;
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.resorceArray[indexPath.section];
    
    if ([str isEqualToString:@"新增收货地址"])
    {

        return 82;
    }
    else if ([str isEqualToString:@"商品详情"])
    {
        return 235;
        
    }
    
    else if([str isEqualToString:@"积分抵扣"]){
        return 40;
    }
    return 55;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    lineView.backgroundColor = BACKGROUND_COLOR;
    return lineView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 5;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH -1, 50)];
        headView.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = BACKGROUND_COLOR;
        [headView addSubview:lineView];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12, 44)];
        titleLB.textColor = TITLETEXTLOWCOLOR;
        titleLB.font = Font15;
        titleLB.textAlignment = NSTextAlignmentRight;
        
        NSString *allNumber = [NSString stringWithFormat:@"%@",_orderModel.count];
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
            titleLB.attributedText =hintString;
        }else{
            NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"共%@件商品   合计:%@",allNumber,allPrice]];
            //获取要调整颜色的文字位置,调整颜色
            NSRange range1=[[hintString string]rangeOfString:allNumber];
            [hintString addAttribute:NSForegroundColorAttributeName  value:KMAINCOLOR range:range1];
            
            NSRange range2=[[hintString string]rangeOfString:allPrice];
            [hintString addAttribute:NSForegroundColorAttributeName value:KMAINCOLOR range:range2];
            titleLB.attributedText =hintString;
        }

        [headView addSubview:titleLB];
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView1.backgroundColor = LINECOLOR;
        [headView addSubview:lineView1];
        
        return headView;
    }
    else{
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        headView.backgroundColor = BACKGROUND_COLOR;
        return headView;
        //        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1){
        return 50;
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

 
}



//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 50;
//    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
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
