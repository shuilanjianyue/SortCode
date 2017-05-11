//
//  HuaDong1Controller.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/1.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "HuaDong1Controller.h"

@interface HuaDong1Controller ()

@end

@implementation HuaDong1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.hidden = YES;
    
   UIButton *showButton1=[[UIButton alloc]initWithFrame:CGRectMake(20, NavHeight + 20, SCREEN_WIDTH - 40, 40)];
    [showButton1 setBackgroundColor:[UIColor magentaColor]];
    [showButton1 setTitle:@"滑动1" forState:UIControlStateNormal];
    [self.view addSubview:showButton1];
    
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
