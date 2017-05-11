//
//  JKLockView.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/22.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "JKLockView.h"
//const 定义 只读的变量名 在其他的类中不能声明同样的变量名

CGFloat const btnCount = 9;
CGFloat const btnW = 74;
CGFloat const btnH = 74;
CGFloat const viewY = 300;
int const colu = 3;
@implementation JKLockView


-(NSMutableArray *)selectBtns{
    if (_selectBtns==nil) {
        self.selectBtns=[NSMutableArray array];
    }
    
    return _selectBtns;
    
}

//通过代码创建的会调用这个方法

-(id)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        
        
        [self addButton];
        
    }
    
    return self;
    
}



//添加按钮
- (void)addButton{
    
    
    for (int i=0; i<btnCount; i++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled=NO;
        [btn setBackgroundImage:[UIImage imageNamed:@"StarLight"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"Star1_new_star"] forState:UIControlStateSelected];
        
        int row = i/colu;//第几行
        int column=i%colu;//第几列
        
        btn.tag=i+1;
        
        //x轴
        
        CGFloat margin=(self.frame.size.width-colu*btnW)/(colu+1);
        
        CGFloat btnX=margin + column*(btnW + margin);
        CGFloat btnY=row*(btnH+margin);
        
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        
        
        [self addSubview:btn];
        
    }
}

#pragma mark  -返回触摸的点
- (CGPoint)pointWithTouch:(NSSet *)touches{
    
    UITouch *touch=[touches anyObject];
    
    CGPoint points=[touch locationInView:self];
    
    
    return points;
    
}

#pragma mark  -判断触摸的点是否在按钮内
-(UIButton *)buttonWithPoint:(CGPoint )point{
    
    for (UIButton *btn in self.subviews ) {
        
        
        if (CGRectContainsPoint(btn.frame, point)) {
            
            return btn;
            
        }
    }
    
    return nil;
    
}

#pragma mark - 触摸
#pragma mark -开始触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    
    CGPoint points=[self pointWithTouch:touches];
    
    UIButton *btn=[self buttonWithPoint:points];
    
    if ( btn && btn.selected==NO) {
        
        btn.selected=YES;
        
        [self.selectBtns addObject:btn];
    }
}


#pragma mark -触摸移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    CGPoint points=[self pointWithTouch:touches];
    
    UIButton *btn=[self buttonWithPoint:points];
    
    
    if (btn && btn.selected==NO) {
        
        btn.selected=YES;
        
        [self.selectBtns addObject:btn];
        
    }else{
        
        currentPoint=points;
        
    }
    
    [self setNeedsDisplay];
    
}

#pragma mark -触摸结束
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    if ([self.delegate respondsToSelector:@selector(lockView:didFinish:)]) {
        
        NSMutableString *path=[NSMutableString string];
        
        for (UIButton *btn in self.selectBtns) {
            
            [path appendFormat:@"%d",(int)btn.tag];
            
        }
        
        [self.delegate lockView:self didFinish:path];
        
    }
    
    //重新排序
    for (UIButton *button in self.subviews) {
        button.selected = NO;
    }
    
    
    [self.selectBtns removeAllObjects];
    
    
    [self setNeedsDisplay];
    
}

#pragma mark -取消触摸
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self touchesEnded:touches withEvent:event];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

#pragma mark - 划线
- (void)drawRect:(CGRect)rect {
    
    if (self.selectBtns.count==0) {
        return   ;
        
    }
    
    
    NSLog(@"%@",[self.selectBtns objectAtIndex:0]);
    
    UIBezierPath  *path=[UIBezierPath bezierPath];
    path.lineWidth=8;
    path.lineJoinStyle=kCGLineJoinRound;
    
    [[UIColor blueColor] set];
    
    for (int i=0; i<self.selectBtns.count; i++) {
        
        UIButton *button=self.selectBtns[i];
        if (i==0) {//设置起点
            [path moveToPoint:button.center];
            
        }else{//连线
            [path addLineToPoint:button.center];
            
        }
    }
    
    [path  addLineToPoint:currentPoint];
    
    
    [path stroke];
    
    // Drawing code
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
