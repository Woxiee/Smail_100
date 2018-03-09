//
//  InvoiceEditorCell.m
//  MyCityProject
//
//  Created by Faker on 17/5/24.
//  Copyright © 2017年 Faker. All rights reserved.
//

#import "InvoiceEditorCell.h"

@implementation InvoiceEditorCell
{

    __weak IBOutlet UIView *lineView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    lineView.backgroundColor = LINECOLOR;
}


@end
