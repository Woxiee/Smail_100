//
//  BaseInforVC.m
//  ShiShi
//
//  Created by ac on 16/3/18.
//  Copyright © 2016年 fec. All rights reserved.
// 没有生日和签名

#define CellID @"USERINFORCEll"

#import "BaseInforVC.h"
#import "ChangeSexVC.h"

#import "changeInfoVC.h"

#import "LoginVC.h"
#import "KX_ActionSheet.h"
#import "MyCodeVC.h"


static NSInteger infoCellTag = 100;

@interface BaseInforVC ()<UITextFieldDelegate>
{
    NSArray * titleArray;
    NSArray * pholdArray;
    
    
    // JP 头像 昵称 手机 性别 生日 地区 签名
    
    
    __weak IBOutlet UIImageView *headerImage;
    
    __weak IBOutlet UILabel *userNameLb;
    
    __weak IBOutlet UILabel *mobileLb;
    
    __weak IBOutlet UILabel *sexLb;

    
    __weak IBOutlet UILabel *wxLb;

    __weak IBOutlet UIButton *outBtn;
    
 
    UIView * backview;
    NSString * sexIDString;
    

    NSString * detail;
    
    UIView * adressbackView;

    UIImage *selectImage;

}

@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *wxname;


@end

@implementation BaseInforVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基本资料";
    [self loadSubview];
    [self refreshUI];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [headerImage setConnerRediu];

    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


#pragma mark - 设置子View
-(void)loadSubview{
    [self loadItem];
}

-(void)loadItem{
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 35)];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn setTitle:@"保存" forState:UIControlStateNormal];
//    btn.titleLabel.font = KY_FONT(15);
//    [btn addTarget:self action:@selector(saveAndUpLoad:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    outBtn.backgroundColor = KMAINCOLOR;
    [outBtn layerForViewWith:4 AndLineWidth:0];
}


#pragma mark - 网络请求得到自己的资料
- (void)refreshUI{
 
    [headerImage sd_setImageWithURL:[NSURL URLWithString:[KX_UserInfo sharedKX_UserInfo].avatar_url] placeholderImage:[UIImage imageNamed:@"6@3x.png"]];
    userNameLb.text =  [KX_UserInfo sharedKX_UserInfo].nickname;
    if ([[KX_UserInfo sharedKX_UserInfo].sex isEqualToString:@"1"]) {
        sexLb.text = @"男";
    }else{
        sexLb.text = @"女";
    }
    
    wxLb.text = [KX_UserInfo sharedKX_UserInfo].wxname;
    headerImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickImageAction)];
    [headerImage addGestureRecognizer:tap];
}



- (void)removeView{
    [backview removeFromSuperview];
    backview = nil;
}

- (IBAction)backToBefor:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)didchangeAciton:(id)sender {
    [self didClickImageAction];
}

/// 点击图片
- (void)didClickImageAction
{
    WEAKSELF;
    KX_ActionSheet *sheetView  = [KX_ActionSheet  sheetWithTitle:@"选择图片" cancelButtonTitle:@"取消" clicked:^(KX_ActionSheet *actionSheet, NSInteger buttonIndex) {
        NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:[KX_UserInfo sharedKX_UserInfo].user_id,@"user_id", nil];

        if (buttonIndex == 1) {
            [self selectImageByPhotoWithBlock:^(UIImage *image)
             {
                 [BaseHttpRequest requestUploadImage:image Url:@"/ucenter/avatar" Params:param  andFileContents:nil andBlock:^(NSString *imageName) {
                     KX_UserInfo *userinfo = [KX_UserInfo sharedKX_UserInfo];
                     userinfo.avatar_url = imageName;
                     [headerImage sd_setImageWithURL:[NSURL URLWithString:[KX_UserInfo sharedKX_UserInfo].avatar_url] placeholderImage:[UIImage imageNamed:@"6@3x.png"]];
                 }];
                 
                 
             }];
            
        }
        else if(buttonIndex == 2)
        {
            [self selectImageByCameraWithBlock:^(UIImage *image)
             {
                 [BaseHttpRequest requestUploadImage:image Url:@"/ucenter/avatar" Params:param  andFileContents:nil andBlock:^(NSString *imageName) {
                     KX_UserInfo *userinfo = [KX_UserInfo sharedKX_UserInfo];
                     userinfo.avatar_url = imageName;
                     [headerImage sd_setImageWithURL:[NSURL URLWithString:[KX_UserInfo sharedKX_UserInfo].avatar_url] placeholderImage:[UIImage imageNamed:@"6@3x.png"]];

                 }];
             }];
            
        }
        
    } otherButtonTitleArray:@[@"相册",@"照相"]];
    [sheetView show];
}



