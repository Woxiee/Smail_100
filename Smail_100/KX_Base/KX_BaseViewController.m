//
//  KX_BaseViewController.m
//  KX_Service
//
//  Created by mac on 16/8/1.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "KX_BaseViewController.h"
#define NUMBERS @"0123456789\n"


@interface KX_BaseViewController ()<UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation KX_BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    KX_BaseViewController *viewController = [super allocWithZone:zone];

    return viewController;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    LOG(@"🍍🍍🍍界面新建= %@🍍🍍🍍",[super class]);
}


-(void)dealloc{
     LOG(@"💣💣💣💣界面销毁= %@ 💣💣💣💣💣",[super class]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
   
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 0)
//     
//                                                         forBarMetrics:UIBarMetricsDefault];
//    
//    
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    //布局统一 从导航拦 下算0坐标
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
//
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//
//    //设置导航栏字体颜色
//    UIColor * color = [UIColor whiteColor];
//    NSDictionary * dict= [NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName,nil];
//    self.navigationController.navigationBar.titleTextAttributes = dict;
//    self.navigationController.navigationBar.tintColor = color;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg.jpg"] forBarMetrics:UIBarMetricsDefault];
//    
//    [self setLeftNaviBtnTitle:@""];
    
}
/**
 *  设置导航条颜色变成蓝色
 */

-(void)setNavigationBarColor{
    
    self.navigationController.navigationBar.backgroundColor = RGB(70, 107, 177);
    self.navigationController.navigationBar.barTintColor =RGB(70, 107, 177);
}

/**
 *  添加白色导航条
 */
- (void)addNavigationBarWhiteStyle
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
}

/**
 *  添加红色导航条
 */
- (void)addNavigationBarRedStyle
{
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
}

- (void)setNavigationTitleImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    self.navigationItem.titleView = imageView;
}

-(void)setRightNaviBtnImage:(UIImage *)img
{
    self.rightNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightNaviBtn setImage:img forState:UIControlStateNormal];
    self.rightNaviBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.rightNaviBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.rightNaviBtn.backgroundColor=[UIColor clearColor];
    [self.rightNaviBtn addTarget:self action:@selector(didClickRightNaviBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:self.rightNaviBtn];
    self.navigationItem.rightBarButtonItem=rightButton;
    [self.rightNaviBtn sizeToFit];

}


-(void)setRightNaviBtnTitle:(NSString*)str withTitleColor:(UIColor *)titleColor
{
    self.rightNaviBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.rightNaviBtn setTitle:str forState:UIControlStateNormal];
    [self.rightNaviBtn setTitleColor:titleColor forState:UIControlStateNormal];
    self.rightNaviBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    [self.rightNaviBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.rightNaviBtn.backgroundColor=[UIColor clearColor];
    [self.rightNaviBtn addTarget:self action:@selector(didClickRightNaviBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:self.rightNaviBtn];
    self.navigationItem.rightBarButtonItem=rightButton;
    [self.rightNaviBtn sizeToFit];

}


-(void)setLeftNaviBtnImage:(UIImage*)img
{
    self.leftNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[self.rightNaviBtn setBackgroundImage:img forState:UIControlStateNormal];
    [self.leftNaviBtn setImage:img forState:UIControlStateNormal];
    //    [self.rightNaviBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.leftNaviBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.leftNaviBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.leftNaviBtn.backgroundColor=[UIColor clearColor];
    [self.leftNaviBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:self.leftNaviBtn];
    self.navigationItem.leftBarButtonItem=rightButton;
    [self.leftNaviBtn sizeToFit];

}


-(void)setLeftNaviBtnTitle:(NSString*)str{
    self.leftNaviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftNaviBtn setImage:[UIImage imageNamed:@"18@3x.png"] forState:UIControlStateNormal];
    [self.leftNaviBtn setImage:[UIImage imageNamed:@"18@3x.png"] forState:UIControlStateHighlighted];
    [self.leftNaviBtn setTitle:str forState:UIControlStateNormal];
    self.leftNaviBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    [self.leftNaviBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    self.leftNaviBtn.backgroundColor=[UIColor clearColor];
    [self.leftNaviBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:self.leftNaviBtn];
    
    self.navigationItem.leftBarButtonItem = rightButton;
    [self.leftNaviBtn sizeToFit];
}



//系统返回
- (void)setbackBarAction
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"返回"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:nil];
    
}

/// 返回上一级
- (void)popVC
{
    [self.navigationController  popViewControllerAnimated:YES];
}


/// 右侧点击事件
- (void)didClickRightNaviBtn
{
    
}

 

#pragma mark- 屏幕旋转设置
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

#pragma mark- 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void) registerCollectionViewCellWithNibName:(NSString *) nibName forCellWithReuseIdentifier:(NSString *) identifier forCollectionView:(UICollectionView *) collectionView{
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
}
- (void) registerCollectionViewCellWithNibName:(NSString *) nibName forCellWithReuseIdentifier:(NSString *) identifier forTableView:(UITableView *) TableView{
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    [TableView registerNib:nib forCellReuseIdentifier:identifier];
}

