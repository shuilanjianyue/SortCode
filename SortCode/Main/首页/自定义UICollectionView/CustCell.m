//
//  CustCell.m
//  整理文
//
//  Created by dazaoqiancheng on 16/10/13.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "CustCell.h"

@implementation CustCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *vgView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 55,55 )];
        vgView.backgroundColor=[UIColor greenColor];
        vgView.layer.masksToBounds=YES;
        vgView.layer.borderWidth=0.5;
        [self.contentView addSubview:vgView];
        
        // Initialization code
    }
    return self;
}

@end
