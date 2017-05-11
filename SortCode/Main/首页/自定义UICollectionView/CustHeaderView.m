//
//  CustHeaderView.m
//  整理文
//
//  Created by dazaoqiancheng on 16/10/13.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "CustHeaderView.h"

@implementation CustHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor magentaColor];
        
        
        UIView *vgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,55)];
        vgView.backgroundColor=[UIColor blueColor];
        [self addSubview:vgView];
        
        // Initialization code
    }
    return self;
}
@end
