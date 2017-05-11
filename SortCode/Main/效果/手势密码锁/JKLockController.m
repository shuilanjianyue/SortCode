//
//  JKLockController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/22.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "JKLockController.h"
#import "JKLockView.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface JKLockController ()<JKLockViewDelegate>
{
    JKLockView *jkView;
    
    
}

@end

@implementation JKLockController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.fd_interactivePopDisabled = true;
    
    
    self.navBar.titleLabel.text = @"手势密码锁";
    
    
    //手势密码锁的背景
    jkView=[[JKLockView alloc]initWithFrame:CGRectMake(0, 100, 320, 300)];
    
    jkView.delegate=self;
    
    jkView.userInteractionEnabled=YES;
    jkView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:jkView];
    
    
    
    // Do any additional setup after loading the view.
}


- (void)lockView:(JKLockView *)lockView didFinish:(NSString *)path
{
    
    if ([path isEqualToString:@"12369"]) {
        
        CustomToastView *toast = [[CustomToastView alloc]initWithView:self.view text:@"密码正确" duration:1];
        [toast show];
        
        
    }else{
        
        CustomToastView *toast = [[CustomToastView alloc]initWithView:self.view text:@"密码错误" duration:1];
        [toast show];

        
    }
    
    
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
