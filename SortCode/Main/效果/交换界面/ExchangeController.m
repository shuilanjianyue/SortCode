//
//  ExchangeController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/29.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "ExchangeController.h"

@interface ExchangeController ()
{
    UIView *exchangeView1;
    UIView *exchangeView2;
    
    NSString *flages;
    
}


@end

@implementation ExchangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navBar.titleLabel.text = @"交换界面";
    
    flages = @"1";
    
    
    [self.navBar.titleRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navBar.titleRight setTitle:@"交换界面" forState:UIControlStateNormal];
    [self.navBar.titleRight addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    exchangeView2 = [[UIView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight)];
    exchangeView2.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:exchangeView2];
    
    
    exchangeView1 = [[UIView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight)];
    exchangeView1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:exchangeView1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
    
    NSLog(@"%@",self.view.subviews);
    
    
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navBar.titleRight.hidden = NO;
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navBar.titleRight.hidden = YES;
    
}


-(void)nextAction{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:2];
    [UIView setAnimationDelegate:self];
    if ([flages intValue] == 1) {
        flages = @"2";
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    }else{
        
          flages = @"1";
         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    }
    
    [UIView commitAnimations];
    
    

}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:2];
    [UIView setAnimationDelegate:self];
    if ([flages intValue] == 1) {
        flages = @"2";
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    }else{
        
        flages = @"1";
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    }
    
    [UIView commitAnimations];
    
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
