//
//  SendCommentsVC.m
//  MyCityProject
//
//  Created by Faker on 17/6/10.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "SendCommentsVC.h"
#import "RatingBar.h"
#import "KYTextView.h"
#import "OrderVModel.h"
@interface SendCommentsVC ()<RatingBarDelegate>

@end

@implementation SendCommentsVC
{
    __weak IBOutlet UIImageView *headImage;

    __weak IBOutlet UIView *bottomView;
    __weak IBOutlet KYTextView *inPuTextView;
    __weak IBOutlet RatingBar *ratingBar2;
    __weak IBOutlet RatingBar *ratingBar3;
    NSString *_isAnonymous;/// 是否匿名
    NSString *_target1;  ///商品包装;
    NSString *_target2;  ///送货速度;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (KX_NULLString(_model.orderId)) {
        _model.orderId = @"";
    }
    inPuTextView.KYPlaceholder = @"详细描述下吧";
    inPuTextView.KYPlaceholderColor = DETAILTEXTCOLOR;
    inPuTextView.maxTextCount = 200;
    
    [headImage layerForViewWith:2 AndLineWidth:0.5];
    
    [headImage sd_setImageWithURL:[NSURL URLWithString:_model.productImgPath] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    ratingBar2.backgroundColor = [UIColor whiteColor];
    ratingBar3.backgroundColor = [UIColor whiteColor];
    [ratingBar2 setImageDeselected:@"ratingStart_empty@3x.png" halfSelected:@"" fullSelected:@"ratingStart" andDelegate:self];
    ratingBar2.tag = 100;
    ratingBar2.isIndicator = NO;
    ratingBar3.isIndicator = NO;

    [ratingBar3 setImageDeselected:@"ratingStart_empty@3x.png" halfSelected:@"" fullSelected:@"ratingStart@3x.png" andDelegate:self];
    ratingBar3.tag = 101;
    _isAnonymous = @"0";
        self.title = @"发表评价";
    if (self.commeType  == ShowTypeType) {
        self.title = @"评价详情";

        inPuTextView.userInteractionEnabled = NO;
        ratingBar2.isIndicator = YES;
        ratingBar3.isIndicator = YES;
        bottomView.hidden = YES;
        UIButton *sumitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sumitBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 44-64, SCREEN_WIDTH , 44);
        [sumitBtn setTitle:@"返回" forState:UIControlStateNormal];
        [sumitBtn addTarget:self action:@selector(submitBtn:) forControlEvents:
         UIControlEventTouchUpInside];
        sumitBtn.backgroundColor = BACKGROUND_COLORHL;
        [self.view addSubview:sumitBtn];
        [self requestNetWork];
    }

}

#pragma mark  - requestNetWork
- (void)requestNetWork
{
  
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
    [param setObject:_model.orderId forKey:@"orderId"];
//    [param setObject:[KX_UserInfo sharedKX_UserInfo].bid forKey:@"bid"];

    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/o/o_114" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSInteger state = [[result valueForKey:@"state"] integerValue];
        if (state == 0) {
            NSDictionary *listDic = [result valueForKey:@"data"][@"obj"][@"comment"];
            [ratingBar2 displayRating:[listDic[@"target1"] integerValue]];
            [ratingBar3 displayRating:[listDic[@"target2"] integerValue]];
            inPuTextView.text = listDic[@"commentContent"];
        }
        
    }];
    
}


/// 是否匿名评价
- (IBAction)didChangeTypeBnt:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected =! btn.selected;
    if (btn.selected) {
        _isAnonymous = @"1";
    }else{
        _isAnonymous = @"0";

    }
    
}


- (IBAction)submitBtn:(id)sender {
    if (self.commeType == ShowTypeType) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
     
        
        if ([_target1 integerValue] == 0 ) {
            [self.view makeToast:@"描述相符还未给评分哦~"];
            return;
        }
        if ([_target2 integerValue] == 0 ) {
            [self.view makeToast:@"服务态度还未给评分哦~"];
            return;
        }
        
        if ([inPuTextView.text isEqualToString:@"详细描述下吧"]) {
            [self.view makeToast:@"请先填写评价内容!"];
            return;
        }
        if ( [NSString cheakInputStrIsBlankSpace:inPuTextView.text]) {
            [self.view makeToast:@"请先填写评价内容!"];
            return;
        }
        
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].bid forKey:@"bid"];

        [param setObject:self.model.orderId forKey:@"orderId"];
        [param setObject:[KX_UserInfo sharedKX_UserInfo].userName forKey:@"userName"];
        
        [param setObject:inPuTextView.text forKey:@"commentContent"];
        [param setObject:_target1 forKey:@"target1"];
        [param setObject:_target2 forKey:@"target2"];
        [param setObject:_isAnonymous forKey:@"param2"];
        WEAKSELF;
        [MBProgressHUD showMessag:@"提交中..." toView:self.view];
        [OrderVModel getOrderOperationUrl:@"/o/o_115" Param:param successBlock:^( BOOL isSuccess,NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (isSuccess) {
                [weakSelf.view toastShow:@"提交评价成功~"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
                
            }else{
                [weakSelf.view toastShow:message];
            }
            
        }];

    }
    
}


#pragma RatingBar代理方法
- (void)ratingChanged:(float)newRating withRating:(RatingBar *)ratingBar{

    if (ratingBar.tag == 100) {
        _target1 = [NSString stringWithFormat:@"%.0f",newRating];
    }
    if (ratingBar.tag == 101) {
        _target2 = [NSString stringWithFormat:@"%.0f",newRating];
    }
       NSLog(@">>>>>>>>%f  ----- ratingBar.tag = %ld",newRating,(long)ratingBar.tag);
}

@end
