//
//  CustPlaceholderField.m
//  整理文
//
//  Created by dazaoqiancheng on 16/11/25.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "CustPlaceholderField.h"

@implementation CustPlaceholderField
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.tintColor = [UIColor magentaColor];  //设置光标颜色
        
    }
    return self;
}



- (void)drawPlaceholderInRect:(CGRect)rect
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blueColor];
    attrs[NSFontAttributeName] = self.font;
    
    //画出占位符
    CGRect placeholderRect;
    placeholderRect.size.width = rect.size.width;
    placeholderRect.size.height = rect.size.height;
    placeholderRect.origin.x = 0;
    placeholderRect.origin.y = (rect.size.height - self.font.lineHeight) * 0.5;
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
