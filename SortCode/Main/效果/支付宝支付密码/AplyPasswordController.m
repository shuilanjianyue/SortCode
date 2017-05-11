//
//  AplyPasswordController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/8.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "AplyPasswordController.h"
#import "SYPasswordView.h"
@interface AplyPasswordController ()

@property (nonatomic, strong) SYPasswordView *pasView;



@end

@implementation AplyPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titleLabel.text = @"支付宝支付密码";
    
    
    self.pasView = [[SYPasswordView alloc] initWithFrame:CGRectMake(16, 100, self.view.frame.size.width - 32, 45)];
    
    
    [self.view addSubview:_pasView];
    
    
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor brownColor];
    button.frame = CGRectMake(100, 180, self.view.frame.size.width - 200, 50);
    [button addTarget:self action:@selector(clearPaw) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"输入的密码" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_pasView.textField resignFirstResponder];
}


- (void)clearPaw
{
    
    NSLog(@"%@",self.pasView.textField.text);
    
    
    //[self.pasView clearUpPassword];
    
    
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
