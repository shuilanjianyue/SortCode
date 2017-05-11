//
//  ProgressView.h
//  总结
//
//  Created by dazaoqiancheng on 16/8/16.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

//中心颜色
 
@property (strong, nonatomic)UIColor *centerColor;

//圆环背景色
@property (strong, nonatomic)UIColor *arcBackColor;

//圆环色进度加载完成的颜色
@property (strong, nonatomic)UIColor *arcFinishColor;

//圆环色进度没有加载完成的颜色
@property (strong, nonatomic)UIColor *arcUnfinishColor;



//百分比数值（0-1）
@property (assign, nonatomic)float percent;


//圆环宽度
@property (assign, nonatomic)float width;


@end
