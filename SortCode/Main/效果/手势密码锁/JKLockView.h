//
//  JKLockView.h
//  整理文
//
//  Created by dazaoqiancheng on 17/3/22.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKLockView;
@protocol JKLockViewDelegate <NSObject>

- (void)lockView:(JKLockView *)lockView didFinish:(NSString *)path;


@end

@interface JKLockView : UIView

{
    
    
    CGPoint currentPoint;
    
}


@property(nonatomic,assign) id <JKLockViewDelegate> delegate;

@property(nonatomic,strong)NSMutableArray *selectBtns;

@end
