//
//  ChangeInfoVC.m
//  MyCityProject
//
//  Created by mac_KY on 17/5/27.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "ChangeInfoVC.h"
#import "MemberInfoVModel.h"

@interface ChangeInfoVC ()
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewHeight;

/**<#Description#>*/
@property(nonatomic,assign)ChangeInfoType type;
/** <#des#> */
@property (nonatomic,strong)NSString *content;

@property (nonatomic, copy) void (^sBlock)(NSString *content);

@end

@implementation ChangeInfoVC


- (instancetype) initWithType:(ChangeInfoType)type
                      content:(NSString *)content sBlock:(void(^)(NSString *content))sBlock
{
    if (self = [super init]) {
        _content = content;
        _type    = type;
        _sBlock = sBlock;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadComment];
    [self loadSubView];
    
}

#pragma mark - 常数设置
- (void)loadComment
{
    _inputTF.textColor = TITLETEXTLOWCOLOR;
    _inputTF.text =_content;
    NSArray *arr = @[@"修改联系人",@"修改部门",@"修改电手机号",@"修改邮箱",@"修改工作",@"修改QQ",@"修改公司名称",@"修改公司详细信息",@"修改网址",@"修改电话",@"修改传真"];
    if (_type >arr.count -1) return;
    
    switch (_type) {
        case  ChangeInfoTypeContact:
        {
//            [param setObject:_inputTF.text forKey:@"nickname"];
        }break;
        case  ChangeInfoTypeTel:
        {
            _inputTF.keyboardType = UIKeyboardTypeNumberPad;
//            [param setObject:_inputTF.text forKey:@"realmobile"];
            
        }break;
        case  ChangeInfoTypeEMeil:
        {
            _inputTF.keyboardType = UIKeyboardTypeEmailAddress;

//            [param setObject:_inputTF.text forKey:@"realemail"];
        }break;
        case  ChangeInfoTypePhone:
        {
            _inputTF.placeholder = @"区号-座机号码";
            _inputTF.keyboardType = UIKeyboardTypeDefault;

//            [param setObject:_inputTF.text forKey:@"telephone"];
            
        }break;
        case  ChangeInfoTypeChuanzhen:
        {
//            [param setObject:_inputTF.text forKey:@"faxes"];
            
            
        }break;
        case  ChangeInfoTypeBumen:
        {
//            [param setObject:_inputTF.text forKey:@"dept"];
            
        }break;
        case  ChangeInfoTypeJob:
        {
//            [param setObject:_inputTF.text forKey:@"position"];
            
        }break;
        case  ChangeInfoTypeQQ:
        {
            _inputTF.keyboardType = UIKeyboardTypeNumberPad;

//            [param setObject:_inputTF.text forKey:@"qq"];
            
        }break;
        case  ChangeInfoTypeAddress:
        {
//            [param setObject:_inputTF.text forKey:@"address"];
            
        }break;
        case  ChangeInfoTypeHTTP:
        {
            _inputTF.keyboardType = UIKeyboardTypeURL;

//            [param setObject:_inputTF.text forKey:@"url"];
            
        }break;
            
            
        default:
            break;
    }


}


#pragma mark - 初始化子View
- (void)loadSubView
{
    [self loadNavItem];
}

- (void)loadNavItem
{
    
}


#pragma mark - 网络数据请求
- (void)loadData:(NSMutableDictionary *)param
{
    NSString *urlStr = @"";
    if ([KX_UserInfo sharedKX_UserInfo].isMembers) {
        urlStr = @"/m/m_042";
    }else{
        urlStr = @"/m/m_047";
    }
    [MemberInfoVModel getSaveInfoUrl:urlStr Param:param successBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            if (_sBlock) {
                _sBlock( _inputTF.text);
            }
            
            [self.navigationController popViewControllerAnimated:YES];

        }
        else{
            
            }
    }];
    
}
#pragma mark - 点击事件

- (IBAction)clickTrueChange:(id)sender {
    [self.view endEditing:YES];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    if ([KX_UserInfo sharedKX_UserInfo].isMembers) {
        [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
    }else{
        [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];
    }

    switch (_type) {
        case  ChangeInfoTypeContact:
        {
            [param setObject:_inputTF.text forKey:@"nickname"];
        }break;
        case  ChangeInfoTypeTel:
        {
            if (![Common isValidateMobile:_inputTF.text]) {
                [self.view toastShow:@"请输入有效的电话号码~"];
                return;
            }
           
            [param setObject:_inputTF.text forKey:@"realmobile"];

        }break;
        case  ChangeInfoTypeEMeil:
        {
            [param setObject:_inputTF.text forKey:@"realemail"];
        }break;
        case  ChangeInfoTypePhone:
        {
            if (![_inputTF.text containsString:@"-"]) {
                [self.view toastShow:@"区号与座机号码之间需要添加'-'"];
                return;
            }
            NSString *str = [_inputTF.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
            if (![NSString cheakInputStrIsNumber:str]) {
                [self.view toastShow:@"电话号码只能为数字"];
                return;
            }
            [param setObject:_inputTF.text forKey:@"telephone"];

        }break;
        case  ChangeInfoTypeChuanzhen:
        {
            [param setObject:_inputTF.text forKey:@"faxes"];


        }break;
        case  ChangeInfoTypeBumen:
        {
            [param setObject:_inputTF.text forKey:@"dept"];

        }break;
        case  ChangeInfoTypeJob:
        {
            [param setObject:_inputTF.text forKey:@"position"];

        }break;
        case  ChangeInfoTypeQQ:
        {
            [param setObject:_inputTF.text forKey:@"qq"];

        }break;
        case  ChangeInfoTypeAddress:
        {
            if (KX_NULLString(_inputTF.text) ) {
                [self.view toastShow:@"详细地址不能为空~"];
                return;
            }
            
            if (_inputTF.text.length <5 || _inputTF.text.length >50) {
                [self.view toastShow:@"详细地址在5-60个字之间~"];
                return;
            }
            [param setObject:_inputTF.text forKey:@"address"];

        }break;
        case  ChangeInfoTypeHTTP:
        {
            [param setObject:_inputTF.text forKey:@"url"];

        }break;

            
        default:
            break;
    }
    
    [self loadData:param];
    
    
}


#pragma mark - private


@end
