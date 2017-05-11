//
//  NSTimersController.m
//  整理文
//
//  Created by dazaoqiancheng on 2017/5/8.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "NSTimersController.h"
#import "HWWeakTimer.h"

@interface NSTimersController ()
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation NSTimersController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"NStimer";
    
    
//    _timer = [HWWeakTimer scheduledTimerWithTimeInterval:3.0f block:^(id userInfo) {
//        NSLog(@"%@", userInfo);
//    } userInfo:@"Fire" repeats:YES];
//    
    
    [_timer fire];
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f
                                              target:self
                                            selector:@selector(timerFire:)
                                            userInfo:nil
                                             repeats:YES];
    [_timer fire];//立即执行
    
    
    
    // 创建定时器
    NSTimer *timers = [NSTimer timerWithTimeInterval:2.0
                                             target:self
                                           selector:@selector(updateTimer:)
                                           userInfo:nil
                                            repeats:YES];
    
    // 将定时器添加到运行循环
    [[NSRunLoop currentRunLoop] addTimer:timers forMode:NSRunLoopCommonModes];
    
   /* NSDefaultRunLoopMode：发生用户交互的时候，时钟会被暂停。时钟，网络。
    NSRunLoopCommonModes：发生用户交互的时候，时钟仍然会触发，如果时钟触发方法非常耗时，
    使用此方式时用户操作会造成非常严重的卡顿。用户交互，响应级别高。*/
    
    
    // Do any additional setup after loading the view.
}


-(void)timerFire:(id)userinfo {
    NSLog(@"Fire");
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_timer invalidate];//停止时间
    _timer = nil;
    
}


- (void)updateTimer:(NSTimer *)timer{
    
}


//- (void)dealloc{
//    
//    //不执行这里
//    /*Timer 添加到 Runloop 的时候，会被 Runloop 强引用：
//     *然后 Timer 又会有一个对 Target 的强引用（也就是 self ）：
//     *也就是说 NSTimer 强引用了 self ，导致 self 一直不能被释放掉，所以也就走不到 self 的 dealloc 里
//     *
//     */
//    
//    
//}
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
