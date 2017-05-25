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

@implementation UIButton (ExteralButton)


- (NSIndexPath *)indexPath
{
    return objc_getAssociatedObject(self, @selector(indexPath));
}

/*
 
 //1 源对象UIBUtton
 //2 关键字 唯一静态变量indexPath
 //3 关联的对象 indexP
 //4 关键策略  OBJC_ASSOCIATION_RETAIN_NONATOMIC
 
 */

-  (void)setIndexPath:(NSIndexPath *)indexPath
{
    objc_setAssociatedObject(self, @selector(indexPath), indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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



- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space{
    
    /**
     * 知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     * 如果只有title，那它上下左右都是相对于button的，image也是一样；
     * 如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     
     它们只是image和button相较于原来位置的偏移量，那什么是原来的位置呢？就是没有设置edgeInset时候的位置了。
     如果要image在右边，label在左边，那image的左边相对于button的左边右移了labelWidth的距离，image的右边相对于label的左边右移了labelWidth的距离
     所以，self.oneButton.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);为什么是负值呢？因为这是contentInset，是偏移量，不是距离
     同样的，label的右边相对于button的右边左移了imageWith的距离，label的左边相对于image的右边左移了imageWith的距离
     所以self.oneButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, imageWith);
     
     */
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    
    //系统最低版本8.0
    labelWidth = self.titleLabel.intrinsicContentSize.width;
    labelHeight = self.titleLabel.intrinsicContentSize.height;
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    /**
     MKButtonEdgeInsetsStyleTop, // image在上，label在下
     MKButtonEdgeInsetsStyleLeft, // image在左，label在右
     MKButtonEdgeInsetsStyleBottom, // image在下，label在上
     MKButtonEdgeInsetsStyleRight // image在右，label在左
     */
    
    switch (style) {
        case MKButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case MKButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
    
    
    
}
@end
