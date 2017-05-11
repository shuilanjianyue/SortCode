//
//  WPLabelController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/10/17.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "WPLabelController.h"
#import "WPLabel.h"
@interface WPLabelController ()

@end

@implementation WPLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"自定义Label的位置";
    
    WPLabel *label = [[WPLabel alloc]initWithFrame:CGRectMake(0, NavHeight+30, SCREEN_WIDTH, 50)];
    label.text = @"测试";
    
    label.backgroundColor = [UIColor greenColor];
    label.verticalAlignment = VerticalAlignmentTop;
    [self.view addSubview:label];
    
    
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