- (void) registerSectionHeaderFooterViewWithNibName:(NSString *) nibName forSupplementaryViewOfKind:(NSString *) kind withReuseIdentifier:(NSString *) identifier forCollectionView:(UICollectionView *) collectionView{
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    [collectionView registerNib:nib forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
}


#pragma mark 封装系统对话框
- (void) systemAlertWithTitle:(NSString *)title andMsg:(NSString *)msg cancel:(NSString *)cancel sure:(NSString *)sure withOkBlock:(UIAlertViewBlock)block
{
    self.alertViewblock = block;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancel otherButtonTitles:sure, nil];
    [alert show];
}

- (void) systemAlertWithTitle:(NSString *)title andMsg:(NSString *)msg withOkBlock:(UIAlertViewBlock)block
{
    self.alertViewblock = block;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void) systemAlertWithTitle:(NSString *)title andMsg:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void) systemAlertTitle:(NSString *)title andMsg:(NSString *)msg withOkBlock:(UIAlertViewBlock)block
{
    self.alertViewblock = block;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL ok = NO;
    if (buttonIndex == 1) {
        ok = YES;
    }
    if (self.alertViewblock) {
        self.alertViewblock(ok);
    }
}
- (void) sheetWithTitle:(NSString *)title  andBlock:(UIActionSheetViewBlock)block andArray:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start(args, otherButtonTitles);
    NSMutableArray *allStr = [NSMutableArray array];
    for (NSString *str = otherButtonTitles; str != nil; str = va_arg(args,NSString*)) {
        [allStr addObject:str];
    }
    va_end(args);
    
    if(allStr.count > 0){
        self.sheetBlock = block;
        
        UIActionSheet *sheet;
        
        switch (allStr.count) {
            case 1:
                sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:allStr[0],nil];
                break;
            case 2:
                sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:allStr[0],allStr[1],nil];
                break;
            case 3:
                sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:allStr[0],allStr[1],allStr[2],nil];
                break;
            case 4:
                sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:allStr[0],allStr[1],allStr[2],allStr[3],nil];
                break;
            case 5:
                sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:allStr[0],allStr[1],allStr[2],allStr[3],allStr[4],nil];
                break;
            case 6:
                sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:allStr[0],allStr[1],allStr[2],allStr[3],allStr[4],allStr[5], nil];
                break;
            default:
                break;
        }
        
        [sheet showInView:self.view];
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.sheetBlock) {
        self.sheetBlock (buttonIndex);
    }
}



#pragma mark - 系统自带的图片选择器和裁剪 UIImage Picker

//从相册中选择图片
- (void)selectImageByPhotoWithBlock:(ImagePickerBlock)block
{
    self.imagePickerBlock = block;
    
    //要选择图片，需要选择使用UIImagePickerController
    UIImagePickerController *imageController = [[UIImagePickerController alloc]init];
    //设置delegate
    [imageController setDelegate:self];
    
    //是否可以编辑
    [imageController setAllowsEditing:YES];
    
    //设置图片的来源为图片
    [imageController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    [self presentViewController:imageController animated:YES completion:^{
        
    }];
}

//从拍照中选择图片
- (void)selectImageByCameraWithBlock:(ImagePickerBlock)block
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        self.imagePickerBlock = block;
        
        //要选择图片，需要选择使用UIImagePickerController
        UIImagePickerController *imageController = [[UIImagePickerController alloc]init];
        //设置delegate
        imageController.delegate = self;
        //是否可以编辑
        [imageController setAllowsEditing:YES];
        
        //设置照相的来源为图片
        [imageController setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        [self presentViewController:imageController animated:YES completion:^{
            
        }];
    }
    else
    {
//        [self systemAlertWithTitle:@"摄像头不可用" andMsg:nil];
        SuccessView *successV  = [[SuccessView alloc]initWithTrueCancleTitle:@"摄像头不可用~" clickDex:^(NSInteger clickDex) {
        }];
        [successV showSuccess];
  
    }
}


//得到编辑后的图片的回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        //选择编辑好的图片
        UIImage *image = info[@"UIImagePickerControllerEditedImage"];
        
        if (self.imagePickerBlock) {
            self.imagePickerBlock (image);
        }
    }];
}
#pragma mark - RAC
/**
 *  添加控件
 */
- (void)kx_addSubviews {}

/**
 *  绑定
 */
- (void)kx_bindViewModel {}

/**
 *  设置navation
 */
- (void)kx_layoutNavigation {}

/**
 *  初次获取数据
 */
- (void)kx_getNewData {}



- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (self.isViewLoaded && !self.view.window)
    {
        self.view = nil;
    }
}



/**
 * 懒加载数据源
 */
- (NSMutableArray *)resorceArray
{
    if (_resorceArray == nil) {
        _resorceArray = [[NSMutableArray alloc] init];
    }
    return _resorceArray;
}


@end
