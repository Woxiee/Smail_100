//
//  PayOrderView.m
//  JXActionSheet
//
//  Created by ap on 2018/3/9.
//  Copyright © 2018年 JX.Wang. All rights reserved.
//

#import "PayOrderView.h"
#import "PayOtherCell.h"
#import "PayViewCell.h"
#import "PayDetailModel.h"


@interface PayOrderView ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) NSArray *dataArray;  /// 选择数据源
@property (nonatomic, weak) UIView *darkView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong)  UILabel *jfLb;

@property (nonatomic, assign)  BOOL isLoading;


@property (nonatomic, assign) float inputValuePoint;

@end


@implementation PayOrderView

static NSString * const payViewCellID = @"PayViewCellID";

static NSString * const OthercellID = @"OthercellID";


- (instancetype)initWithFrame:(CGRect)frame withPayType:(PayType)payType;
{
    if (self = [super initWithFrame:frame]) {
        self.payType = payType;
        [self addNoticeForKeyboard];

    }
    return self;
}

/// 初始化视图
- (void)setup
{
    UIView *darkView                = [[UIView alloc] init];
    darkView.userInteractionEnabled = YES;
    darkView.frame = CGRectMake(0, 0, self.frame.size.width, SCREEN_HEIGHT);
    darkView.backgroundColor        = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:darkView];
    self.darkView = darkView;
    
    UITapGestureRecognizer  *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheetView)];
    [self.darkView addGestureRecognizer:tapGestureRecognizer];
    
    CGFloat hegiht = 40 +90;
    
    UIView *bottomView = [[UIView alloc] init];
//    if (self.payType == PayTypeNoaml) {
//        bottomView.frame = CGRectMake(0, SCREEN_HEIGHT  -(_dataArr.count+1) *44 -hegiht, self.frame.size.width,(_dataArr.count+1) *44 + hegiht);
//    }else{
//        bottomView.frame = CGRectMake(0, SCREEN_HEIGHT  -(_dataArr.count+1) *44 - hegiht, self.frame.size.width,(_dataArr.count+1) *44 +hegiht);
//    }
    
    bottomView.frame = CGRectMake(0, SCREEN_HEIGHT  -(_dataArr.count+1) *45 -hegiht, self.frame.size.width,(_dataArr.count+1) *45 +hegiht);
    bottomView.backgroundColor  = [UIColor whiteColor];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    
 

    
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, self.frame.size.width - 50 - 12, 50)];
    titleLb.text = @"请选择支付方式";
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:titleLb];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLb.frame),  self.frame.size.width, 0.5)];
    lineView.backgroundColor  = LINECOLOR;
    [bottomView addSubview:lineView];

    UIButton *dissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dissBtn.frame = CGRectMake(self.frame.size.width - 50 ,8 , 35, 35);
    [dissBtn setImage:[UIImage imageNamed:@"hehuorenshengji7@3x"] forState:UIControlStateNormal];
    [dissBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dissBtn addTarget:self action:@selector(hiddenSheetView) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:dissBtn];

    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame)+1, self.frame.size.width,_dataArr?_dataArr.count*45 : _dataArray.count*45) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 44;
    tableView.scrollEnabled = NO;
    tableView.backgroundColor = [UIColor redColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bottomView addSubview:tableView];
    self.tableView = tableView;
    [self.tableView registerNib:[UINib nibWithNibName:@"PayOtherCell" bundle:nil] forCellReuseIdentifier:OthercellID];

    [self.tableView registerNib:[UINib nibWithNibName:@"PayViewCell" bundle:nil] forCellReuseIdentifier:payViewCellID];


    UILabel *jfLb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tableView.frame)+10, self.frame.size.width, 44)];
    jfLb.textAlignment = NSTextAlignmentCenter;
    jfLb.font = [UIFont systemFontOfSize:14];
    jfLb.textColor = KMAINCOLOR;
    [bottomView addSubview:jfLb];
    self.jfLb = jfLb;
  
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(20, bottomView.mj_h - 70,self.frame.size.width - 40 , 45);
    [sureBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    sureBtn.backgroundColor = KMAINCOLOR;
    [sureBtn layerForViewWith:10 AndLineWidth:0];
    [sureBtn addTarget:self action:@selector(didClickCompletAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sureBtn];
}


#pragma mark - 键盘通知
- (void)addNoticeForKeyboard {
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
//    CGFloat offset = (_bottomView.frame.origin.y+_bottomView.frame.size.height+ _bottomView.height) - (SCREEN_HEIGHT - kbHeight);
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //将视图上移计算好的偏移
//    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = CGRectMake(0.0f, -kbHeight, self.frame.size.width, SCREEN_HEIGHT);
        }];
//    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, SCREEN_HEIGHT);
    }];
}


/// 出现
- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    
    [keyWindow addSubview:self];
}

