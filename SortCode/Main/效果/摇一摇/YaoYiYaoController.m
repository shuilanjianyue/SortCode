//
//  YaoYiYaoController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/10/31.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "YaoYiYaoController.h"
#import <AVFoundation/AVFoundation.h>

@interface YaoYiYaoController ()
{
    SystemSoundID  soundID;
    
    UIButton *showButton1;
}
@end

@implementation YaoYiYaoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"摇一摇";
    
    showButton1=[[UIButton alloc]initWithFrame:CGRectMake(20, NavHeight + 20, SCREEN_WIDTH - 40, 40)];
    [showButton1 setBackgroundColor:[UIColor magentaColor]];
    [showButton1 setTitle:@"摇一摇" forState:UIControlStateNormal];
    
    [showButton1 addTarget:self action:@selector(showsAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton1];
    
    
    
    [[UIApplication sharedApplication]setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"shakeSound" ofType:@"mp3"];
//    AudioServicesCreateSystemSoundID((__bridge  CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    
    
    // Do any additional setup after loading the view.
}


- (void)showsAction1{
    //    [[UIApplication sharedApplication]setApplicationSupportsShakeToEdit:YES];
    //    [self becomeFirstResponder];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shakeSound" ofType:@"mp3"];
    AudioServicesCreateSystemSoundID((__bridge  CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound (soundID);
}


#pragma mark  -摇动
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //    if (_integerCount <= 0) {
    //        [[UIApplication sharedApplication]setApplicationSupportsShakeToEdit:NO];
    //
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的摇一摇次数已经用完！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    //        [alert show];
    //        return;
    //
    //    }else{
    //        [[UIApplication sharedApplication]setApplicationSupportsShakeToEdit:YES];
    //    }
    
    //    [self closeAlert];
    NSLog(@"shake  begin");
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"shake  cancel");
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //    if (_integerCount <= 0) {
    //        return;
    //    }
    
    NSLog(@"shake  end");
    
    //    NSString *integral = [NSString stringWithFormat:@"%d",[self getRandomIntegra]];
    //
    //    if ([integral intValue] == 0) {
    //        _shakeAlert.title.text = @"很遗憾！";
    //        _shakeAlert.integral.text = @"您没有获取积分";
    //    }else{
    //        _shakeAlert.title.text = @"恭喜您！";
    //        _shakeAlert.integral.text = [NSString stringWithFormat:@"获得%@个积分",integral];
    //    }
    
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound (soundID);
    //    _maskView.hidden = NO;
    //    _shakeAlert.hidden = NO;
    //
    //    //    //测试
    //    //    //摇一摇次数
    //    //    _count -= 1;
    //
    //    [self getAwardResult];
}

#pragma mark - 随机获取积分
- (int)getRandomIntegra
{
    /*
     0-29  0
     30-49 1
     50-69 2
     70-84 3
     85- 94 4
     95 -99 5
     */
    int rand = 0;
    
    int temp = arc4random() % 100;
    if (temp >= 0 && temp <= 29) {
        rand = 0;
    }else if (temp >= 0 && temp <= 29) {
        rand = 1;
    }else if (temp >= 30 && temp <= 49) {
        rand = 2;
    }else if (temp >= 50 && temp <= 69) {
        rand = 3;
    }else if (temp >= 85 && temp <= 94) {
        rand = 4;
    }else if (temp >= 95 && temp <= 99) {
        rand = 5;
    }
    
    return rand;
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
