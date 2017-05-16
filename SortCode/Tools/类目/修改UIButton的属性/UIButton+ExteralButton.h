//
//  UIButton+ExteralButton.h
//  100PiFa
//
//  Created by 锤子科技 on 15/11/13.
//  Copyright © 2015年 孙翠花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ExteralButton)

//添加UIButton属性
@property (nonatomic,strong)NSIndexPath *indexPath;


//圆角的button，边框线
+ (UIButton *)buttonWithRoundBoderForTitle:(NSString *)title target:(id)target action:(SEL)action;

//普通和高亮
+ (UIButton *)buttonWithNormalImage:(UIImage *)normalImage HeightImage:(UIImage *)heightImage title:(NSString *)title target:(id)target action:(SEL)action frame:(CGRect)frame;



//一个普通的button，给定一个标题，并添加事件
+ (UIButton *)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action frame:(CGRect)frame titleColor:(UIColor *)titleColor;



@end