- (IBAction)saveAndUpLoad:(UIButton *)sender {//1:女性,2:男性,0:保密
//    
    if ([Common stringWithOutSpace:userNameLb.text].length <= 0) {
        [self.view makeToast:@"请先填写昵称"];
        return;
    }
    
    if ([sexLb.text isEqualToString:@"男"]) {
        sexIDString = @"2";
    }else if([sexLb.text isEqualToString:@"女"]){
        sexIDString = @"1";
    }else{
        sexIDString = @"0";
    }
    NSMutableDictionary * updict = [NSMutableDictionary dictionary];
//    [updict setObject:[[LoginData loginData] getMid] forKey:@"loginMid"];
//    [updict setObject:[[LoginData loginData] getLoginType] forKey:@"loginType"];
    [updict setObject:userNameLb.text forKey:@"nickname"];
    [updict setObject:[NSString stringWithFormat:@"%@",sexIDString] forKey:@"sex"];
  

}


/// 上传用户资料
- (void)updateUserInfoRequest
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:userNameLb.text forKey:@"nickname"];
    [param setObject:sexLb.text forKey:@"sex"];
    [param setObject:wxLb.text forKey:@"wxname"];
    [param setObject:@"edit" forKey:@"method"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/ucenter/user" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *msg = [result valueForKey:@"msg"];
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
//            NSArray *dataArr = [result valueForKey:@"data"];
//            NSArray *listArray  = [[NSArray alloc] init];
//            if ([dataArr isKindOfClass:[NSArray class]]) {
                if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
//                    listArray = [AcctoutWaterModel mj_objectArrayWithKeyValuesArray:dataArr];
//                    if (weakSelf.page == 0) {
//                        [weakSelf.resorceArray removeAllObjects];
//                    }
//                    [weakSelf.resorceArray addObjectsFromArray:listArray];
//                    [weakSelf.tableView reloadData];
//                    [weakSelf setRefreshs];
                    [self.view makeToast:result[@"msg"]];
                  
                }
//            }
        }else{
            [weakSelf showHint:msg];
            
        }
        
        
    }];
}



#pragma mark - ActionFromXib

