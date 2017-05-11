//
//  BaseController.m
//  AiBanJiStudent
//
//  Created by dazaoqiancheng on 16/9/26.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "BaseController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "NSArray+Boundary.h"

#import "UIViewController+TongJi.h"



@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    
//    NSArray *array=[[NSArray alloc]initWithObjects:@"111",@"222", nil];
//    
//    [array objectAtIndex:3];
    
    
    //很主要，一定要隐藏
    self.fd_prefersNavigationBarHidden = YES;
    
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 50;
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NavHeight = 64;
    
    [self buildNavBar];
    
    
    //左部的返回按钮
    if(self.navigationController.viewControllers.count>1)
    {
        [self.navBar.imageLeft setImage:[UIImage imageNamed:@"reg_back"] forState:UIControlStateNormal];
        [self.navBar.imageLeft setImage:[UIImage imageNamed:@"reg_back"] forState:UIControlStateHighlighted];
        
        [self.navBar.imageLeft addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    // Do any additional setup after loading the view.
}


#pragma mark - 初始化控件
- (void)buildNavBar
{
    if (self.navBar==nil) {
        
        self.navBar = [[NavigationView alloc] initWithFrame:
                       CGRectMake(0,0,SCREEN_WIDTH,NavHeight)];
         self.navBar.backgroundColor=UIColorFromRGB(0xeca701);
        [self.view addSubview:self.navBar];
                
        
        self.lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.navBar.bottom-0.5, SCREEN_WIDTH, 0.5)];
        self.lineView.backgroundColor = UIColorFromRGB(0xcccccc);
        [self.navBar addSubview:self.lineView];
        
        
    }
    
}


#pragma mark - 下一级
- (void)pushNewViewController:(UIViewController *)newViewController {
    [self.navigationController pushViewController:newViewController animated:YES];
}



#pragma mark - 返回一级
-(void)backBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


#pragma mark - 返回根试图
- (void)backRoot{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
