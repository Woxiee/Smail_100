//
//  MemberInforVC.m
//  MyCityProject
//
//  Created by mac_KY on 17/5/26.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "MemberInforVC.h"
#import "MemberModel.h"
#import "ChangeInfoVC.h"
#import "LZCityPickerController.h"
#import "MemberInfoVModel.h"
//#import "OldPhoneeValidationVC.h"
#import "KYOlderPhoneVC.h"
@interface MemberInforVC ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView *tableView;
@end

@implementation MemberInforVC

#pragma mark - set懒加载
/*懒加载*/
-(UITableView *)tableView
{
    if (!_tableView) {
        //初始化数据
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];//默认设置为空
        [_tableView setSeparatorInset:UIEdgeInsetsZero];//默认设置下划线左边移动 15.0f
        [_tableView setSeparatorColor:BACKGROUND_COLOR];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUND_COLOR;
    }
    return _tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadComment];
    [self loadSubView];
    [self loadData];
    
}

#pragma mark - 设置子常数
-(void)loadComment
{
    

    
}

#pragma mark - 设置子View
-(void)loadSubView
{
    [self.view addSubview:self.tableView];
}

#pragma mark - 得到网络数据
-(void)loadData
{
    NSString *urlStr = @"";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (KX_NULLString(_bid)) {
        if ([KX_UserInfo sharedKX_UserInfo].isMembers) {
            urlStr = @"/m/m_041";
            [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
        }
        else{
            urlStr = @"/m/m_046";
            [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];
        }
        
    }else{
        urlStr = @"/m/m_052";
        [param setObject:_bid forKey:@"bid"];
//        [param setObject:_bid forKey:@"aid"];

    }
    
    [MemberInfoVModel getMenberInfoUrl:urlStr Param:param successBlock:^(NSArray<MemberModel *> *dataArray, BOOL isSuccess) {
        // group1
        if (isSuccess) {
            [self.resorceArray removeAllObjects];
            MemberModel *menberModel = dataArray[0];
            NSString *address = [NSString stringWithFormat:@"%@%@%@",menberModel.province,menberModel.city,menberModel.area];
            NSArray *titles ;
            NSArray *detailArr;
            if (!KX_NULLString(_bid)) {
                titles = @[@[@"联系人",@"手机号",@"邮箱",@"电话",@"传真"],@[@"地址    "]];
                detailArr = @[@[menberModel.nickname,menberModel.realmobile,menberModel.realemail,menberModel.telephone,menberModel.faxes],@[[NSString stringWithFormat:@"%@%@",address,menberModel.address]]];
            }else{
                titles = @[@[@"联系人",@"手机号",@"邮箱",@"电话",@"传真"],@[@"部门",@"职位",@"QQ"],@[@"地址区域",@"详细地址"],@[@"网址"]];
                detailArr = @[@[menberModel.nickname,menberModel.realmobile,menberModel.realemail,menberModel.telephone,menberModel.faxes],@[menberModel.dept,menberModel.position,menberModel.qq],@[address,menberModel.address],@[menberModel.url]];

            }
            
            
            
            for (int i = 0; i< detailArr.count; i++) {
                NSMutableArray *items = [NSMutableArray array];
                
                NSArray *titleArr = titles[i];
                NSArray *detailsArr = detailArr[i];
                for (int i = 0; i<titleArr.count; i++) {
                    MemberModel *item = [MemberModel new];
                    item.title = titleArr[i];
                    item.subTitle = detailsArr[i];
                    [items addObject:item];
                    
                }
                [self.resorceArray addObject:items];
                [self.tableView reloadData];
            }

        }
        
    }];
   
}


#pragma mark - 网络数据请求
- (void)savaInfoRequestParam:(NSDictionary *)param
{
    WEAKSELF;
    NSString *urlStr = @"";
    
    if ([KX_UserInfo sharedKX_UserInfo].isMembers) {
        urlStr = @"/m/m_042";
    }else{
        urlStr = @"/m/m_047";
    }
    [MemberInfoVModel getSaveInfoUrl:urlStr Param:param successBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf loadData];
        }
        else{
            
        }
    }];
    
}
#pragma mark - 点击方法

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resorceArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.resorceArray objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        if (!KX_NULLString(_bid)) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    MemberModel *item = [self.resorceArray objectAtIndex:indexPath.section][indexPath.row];
    cell.textLabel.text = item.title;
    
    cell.textLabel.textColor = TITLETEXTLOWCOLOR;
    cell.textLabel.font = Font15;
    cell.textLabel.numberOfLines = 0;

    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = item.subTitle;
    cell.detailTextLabel.font = Font15;
    cell.detailTextLabel.textColor = TITLETEXTLOWCOLOR;

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WEAKSELF;
    ChangeInfoType type = ChangeInfoTypeContact;
    if (!KX_NULLString(_bid)) {
        MemberModel *item = [self.resorceArray objectAtIndex:indexPath.section][indexPath.row];
        if ([item.title isEqualToString:@"手机号"] || [item.title isEqualToString:@"电话"]) {
            if (KX_NULLString(item.subTitle)) {
                [weakSelf.view toastShow:@"此号码无效~"];
                return ;
            }
            
            SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:[NSString stringWithFormat:@"呼叫号码%@？",item.subTitle] clickDex:^(NSInteger clickDex) {
                if (clickDex == 1) {
                    NSMutableString *str1=[[NSMutableString alloc] initWithFormat:@"tel:%@",item.subTitle];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str1]];
                }}];
            [successV showSuccess];
        }
        
    }else{
        NSString *title = @"";
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case  0: {type = ChangeInfoTypeContact;title = @"修改联系人";}break;
                case  1: {type = ChangeInfoTypeTel;title = @"修改手机号";}break;
                case  2: {type = ChangeInfoTypeEMeil;title = @"修改邮箱";}break;
                case  3: {type = ChangeInfoTypePhone;title = @"修改电话";}break;
                case  4: {type = ChangeInfoTypeChuanzhen;title = @"修改传真";}break;
                    
                default:
                    break;
            }
        }
        else if(indexPath.section ==1){
            switch (indexPath.row) {
                case  0: {type = ChangeInfoTypeBumen;title = @"修改部门";}break;
                case  1: {type = ChangeInfoTypeJob;title = @"修改职位";}break;
                case  2: {type = ChangeInfoTypeQQ;title = @"修改QQ";}break;
                default:
                    break;
            }
        }
        else if(indexPath.section == 2){
            switch (indexPath.row) {
                case  0: {
                    WEAKSELF;
                    [LZCityPickerController showPickerInViewController:self selectBlock:^(NSString *address, NSString *province, NSString *city, NSString *area) {
                        // 选择结果回调
                        NSString *MyAddress = [NSString stringWithFormat:@"%@%@%@",province,city,area];
                        NSLog(@"%@--%@--%@--%@",address,province,city,area);
                        MemberModel *item = weakSelf.resorceArray[indexPath.section][indexPath.row];
                        item.subTitle = MyAddress;
                        //                    [weakSelf.tableView reloadData];
                        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                        if ([KX_UserInfo sharedKX_UserInfo].isMembers) {
                            [param setObject:[KX_UserInfo sharedKX_UserInfo].ID forKey:@"mid"];
                        }else{
                            [param setObject:[KX_UserInfo sharedKX_UserInfo].aid forKey:@"aid"];
                        }
                        [param setObject:province forKey:@"province"];
                        [param setObject:city forKey:@"city"];
                        [param setObject:area forKey:@"area"];
                        [weakSelf savaInfoRequestParam:param];
                    }];
                    return;
                }break;
                case  1: {type = ChangeInfoTypeAddress;title = @"修改详细地址";}break;
                default:
                    break;
            }
        }else{
            type = ChangeInfoTypeHTTP;title = @"修改网址";
        }
        __block MemberModel *item = [self.resorceArray objectAtIndex:indexPath.section][indexPath.row];
