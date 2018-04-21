//
//  StoreMangerVC.m
//  Smail_100
//
//  Created by Faker on 2018/3/20.
//  Copyright © 2018年 Smail_100. All rights reserved.
//

#import "StoreMangerVC.h"

@interface StoreMangerVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UIView *storeView;
@property (weak, nonatomic) IBOutlet UITextField *storeTF;
@property (weak, nonatomic) IBOutlet UITextField *storeInfoTF;
@property (weak, nonatomic) IBOutlet UITextField *telTF;
@property (weak, nonatomic) IBOutlet UITextField *tiemTF;

@property (weak, nonatomic) IBOutlet UITextView *businessTX;
@property (weak, nonatomic) IBOutlet UIView *storeAddressView;

@property (weak, nonatomic) IBOutlet UITextField *storeAddressTF;
@property (weak, nonatomic) IBOutlet UITextField *industryTF;
@property (weak, nonatomic) IBOutlet UITextField *benefitT;
@property (weak, nonatomic) IBOutlet UITextField *jfblTF;
@property (weak, nonatomic) IBOutlet UITextField *recommendedTF;

@end

@implementation StoreMangerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


-(void)viewDidLayoutSubviews{
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 900);
}

- (IBAction)didSureAciton:(id)sender {
}


@end
