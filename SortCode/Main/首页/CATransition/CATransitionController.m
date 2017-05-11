//
//  CATransitionController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/4/5.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "CATransitionController.h"

@interface CATransitionController ()
@property(nonatomic,strong)UIView *baseView;

@property(nonatomic,strong)UIView *subView1;

@property(nonatomic,strong)UIView *subView2;

@property(nonatomic,strong)UIImageView *image2;

@end

@implementation CATransitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"CATransition";
    
    
    self.baseView = [[UIView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight - 50)];
    [self.view addSubview:self.baseView];
    
    
    
    self.subView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight - 50)];
    self.subView1.backgroundColor = [UIColor blueColor];
    [self.baseView addSubview:self.subView1];
    
    
    
    self.subView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavHeight - 50)];
    self.subView2.backgroundColor = [UIColor magentaColor];
    [self.baseView addSubview:self.subView2];
    
    self.image2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 100, 100)];
    self.image2.image = [UIImage imageNamed:@"孙翠花.jpg"];
    [self.subView2 addSubview:self.image2];
    
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT- 50, SCREEN_WIDTH/4, 50)];
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT- 50, SCREEN_WIDTH/4, 50)];
    button2.backgroundColor = [UIColor yellowColor];
    [button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
    
    
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4*2, SCREEN_HEIGHT- 50, SCREEN_WIDTH/4, 50)];
    button3.backgroundColor = [UIColor greenColor];
    [button3 setTitle:@"结束动画" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    
    // Do any additional setup after loading the view.
}


- (void)buttonAction{
    //产生一个动画对象
    CATransition *animation = [CATransition animation];
    //动画持续时间
    animation.duration = 0.6;
    //animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    
    animation.type = kCATransitionPush;//淡入淡出
    animation.subtype = kCATransitionFromRight;//移出方向
    
    //将动画添加到layer上 起名为animationKey
    [self.baseView.layer addAnimation:animation forKey:@"animationKey"];
    
    [self.baseView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
}


- (void)button2Action{
    
    CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnima.fromValue = @(self.image2.center.y);
    positionAnima.toValue = @(self.image2.center.y-1);
    positionAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    
    
    CABasicAnimation *transformAnima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    transformAnima.fromValue = @(0);
    transformAnima.toValue = @(2*M_PI);//旋转360度
    //transformAnima.repeatCount = HUGE_VALF;//重复次数。永久重复的话设置为HUGE_VALF。
    transformAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    CAAnimationGroup *animaGroup = [CAAnimationGroup animation];
    animaGroup.duration = 0.1f;
    //动画终了后不返回初始状态设为No   返回初始状态设为YES
    animaGroup.fillMode = kCAFillModeForwards;
    animaGroup.removedOnCompletion = NO;
    animaGroup.repeatCount = HUGE_VALF;//重复次数。永久重复的话设置为HUGE_VALF。
    animaGroup.animations = @[positionAnima,transformAnima];
    
    [self.image2.layer addAnimation:animaGroup forKey:@"Animation"];
    
}


-(void)button3Action{
    
    [self.image2.layer removeAllAnimations];//结束动画
    
    
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
