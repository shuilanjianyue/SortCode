//
//  TapButtonView.h
//  DZQCCompany
//
//  Created by dazaoqiancheng on 17/3/18.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TapButtonView;

@protocol TapButtonViewDelegate <NSObject>

@optional

- (void)tapView:(TapButtonView *)tapView tapIndex:(NSInteger)tapIndex;


@end
@interface TapButtonView : UIView

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,assign)UIButton *selectButton;

@property(nonatomic,assign)id <TapButtonViewDelegate>delegate;


- (void)addButton:(NSArray *)array index:(NSInteger)index;
- (void)addButton1:(NSArray *)array index:(NSInteger)index;



@end
