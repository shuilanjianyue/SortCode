//
//  ShareController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/11/7.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "ShareController.h"
#import "ShareView.h"

@interface ShareController ()
{
    UIButton *showButton1;
    
}
@end

@implementation ShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"分享";
    
    showButton1=[[UIButton alloc]initWithFrame:CGRectMake(20, NavHeight + 20, SCREEN_WIDTH - 40, 40)];
    [showButton1 setBackgroundColor:[UIColor magentaColor]];
    [showButton1 setTitle:@"分享" forState:UIControlStateNormal];
    
    [showButton1 addTarget:self action:@selector(showsAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton1];
    
    // Do any additional setup after loading the view.
}


- (void)showsAction1{
    
    
NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@""]];
    
   UIImage *shareImage = [UIImage imageWithData:data];
    
    
    ShareView *share = [[ShareView alloc]initWithSuperViewController:self urlString:@"" shareImage:shareImage];
    
    
    [share show];
    
    
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
