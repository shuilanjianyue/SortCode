//
//  NavigationView.m
//  DZQCStudent
//
//  Created by dazaoqiancheng on 16/4/22.
//  Copyright © 2016年 DZQC. All rights reserved.
//
/*********************左右按钮和中间的标题************************/

#import "NavigationView.h"
#define  KBARGIN  8
#define NAV_HEIGHT 31

#define  NAV_BUTTON_WIDTH  27  //导航区域button的宽度
#define  NAV_BUTTON_HEIGHT  27
@implementation NavigationView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        self.userInteractionEnabled = YES;
        
        self.imageLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        self.imageLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self.imageLeft setFrame:CGRectMake(KBARGIN, NAV_HEIGHT, NAV_BUTTON_WIDTH, NAV_BUTTON_HEIGHT)];
        
        self.imageRight = [UIButton buttonWithType:UIButtonTypeCustom];
        self.imageRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.imageRight setFrame:CGRectMake(SCREEN_WIDTH-NAV_BUTTON_WIDTH - KBARGIN, NAV_HEIGHT, NAV_BUTTON_WIDTH, NAV_BUTTON_HEIGHT)];

        
        self.titleRight = [UIButton buttonWithType:UIButtonTypeCustom];
        self.titleRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.titleRight.titleLabel.font =[UIFont systemFontOfSize:14];
        [self.titleRight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.titleRight setFrame:CGRectMake(SCREEN_WIDTH-60-10, NAV_HEIGHT, 60, NAV_BUTTON_HEIGHT)];
        self.titleRight.hidden=YES;//很主要 如果不隐藏right将无法点击
        
        
        self.titleLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        self.titleLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.titleLeft.titleLabel.font =[UIFont systemFontOfSize:15];
        [self.titleLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.titleLeft setFrame:CGRectMake(10, NAV_HEIGHT, 60, NAV_BUTTON_HEIGHT)];
        self.titleLeft.hidden=YES;//很主要 如果不隐藏left将无法点击
        
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.imageLeft.right+8, self.imageLeft.top, SCREEN_WIDTH-43*2, 27)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel setTextColor:[UIColor blackColor]];
        
        [self addSubview:self.imageLeft];
        [self addSubview:self.imageRight];
        [self addSubview:self.titleLeft];
        [self addSubview:self.titleRight];
        [self addSubview:self.titleLabel];
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
