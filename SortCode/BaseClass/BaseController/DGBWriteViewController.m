//
//  DGBWriteViewController.m
//  Demo
//
//  Created by douguangbin on 16/9/1.
//  Copyright © 2016年 douguangbin. All rights reserved.
//

#import "DGBWriteViewController.h"
#import "DGBCenterTitleButton.h"


@interface DGBWriteViewController ()

@property (nonatomic,weak) UIButton *closeBtn;

@end

@implementation DGBWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor magentaColor];
    
    UIBlurEffect *blure = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *visuale = [[UIVisualEffectView alloc] init];
    visuale.frame = self.view.bounds;
    visuale.effect = nil;
    
    [UIView animateWithDuration:0.01 animations:^{
        
        visuale.effect = blure;
        
    }];
    
    
    [self.view addSubview:visuale];
    
    
    DGBCenterTitleButton *centerTitleBtn1 = [DGBCenterTitleButton centertitleButtonWithImageName:@"tabbar_compose_camera" titleName:@"相机"];
    DGBCenterTitleButton *centerTitleBtn2 = [DGBCenterTitleButton centertitleButtonWithImageName:@"tabbar_compose_friend" titleName:@"朋友"];
     DGBCenterTitleButton *centerTitleBtn3 = [DGBCenterTitleButton centertitleButtonWithImageName:@"tabbar_compose_music" titleName:@"音乐"];
     DGBCenterTitleButton *centerTitleBtn4 = [DGBCenterTitleButton centertitleButtonWithImageName:@"tabbar_compose_idea" titleName:@"小说"];
     DGBCenterTitleButton *centerTitleBtn5 = [DGBCenterTitleButton centertitleButtonWithImageName:@"tabbar_compose_delete" titleName:@"删除"];
    DGBCenterTitleButton *centerTitleBtn6 = [DGBCenterTitleButton centertitleButtonWithImageName:@"tabbar_compose_more" titleName:@"更多"];
    
    NSArray *btnArray = @[centerTitleBtn1,centerTitleBtn2,centerTitleBtn3,centerTitleBtn4,centerTitleBtn5,centerTitleBtn6];
    
    int coloumn= 3;
    CGFloat btnWH = 120;
    
    CGFloat margin = (self.view.width - coloumn * btnWH) / (coloumn + 1);
    
    CGFloat x = 0;
    CGFloat y = 0;
    
    int currentColomn = 0;
    int currentRow = 0;
    
    CGFloat oriY = 200;
    
    for (int i = 0; i < btnArray.count; i++) {
        
        UIButton *btn = btnArray[i];
        
        btn.tag = i;
        
        currentColomn = i % coloumn;
        currentRow = i / coloumn;
        
        x = margin + (margin + btnWH) * currentColomn;
        y = oriY + (margin + btnWH) * currentRow;
        
        btn.frame = CGRectMake(x, y, btnWH, btnWH);
        
        [self.view addSubview:btn];
        
        btn.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);
        

        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    
    UIView *bottomV = [[UIView alloc] init];
    bottomV.backgroundColor = [UIColor whiteColor];
    
    CGFloat btnH = 49;
    
    bottomV.frame = CGRectMake(0,SCREEN_HEIGHT - btnH, SCREEN_WIDTH, btnH);
    
    [self.view addSubview:bottomV];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.userInteractionEnabled = NO;
    [closeBtn setImage:[UIImage imageNamed:@"ground_icon_close"] forState:UIControlStateNormal];
    CGFloat closeBtnW = 25;
    closeBtn.frame = CGRectMake((bottomV.width - closeBtnW) * 0.5, (bottomV.height - closeBtnW) * 0.5, closeBtnW, closeBtnW);
    [bottomV addSubview:closeBtn];
    self.closeBtn = closeBtn;
    self.closeBtn.transform = CGAffineTransformMakeRotation(-M_PI_4);
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    for (int i = 0; i < self.view.subviews.count; i++) {
        
        UIView *view = self.view.subviews[i];
        
        if ([view isKindOfClass:[DGBCenterTitleButton class]]) {
            
            [UIView animateWithDuration:0.5 delay:i * 0.05 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                
                view.transform = CGAffineTransformIdentity;
                
            } completion:nil];
            
        }
        
    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.closeBtn.transform = CGAffineTransformIdentity;
        
    }];
    
}

- (void)btnClick:(UIButton *)btn {
    
    for (int i = 0; i < self.view.subviews.count; i++) {
        UIView *view = self.view.subviews[i];
        
        if ([view isKindOfClass:[DGBCenterTitleButton class]]) {
            
            if (btn == view) {
                
                [UIView animateWithDuration:0.5 animations:^{
                    
                    btn.layer.transform = CATransform3DMakeScale(3.0, 3.0, 1);
                    btn.alpha = 0;
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        
                        self.view.alpha = 0;
                    } completion:^(BOOL finished) {
                        
                        self.closeTask();
                    }];
                    
                    
                }];
                
            }else {
                
                [UIView animateWithDuration:0.5 animations:^{
                    
                    CGAffineTransformMakeScale(0.001, 0.001);
                    
                    view.alpha = 0;
                    
                }];
                
            }
            
        }
        
        
    }
      
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    [self close];
    
    
}

- (void)close {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.closeBtn.transform = CGAffineTransformMakeRotation(-M_PI_4);
        
        
    }];
    
    NSArray *subView = self.view.subviews;
    
    NSArray *array = [[subView reverseObjectEnumerator] allObjects];
    
    
    for (int i = 0; i < array.count; i++) {
        
        UIView *view = array[i];
        
        if ([view isKindOfClass:[DGBCenterTitleButton class]]) {
            
            
            [UIView animateWithDuration:0.5 delay: i * 0.05 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                
                view.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);
                
            } completion:nil];
            
        }
        
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.view.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            self.closeTask();
            
            
        }];
        
        
    });
    
    
    
}


@end
