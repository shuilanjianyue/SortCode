//
//  CustPressController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/28.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "CustPressController.h"
#import "ProgressView.h"
#import "ProcessBanView.h"

@interface CustPressController ()
{
    ProgressView *progress;
    
    ProcessBanView *banProcess;
    
}

@property (nonatomic, strong) NSTimer      *timer;



@end

@implementation CustPressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navBar.titleLabel.text = @"进度条";
    
    
    progress = [[ProgressView alloc]initWithFrame:CGRectMake(100, NavHeight + 40, 60, 60)];
    
    progress.width = 2;
    
    //progress.centerColor = [UIColor redColor];
    
    progress.arcFinishColor = [UIColor magentaColor];
    
    progress.arcUnfinishColor = [UIColor blueColor];
    
    progress.arcBackColor = [UIColor yellowColor];
    
    progress.percent = 0;
    
    [self.view addSubview:progress];
    
    
    
    banProcess = [[ProcessBanView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100/2, NavHeight + 140, 100, 100)];
    banProcess.percent = 0;
    progress.width = 5;
    banProcess.arcUnfinishColor = [UIColor blueColor];
    
    banProcess.arcBackColor = [UIColor yellowColor];
    
    [self.view addSubview:banProcess];
    
    
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(banProcess.frame) + 50, self.view.bounds.size.width - 2*50, 30)];
    [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
    [slider setMaximumValue:1];
    [slider setMinimumValue:0];
    [slider setMinimumTrackTintColor:[UIColor colorWithRed:255.0f/255.0f green:151.0f/255.0f blue:0/255.0f alpha:1]];
    [self.view addSubview:slider];
    
    
    
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
}


-(void)sliderMethod:(UISlider*)slider
{
    
    NSLog(@"slider.value = %f",slider.value);
    
    [progress setPercent:slider.value];
    
    
    [banProcess setPercent:slider.value];
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
