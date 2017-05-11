//
//  TextViewController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/10/26.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "TextViewController.h"
#import "BRPlaceholderTextView.h"

@interface TextViewController ()

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"自定义TextView";
    
    
    BRPlaceholderTextView *view=[[BRPlaceholderTextView alloc] initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH -10*2, 200)];
    view.placeholder=@"请输入xxxx阿达索朗多吉阿克琉斯的距离卡洛斯大家阿莱克斯多久阿萨德卡拉斯京的卡拉胶上地理课:1231123";
    view.font=[UIFont boldSystemFontOfSize:14];
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=8.0f;
    view.layer.borderWidth=0.5f;
    view.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.view addSubview:view];
    //颜色
    [view setPlaceholderColor:[UIColor redColor]];
    //透明度
    [view setPlaceholderOpacity:0.6];
    //字体大小
    [view setFont:[UIFont systemFontOfSize:14]];
    
    //限制长度
    [view addMaxTextLengthWithMaxLength:10 andEvent:^(BRPlaceholderTextView *text) {
        
        NSLog(@"----------");
    }];
    
    [view addTextViewBeginEvent:^(BRPlaceholderTextView *text) {
        NSLog(@"begin");
    }];
    
    [view addTextViewEndEvent:^(BRPlaceholderTextView *text) {
        NSLog(@"end");
    }];
    

    
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
