  //
//  MenuCell.m
//  整理文
//
//  Created by dazaoqiancheng on 16/10/17.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addGestureRecognizer: [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)]];
    
    // Initialization code
}


-(void)longTap:(UILongPressGestureRecognizer *)longRecognizer
{
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        
        [self becomeFirstResponder];
        
        UIMenuController *menu=[UIMenuController sharedMenuController];
        
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyItemClicked:)];
        
        UIMenuItem *resendItem = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(resendItemClicked:)];
        
        [menu setMenuItems:[NSArray arrayWithObjects:copyItem,resendItem,nil]];
        
        [menu setTargetRect:self.bounds inView:self];
        
        [menu setMenuVisible:YES animated:YES];
        
    }
    
}



#pragma mark 处理action事件

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    if(action ==@selector(copyItemClicked:)){
        
        return YES;
        
    }else if (action==@selector(resendItemClicked:)){
        
        return YES;
        
    }
    
    return [super canPerformAction:action withSender:sender];
    
}



#pragma mark 实现成为第一响应者方法

-(BOOL)canBecomeFirstResponder{
    
    return YES;
    
}


#pragma mark method

-(void)resendItemClicked:(id)sender{
    
    NSLog(@"转发");
    
    //通知代理
    
}

-(void)copyItemClicked:(id)sender{
    
    NSLog(@"复制");
    
    // 通知代理
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
