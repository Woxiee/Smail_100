//
//  AddOrEidtGoodVC.m
//  Smail_100
//
//  Created by Faker on 2018/3/19.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "AddOrEidtGoodVC.h"
#import "KYTextView.h"
#import "SelectGoodSClassVC.h"
#import "ChildModel.h"

@interface AddOrEidtGoodVC ()
@property (weak, nonatomic) IBOutlet UIButton *pohoteBtn;
@property (weak, nonatomic) IBOutlet UIButton *imagePickBtn;

@property (weak, nonatomic) IBOutlet UIImageView *stortImageView;
@property (weak, nonatomic) IBOutlet KYTextView *markTextView;


@property (weak, nonatomic) IBOutlet UITextField *selectTF;

@property (weak, nonatomic) IBOutlet UIView *selectClassGoodView;

@property (weak, nonatomic) IBOutlet UITextField *selectPriceTF;


@property (weak, nonatomic) IBOutlet UITextField *inputKuCunTF;

@property (strong, nonatomic)  NSString *status;

@end

@implementation AddOrEidtGoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
}

#pragma mark - request
- (void)getRequestData
{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_markTextView.text forKey:@"title"];
    [param setObject:_inputKuCunTF.text forKey:@"stock"];
    [param setObject:_status forKey:@"status"];
    [param setObject:_selectPriceTF.text forKey:@"price"];
    [param setObject:_model.sub_category_id?_model.sub_category_id:@"14" forKey:@"sub_category_id"];
    [param setObject:_model.goods_id?_model.goods_id:@"0" forKey:@"goods_id"];
    [param setObject:[KX_UserInfo sharedKX_UserInfo].user_id forKey:@"user_id"];
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [BaseHttpRequest postWithUrl:@"/shop/edit_goods" andParameters:param andRequesultBlock:^(id result, NSError *error) {
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
                    [weakSelf showHint:msg];
                    [weakSelf.navigationController popViewControllerAnimated:YES];

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
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickSelectGoodAction)];
    [_selectClassGoodView addGestureRecognizer:tapGest];
    
    _markTextView.KYPlaceholder  = @"请输入商品标题（限30字）";
    _markTextView.KYPlaceholderColor = DETAILTEXTCOLOR;
    if (_model) {
        self.title = @"编辑商品";
        [_stortImageView sd_setImageWithURL:[NSURL URLWithString:_model.pict_url] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];

        _markTextView.text = _model.title;
       _inputKuCunTF.text  = _model.stock;
        _status = _model.status;
        _inputKuCunTF.text  = _model.stock;
        _selectPriceTF.text = _model.price;
        
    }
    else{
        self.title = @"发布商品";

        _model = [MeChantOrderModel new];
        
    }
}

- (void)setConfiguration
{
    
}



- (IBAction)didClickphotoAction:(UIButton *)sender {
    WEAKSELF;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[KX_UserInfo sharedKX_UserInfo].user_id,@"user_id", nil];
//    [param setObject:_model.goods_id?_model.goods_id:@"0" forKey:@"goods_id"];
    if (sender.tag == 100) {
        [self selectImageByPhotoWithBlock:^(UIImage *image)
         {
             [BaseHttpRequest requestUploadImage:image Url:@"/shop/upload_image" Params:param  andFileContents:nil andBlock:^(NSString *imageName) {
                 weakSelf.stortImageView.image = image;

             }];
             
         }];
    }
    
    
    if (sender.tag == 101) {
        [self selectImageByCameraWithBlock:^(UIImage *image)
         {
             [BaseHttpRequest requestUploadImage:image Url:@"/shop/upload_image" Params:param  andFileContents:nil andBlock:^(NSString *imageName) {
                 weakSelf.stortImageView.image = image;
             }];
         }];
//    KX_ActionSheet *sheetView  = [KX_ActionSheet  sheetWithTitle:@"选择图片" cancelButtonTitle:@"图片" clicked:^(KX_ActionSheet *actionSheet, NSInteger buttonIndex) {
//
//        if (buttonIndex == 1) {
//
//
//        }
//        else if(buttonIndex == 2)
//        {
//
//             }];
//
//        }
//
//    } otherButtonTitleArray:@[@"相册",@"照相"]];
//    [sheetView show];
    }

}


/// 100 放入仓库 101 立即发布
- (IBAction)didClickBottomAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 100) {
        _status = @"Disabled";
    }
    else{
        _status = @"Enabled";
      }

    if (KX_NULLString(_markTextView.text)) {
        [self.view toastShow:@"商品名称未填写"];
        return;
    }
    if (KX_NULLString(_model.sub_category_id)) {
        [self.view toastShow:@"商品品类未选择"];
        return;
    }
    if (KX_NULLString(_selectPriceTF.text)) {
        [self.view toastShow:@"商品价格未填写"];
        return;
    }
    
    if (KX_NULLString(_inputKuCunTF.text)) {
        [self.view toastShow:@"商品库存未填写"];
        return;
    }
    [self getRequestData];
}

/// 
- (void)didClickSelectGoodAction
{
    WEAKSELF;
    NSMutableArray *selectArr = [[NSMutableArray alloc] init];
    NSMutableArray *selectIDArr = [[NSMutableArray alloc] init];

    SelectGoodSClassVC *VC = [[SelectGoodSClassVC alloc] init];
    VC.didClickCompleBlock = ^(NSArray *listArr) {
        for (ChildModel *model in listArr) {
            [selectArr addObject:model.name];
            [selectIDArr addObject:model.id];
        }
        weakSelf.selectTF.text = [selectArr componentsJoinedByString:@","];
        weakSelf.model.sub_category_id  = [selectIDArr componentsJoinedByString:@","];
    };
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - publice


#pragma mark - set & get



#pragma mark - delegate

@end