/// 消失
- (void)hiddenSheetView {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        //        CGRect bgRect =  weakSelf.darkView.frame;
        //        CGRect chooseMenuRect =  weakSelf.contenView.frame;
        //        bgRect.origin.x= SCREEN_WIDTH;
        //        chooseMenuRect  = CGRectMake(SCREEN_WIDTH +40, 0, SCREEN_WIDTH- 40, SCREEN_HEIGHT);
        //        weakSelf.darkView.frame = bgRect;
        //        weakSelf.contenView.frame = chooseMenuRect;
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
    }];
}


///
- (void)didClickCompletAction
{
    [self endEditing:YES];
 
    if ( _orderModel.allFreight> 0 &&  self.payType == PayTypeOther  &&  [_orderModel.payIndexStr isEqualToString:@"兑换积分支付"]) {
            [self makeToast:@"请勾选快递费支付后提交支付哦"];
            return;
        
    }
    if (KX_NULLString(_orderModel.payIndexStr)) {
        [self makeToast:@"还未选择支付方式哦"];
        return;
    }
    
    if ([_orderModel.jfValue floatValue] > _orderModel.allPoint) {
        [self makeToast:@"兑换积分支付大于待支付积分"];
        return;
    }
    
    if ( self.payType == PayTypeOther) {
        if ([[KX_UserInfo sharedKX_UserInfo].point floatValue] < _orderModel.allPoint) {
            [self makeToast:@"积分不足"];
            return;
        }
        _orderModel.jfValue = [NSString stringWithFormat:@"%.1f",_orderModel.allPoint];
    }
    
    if (_didChangeJFValueBlock) {
        _didChangeJFValueBlock(_orderModel);
    }
    
    [self hiddenSheetView];
}

#pragma mark - UITaleViewDelegate and UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayDetailModel *model = self.dataArr[indexPath.row];
    if ( self.payType == PayTypeOther) {
        PayViewCell *cell = [tableView dequeueReusableCellWithIdentifier:payViewCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataArr[indexPath.row];
        return cell;
    }else{
        if ([model.title isEqualToString:@"兑换积分支付"]) {
            PayOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:OthercellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.numberTextFied.delegate = self;
            cell.model = self.dataArr[indexPath.row];
            cell.numberTextFied.placeholder = [NSString stringWithFormat:@"当前可兑换积分支付%@",_orderModel.userinfo.point];
            return cell;
            
        }else{
            PayViewCell *cell = [tableView dequeueReusableCellWithIdentifier:payViewCellID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.dataArr[indexPath.row];
            return cell;
        }

    }
    
   
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self endEditing:YES];
    PayDetailModel *model = self.dataArr[indexPath.row];
//    if ([model.title isEqualToString:@"兑换积分支付"]) {
//        if ( self.payType == PayTypeOther) {
//            for (PayDetailModel *payDetailModel in self.dataArr) {
//                payDetailModel.isSelect = NO;
//                if (<#condition#>) {
//                    <#statements#>
//                }
//            }
//            model.isSelect = YES;
//            _orderModel.payIndexStr = model.title;
//            [self.tableView reloadData];
//        }
//
//    }else{
    
//    }
    for (PayDetailModel *payDetailModel in self.dataArr) {
        payDetailModel.isSelect = NO;
        if ( self.payType == PayTypeOther) {
            if ([payDetailModel.title isEqualToString:@"兑换积分支付"]) {
                payDetailModel.isSelect = YES;
            }
        }
    }
   
    model.isSelect = YES;
    _orderModel.payIndexStr = model.title;
    [self.tableView reloadData];
 
}


#pragma mark - get &set

 -(void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    
    if (_dataArr.count == 1 ) {
        PayDetailModel *model = _dataArr.lastObject;
        if ([model.title isEqualToString:@"兑换积分支付"]) {
            _orderModel.payIndexStr = model.title;
        }
    }
    
    [self setup];

}

-(NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSArray alloc] init];
    }
    return _dataArray;
}

