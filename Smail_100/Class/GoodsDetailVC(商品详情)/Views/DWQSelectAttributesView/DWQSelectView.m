//
//  DWQSelectView.m
//  DWQSelectAttributes
//
//  Created by 杜文全 on 15/5/21.
//  Copyright © 2015年 com.sdzw.duwenquan. All rights reserved.
//

#import "DWQSelectView.h"
@interface DWQSelectView ()<UITextFieldDelegate>

//规格分类
@property(nonatomic,strong)NSArray *rankArr;
@property(nonatomic,assign) int goodSCount;
@property (nonatomic, strong) UIButton *addCountBtn;
@property (nonatomic, strong) UIButton *deleBtn;

@end
@implementation DWQSelectView

@synthesize alphaView,whiteView,headImage,LB_detail,LB_line,LB_price,LB_stock,LB_showSales,mainscrollview,cancelBtn,addBtn,buyBtn,stockBtn;

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self creatUI];
        [self addNoticeForKeyboard];

        
    }
    return self;
}



-(void)creatUI{
    
    _goodSCount = 1;
    //半透明视图
    alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.3;
    [self addSubview:alphaView];
    
    //装载商品信息的视图
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT-300)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    
    //商品图片
    headImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
//    headImage.image = [UIImage imageNamed:@"凯迪拉克.jpg"];
    headImage.layer.cornerRadius = 4;
