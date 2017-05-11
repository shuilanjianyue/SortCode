//
//  ProcessBanView.m
//  整理文
//
//  Created by dazaoqiancheng on 2017/5/10.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "ProcessBanView.h"

@implementation ProcessBanView


- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor =[UIColor clearColor];
        
        
        _percent = 0;
        
        _width = 0;
        
    }
    
    return self;
    
}


- (void)setPercent:(float)percent{
    
    _percent = percent;
    
    [self setNeedsDisplay];
    
}



- (void)drawRect:(CGRect)rect{
    
    [self addArcBackColor];
    
    [self drawArc];
    
    [self addCenterBack];
    
    [self addCenterLabel];
    
}


- (void)addArcBackColor{
    
    CGColorRef color = (_arcBackColor == nil) ? [UIColor lightGrayColor].CGColor : _arcBackColor.CGColor;
    
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGSize viewSize = self.bounds.size;
    
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    
    // Draw the slices.
    
    CGFloat radius = viewSize.width / 2;
    
    CGContextBeginPath(contextRef);
    
    CGContextMoveToPoint(contextRef, center.x, center.y);
    
    CGContextAddArc(contextRef, center.x, center.y, radius, 0.75*M_PI, 0.25*M_PI, 0);
    
    CGContextSetFillColorWithColor(contextRef, color);
    
    CGContextFillPath(contextRef);
    
}


- (void)drawArc{
    
    if (_percent == 0 || _percent > 1) {
        
        return;
        
    }
    
    
      CGColorRef color = (_arcUnfinishColor == nil) ? [UIColor blueColor].CGColor : _arcUnfinishColor.CGColor;
    
    
   
    
        
      float endAngle =0.75*M_PI +(2-0.5)*M_PI *_percent;
    
       
        
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        
        CGSize viewSize = self.bounds.size;
        
        CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
        
        // Draw the slices.
        
        CGFloat radius = viewSize.width / 2;
        
        CGContextBeginPath(contextRef);
        
        CGContextMoveToPoint(contextRef, center.x, center.y);
        
        CGContextAddArc(contextRef, center.x, center.y, radius, 0.75*M_PI,endAngle, 0);
        
        CGContextSetFillColorWithColor(contextRef, color);
        
        CGContextFillPath(contextRef);
    
    
}


-(void)addCenterBack{
    
    float width = (_width == 0) ? 5 : _width;
    
    CGColorRef color = (_centerColor == nil) ? [UIColor whiteColor].CGColor : _centerColor.CGColor;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGSize viewSize = self.bounds.size;
    
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    
    // Draw the slices.
    
    CGFloat radius = viewSize.width / 2 - width;
    
    CGContextBeginPath(contextRef);
    
    CGContextMoveToPoint(contextRef, center.x, center.y);
    
    CGContextAddArc(contextRef, center.x, center.y, radius, 0,2*M_PI, 0);
    
    CGContextSetFillColorWithColor(contextRef, color);
    
    CGContextFillPath(contextRef);
    
}


- (void)addCenterLabel{
    
    NSString *percent = @"";
    
    
    float fontSize = 14;
    
    UIColor *arcColor = [UIColor blueColor];
    
    
    if (_percent == 1) {
        
        fontSize = 14;
        percent = @"100%";
        
        
    }else if(_percent < 1 && _percent >= 0){
        
        fontSize = 13;
        
       
        
        percent = [NSString stringWithFormat:@"%0.2f%%",_percent*100];
        
    }
    
    arcColor = (_arcUnfinishColor == nil) ? [UIColor blueColor] : _arcUnfinishColor;
    
    CGSize viewSize = self.bounds.size;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:fontSize],NSFontAttributeName ,arcColor,NSForegroundColorAttributeName,[UIColor clearColor],NSBackgroundColorAttributeName,paragraph,NSParagraphStyleAttributeName,nil];
    
    
    [percent drawInRect:CGRectMake(5, (viewSize.height-fontSize)/2, viewSize.width-10, fontSize) withAttributes:attributes];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
