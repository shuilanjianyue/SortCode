//
//  NSTimer+addition.h
//  整理文
//
//  Created by dazaoqiancheng on 16/11/17.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (addition)
- (void)pause;
- (void)resume;
-(void)startTime;
- (void)resumeWithTimeInterval:(NSTimeInterval)time;

@end