- (void)setOrderModel:(GoodsOrderModel *)orderModel
{
    _orderModel = orderModel;
    _inputValuePoint = _orderModel.allPoint;
    NSMutableArray *priceArr = [NSMutableArray array];

    if (_orderModel.allPriceAttriStr == nil) {
        if (_orderModel.allPrices>0) {
            NSString *str = [NSString stringWithFormat:@"¥%.2f",_orderModel.allPrices];
            [priceArr addObject:str];
        }
        if (_orderModel.allPoint>0) {
            NSString *str = [NSString stringWithFormat:@"%.2f积分",_orderModel.allPoint];
            [priceArr addObject:str];
        }
        
        if (_orderModel.allFreight>0) {
            NSString *str = [NSString stringWithFormat:@"%.2f快递费",_orderModel.allFreight];
            [priceArr addObject:str];
        }
        
        
        NSString *allStr = [priceArr componentsJoinedByString:@"+"];
        allStr = [allStr stringByReplacingOccurrencesOfString:@".00" withString:@""];
//        NSString *conten = [NSString stringWithFormat:@"待支付:%@",allStr];
        
        NSAttributedString *attributedStr =  [self attributeStringWithContent:[NSString stringWithFormat:@"待支付:%@",allStr] keyWords:@[@"积分",@"+",@"快递费"]];
        
        
     NSMutableAttributedString *conten =(NSMutableAttributedString *)attributedStr;
        [conten addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:14]
                           range:NSMakeRange(0, 4)];
        
        [conten addAttribute:NSForegroundColorAttributeName value:DETAILTEXTCOLOR range:NSMakeRange(0 ,4)];

        self.jfLb.attributedText  = conten;


    }else{
        self.jfLb.attributedText = _orderModel.allPriceAttriStr;

    }

    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    if (_isLoading ==  NO) {
//         _number = @"1";
//        [self.tableView reloadData];
//        _isLoading = YES;
//    }

    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    LOG(@"textField.TEXT = %@   string = %@",textField.text,string);
    NSMutableString *text = [NSMutableString stringWithString:textField.text];
    
    [text replaceCharactersInRange:range withString:string];
    
//    BOOL basic = [NSString cheakInputStrIsNumber:string];
//    if(!basic)
//    {
//        //输入了非法字符
//        return NO;
//    }
//
//    basic = [textField.text integerValue] >99999999? 1:0;
//    if (basic) {
//        textField.text =@"99999999";
//        return YES;
//    }
//    _number = textField.text;
//     textField.text = [textField.text stringByAppendingString:string];
    

    if ([text floatValue] > _orderModel.allPoint) {
        [self makeToast:@"请输入对应积分"];

    }

    else if ([_orderModel.jfValue floatValue] > [[KX_UserInfo sharedKX_UserInfo].point floatValue]) {
        [self makeToast:@"积分不足"];

    }
    
    [self upDataAllproTex:[text floatValue]];

    return YES;
}


-  (void)textFieldDidEndEditing:(UITextField *)textField
{
    _number = textField.text;
//    _orderModel.allPoint = _orderModel.allPoint -  _number.floatValue;
    _orderModel.jfValue = textField.text;

    
}

- (void)upDataAllproTex:(float )allPoint
{
    NSString *allPriceStr = @"";
    NSMutableArray *priceArr = [NSMutableArray array];
    if (_orderModel.allPrices>0) {
        NSString *str = [NSString stringWithFormat:@"¥%.1f",_orderModel.allPrices];
        [priceArr addObject:str];
    }
    
    if (allPoint>0) {
        if (allPoint > _orderModel.allPoint ) {
            allPoint =  _orderModel.allPoint;
        }
        NSString *str = [NSString stringWithFormat:@"%.2f积分",_inputValuePoint - allPoint];
        [priceArr addObject:str];
    }
    else {
        NSString *str = [NSString stringWithFormat:@"%.2f积分",_orderModel.allPoint];
        [priceArr addObject:str];
    }
    
    if (_orderModel.allFreight>0) {
        NSString *str = [NSString stringWithFormat:@"%.2f快递费",_orderModel.allFreight];
        [priceArr addObject:str];
    }
    
    allPriceStr = [priceArr componentsJoinedByString:@"+"];
    allPriceStr = [allPriceStr stringByReplacingOccurrencesOfString:@"+0积分" withString:@""];
    allPriceStr = [allPriceStr stringByReplacingOccurrencesOfString:@"0积分+" withString:@""];
    NSAttributedString *attributedStr =  [self attributeStringWithContent:allPriceStr keyWords:@[@"积分",@"快递费",@"+"]];

    self.jfLb.attributedText = attributedStr;
    
    
}

- (NSAttributedString *)attributeStringWithContent:(NSString *)content keyWords:(NSArray *)keyWords
{
    UIColor *color = KMAINCOLOR;
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:content];
    
    if (keyWords) {
        
        [keyWords enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSMutableString *tmpString=[NSMutableString stringWithString:content];
            
            NSRange range=[content rangeOfString:obj];
            
            NSInteger location=0;
            
            while (range.length>0) {
                
                [attString addAttribute:(NSString*)NSForegroundColorAttributeName value:color range:NSMakeRange(location+range.location, range.length)];
                [attString addAttribute:NSFontAttributeName
                                  value:Font11
                                  range:range];
                
                location+=(range.location+range.length);
                
                NSString *tmp= [tmpString substringWithRange:NSMakeRange(range.location+range.length, content.length-location)];
                
                tmpString=[NSMutableString stringWithString:tmp];
                
                range=[tmp rangeOfString:obj];
            }
        }];
    }
    return attString;
}


@end
