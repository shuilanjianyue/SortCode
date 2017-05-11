//
//  CustFieldController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/11/25.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "CustFieldController.h"
#import "CustPlaceholderField.h"

@interface CustFieldController ()
{
    CustPlaceholderField *phoneTextField;//手机号
    
    UITextField *testField;
    
    
}
@end

@implementation CustFieldController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"自定义UITextField的Placeholder颜色";
    
    //输入手机号
    phoneTextField = [[CustPlaceholderField alloc]initWithFrame:CGRectMake(10,NavHeight + 40, SCREEN_WIDTH-20, 40)];
    phoneTextField.font = [UIFont systemFontOfSize:16];
    phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    phoneTextField.placeholder = @"ffffff";
    [self.view addSubview:phoneTextField];
    
    
    
    //测试
    testField = [[UITextField alloc]initWithFrame:CGRectMake(10,NavHeight + 100, SCREEN_WIDTH-20, 40)];
    testField.font = [UIFont systemFontOfSize:16];
    testField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    testField.placeholder = @"测试";
    [testField setValue:[UIColor redColor]forKeyPath:@"_placeholderLabel.textColor"];
    [testField setValue:[UIFont systemFontOfSize:16]forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:testField];
    
    
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