//        if ([KX_UserInfo sharedKX_UserInfo].isMembers) {
//            if (![title isEqualToString:@"修改手机号"] ) {
//                [self.view toastShow:@"亲，您无权限操作，请到PC端提交企业信息升级为供应商~"];
//                return;
//            }
//        }
        if ([title isEqualToString:@"修改手机号"] ) {
            return;
        }
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                KYOlderPhoneVC *VC = [[KYOlderPhoneVC alloc] init];
                [self.navigationController pushViewController:VC animated:YES];
            }else{
           
                WEAKSELF;
                ChangeInfoVC *VC = [[ChangeInfoVC alloc] initWithType:type content:item.subTitle sBlock:^(NSString *content) {
                    LOG(@"%@",content);
                    item.subTitle = content;
                    [weakSelf.tableView reloadData];
                }];
                VC.title = title;
                [self.navigationController pushViewController:VC animated:YES];
                
            }
        }else{
            WEAKSELF;
            ChangeInfoVC *VC = [[ChangeInfoVC alloc] initWithType:type content:item.subTitle sBlock:^(NSString *content) {
                LOG(@"%@",content);
                item.subTitle = content;
                [weakSelf.tableView reloadData];
            }];
            VC.title = title;
            [self.navigationController pushViewController:VC animated:YES];
            
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberModel *item = [self.resorceArray objectAtIndex:indexPath.section][indexPath.row];
    CGSize rowSize = [NSString heightForString:item.subTitle  fontSize:Font15 WithSize:CGSizeMake(SCREEN_WIDTH - 150, SCREEN_HEIGHT)];
    if (rowSize.height <44) {
        return 44;
    }
    return rowSize.height;
    
}
#pragma mark - public 共有方法



@end
