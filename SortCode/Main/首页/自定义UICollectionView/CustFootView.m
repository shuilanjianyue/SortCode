//
//  CustFootView.m
//  整理文
//
//  Created by dazaoqiancheng on 16/10/13.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "CustFootView.h"

@implementation CustFootView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor magentaColor];
        
        
        UIView *vgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,55)];
        vgView.backgroundColor=[UIColor orangeColor];
        [self addSubview:vgView];
        
        // Initialization code
    }
    
    return self;
}

@end
