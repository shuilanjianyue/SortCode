//
//  CustomAlertController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/17.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "CustomAlertController.h"
#import "CustomAlertView.h"
@interface CustomAlertController ()
@property(nonatomic,strong)UIButton *lastButton;

@property(nonatomic,strong)UIButton *nextButton;
@end

@implementation CustomAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"自定义UIAlert";
    
    
    _lastButton = [[UIButton alloc]initWithFrame:CGRectMake(20, NavHeight + 20, SCREEN_WIDTH-40, 40)];
    _lastButton.backgroundColor = [UIColor magentaColor];
    [_lastButton setTitle:@"alert1" forState:UIControlStateNormal];
    [_lastButton addTarget:self action:@selector(lastAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_lastButton];
    
    
    _nextButton = [[UIButton alloc]initWithFrame:CGRectMake(20, _lastButton.bottom + 20, SCREEN_WIDTH - 40, 40)];
    _nextButton.backgroundColor = [UIColor magentaColor];
    [_nextButton setTitle:@"alert2" forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextButton];
    
    // Do any additional setup after loading the view.
}


- (void)lastAction{
    
//    CustomAlertView *alert = [CustomAlertView alertWithTitle:nil message:@"您使用的已经是最行版本了" buttonTitles:@[@"我知道了"] clicked:^(NSInteger buttonIndex) {
//        if (buttonIndex == 1) {
//            NSLog(@"第一个");
//        }
//    }];
    
    
    CustomAlertView *alerts = [[CustomAlertView alloc]initWithTitle:@"ddddd" message:@"您使用的已经是最新版本了" buttonTitles:@[@"我知道了"] clicked:^(NSInteger buttonIndex) {
        
    }];
    
    
    
    
    [self.view addSubview:alerts];
    
    
    
    
}


- (void)nextAction{
    
    CustomAlertView *alerts = [CustomAlertView alertWithTitle:@"温馨提示" message:@"您使用的已经是最新版本了" buttonTitles:@[@"取消",@"确认"] clicked:^(NSInteger buttonIndex) {
       
        if (buttonIndex == 1) {
            NSLog(@"取消");
        }else{
             NSLog(@"确认");
        }
    }];
    
    [self.view addSubview:alerts];
    
    
    
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
