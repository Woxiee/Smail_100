//
//  OrderCommitSuccessVC.m
//  ShiShi
//
//  Created by mac_KY on 17/3/7.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "OrderCommitSuccessVC.h"
#import "AllOrderManageVC.h"
#import "GoodsDetailVC.h"

//#import "LookSupplyVC.h"
@interface OrderCommitSuccessVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *titleLb1;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rifghtBtn;


@end

@implementation OrderCommitSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    [_rifghtBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    self.title = @"提交成功";
    [self setConfiguration];
}

/// 配置基础设置
- (void)setConfiguration
{
    _titleLb.textColor = TITLETEXTLOWCOLOR;
    _titleLb1.textColor = DETAILTEXTCOLOR;
    
    _rifghtBtn.backgroundColor = BACKGROUND_COLORHL;
    [_rifghtBtn layerForViewWith:3 AndLineWidth:0];
    
    _leftBtn.backgroundColor = [UIColor whiteColor];
    [_leftBtn layerWithRadius:3 lineWidth:0.5 color:BACKGROUND_COLORHL];
    [_leftBtn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateNormal];
    
 
    if (_successType == CommitSuccessAutiocnType) {
        _titleLb.text = @"恭喜您，提交报名成功!";
        _titleLb1.text = @"请尽快在PC端拍卖订单管理界面缴纳保证金完成报名";
        [_rifghtBtn setTitle:@"查看我的订单" forState:UIControlStateNormal];
        [_leftBtn setTitle:@"继续拍卖" forState:UIControlStateNormal];

    }
    else if (_successType == CommitSuccessSupplyType){
        _titleLb.text = @"恭喜您，供货单提交成功!";
        _titleLb1.text = @"";
        [_rifghtBtn setTitle:@"查看我的供货单" forState:UIControlStateNormal];
        
//        _rifghtBtn.backgroundColor = [UIColor whiteColor];
//        [_rifghtBtn layerWithRadius:3 lineWidth:0.5 color:BACKGROUND_COLORHL];
//        [_rifghtBtn setTitleColor:BACKGROUND_COLORHL forState:UIControlStateNormal];
        
        [_leftBtn setTitle:@"浏览更多需求" forState:UIControlStateNormal];
//        _leftBtn.hidden = YES;
    }
    
    
    else if (_successType == CommitSuccesscollectType){
        _titleLb.text = @"恭喜您，参与成功!";
        _titleLb1.text = @"集采达成最小集采量后将生成正式订单";
        [_rifghtBtn setTitle:@"查看我的订单" forState:UIControlStateNormal];
        [_leftBtn setTitle:@"继续购买" forState:UIControlStateNormal];
    }
    
    
}



#pragma mark - Click

- (void)popVC
{
    NSArray *ctrlArray = self.navigationController.viewControllers;
    //跳转控制
//    if (_successType == CommitSuccessAutiocnType) {
//        for (UIViewController *ctrl in ctrlArray) {
//            if ([ctrl isKindOfClass:[GoodsAuctionDetailVC class]]) {
//                [self.navigationController popToViewController:ctrl animated:YES];
//                break;
//            }
//        }
//    }
//    ///
//    else if (_successType == CommitSuccessSupplyType){
//
//        for (UIViewController *ctrl in ctrlArray) {
//            if ([ctrl isKindOfClass:[GoodsSolinDetailVCS class]]) {
//                [self.navigationController popToViewController:ctrl animated:YES];
//                break;
//            }
//        }
//
//    }else{
//        for (UIViewController *ctrl in ctrlArray) {
//            if ([ctrl isKindOfClass:[GoodsDetailVC class]]) {
//                [self.navigationController popToViewController:ctrl animated:YES];
//                break;
//            }
//            else{
//                [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
//            }
//        }
//    }

}

-(void)clickLeftBtn{
    
//    NSArray *ctrlArray = self.navigationController.viewControllers;
//    //跳转控制
//    if (_successType == CommitSuccessAutiocnType) {
//        for (UIViewController *ctrl in ctrlArray) {
//            if ([ctrl isKindOfClass:[GoodsAuctionDetailVC class]]) {
//                [self.navigationController popToViewController:ctrl animated:YES];
//                break;
//            }
//        }
//    }
//    else if (_successType == CommitSuccessSupplyType){
//        NSArray *ctrlArray = self.navigationController.viewControllers;
//        for (UIViewController *ctrl in ctrlArray) {
//            if ([ctrl isKindOfClass:[GoodsSolinDetailVCS class]]) {
//                [self.navigationController popToViewController:ctrl animated:YES];
//                break;
//            }
//        }
//    }
//    ///
//    else if (_successType == CommitSuccessSupplyType){
//
//        for (UIViewController *ctrl in ctrlArray) {
//            if ([ctrl isKindOfClass:[GoodsSolinDetailVCS class]]) {
//                [self.navigationController popToViewController:ctrl animated:YES];
//                break;
//            }
//        }
//
//    }else{
//        for (UIViewController *ctrl in ctrlArray) {
//            if ([ctrl isKindOfClass:[GoodsDetailVC class]]) {
//                [self.navigationController popToViewController:ctrl animated:YES];
//                break;
//            }else{
//                [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
//            }
//        }
//    }
}

-(void)clickRightBtn{
//  if (_successType == CommitSuccessSupplyType){
//      LookSupplyVC *vc = [[LookSupplyVC alloc] init];
//      vc.type  = LookSupplyTypeForSelect;
//      [self.navigationController pushViewController:vc animated:YES];
//  }else{
      if (_model) {
          AllOrderManageVC *VC = [[AllOrderManageVC alloc ] init];
          VC.orderTitleType = [_model.productInfo.productType integerValue] - 1;
          if ([_model.productInfo.productType isEqualToString:@"9"]) {
              VC.orderTitleType = BuyOrderTitleType;
          }
          else if ([_model.productInfo.productType isEqualToString:@"10"])
          {
              VC.orderTitleType = AuctionOrderTitleType;
              
          }
          [self.navigationController pushViewController:VC animated:YES];
          
//      }
  }
    

}

@end