- (IBAction)clickCell:(UIButton *)sender {
    NSInteger tag = sender.tag - infoCellTag;
    //0-6 头像  1昵称 2手机 3性别 4生日 5地区 6个性签名  9=推出登陆
    WEAKSELF;
    switch (tag) {
        case 0:{
            KX_ActionSheet *sheetView  = [KX_ActionSheet  sheetWithTitle:@"选择性别" cancelButtonTitle:@"取消" clicked:^(KX_ActionSheet *actionSheet, NSInteger buttonIndex) {
                
                KX_UserInfo *userinfo = [KX_UserInfo sharedKX_UserInfo];
                if (buttonIndex == 1) {
                    sexLb.text = @"男";
                    userinfo.sex = @"1";
                }
                else if(buttonIndex == 2)
                {
                    sexLb.text = @"女";
                    userinfo.sex = @"2";
                }
                [weakSelf updateUserInfoRequest];
                
            } otherButtonTitleArray:@[@"男",@"女"]];
            [sheetView show];
            
        
        }break;
        case 1:{
          
            changeInfoVC *changeVC = [[changeInfoVC alloc]init];
            changeVC.aTitle= @"修改昵称";
            changeVC.inputText = userNameLb.text;
            changeVC.warnStr = @"注意:与微笑100业务或商家品牌冲突的昵称，微笑100有权收回";
            __block typeof(userNameLb) b_userNameLb = userNameLb;
            changeVC.clickTrue = ^(NSString *content){
                
                b_userNameLb.text = content;
                KX_UserInfo *userinfo = [KX_UserInfo sharedKX_UserInfo];
                userinfo.nickname = content;
                [weakSelf updateUserInfoRequest];
            };
            [self.navigationController pushViewController:changeVC animated:YES];
        }break;
        case 2:{
            changeInfoVC *changeVC = [[changeInfoVC alloc]init];
            changeVC.aTitle= @"修改微信名称";
            changeVC.inputText = wxLb.text;
            changeVC.warnStr = @"";
            __block typeof(userNameLb) b_userNameLb = wxLb;
            changeVC.clickTrue = ^(NSString *content){
                
                b_userNameLb.text = content;
                KX_UserInfo *userinfo = [KX_UserInfo sharedKX_UserInfo];
                userinfo.wxname = content;
                [weakSelf updateUserInfoRequest];
            };
            [self.navigationController pushViewController:changeVC animated:YES];
            
        }break;
        case 3:{
            MyCodeVC * VC = [[MyCodeVC alloc]init];
            VC.title = @"我的二维码";
            [self.navigationController pushViewController:VC animated:YES];
//            ChangeSexVC *sexVC = [[ChangeSexVC alloc]init];
//            sexVC.sex = sexLb.text;
//            __block typeof(sexLb) b_sexLb = sexLb;
//            sexVC.selectDex = ^(NSString *sex){
//                b_sexLb.text = sex;
//            };
//            [self.navigationController pushViewController:sexVC animated:YES];
        }break;
        case 4:{
            SuccessView *successV = [[SuccessView alloc] initWithTrueCancleTitle:@"是否退出登录?" cancelTitle:@"取消" clickDex:^(NSInteger clickDex) {
                if (clickDex == 1) {
                    [[KX_UserInfo sharedKX_UserInfo] cleanUserInfoToSanbox];
                   
                    [Common presentToLoginView:self.navigationController.viewControllers.firstObject];
                    
                    [self.navigationController popToRootViewControllerAnimated:NO];
                    
                    
                }}];
            [successV showSuccess];
           
//            //清除本地数据 返回登陆页面
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"passWord"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            LoginVC *loginVc = [[LoginVC alloc]init];
//            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
//            [UIApplication sharedApplication ].keyWindow.rootViewController = nav;
        }break;
        case 5:{
        }break;
        case 6:{}break;

        //9=推出登陆
        case 9:{
            


        }break;

        default:
            break;
    }
}



