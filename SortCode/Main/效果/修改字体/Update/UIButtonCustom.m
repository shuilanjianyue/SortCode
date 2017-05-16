//
//  UIButtonCustom.m
//  UpdateSystemFont
//
//  Created by dazaoqiancheng on 2017/5/15.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "UIButtonCustom.h"
#import "UpdateManger.h"

@implementation UIButtonCustom

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configureViews];
        [self regitserAsObserver];
        //        self.textColor = [UIColor blackColor];
    }
    
    
    return self;
}



- (void)dealloc
{
    [self unregisterAsObserver];
}

#pragma mark
#pragma mark - UpdateManager
- (void)configureViews
{
    // set backgroundColor
    
    self.titleLabel.font = [[UpdateManger shareManger]getLabelTextFont:17.0f];
    
}



- (void)regitserAsObserver
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(configureViews)
                   name:UpdateFontNotification
                 object:nil];
}



- (void)unregisterAsObserver
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
