//
//  UILabel+UILabelRuntime.m
//  SortCode
//
//  Created by dazaoqiancheng on 2017/5/11.
//  Copyright © 2017年 DZQC. All rights reserved.
//
#import "UILabel+UILabelRuntime.h"
#import <objc/runtime.h>
#import "UpdateManger.h"

@implementation UILabel (UILabelRuntime)

/**************UILabel自定义适配************************/
/*
 *
 *UILabel自定义适配的宽度
 *
 */
- (CGFloat)autoWidth{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}


- (void)setAutoWidth:(CGFloat)autoWidth{
    
    objc_setAssociatedObject(self, @selector(autoWidth), @(autoWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

/*
 *
 *判断是否使用系统字体 100不使用
 *
 */

- (NSInteger)autoLabelTag{
    return [objc_getAssociatedObject(self, _cmd) intValue];
}


- (void)setAutoLabelTag:(NSInteger)autoLabelTag{
    
    objc_setAssociatedObject(self, @selector(autoLabelTag), @(autoLabelTag), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


/*
 *
 *返回UILabel自定义适配的宽度和高度
 *
 */
-(CGSize)autoLabel{
    
    
    
    if (self.autoLabelTag == 100) {
        
        self.font = [UIFont systemFontOfSize:self.font.pointSize];
        
        
    } else {
        
        if ([UIFont fontNamesForFamilyName:@"FZLBJW--GB1-0"])
            self.font  = [UIFont fontWithName:@"FZLBJW--GB1-0" size:self.font.pointSize];
    }
    
    self.numberOfLines = 0;
    
    NSDictionary *attrs = @{NSFontAttributeName : self.font};
    
    return  [self.text boundingRectWithSize:CGSizeMake(self.autoWidth, 6000000000) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}



/**************UILabel自定义几种字体************************/
+ (void)load {
    //方法交换应该被保证，在程序中只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获得viewController的生命周期方法的selector
        SEL systemSel = @selector(willMoveToSuperview:);
        //自己实现的将要被交换的方法的selector
        SEL swizzSel = @selector(myWillMoveToSuperview:);
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



- (void)myWillMoveToSuperview:(UIView *)newSuperview {
    
    [self myWillMoveToSuperview:newSuperview];
    
    if ([self isKindOfClass:NSClassFromString(@"UIButtonLabel")]) {
        
        return;
    }
    
    
    if (self) {
        
        if (self.autoLabelTag == 100) {
            
            self.font = [UIFont systemFontOfSize:self.font.pointSize];
            
            
        } else {
            
            if ([UIFont fontNamesForFamilyName:@"FZLBJW--GB1-0"])
                self.font  = [UIFont fontWithName:@"FZLBJW--GB1-0" size:self.font.pointSize];
        }
    }
}


@end
