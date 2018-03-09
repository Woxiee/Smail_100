//
//  GoodGuigeView.m
//  ShiShi
//
//  Created by Faker on 17/3/9.
//  Copyright © 2017年 fec. All rights reserved.
//

#import "GoodGuigeView.h"
#import "GoodGuigeCell.h"
#import "GoodGuigeSectionHeadView.h"
@interface GoodGuigeView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
@property (nonatomic, weak) UIView *darkView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong)  UILabel *pricekLabel;
@property (nonatomic, strong) UILabel *kuCunLabel;
@property (nonatomic, strong) NSMutableArray *dataArray;  /// 选择数据源
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong)  UILabel *guiGeLabel;/// 选择规格属性


@property (nonatomic, strong) NSMutableArray *titleArray;  ///标题

@property (nonatomic, strong)  UITextField *numberTextField;/// 数量TextField
@property (nonatomic, assign)  float pading;  /// 间隔距离
@end


static NSString * const cellID = @"cellID";
static NSString *goodGuigeSectionHeadViewID = @"GoodGuigeSectionHeadView";

@implementation GoodGuigeView
{
    NSString *_guigeID; ///  规格默认选中
}

- (instancetype)initWithFrame:(CGRect)frame withChooseType:(GoodGuigeChooseType )chossType
{
    if (self = [super initWithFrame:frame]) {
        self.goodGuigeChooseType = chossType;

        [self setConfiguration];
        [self addNoticeForKeyboard];
    }
    return self;
}

/// 初始化视图
- (void)setup
{
    UIView *darkView                = [[UIView alloc] init];
    darkView.userInteractionEnabled = YES;
    darkView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    darkView.backgroundColor        = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:darkView];
    self.darkView = darkView;
    
    UITapGestureRecognizer  *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheetView)];
    [self.darkView addGestureRecognizer:tapGestureRecognizer];

    UIView *bottomView = [[UIView alloc] init];
    int j = 0;
//    for (int i = 0; i<self.dataArray.count * self.titleArray.count; i++) {
//        if (i%4 == 0 ) {
//            j++;
//        }
//    }

    bottomView.frame = CGRectMake(0, SCREEN_HEIGHT  - 200, SCREEN_WIDTH,200);
    bottomView.backgroundColor  = [UIColor whiteColor];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT - bottomView.height  - 20, 92, 92)];
    iconImageView.backgroundColor = [UIColor whiteColor];
    [iconImageView  layerForViewWith:0 AndLineWidth:1];
    [self addSubview:iconImageView];
    self.iconImageView = iconImageView;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.subResult.imgSrc_one] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    ///
    UILabel *pricekLabel = [[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame) +12,12 ,200, 15)];
    pricekLabel.font = Font15;
    pricekLabel.textColor = BACKGROUND_COLORHL;
    pricekLabel.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:pricekLabel];
    self.pricekLabel = pricekLabel;
    self.pricekLabel.text = [NSString stringWithFormat:@"￥%@",_model.showPirce];
    /// 库存
    UILabel *kuCunLabel = [[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame) +12,CGRectGetMaxY(pricekLabel.frame) +7 , 200, 15)];
//    kuCunLabel.text = _model.productQty;
    kuCunLabel.font = Font13;
    kuCunLabel.textColor = RGB(102, 102, 102);
    kuCunLabel.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:kuCunLabel];
    self.kuCunLabel = kuCunLabel;
    if ([_model.param5 isEqualToString:@"1"]) {
         self.kuCunLabel.text   = @"库存充足";
    }else{
        self.kuCunLabel.text = [NSString stringWithFormat:@"库存：%@件",_model.cargoNumber];
    }
    /// 规格
    UILabel *guiGeLabel = [[UILabel alloc]  initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame) + 12 ,CGRectGetMaxY(kuCunLabel.frame) + 7, SCREEN_WIDTH - CGRectGetMaxX(iconImageView.frame)-24 , 15)];
    guiGeLabel.text = @"已选择:";
    guiGeLabel.font = Font13;
    guiGeLabel.textColor = DETAILTEXTCOLOR;
    guiGeLabel.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:guiGeLabel];
    _guiGeLabel = guiGeLabel;
    _guiGeLabel.text = @"";
