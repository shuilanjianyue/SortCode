//
//  ButtonLocationController.m
//  SortCode
//
//  Created by dazaoqiancheng on 2017/5/19.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "ButtonLocationController.h"
#import "UIButton+ExteralButton.h"

@interface ButtonLocationController ()
{
    UIButton *button1;//上下
    UIButton *button2;//左右
    UIButton *button3;//下上
    UIButton *button4;//右左
}
@end


@implementation ButtonLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titleLabel.text = @"按钮的位置关系";
    
    button1 = [[UIButton alloc]initWithFrame:CGRectMake(50, NavHeight + 20, SCREEN_WIDTH - 100, 60)];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"夜间"] forState:UIControlStateNormal];
    [button1 setTitle:@"按钮" forState:UIControlStateNormal];
    [button1 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:0];
    [self.view addSubview:button1];
    
    
    
    button2 = [[UIButton alloc]initWithFrame:CGRectMake(50, button1.bottom + 10, SCREEN_WIDTH - 100, 60)];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"夜间"] forState:UIControlStateNormal];
    [button2 setTitle:@"按钮" forState:UIControlStateNormal];
    [button2 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:0];
    [self.view addSubview:button2];
    
    
    
    button3 = [[UIButton alloc]initWithFrame:CGRectMake(50, button2.bottom + 10, SCREEN_WIDTH - 100, 60)];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"夜间"] forState:UIControlStateNormal];
    [button3 setTitle:@"按钮" forState:UIControlStateNormal];
    [button3 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleBottom imageTitleSpace:0];
    [self.view addSubview:button3];

    
    
    button4 = [[UIButton alloc]initWithFrame:CGRectMake(50, button3.bottom + 10, SCREEN_WIDTH - 100, 60)];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button4 setImage:[UIImage imageNamed:@"夜间"] forState:UIControlStateNormal];
    [button4 setTitle:@"按钮" forState:UIControlStateNormal];
    [button4 layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:0];
    [self.view addSubview:button4];
    
    // Do any additional setup after loading the view.
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