//#pragma mark - 图片选择控制器的代理
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    // 1.销毁picker控制器
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    // 2.取得的图片
//    UIImage *image = info[UIImagePickerControllerOriginalImage];
//    selectImage = image;
//    [self upLoadImageWithImageData:image];
//}
//
//- (void)upLoadImageWithImageData:(UIImage *)image{
//
////    [MBProgressHUD showMessag:@"上传中..." toView:self.view];
////    NSData *imageData = UIImageJPEGRepresentation(image, 0.2);
////    NSString *imageDataStr = [imageData base64EncodedString];
//
////    if (imageData.length/1024/1024>1) {
////        [self.view makeToast:@"图片不能大于1M"];
////        return;
////    }
////
////    NSMutableDictionary * updict = [NSMutableDictionary dictionary];
////    [updict setObject:[[LoginData loginData] getMid] forKey:@"mid"];
////    [updict setObject:imageDataStr forKey:@"imgData"];
////    [updict setObject:@"png" forKey:@"type"];
////    [updict setObject:[[LoginData loginData] getLoginType] forKey:@"loginType"];
////    BaseHttpRequest * base = [[BaseHttpRequest alloc] initWithinterfaceURL:@"/c/c_002" andmethod:kPOST andParams:updict];
////    [base sendRequest:^(id result, NSError *error) {
////        [MBProgressHUD hideHUDForView:self.view animated:YES];
////        WS(b_self)
////        if (error) {
////            [b_self.view makeToast:LocalMyString(NOTICEMESSAGE)];
////        }else{
////            ImageUpLoadRespon * respon = [[ImageUpLoadRespon alloc] initWithJsonData:result];
////            if (respon.state == 0) {
////                [self changeHeadImage:respon.fileName];
////            }else{
////                [b_self.view makeToast:respon.msg];
////            }
////        }
////    }];
//
//}


//修改头像
- (void)changeHeadImage:(NSString *)fileName{
    
//    
//    NSMutableDictionary * updict = [NSMutableDictionary dictionary];
//    [updict setObject:[[LoginData loginData] getMid] forKey:@"loginMid"];
//    [updict setObject:[[LoginData loginData] getLoginType] forKey:@"loginType"];
//    [updict setObject:[NSString stringWithFormat:@"%@",fileName] forKey:@"logo"];
//    [updict setObject:userNameLb.text forKey:@"nickname"];
//    [updict setObject:[NSString stringWithFormat:@"%@",sexIDString] forKey:@"sex"];
//    [updict setObject:_city forKey:@"prov"];
//    [updict setObject:_city forKey:@"city"];
//    [updict setObject:_area forKey:@"area"];
//    [MBProgressHUD showMessag:@"上传中..." toView:self.view];
//    BaseHttpRequest * request = [[BaseHttpRequest alloc] initWithinterfaceURL:@"/m/m_009" andmethod:kPOST andParams:updict];
//    WS(b_self)
//    [request sendRequest:^(id result, NSError *error) {
//        [MBProgressHUD hideHUDForView:b_self.view animated:YES];
//        if (error) {
//            [b_self.view makeToast:@"上传失败！"];
//        }else{
//            CommRespon * respon = [[CommRespon alloc] initWithJsonData:result];
//            if (respon.state == 0) {
//                
//                [headerBtn setBackgroundImage:selectImage forState:UIControlStateNormal];
//              //  [self getMemberInfor];
//                
//            }else{
//                [b_self.view makeToast: respon.msg];
//            }
//        }
//    }];
}


#pragma mark - 得到网络数据
-(void)requestListNetWork
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@"" forKey:@"method"];
    [param setObject:@"" forKey:@"nickname"];
    [param setObject:@"" forKey:@"sex"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    
    [BaseHttpRequest postWithUrl:@"/ucenter/user" andParameters:param andRequesultBlock:^(id result, NSError *error) {
        LOG(@"订单列表 == %@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSString *msg = [result valueForKey:@"msg"];
        
        if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
            NSArray *dataArr = [result valueForKey:@"data"];
            NSArray *listArray  = [[NSArray alloc] init];
            if ([dataArr isKindOfClass:[NSArray class]]) {
                if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"0"]) {
//                    listArray = [AcctoutWaterModel mj_objectArrayWithKeyValuesArray:dataArr];
//                    if (weakSelf.page == 0) {
//                        [weakSelf.resorceArray removeAllObjects];
//                    }
//                    [weakSelf.resorceArray addObjectsFromArray:listArray];
//                    [weakSelf.tableView reloadData];
//                    [weakSelf setRefreshs];
                    [self.view makeToast:result[@"msg"]];
                }
            }
        }else{
            [weakSelf showHint:msg];
            
        }
        
        
    }];
    
}




@end
