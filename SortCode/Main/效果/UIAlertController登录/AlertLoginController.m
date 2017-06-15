//
//  AlertLoginController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/11/25.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "AlertLoginController.h"

@interface AlertLoginController ()
{
    UIButton *showButton1;
    
}
@end

@implementation AlertLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"UIAlertController登录";
    
    showButton1=[[UIButton alloc]initWithFrame:CGRectMake(20, NavHeight + 20, SCREEN_WIDTH - 40, 40)];
    [showButton1 setBackgroundColor:[UIColor magentaColor]];
    [showButton1 setTitle:@"登录" forState:UIControlStateNormal];
    [showButton1 addTarget:self action:@selector(showsAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton1];
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}


- (void)showsAction1{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"文本对话框" message:@"登录和密码对话框示例" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"登录";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"密码";
        textField.secureTextEntry = YES;
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
   
  
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UITextField *login = alertController.textFields.firstObject;
        UITextField *password = alertController.textFields.lastObject;
        
        
        NSLog(@"%@",login.text);
        
        NSLog(@"%@",password.text);
        
    }];
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    okAction.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification  object:nil];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}



- (void)alertTextFieldDidChange:(NSNotification *)notification{
    
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    
    if (alertController) {
        UITextField *login = alertController.textFields.firstObject;
        NSLog(@"%@",login.text);
        
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = login.text.length > 2;
        
    }
}




- (void)didEnterBackground:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
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
