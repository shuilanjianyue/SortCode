//
//  NSTimer+addition.m
//  整理文
//
//  Created by dazaoqiancheng on 16/11/17.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "NSTimer+addition.h"

@implementation NSTimer (addition)

- (void)pause {
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];//暂停
}

- (void)resume {
    if (!self.isValid) return;
    [self setFireDate:[NSDate date]];//继续
}

-(void)startTime{
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantPast]];//开启
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time {
    if (!self.isValid){
        
        return;
    }
    
    
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}
@end
