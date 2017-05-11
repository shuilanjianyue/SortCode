//
//  CustomAlertView.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/17.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "CustomAlertView.h"

@interface CustomAlertView ()
/** 提示标题 */
@property(nonatomic, strong) NSString *title;

/** 提示内容 */
@property(nonatomic, strong) NSString *message;

/** 所有按钮 */
@property (nonatomic, strong) NSMutableArray *buttonTitles;

/** 遮早的view */
@property (nonatomic, strong) UIView *maskView;

/** 所有按钮的底部view */
@property (nonatomic, strong) UIView *alertView;


@end


@implementation CustomAlertView



+(instancetype)alertWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles clicked:(CustAlertBlock)clicked{
    
    return  [[self alloc]initWithTitle:title message:message buttonTitles:buttonTitles clicked:clicked];
    
}



- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles clicked:(CustAlertBlock)clicked{
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self = [super  initWithFrame:rect];
    
    
    if (self) {
        
        self.title = title;
        self.message = message;
        self.buttonTitles = [[NSMutableArray alloc] initWithArray:buttonTitles];
        
        self.clickedBlock = clicked;
        
        
        [self initSubView];
        
        
        
    }
    
    
    
    return self;
}


- (void)initSubView{
    
    //遮罩视图
    _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [self addSubview:_maskView];
    
    
    //控件
    _alertView = [[UIView alloc]initWithFrame:CGRectZero];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.masksToBounds = YES;
    _alertView.layer.cornerRadius = 10;
    [_maskView addSubview:_alertView];
    
    CGSize messageSize =[self.message boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 40, 400000) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0f]} context:nil].size;

    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    messageLabel.font = [UIFont systemFontOfSize:14.0f];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.text = self.message;
    [_alertView addSubview:messageLabel];
    
    
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectZero];
    lineView1.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    [_alertView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectZero];
     lineView2.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    [_alertView addSubview:lineView2];
    
    
    UIButton *cancellButton = [[UIButton alloc]initWithFrame:CGRectZero];
    cancellButton.backgroundColor = [UIColor whiteColor];
    cancellButton.tag = 1;
    cancellButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [cancellButton addTarget:self action:@selector(cancellAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancellButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_alertView addSubview:cancellButton];
    
    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectZero];
    sureButton.backgroundColor = [UIColor whiteColor];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.tag = 2;
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_alertView addSubview:sureButton];
    
    
    if (self.title) {
        lineView1.frame = CGRectMake(0, 35 +messageSize.height + 20, SCREEN_WIDTH - 40, 0.5);
        _alertView.frame = CGRectMake(20, self.center.y-32, SCREEN_WIDTH - 40, 35 + messageSize.height + 20 + 40);
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 35)];
        titleLabel.text = self.title;
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_alertView addSubview:titleLabel];
        
        messageLabel.frame = CGRectMake(10, 35, SCREEN_WIDTH - 60 , messageSize.height + 10);
        
        
        
    }else{
        
        lineView1.frame = CGRectMake(0, messageSize.height + 20, SCREEN_WIDTH - 40, 0.5);
        _alertView.frame = CGRectMake(20, self.center.y - 32, SCREEN_WIDTH - 40, messageSize.height + 20 + 40);
        
        messageLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH - 60 , messageSize.height + 10);
        
    }
    
    
    
    
    
    if (self.buttonTitles.count==1) {
        
        cancellButton.frame = CGRectMake(0, 35 +messageSize.height + 20 + 0.5, SCREEN_WIDTH - 40, 40);
        [cancellButton setTitle:self.buttonTitles[0] forState:UIControlStateNormal];
        
        
    }else{
        
        lineView2.frame = CGRectMake((SCREEN_WIDTH - 40)/2, messageLabel.bottom + 10, 0.5, 40);
        
        cancellButton.frame = CGRectMake(0, lineView1.bottom,(SCREEN_WIDTH - 40)/2, 40);
        sureButton.frame = CGRectMake((SCREEN_WIDTH - 40)/2 + 0.5, 35 +messageSize.height + 20 + 0.5, (SCREEN_WIDTH - 40)/2, 40);
        [cancellButton setTitle:self.buttonTitles[0] forState:UIControlStateNormal];
        [sureButton setTitle:self.buttonTitles[1] forState:UIControlStateNormal];
    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        _alertView.transform = CGAffineTransformScale(_alertView.transform, 1.08, 1.08);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 animations:^{
            _alertView.transform = CGAffineTransformIdentity;
        }];
        
    }];

}



- (void)cancellAction:(UIButton *)btn{
    
    
    
    if (self.clickedBlock) {
        
        self.clickedBlock(1);
    }
    
    [_maskView removeAllSubviews];
    [_maskView removeFromSuperview];
    _maskView = nil;
    
    [self removeFromSuperview];
}



- (void)sureAction:(UIButton *)btn{
    
    if (self.clickedBlock) {
        
        self.clickedBlock(2);
    }
    
    [_maskView removeAllSubviews];
    [_maskView removeFromSuperview];
    _maskView = nil;
    
    [self removeFromSuperview];

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