//    /// 线
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(guiGeLabel.frame) +15, SCREEN_WIDTH - 20, 0.5)];
    lineView1.backgroundColor = [UIColor clearColor];
    [bottomView addSubview:lineView1];

    
    UIButton *dissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dissBtn.frame = CGRectMake(SCREEN_WIDTH - 37 ,12 , 25, 25);
    [dissBtn setImage:[UIImage imageNamed:@"35@3x.png"] forState:UIControlStateNormal];
    [dissBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dissBtn addTarget:self action:@selector(hiddenSheetView) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:dissBtn];
    
//    /// 规格
//    UILabel *guiGeLabel1 = [[UILabel alloc]  initWithFrame:CGRectMake(10,CGRectGetMaxY(lineView1.frame) +15 , 200, 15)];
//    guiGeLabel1.text = @"规格";
//    guiGeLabel1.font = Font15;
//    guiGeLabel1.textColor = TITLETEXTLOWCOLOR;
//    guiGeLabel1.textAlignment = NSTextAlignmentLeft;
//    [bottomView addSubview:guiGeLabel1];
    
    UICollectionViewFlowLayout  *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView1.frame) +12, SCREEN_WIDTH, _pading + _pading*j) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollEnabled = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:collectionView];
    self.collectionView = collectionView;
        [self.collectionView registerNib:[UINib nibWithNibName:@"GoodGuigeCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GoodGuigeSectionHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:goodGuigeSectionHeadViewID];
    /// 线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(collectionView.frame), SCREEN_WIDTH - 20, 0.5)];
    lineView.backgroundColor = LINECOLOR;
    [bottomView addSubview:lineView];
    
    /// 购买数量
    UILabel *numberTitle = [[UILabel alloc]  initWithFrame:CGRectMake(10,CGRectGetMaxY(lineView.frame) +15 , 200, 15)];
   
    if ([ _model.typeStr isEqualToString:@"3"] || [ _model.typeStr isEqualToString:@"4"]) {
        numberTitle.text = @"租赁数量";

    }else{
        numberTitle.text = @"购买数量";
    }

    numberTitle.font = Font15;
    numberTitle.textColor = TITLETEXTLOWCOLOR;
    numberTitle.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:numberTitle];
    


    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCREEN_WIDTH - 40,CGRectGetMaxY(lineView.frame) +12 , 30, 30);
    [addBtn setImage:[UIImage imageNamed:@"ico_add"] forState:UIControlStateNormal];
    addBtn.tag = 101;
    [addBtn addTarget:self action:@selector(didClickChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:addBtn];
    

    
    UITextField *numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -100,CGRectGetMaxY(lineView.frame) +12 , 60, 30)];
    numberTextField.delegate  =self;
    numberTextField.text = [NSString stringWithFormat:@"%ld",(long)_model.goodSCount];
    [bottomView addSubview:numberTextField];
    numberTextField.textAlignment = NSTextAlignmentCenter;
//    numberTextField.userInteractionEnabled =  NO;//jp 暂时不用
    [numberTextField layerForViewWith:0 AndLineWidth:0.5];
    _numberTextField = numberTextField;

    
    UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleBtn.frame = CGRectMake(SCREEN_WIDTH -100 - 30,CGRectGetMaxY(lineView.frame) +12 , 30, 30);
    [deleBtn setImage:[UIImage imageNamed:@"ico_minus"] forState:UIControlStateNormal];
    deleBtn.tag = 100;
    [deleBtn addTarget:self action:@selector(didClickChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:deleBtn];
   //    GoodGuigeAddCartOrBuyType, ///添加购物车或者购买
//    GoodGuigeChooseGoodsType      ///购买
           UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(0 ,self.bottomView.height - 49, SCREEN_WIDTH, 49);
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        sureBtn.userInteractionEnabled = YES;
        sureBtn.tag = 1000;

        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(didClickSureAction:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.backgroundColor = BACKGROUND_COLORHL;
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [bottomView addSubview:sureBtn];

}

/// 配置基础设置
- (void)setConfiguration
{
//    _count =1;
    _titleArray = [[NSMutableArray alloc] init];
    _pading = 0;
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
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }];
}

