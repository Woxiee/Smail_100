//
//  AddSuggestionVC.m
//  MyCityProject
//
//  Created by mac_KY on 17/5/26.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "AddSuggestionVC.h"
#import "KYTextView.h"
#import "CommitSuccessVC.h"


@interface AddSuggestionVC ()
@property(strong,nonatomic)KYTextView *textView;
@property (nonatomic, strong) UIView *suggetView;
@property (nonatomic, strong) UILabel *detailLB;

@property (nonatomic, strong) NSString *param1;
@property (nonatomic, strong)  KYActionSheetDown *sheet;
@end
@implementation AddSuggestionVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadComment];
    [self loadSubView];
    [self loadData];
    
}

#pragma mark - 常数设置
-(void)loadComment
{
    self.title = @"投诉及意见反馈";
}


#pragma mark - 初始化子View
-(void)loadSubView
{
    UIView *suggetView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 44)];
    suggetView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:suggetView];
    _suggetView = suggetView;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickSuggetView)];
    [suggetView addGestureRecognizer:tapGesture];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 100, 44) ];
    titleLB.text = @"意见反馈类型:";
    titleLB.textColor = TITLETEXTLOWCOLOR;
    titleLB.font = Font15;
    [suggetView addSubview:titleLB];

    UILabel *detailLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLB.frame)+20, 0, SCREEN_WIDTH - 100 - 20 - 34, 44) ];
    detailLB.textColor = TITLETEXTLOWCOLOR;
    detailLB.font = Font15;
    detailLB.textAlignment = NSTextAlignmentRight;
    [suggetView addSubview:detailLB];
    _detailLB = detailLB;
    
    UIImageView *rightIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 12 - 7 , 15 , 7, 15)];
    rightIcon.image = [UIImage imageNamed:@"32@3x.png"];
    [suggetView addSubview:rightIcon];

   
    // textView
    KYTextView *textView = [[KYTextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(suggetView.frame)+10, kScreenWidth, 240)];
    textView.KYPlaceholder = @"请输入意见反馈内容";
    textView.KYPlaceholderColor = SUBTITLE_COLOR;
    textView.font = KY_FONT(14);
    textView.backgroundColor = [UIColor whiteColor];
    textView.maxTextCount = 200;
    _textView = textView;
    [self.view addSubview:textView];
    
    // button
    CGFloat marginLeft = 10.0f;
    CGFloat marginTop = 10.0f;
    UIButton *bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(marginLeft, textView.bottom + marginTop, kScreenWidth - 2*marginLeft, 44)];
    bottomBtn.backgroundColor = BACKGROUND_COLORHL;
    [bottomBtn setTitle:@"提交" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(clickCommit) forControlEvents:UIControlEventTouchUpInside];
    bottomBtn.KYConnerRediu(4);
    [self.view addSubview:bottomBtn];
  
    
}



#pragma mark - 网络数据请求
-(void)loadData
{
    
}
#pragma mark - 点击事件

-(void)back
{
    [_sheet hiddenSheetView];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickCommit
{
    if (KX_NULLString(self.param1)) {
        [self.view makeToast:@"反馈意见类型未填写~"];
        return;
    }
    
    if ([_textView.text isEqualToString:@"请输入意见反馈内容"]) {
        [self.view makeToast:@"反馈意见类型未填写~"];
        return;
    }
    
    if ([NSString cheakInputStrIsBlankSpace:_textView.text] ) {
        [self.view makeToast:@"反馈意见还未填写~"];
        return;
    }
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:_textView.text forKey:@"advice"];
    [param setObject:_param1 forKey:@"param1"];

    [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].bid forKey:@"bid"];
    [MBProgressHUD showMessag:@"提交中..." toView:self.view];
    WEAKSELF;
    [BaseHttpRequest postWithUrl:@"/m/m_014" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (error) {
            [weakSelf.view makeToast:LocalMyString(NOTICEMESSAGE)];
        }else{
            if ([result[@"data"][@"state"] isEqualToString:@"0"]) {
                
                [weakSelf.navigationController pushViewController:[CommitSuccessVC new] animated:YES];

            }else{
                [weakSelf.view makeToast:result[@"data"][@"msg"]];
            }
        }
    }];

    
}


- (void)didClickSuggetView
{
    WEAKSELF;
    NSArray *titleArr =  @[@"平台建议",@"供应商投诉",@"会员投诉",@"其他意见"];
    KYActionSheetDown *sheet = [KYActionSheetDown sheetWithFrame:CGRectMake(0, CGRectGetMaxY(_suggetView.frame) + 44+20, SCREEN_WIDTH, SCREEN_HEIGHT - 64) clicked:^(NSInteger buttonIndex,NSInteger buttonTag) {
        weakSelf.param1 = titleArr[buttonIndex];
        weakSelf.detailLB.text = weakSelf.param1;
     } otherButtonTitleArray:titleArr];
    [sheet show];
    
}
#pragma mark - private



@end
