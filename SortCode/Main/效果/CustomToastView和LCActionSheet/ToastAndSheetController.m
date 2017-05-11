//
//  ToastAndSheetController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/10/14.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "ToastAndSheetController.h"

@interface ToastAndSheetController ()<LCActionSheetDelegate>
{
    
    UIButton *pickButton;
    
    UIButton *listButton;
    
    UIButton *zhuButton;
    
    CustomToastView *toast;
    
}
@end


@implementation ToastAndSheetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navBar.titleLabel.text = @"CustomToastView和LCActionSheet";
    
    pickButton=[[UIButton alloc]initWithFrame:CGRectMake(20, NavHeight+20, SCREEN_WIDTH-40, 40)];
    [pickButton setBackgroundColor:[UIColor magentaColor]];
    [pickButton setTitle:@"CustomToastView" forState:UIControlStateNormal];
    [pickButton addTarget:self action:@selector(pickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pickButton];
    
    
    
    listButton=[[UIButton alloc]initWithFrame:CGRectMake(20, pickButton.bottom+30, SCREEN_WIDTH-40, 40)];
    [listButton setTitle:@"LCActionSheet" forState:UIControlStateNormal];
    [listButton setBackgroundColor:[UIColor cyanColor]];
    [listButton addTarget:self action:@selector(listBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:listButton];
    
    
    zhuButton=[[UIButton alloc]initWithFrame:CGRectMake(20, listButton.bottom+30, SCREEN_WIDTH-40, 40)];
    [zhuButton setTitle:@"LCActionSheet" forState:UIControlStateNormal];
    [zhuButton setBackgroundColor:[UIColor cyanColor]];
    [zhuButton addTarget:self action:@selector(zhuButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuButton];
    
    
    // Do any additional setup after loading the view.
}


- (void)pickBtn{
    
    toast=[[CustomToastView alloc]initWithIndicatorWithView:self.view withText:@"正在加载中。。。"];
    [toast startTheView];
    
    [self performSelector:@selector(stop) withObject:nil afterDelay:3];
    
    
}


-(void)stop{
    [toast stopAndRemoveFromSuperView];
    
}

- (void)listBtn{
    
    // 类方法
    LCActionSheet *sheet = [LCActionSheet sheetWithTitle:@"一个超长超长超长超长超长超长超长超长超长超长超长超长超长超长超长的标题" buttonTitles:@[@"拍照", @"从相册选择"] redButtonIndex:-1 clicked:^(NSInteger buttonIndex) {
        
        NSLog(@"> Block way -> Clicked Index: %ld", (long)buttonIndex);
    }];
    
    
    [sheet show];
    
}


- (void)zhuButton{
    // 实例方法
    LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:@"你确定要注销吗？"
                                                   buttonTitles:nil
                                                 redButtonIndex:0
                                                       delegate:self];
    [sheet addButtonTitle:@"注销"];
    
//        sheet.animationDuration = 1.0f;
//        sheet.backgroundOpacity = 1.0f;
    
    [sheet show];
    
    
}

#pragma mark - LCActionSheet 代理方法

- (void)actionSheet:(LCActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"> Delegate way -> Clicked Index: %ld", (long)buttonIndex);
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
