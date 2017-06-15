//
//  UILabelCustom.m
//  UpdateSystemFont
//
//  Created by dazaoqiancheng on 2017/5/15.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "UILabelCustom.h"
#import "UpdateManger.h"

@implementation UILabelCustom

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
          // Initialization code
//        self.backgroundColor = [UIColor clearColor];
//        self.font = [UIFont systemFontOfSize:17.0];
        
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
#pragma mark - ThemeManager
- (void)configureViews
{
    // set backgroundColor
    
   
    
    self.font = [[UpdateManger shareManger]getLabelTextFont:17.0f];
    

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