//    headImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    headImage.layer.borderWidth = 1;
//    [headImage.layer setMasksToBounds:YES];
    [whiteView addSubview:headImage];
    
    cancelBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(SCREEN_WIDTH-40, 10, 25, 25);
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"Close@2x.png"] forState:UIControlStateNormal];
    [whiteView addSubview:cancelBtn];
    
    UILabel *nameLB = [[UILabel  alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+10, 10, SCREEN_WIDTH -CGRectGetMaxX(headImage.frame)- 60 , 35)];
    nameLB.font = Font14;
    nameLB.textColor = TITLETEXTLOWCOLOR;
    nameLB.textAlignment = NSTextAlignmentLeft;
    nameLB.numberOfLines = 2;
    [whiteView addSubview:nameLB];
    self.nameLB  = nameLB;
    
    
    //商品价格
    LB_price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+10, CGRectGetMaxY(nameLB.frame)+3, 150, 20)];
    LB_price.text = @"¥100";
    LB_price.textColor = KMAINCOLOR;
    LB_price.font = [UIFont systemFontOfSize:16];
    [whiteView addSubview:LB_price];
    //商品库存
    LB_stock = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+10, CGRectGetMaxY(LB_price.frame)+3, 150, 20)];
    LB_stock.text = @"";
    LB_stock.textColor = DETAILTEXTCOLOR;
    LB_stock.font = Font14;
    [whiteView addSubview:LB_stock];
    
    //用户所选择商品的尺码和颜色
    LB_detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+10, CGRectGetMaxY(LB_stock.frame) + 3, SCREEN_WIDTH - CGRectGetMaxX(headImage.frame)-10 , 20)];
    LB_detail.text = @"";
    LB_detail.numberOfLines = 0;
    LB_detail.textColor = DETAILTEXTCOLOR;
    LB_detail.font = Font14;
    [whiteView addSubview:LB_detail];
    //分界线
    LB_line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(LB_detail.frame)+10, SCREEN_WIDTH, 0.5)];
    LB_line.backgroundColor = [UIColor clearColor];
    [whiteView addSubview:LB_line];
    
 
    //有的商品尺码和颜色分类特别多 所以用UIScrollView 分类过多显示不全的时候可滑动查看
    mainscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headImage.frame)+10, SCREEN_WIDTH,10)];
    mainscrollview.contentSize = CGSizeMake(0, 200);
    mainscrollview.showsHorizontalScrollIndicator = NO;
    mainscrollview.showsVerticalScrollIndicator = NO;
    [whiteView addSubview:mainscrollview];
   
    
    
    UILabel *numLB = [[UILabel  alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(mainscrollview.frame), 100, 30)];
    numLB.font = Font15;
    numLB.text = @"购买数量";
    numLB.textColor = TITLETEXTLOWCOLOR;
    numLB.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:numLB];
    self.numLB  = numLB;
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(SCREEN_WIDTH - 40,CGRectGetMaxY(mainscrollview.frame) , 30, 30);
    [addBtn setImage:[UIImage imageNamed:@"ico_add"] forState:UIControlStateNormal];
    addBtn.tag = 101;
    [addBtn addTarget:self action:@selector(didClickChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:addBtn];
    _addCountBtn = addBtn;
    
    UITextField *numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -100,CGRectGetMinY(addBtn.frame)  , 60, 30)];
    numberTextField.delegate  =self;
    numberTextField.text = @"1";
    [whiteView addSubview:numberTextField];
    numberTextField.textAlignment = NSTextAlignmentCenter;
    //    numberTextField.userInteractionEnabled =  NO;//jp 暂时不用
    [numberTextField layerForViewWith:0 AndLineWidth:1];
    _numberTextField = numberTextField;
    
    
    UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleBtn.frame = CGRectMake(SCREEN_WIDTH -100 - 30,CGRectGetMinY(addBtn.frame) , 30, 30);
    [deleBtn setImage:[UIImage imageNamed:@"ico_minus"] forState:UIControlStateNormal];
    deleBtn.tag = 100;
    [deleBtn addTarget:self action:@selector(didClickChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:deleBtn];
    _deleBtn = deleBtn;
    
    //加入购物车按钮
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(0, whiteView.mj_h-50, whiteView.frame.size.width/2, 50);
    [self.addBtn setBackgroundColor:RGB(148, 149, 150)];
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:0];
    self.addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.addBtn setTitle:@"加入购物车" forState:0];
    self.addBtn.tag = 100;
    [whiteView addSubview: self.addBtn];
    
    //立即购买按钮
    buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(whiteView.frame.size.width/2,  whiteView.mj_h-50, whiteView.frame.size.width/2, 50);
    [buyBtn setBackgroundColor:KMAINCOLOR];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:0];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [buyBtn setTitle:@"立即购买" forState:0];
    buyBtn.tag = 101;
    
    [whiteView addSubview:buyBtn];
    
    
    //默认隐藏
    stockBtn.hidden = YES;
    
    //加入购物车按钮
    [self.addBtn addTarget:self action:@selector(addGoodsCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //立即购买
    [self.buyBtn addTarget:self action:@selector(addGoodsCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //取消按钮
    [self.cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.alphaView addGestureRecognizer:tap];
}



-(void)setItemIfoModel:(ItemInfoList *)itemIfoModel
{
    _itemIfoModel = itemIfoModel;

    mainscrollview.frame = CGRectMake(0, CGRectGetMaxY(headImage.frame)+10, SCREEN_WIDTH, _itemIfoModel.titleArr.count*80);
    
    self.numLB.frame =CGRectMake(15, CGRectGetMaxY(mainscrollview.frame), 100, 30);
    
    _addCountBtn.frame= CGRectMake(SCREEN_WIDTH - 40,CGRectGetMaxY(mainscrollview.frame) , 30, 30);

    _numberTextField.frame =  CGRectMake(SCREEN_WIDTH -100,CGRectGetMinY(_addCountBtn.frame)  , 60, 30);
    
    _deleBtn.frame = CGRectMake(SCREEN_WIDTH -100 - 30,CGRectGetMinY(_addCountBtn.frame) , 30, 30);
    
}


-(void)addGoodsCartBtnClick:(UIButton *)btn{
    if (_itemIfoModel.spec.count >0) {
        if (KX_NULLString(_itemIfoModel.itemContent.spec)) {
            [self.window makeToast:@"请选择规格属性"];
            return;
        }
      
    }
    if (self.didClickComTFpltBlock) {
        self.didClickComTFpltBlock(btn.tag - 100, _goodSCount);
    }
    [self dismiss];
}

/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss
{
    [UIView animateWithDuration: 0.35 animations: ^{
        self.frame =CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion: nil];
    
}



/// 增加 减少BTN
- (void)didClickChangeAction:(UIButton *)btn
{
    if (btn.tag == 100) {
        _goodSCount --;
        if (_goodSCount ==1 ||_goodSCount<1) {
            _goodSCount =1;
        }

        _numberTextField.text = [NSString stringWithFormat:@"%ld",(long)_goodSCount];
        
    }
    
    else if (btn.tag == 101){
        _goodSCount ++;
        _numberTextField.text = [NSString stringWithFormat:@"%ld",(long)_goodSCount];
        
                }else{
//                    if (_goodSCount > [_itemInfoList.cargoNumber integerValue]) {
//                        if ([_itemInfoList.cargoNumber integerValue] == 0) {
//                            [self makeToast:@"库存不足"];
//
//                        }else{
//                            [self makeToast:[NSString stringWithFormat:@"库存不足，最多购买‘%@’件",_itemInfoList.cargoNumber]];
//                        }
//
//                        _numberTextField.text = [NSString stringWithFormat:@"%@",_itemInfoList.cargoNumber];
//                        _itemInfoList.goodSCount = [_itemInfoList.cargoNumber integerValue];
//                    }
        
                    _numberTextField.text = [NSString stringWithFormat:@"%ld",(long)_goodSCount];
        
        
//                }
    
    
    }
    
    _numLB.text = [NSString stringWithFormat:@"数量:%@",_numberTextField.text] ;
    
    
    
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
        _goodSCount =  1;
    }else{
//                if ([_model.param5 isEqualToString:@"1"]) {
        _goodSCount =  [_numberTextField.text intValue];
        _numLB.text = [NSString stringWithFormat:@"购买数量:%@",_numberTextField.text] ;

//                }else{
//                    if ([textField.text integerValue] > [_model.cargoNumber integerValue]) {
////                        [self.window makeToast:[NSString stringWithFormat:@"库存不足，最多购买‘%@’件",_model.cargoNumber]];
////                        _numberTextField.text = [NSString stringWithFormat:@"%@",_model.cargoNumber];
////                    }
//                    _model.goodSCount =  [ _numberTextField.text integerValue];
//                }
        
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
    CGFloat offset = (_numberTextField.frame.origin.y+_numberTextField.frame.size.height+ whiteView.height) - (self.frame.size.height - kbHeight);
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



/// 出现
- (void)show
{
    
    [UIView animateWithDuration: 0.35 animations: ^{
        //        self.backgroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        self.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:self];
    } completion: nil];
    
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
