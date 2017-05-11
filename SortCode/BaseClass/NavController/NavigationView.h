//
//  NavigationView.h
//  DZQCStudent
//
//  Created by dazaoqiancheng on 16/4/22.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationView : UIImageView

@property (nonatomic,strong)UIButton *imageLeft;    //左边图片

@property (nonatomic,strong)UIButton *imageRight;     // 右边图片

@property(nonatomic,strong)UIButton *titleLeft;  //左边文字

@property (nonatomic,strong)UIButton *titleRight;   //  右边文字

//标题
@property (nonatomic,strong)UILabel *titleLabel;//中间标题
@end
