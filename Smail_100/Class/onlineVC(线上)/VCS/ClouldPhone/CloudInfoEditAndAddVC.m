//
//  CloudInfoEditAndAddVC.m
//  Smail_100
//
//  Created by ap on 2018/3/27.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "CloudInfoEditAndAddVC.h"

@interface CloudInfoEditAndAddVC ()
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *idTF;
@property (weak, nonatomic) IBOutlet UITextField *telTF;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UILabel *msg1LB;
@property (weak, nonatomic) IBOutlet UILabel *msg2LB;


@end

@implementation CloudInfoEditAndAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];

    
}

- (void)getNetWorkRequest
{
    
    WEAKSELF;
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:_codeTF.text  forKey:@"devid"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [param setObject:_nameTF.text  forKey:@"realname"];
    [param setObject:_idTF.text  forKey:@"idcard"];
    [param setObject:_telTF.text  forKey:@"mobile"];
    
    [BaseHttpRequest postWithUrl:@"/device/bind" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
                
                NSArray  *imgList = result[@"data"];
                //                for (ItemInfoList *model in imgList ) {
                //                    model.itemContentList = [NSArray yy_modelArrayWithClass:[ItemContentList class] json:model.itemContentList];
                //                }
                
                
            }
            
        }else{
        }
        
    }];
}

/// 初始化视图
- (void)setup
{
    self.title = @"我的云设备";
    [_sureBtn layerForViewWith:10 AndLineWidth:0];

    if (!_isConnection) {
        _codeTF.userInteractionEnabled = NO;
        _nameTF.userInteractionEnabled = NO;
        _idTF.userInteractionEnabled = NO;
        _telTF.userInteractionEnabled = NO;
        _sureBtn.hidden = YES;
        _msg1LB.hidden = YES;
        _msg2LB.hidden = YES;

    }
    
}

- (IBAction)didClickSureAciton:(id)sender {
    
    if (KX_NULLString(_codeTF.text)) {
        [self.view toastShow:_codeTF.placeholder];
        return;
    }
    
    if (KX_NULLString(_nameTF.text)) {
        [self.view toastShow:_nameTF.placeholder];
        return;
    }
    
    if (KX_NULLString(_idTF.text)) {
        [self.view toastShow:_idTF.placeholder];
        return;
    }
    
    if (KX_NULLString(_telTF.text)) {
        [self.view toastShow:_telTF.placeholder];
        return;
    }
    [self getNetWorkRequest];
    
}

@end