/// 确定
- (void)didClickSureAction:(UIButton*)sender
{
    [self endEditing:YES];

//    else if (![_model.param5 isEqualToString:@"1"]) {
//        if (_model.goodSCount > [_model.cargoNumber intValue]){
//            [self makeToast:@"购买数量大于库存数量！"];
//            return;
//        }
//    }

     _model.goodsSizeID = @"";
    _model.propertys  = @"";
    for (NSArray *contenArray  in _dataArray) {
        for ( AttrValue *attrModel in contenArray) {
            if (attrModel.isSelect) {
                if (KX_NULLString(_model.propertys)) {
                    _model.propertys = [NSString stringWithFormat:@"%@:%@",attrModel.attrValueMainName,attrModel.attrValueName];
                }else{
                    _model.propertys =  [NSString stringWithFormat:@"%@ %@:%@",_model.propertys,attrModel.attrValueMainName,attrModel.attrValueName];
                }
                
                if (KX_NULLString(_model.goodsSizeID)) {
                    _model.goodsSizeID = [NSString stringWithFormat:@"%@:%@",attrModel.attrValueMainID,attrModel.attrValueId];
                }else{
                    _model.goodsSizeID =  [NSString stringWithFormat:@"%@,%@:%@",_model.goodsSizeID,attrModel.attrValueMainID,attrModel.attrValueId];
                }
                
            }
        }
    }


    if (self.goodGuigeChooseType == GoodGuigeAddCartOrBuyType ) {
        if (self.submitBlock) {
            self.submitBlock(_model,1);
        }
    }else{
        if (self.submitBlock) {
            self.submitBlock(_model,2);
        }
    }
   
    [self hiddenSheetView];
}


/// 增加 减少BTN
- (void)didClickChangeAction:(UIButton *)btn
{
       if (btn.tag == 100) {
           _model.goodSCount --;
           if (_model.goodSCount ==1 ||_model.goodSCount<1) {
               _model.goodSCount =1;
           }
  
           _numberTextField.text = [NSString stringWithFormat:@"%ld",(long)_model.goodSCount];

    }
   
    else if (btn.tag == 101){
         _model.goodSCount ++;
        if ([_model.param5 isEqualToString:@"1"]) {
            _numberTextField.text = [NSString stringWithFormat:@"%ld",(long)_model.goodSCount];

        }else{
            if (_model.goodSCount > [_model.cargoNumber integerValue]) {
                if ([_model.cargoNumber integerValue] == 0) {
                    [self makeToast:@"库存不足"];
                    
                }else{
                    [self makeToast:[NSString stringWithFormat:@"库存不足，最多购买‘%@’件",_model.cargoNumber]];
                }
                
                _numberTextField.text = [NSString stringWithFormat:@"%@",_model.cargoNumber];
                _model.goodSCount = [_model.cargoNumber integerValue];
            }
            
            _numberTextField.text = [NSString stringWithFormat:@"%ld",(long)_model.goodSCount];


        }
        
        
    }
    


}




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return  _model.sKU.count;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_dataArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodGuigeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.attrModel = _dataArray[indexPath.section][indexPath.row];
//     AttrValue *model  = _model.selectAttrMap;
//    LOG(@"%ld",(long)[cell.model.attrvalueId integerValue]);
    return cell;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
     AttrValue *model = _dataArray[indexPath.section][indexPath.row];
    CGSize itemsW =  [NSString heightForString:model.attrValueName fontSize:Font12 WithSize:CGSizeMake(SCREEN_WIDTH, 30)];
   
    return CGSizeMake(itemsW.width +20, 30);
 
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 5, 10);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    [self changeModelValueWithIndexPatch:indexPath];
     AttrValue *attrModel = _dataArray[indexPath.section][indexPath.row];
    LOG(@"attrModel = %@",attrModel.attrValueId);
    attrModel.isSelect = YES;
    [self.collectionView reloadData];
    
    _model.goodsSizeID = @"";
    _model.propertys  = @"";
    for (NSArray *contenArray  in _dataArray) {
        for ( AttrValue *attrModel in contenArray) {
            if (attrModel.isSelect) {
                if (KX_NULLString(_model.propertys)) {
                    _model.propertys = [NSString stringWithFormat:@"%@:%@",attrModel.attrValueMainName,attrModel.attrValueName];
                }else{
                    _model.propertys =  [NSString stringWithFormat:@"%@ %@:%@",_model.propertys,attrModel.attrValueMainName,attrModel.attrValueName];
                }
            }
        }
        _guiGeLabel.text = [NSString stringWithFormat:@"已选择：%@",_model.propertys];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if ([_model.onSale isEqualToString:@"0"]) {
//        [iToast alertWithTitle:@"该商品已下架~"];
        return NO;
    }
  
    return YES;
}



- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

        return CGSizeMake(SCREEN_WIDTH, 20);

}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        GoodGuigeSectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:goodGuigeSectionHeadViewID forIndexPath:indexPath];
        headerView.titleLabel.text = _titleArray[indexPath.section];
        return headerView;
    }
 
    return nil;

}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    LOG(@"textField.TEXT = %@   string = %@",textField.text,string);
    BOOL basic = [NSString cheakInputStrIsNumber:string];
    if(!basic)
    {
        //输入了非法字符
        return NO;
    }
    
    basic = [textField.text integerValue] >99999999? 1:0;
    if (basic) {
        textField.text =@"99999999";
        return YES;
    }
    
    return YES;
}


-  (void)textFieldDidEndEditing:(UITextField *)textField
{
    LOG(@"textField.TEXT  = %@",textField.text);
    if ([textField.text isEqualToString:@""] || [textField.text isEqualToString:@"0"]) {
        _numberTextField.text = @"1";
        _model.goodSCount =  1;
    }else{
        if ([_model.param5 isEqualToString:@"1"]) {
            _model.goodSCount =  [ _numberTextField.text integerValue];
            
        }else{
            if ([textField.text integerValue] > [_model.cargoNumber integerValue]) {
                [self.window makeToast:[NSString stringWithFormat:@"库存不足，最多购买‘%@’件",_model.cargoNumber]];
                _numberTextField.text = [NSString stringWithFormat:@"%@",_model.cargoNumber];
            }
            _model.goodSCount =  [ _numberTextField.text integerValue];
        }
        
    }

}


#pragma mark = get & set
-(void)setModel:(GoodSDetailModel *)model
{
    _model = model;
    NSArray *goodsSizeIDArray = nil;
 
    if (!KX_NULLString(_model.goodsSizeID)) {
        /// 将之前拼接的id 还原
        goodsSizeIDArray  = [_model.goodsSizeID componentsSeparatedByString:NSLocalizedString(@",", nil)];
    }
    NSMutableArray *contenArray = [[NSMutableArray alloc] init];
    for (SKU *property in _model.sKU) {
        LOG(@"%@", property.attrValue);
        [_titleArray addObject:property.attrName];
        contenArray = [AttrValue mj_objectArrayWithKeyValuesArray:property.attrValue];
        for ( AttrValue *attrModel  in  contenArray) {
            if (contenArray.count == 1) {
                attrModel.isSelect = YES;
            }
            attrModel.attrValueMainID = property.attrId;
            attrModel.attrValueMainName = property.attrName;
            ///没有记录规格的话 默认选择 第一个规格属性
            for (NSString *attrValueStr in  goodsSizeIDArray) {
                NSString *attvaluAndMainID = [NSString stringWithFormat:@"%@:%@",attrModel.attrValueMainID,attrModel.attrValueId];
                if ([attvaluAndMainID isEqualToString:attrValueStr]) {
                    attrModel.isSelect = YES;
                }
            }
        }
        
        if (goodsSizeIDArray == nil) {
            AttrValue *attrModel = contenArray[0];
           attrModel.isSelect = YES;

        }
        [self.dataArray addObject:contenArray];
    }
    
    /// 默认购买数量为1
    if (  _model.goodSCount == 0   ) {
        _model.goodSCount = 1;
    }
    
    for (NSArray *contenArray  in _dataArray) {
        for ( AttrValue *attrModel in contenArray) {
            if (attrModel.isSelect) {
                if (KX_NULLString(_model.propertys)) {
                    _model.propertys = [NSString stringWithFormat:@"%@:%@",attrModel.attrValueMainName,attrModel.attrValueName];
                }else{
                    _model.propertys =  [NSString stringWithFormat:@"%@ %@:%@",_model.propertys,attrModel.attrValueMainName,attrModel.attrValueName];
                }
            }
        }
    }

    
     [self setup];
}


-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark  -private
- (void)changeModelValueWithIndexPatch:(NSIndexPath *)indexPath
{

    LOG(@"_model.goodsSizeID = %@",_model.goodsSizeID);
    LOG(@"_model.goodsSi = %@",_model.propertys);
    for (   AttrValue *attrModel  in  self.dataArray[indexPath.section]) {
        attrModel.isSelect = NO;
    }
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
    CGFloat offset = (_numberTextField.frame.origin.y+_numberTextField.frame.size.height+ _bottomView.height) - (self.frame.size.height - kbHeight);
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = CGRectMake(0.0f, -kbHeight, self.frame.size.width, self.frame.size.height);
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }];
}

@end
