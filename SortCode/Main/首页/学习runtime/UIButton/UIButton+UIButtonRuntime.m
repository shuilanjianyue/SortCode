//
//  UIButton+UIButtonRuntime.m
//  SortCode
//
//  Created by dazaoqiancheng on 2017/5/12.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "UIButton+UIButtonRuntime.h"
#import <objc/runtime.h>

@implementation UIButton (UIButtonRuntime)

/*
 *
 *判断是否使用系统字体 100不使用
 *
 */

- (NSInteger)autoButtonTag{
    return [objc_getAssociatedObject(self, _cmd) intValue];
}


- (void)setAutoButtonTag:(NSInteger)autoButtonTag{
    
    objc_setAssociatedObject(self, @selector(autoButtonTag), @(autoButtonTag), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


+ (void)load {
    //方法交换应该被保证，在程序中只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获得viewController的生命周期方法的selector
        SEL systemSel = @selector(willMoveToSuperview:);
        //自己实现的将要被交换的方法的selector
        SEL swizzSel = @selector(buttonWillMoveToSuperview:);
        //两个方法的Method
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        } else {
            //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
        
    });
}



- (void)buttonWillMoveToSuperview:(UIView *)newSuperview {
    
    [self buttonWillMoveToSuperview:newSuperview];
    
    
    if (self) {
        
        if (self.autoButtonTag == 100) {
            
            self.titleLabel.font = [UIFont systemFontOfSize:self.titleLabel.font.pointSize];
            
            
        } else {
            
            if ([UIFont fontNamesForFamilyName:@"FZLBJW--GB1-0"])
                self.titleLabel.font  = [UIFont fontWithName:@"FZLBJW--GB1-0" size:self.titleLabel.font.pointSize];
        }
    }
}
@end
