//
//  NavController.m
//  AIBANJI
//
//  Created by dazaoqiancheng on 16/9/8.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "NavController.h"

@interface NavController ()<UIGestureRecognizerDelegate>

@end


@implementation NavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationBarHidden = YES;//上部的导航栏
    self.toolbarHidden = YES;//底部的状态栏
    
    // Do any additional setup after loading the view.
}


//进入下一级
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    if (self.viewControllers.count > 0) {
        
        //处理黑色区域
        viewController.hidesBottomBarWhenPushed = YES;
        
        
    }
    
    
    
    [super pushViewController:viewController animated:animated];
}


//返回
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    
    
    return [super popViewControllerAnimated:animated];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
