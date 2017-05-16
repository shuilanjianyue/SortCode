//
//  UILabel+UILabelRuntime.h
//  SortCode
//
//  Created by dazaoqiancheng on 2017/5/11.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (UILabelRuntime)
/*
 *
 *UILabel自定义适配的宽度
 *
 */
@property(nonatomic,assign)CGFloat autoWidth;


/*
 *
 *返回UILabel自定义适配的宽度和高度
 *
 */
-(CGSize)autoLabel;



/**************UILabel自定义几种字体************************/

/*
 *
 *判断是否使用系统字体 100不使用 其他使用
 *
 */

@property(nonatomic,assign)NSInteger autoLabelTag;



@end
