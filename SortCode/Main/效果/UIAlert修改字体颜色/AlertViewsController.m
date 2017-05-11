//
//  AlertViewsController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/17.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "AlertViewsController.h"
@interface AlertViewsController ()

@property(nonatomic,strong)UIButton *lastButton;

@property(nonatomic,strong)UIButton *nextButton;

@end

@implementation AlertViewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"UIAlert修改字体颜色";
    
    
    _lastButton = [[UIButton alloc]initWithFrame:CGRectMake(20, NavHeight + 20, SCREEN_WIDTH-40, 40)];
    _lastButton.backgroundColor = [UIColor magentaColor];
    [_lastButton setTitle:@"alert" forState:UIControlStateNormal];
    [_lastButton addTarget:self action:@selector(lastAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_lastButton];
    
    
    _nextButton = [[UIButton alloc]initWithFrame:CGRectMake(20, _lastButton.bottom + 20, SCREEN_WIDTH - 40, 40)];
    _nextButton.backgroundColor = [UIColor magentaColor];
    [_nextButton setTitle:@"ActionSheet" forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextButton];
    // Do any additional setup after loading the view.
}




- (void)lastAction{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否效果推送或流量推送？" preferredStyle:UIAlertControllerStyleAlert];
    
    
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"温馨提示"];
    [hogan addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor magentaColor] range:NSMakeRange(0, [[hogan string] length])];
    [alert setValue:hogan forKey:@"attributedTitle"];
    
    
    
    //修改message
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:@"是否效果推送或流量推送？"];
    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, 12)];
    [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 12)];
    [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];

    
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"ffff1");
        
    }];
    
    
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"ffff2");
        
    }];
    
    [action1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [action2 setValue:[UIColor magentaColor] forKey:@"titleTextColor"];
    //[action1 setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    
    [alert addAction:action1];
    [alert addAction:action2];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (void)nextAction{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否效果推送或流量推送？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"温馨提示"];
    [hogan addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor magentaColor] range:NSMakeRange(0, [[hogan string] length])];
    [alert setValue:hogan forKey:@"attributedTitle"];
    
    
    
    //修改message
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:@"是否效果推送或流量推送？"];
    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, 12)];
    [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 12)];
    [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    
    
    
    
    
    
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        NSLog(@"ffff1");
        
    }];
    
    
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        NSLog(@"ffff2");
        
    }];
    
    
   // [action1 setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    
    [alert addAction:action1];
    [alert addAction:action2];
    
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];

    
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
