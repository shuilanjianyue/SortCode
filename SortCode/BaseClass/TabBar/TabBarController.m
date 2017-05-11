//
//  TabBarController.m
//  AIBANJI
//
//  Created by dazaoqiancheng on 16/9/8.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "TabBarController.h"
#import "HomeController.h"
#import "XiaoGuoController.h"
#import "ActivityController.h"
#import "NavController.h"
#import "DGBWriteViewController.h"
#import "MineController.h"
@interface TabBarController ()
@property (nonatomic,strong) DGBWriteViewController *writeVC;

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;
   // self.tabBar.backgroundImage = [UIImage imageNamed:@"bar"];
    self.tabBar.tintColor = [UIColor blackColor];
    
    
    [self setChildVC];
    
    [self setUpTabbar];
    
    // Do any additional setup after loading the view.
}


- (void)setUpTabbar {
    
    //改变TabBar顶部那条线的颜色
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   UIColorFromRGB(0xd1d1d1).CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //这两个很主要缺一不可
    
    [self.tabBar setShadowImage:img];
    
    
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
    
    //UITabBar的底部字的位置
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0, -5)];
    
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"tab_ncall"] forState:UIControlStateNormal];
    [self.tabBar addSubview:button];
    
    CGFloat btnWH = 98;
    button.frame = CGRectMake((SCREEN_WIDTH - btnWH) *0.5, -40 , btnWH, btnWH);
    
    [button addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}



- (void)addButtonClick {
    
    
    DGBWriteViewController *writeVC = [[DGBWriteViewController alloc] init];
    
    self.writeVC = writeVC;
    
    __weak typeof(self) weakSelf = self;
    
    writeVC.closeTask = ^{
        
        weakSelf.writeVC = nil;
        
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:writeVC.view];
    
}


- (void)setChildVC {
    
    [self setupOneChildViewController:[[HomeController alloc] init] title:@"首页" image:@"tab_index_before" selectedImage:@"tab_index_after"];
    
    [self setupOneChildViewController:[[XiaoGuoController alloc] init] title:@"课程表" image:@"tab_class_before" selectedImage:@"tab_class_after"];
    
    [self setupOneChildViewController:[[UIViewController alloc] init] title:@"签到" image:nil selectedImage:nil];
    
    
    [self setupOneChildViewController:[[ActivityController alloc] init] title:@"活动" image:@"tab_active_before" selectedImage:@"tab_active_after"];
    
    [self setupOneChildViewController:[[MineController alloc] init] title:@"我的" image:@"tab_mine_before" selectedImage:@"tab_mine_after"];
    
    
}


- (void)setupOneChildViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    NavController *dgbNav = [[NavController alloc] initWithRootViewController:viewController];
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    
//    //UITabBar的未选中的颜色
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : UIColorFromRGB(0x7b7b7b) }
//                                             forState:UIControlStateNormal];
//    //UITabBar的选中的颜色
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName :UIColorFromRGB(0xeca701) }
//                                             forState:UIControlStateSelected];
    
    
    [self addChildViewController:dgbNav];
    
    
    
    
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
