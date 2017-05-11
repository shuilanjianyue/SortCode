//
//  NSArray+Boundary.m
//  整理文
//
//  Created by dazaoqiancheng on 2017/5/2.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "NSArray+Boundary.h"

@implementation NSArray (Boundary)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        SEL safeSel = @selector(safeObjectAtIndex:);
        SEL unsafeSel = @selector(objectAtIndex:);
        Class myClass = NSClassFromString(@"__NSArrayI");
        Method safeMethod = class_getInstanceMethod(myClass, safeSel);
        Method unsafeMethod = class_getInstanceMethod(myClass, unsafeSel);
        method_exchangeImplementations(unsafeMethod, safeMethod);
    });
}


- (id)safeObjectAtIndex:(NSUInteger)index{
    if (self.count-1 < index) {
        // 这里做一下异常处理，不然都不知道出错了。
        @try {
            return [self safeObjectAtIndex:index];
        }
        @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息，方便我们调试。
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
    } else {
        return [self safeObjectAtIndex:index];
    }
}
@end
