//
//  UIButton+ExteralButton.m
//  100PiFa
//
//  Created by 锤子科技 on 15/11/13.
//  Copyright © 2015年 孙翠花. All rights reserved.
//

/*
 1.category使用 objc_setAssociatedObject/objc_getAssociatedObject 实现添加属性
 2.属性 其实就是get/set 方法。我们可以使用  objc_setAssociatedObject/objc_getAssociatedObject  实现 动态向类中添加 方法
 */

#import "UIButton+ExteralButton.h"
#import <objc/runtime.h>

static const void *indexPath = &indexPath;

@implementation UIButton (ExteralButton)

@dynamic indexP;

- (NSIndexPath *)indexP
{
    return objc_getAssociatedObject(self, indexPath);
}

/*
 
 //1 源对象UIBUtton
 //2 关键字 唯一静态变量indexPath
 //3 关联的对象 indexP
 //4 关键策略  OBJC_ASSOCIATION_RETAIN_NONATOMIC
 
 */
-  (void)setIndexP:(NSIndexPath *)indexP
{
    objc_setAssociatedObject(self, indexPath, indexP, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/*
 
 另外，objc_removeAssociatedObjects可以删除指定对象实例的所有扩展属性。//不建议使用,删除的时候会删除所有
 
 */



+ (UIButton *)buttonWithRoundBoderForTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [button setBackgroundColor:UIColorFromRGB(0xef4b87)];
    button.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 8;
    return button;
}


+ (UIButton *)buttonWithNormalImage:(UIImage *)normalImage HeightImage:(UIImage *)heightImage title:(NSString *)title target:(id)target action:(SEL)action frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setBackgroundColor:UIColorFromRGB(0x4f4b87)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [button setBackgroundImage:heightImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


+ (UIButton *)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action frame:(CGRect)frame titleColor:(UIColor *)titleColor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [button setFrame:frame];
    [button setBackgroundColor:UIColorFromRGB(0x4f4b87)];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
