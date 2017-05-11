//
//  ProcessBanView.h
//  整理文
//
//  Created by dazaoqiancheng on 2017/5/10.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProcessBanView : UIView

//中心颜色

@property (strong, nonatomic)UIColor *centerColor;

//圆环背景色
@property (strong, nonatomic)UIColor *arcBackColor;


//圆环色进度加载的颜色
@property (strong, nonatomic)UIColor *arcUnfinishColor;



//百分比数值（0-1）
@property (assign, nonatomic)float percent;


//圆环宽度
@property (assign, nonatomic)float width;


@end
