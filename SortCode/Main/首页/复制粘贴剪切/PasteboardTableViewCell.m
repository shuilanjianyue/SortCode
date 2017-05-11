//
//  PasteboardTableViewCell.m
//  整理文
//
//  Created by dazaoqiancheng on 17/1/6.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "PasteboardTableViewCell.h"

@implementation PasteboardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.images = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 10, 40, 40)];
    self.images.userInteractionEnabled = YES;
    self.images.image =[UIImage imageNamed:@"btn_card@2x"];
    [self.contentView addSubview:self.images];
    
    
    self.zhantieImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80 - 60, 10, 40, 40)];
    self.zhantieImage.userInteractionEnabled = YES;
    [self.contentView addSubview:self.zhantieImage];
    
    
     [self addGestureRecognizer: [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)]];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)longTap:(UILongPressGestureRecognizer *)longRecognizer

{
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        
        [self becomeFirstResponder];
        
        UIMenuController *menu=[UIMenuController sharedMenuController];
        
        
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyItemClicked:)];
        
        UIMenuItem *resendItem = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(resendItemClicked:)];
        
        
        UIMenuItem *zhantie = [[UIMenuItem alloc] initWithTitle:@"粘贴" action:@selector(zhantieAction:)];
        
        
        [menu setMenuItems:[NSArray arrayWithObjects:copyItem,resendItem,zhantie,nil]];
        
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
        
    }else if (action == @selector(zhantieAction:)){
        
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
    
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    //pasteboard.string = @"wwwww";
    NSLog(@"%@",pasteboard.string);
    
    
    pasteboard.image = [UIImage imageNamed:@"btn_card@2x"];
    
    
    NSLog(@"%@",pasteboard.images);
    
    
    
    
    // 通知代理
    
}


- (void)zhantieAction:(id)sender{
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    self.zhantieImage.image = pasteboard.image;
    
    
}



@end
