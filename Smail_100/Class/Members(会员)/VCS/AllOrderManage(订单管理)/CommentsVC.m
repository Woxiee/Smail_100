//
//  CommentsVC.m
//  Smail_100
//
//  Created by ap on 2018/5/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "CommentsVC.h"
#import "DQStarView.h"
#import "KYTextView.h"

@interface CommentsVC ()<DQStarViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *shopNameLB;
@property (weak, nonatomic) IBOutlet UIView *starBiew;

@property (weak, nonatomic) IBOutlet UIView *commView;
@property (weak, nonatomic) IBOutlet KYTextView *commTextvIEW;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (weak, nonatomic) IBOutlet UILabel *detailLB;

@property (weak, nonatomic) IBOutlet DQStarView *scoreImageView;
@property (weak, nonatomic) IBOutlet UIButton *isHiddenBtn;

//__weak IBOutlet DQStarView *scoreImageView;

@end

@implementation CommentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}


#pragma mark - request
- (void)requestListNetWork
{
//    http://39.108.4.18:6803/api/shop/comment  comment=%E5%93%88%E5%93%88%E5%93%88%E5%93%88&orderno=20180519145710561301&shop_id=42&stars=70.0&user_id=84561
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_commTextvIEW.text forKey:@"comment"];
    [param setObject:_model.orderno forKey:@"orderno"];
    [param setObject:_model.shopID forKey:@"shop_id"];
    [param setObject:@(_scoreImageView.starCurrntFl*20) forKey:@"stars"];

    [param setObject:_isHiddenBtn.selected?@"1":@"0" forKey:@"is_anonymous"];

    
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/shop/comment" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单列表 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *msg = [result valueForKey:@"msg"];
        
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            NSArray *dataArr = [result valueForKey:@"data"];
            NSArray *listArray  = [[NSArray alloc] init];
            if ([dataArr isKindOfClass:[NSArray class]]) {
                if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {

                    [weakSelf showHint:msg];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeAfter * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                        
                    });
                }
            }
        }else{
            [weakSelf showHint:msg];
            
        }
        
        
    }];
}

#pragma mark - private
- (void)setup
{
    self.title  = @"评价";
    self.view.backgroundColor = BACKGROUND_COLOR;
    _shopNameLB.text = _model.shop_name;
    _scoreImageView.starTotalCount = 5;
    _scoreImageView.delegate = self;
    _scoreImageView.ShowStyle = DQStarShowStyleSingleHalfClick;
//    [_scoreImageView ShowDQStarScoreFunction:[_model.stars intValue]/20];

    [_commView layerForViewWith:8 AndLineWidth:1];
    
    
    [_submitBtn layerForViewWith:8 AndLineWidth:1];
    
    _detailLB.textColor = DETAILTEXTCOLOR;
    
    _commTextvIEW.KYPlaceholder  = @"说说这家店铺的优点和每种不足的地方吧！";
   _commTextvIEW.KYPlaceholderColor = DETAILTEXTCOLOR;
}

- (void)setConfiguration
{
    
}
- (IBAction)didClickShowinfoAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    
    btn.selected =!  btn.selected;
    
}

#pragma mark - publice

- (IBAction)didClickSubmitAction:(id)sender {
    if (KX_NULLString(_commTextvIEW.text) ||  [_commTextvIEW.text isEqualToString:_commTextvIEW.KYPlaceholder]) {
        [self.view makeToast:@"请填写评论内容"];
        return;
    }
    [self requestListNetWork];
}

#pragma mark - set & get



#pragma mark - delegate
/**
 * 选择评分的代理方法 view:为展示的评分的视图 score:显示的分数
 */
- (void)starScoreChangFunction:(UIView *)view andScore:(CGFloat)score
{
    
    
}
@end
