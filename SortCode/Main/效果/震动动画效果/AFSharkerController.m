//
//  AFSharkerController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/28.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "AFSharkerController.h"
#import "AFViewShaker.h"

@interface AFSharkerController ()
@property(nonatomic,strong)UITextField *phoneTextField;

@property(nonatomic,strong)UITextField *passwordTextField;


@property(nonatomic,strong)UIButton *loginButton;


@end

@implementation AFSharkerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"震动动画效果";
    
    
    //输入手机号
    self.phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(30,NavHeight + 50, SCREEN_WIDTH-60, 45)];
    self.phoneTextField.layer.masksToBounds = YES;
    self.phoneTextField.layer.borderWidth = 0.5;
    self.phoneTextField.layer.cornerRadius = 5;
    self.phoneTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.phoneTextField.font = [UIFont systemFontOfSize:16];
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.phoneTextField.placeholder = @"手机号";
    [self.view addSubview:self.phoneTextField];
    
    
    
    
    //输入密码
    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, self.phoneTextField.bottom+10, SCREEN_WIDTH-60, 45)];
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.layer.borderWidth = 0.5;
    self.passwordTextField.layer.cornerRadius = 5;
    self.passwordTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.passwordTextField.font = [UIFont systemFontOfSize:16];
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
   
    self.passwordTextField.placeholder = @"设置密码";
    [self.view addSubview:self.passwordTextField];
    
    
    
    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(20, self.passwordTextField.bottom + 20, SCREEN_WIDTH - 40, 35)];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    //_loginButton.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentRight;
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _loginButton.backgroundColor = [UIColor magentaColor];
    [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, _loginButton.bottom + 20, SCREEN_WIDTH - 40, 35)];
    [button setTitle:@"全部摇动" forState:UIControlStateNormal];
    //button.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentRight;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.backgroundColor = [UIColor magentaColor];
    [button addTarget:self action:@selector(buAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    // Do any additional setup after loading the view.
}


- (void)loginAction{
     [[[AFViewShaker alloc] initWithView:_loginButton] shake];
    
}

-(void)buAction{
    NSArray *all = @[self.phoneTextField,self.passwordTextField];
    
     [[[AFViewShaker alloc] initWithViewsArray:all] shake];
    
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
