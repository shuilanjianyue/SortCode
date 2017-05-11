//
//  TapButtonView.m
//  DZQCCompany
//
//  Created by dazaoqiancheng on 17/3/18.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "TapButtonView.h"

@implementation TapButtonView


//alloc时会执行这些代码
-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 35)];
        self.scrollView.showsHorizontalScrollIndicator=NO;
        self.scrollView.showsVerticalScrollIndicator=NO;
        [self addSubview:self.scrollView];
        
        
//        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 34.5, SCREEN_WIDTH, 0.5)];
//        lineView.backgroundColor = GRB6;
//        [self.scrollView addSubview:lineView];
        
        
    }
    
    return self;
    
}



//添加按钮
- (void)addButton1:(NSArray *)array index:(NSInteger)index{
    
    
    for (int i=0; i<array.count; i++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.frame=CGRectMake(70*i, 0, 70, 35);
        [btn addTarget:self action:@selector(buttonSelected1:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:btn];
        
        btn.tag=i+1;
        
        
        if (btn.tag==index) {
            
            [self buttonSelected1:btn];
            
        }
        
    }
    
    if (array.count *70<SCREEN_WIDTH) {
        self.scrollView.contentSize=CGSizeMake(70*array.count, 35);
    }else{
        self.scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 35);
    }
    
    
    
}





//添加按钮
- (void)addButton:(NSArray *)array index:(NSInteger)index{
    
    CGRect frame  = self.scrollView.frame;
    frame.size.height = 50;
    self.scrollView.frame = frame;
    
    
    for (int i=0; i<array.count; i++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.frame=CGRectMake(SCREEN_WIDTH/array.count*i, 0, SCREEN_WIDTH/array.count, 50);
        [btn addTarget:self action:@selector(buttonSelected1:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:btn];
        
        btn.tag=i+1;
        
        
        if (btn.tag==index) {
            
            [self buttonSelected1:btn];
            
        }
        
    }
    
    self.scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 50);
}










- (void)buttonSelected1:(UIButton *)btn{
    
    
    if ([self.delegate respondsToSelector:@selector(tapView:tapIndex:)]) {
        
        [self.delegate tapView:self tapIndex:btn.tag];
        
    }
    
    _selectButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _selectButton.selected=NO;
    
    btn.selected=YES;
    _selectButton=btn;
    
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
