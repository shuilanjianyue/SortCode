//
//  BaseController.h
//  AiBanJiStudent
//
//  Created by dazaoqiancheng on 16/9/26.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationView.h"
@interface BaseController : UIViewController
{
@public NSInteger NavHeight;
    
}


@property (nonatomic,strong)NavigationView *navBar;

@property(nonatomic,strong)UIView *lineView;//下面的那条线

/**
 *  push新的控制器到导航控制器
 *
 *  @param newViewController 目标新的控制器对象
 */
- (void)pushNewViewController:(UIViewController *)newViewController;//下一级

-(void)backBtnAction;//返回一级


- (void)backRoot;//返回根目录


@end
