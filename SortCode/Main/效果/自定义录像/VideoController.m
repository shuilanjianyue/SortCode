//
//  VideoController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/23.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "VideoController.h"
#import "CustVideoController.h"
#import "SystemController.h"

@interface VideoController ()
@property(nonatomic,strong)UIButton *lastButton;

@property(nonatomic,strong)UIButton *nextButton;
@end

@implementation VideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titleLabel.text = @"视频";
    
    _lastButton = [[UIButton alloc]initWithFrame:CGRectMake(20, NavHeight + 20, SCREEN_WIDTH-40, 40)];
    _lastButton.backgroundColor = [UIColor magentaColor];
    [_lastButton setTitle:@"系统视频" forState:UIControlStateNormal];
    [_lastButton addTarget:self action:@selector(lastAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_lastButton];
    
    
    
    _nextButton = [[UIButton alloc]initWithFrame:CGRectMake(20, _lastButton.bottom + 20, SCREEN_WIDTH - 40, 40)];
    _nextButton.backgroundColor = [UIColor magentaColor];
    [_nextButton setTitle:@"自定义视频" forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextButton];

    
    // Do any additional setup after loading the view.
}



- (void)lastAction{
    
    SystemController *system = [[SystemController alloc]init];
    
    [self pushNewViewController:system];
    
    
}


- (void)nextAction{
    
    CustVideoController *video = [[CustVideoController alloc]init];
    [self pushNewViewController:video];
    
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
