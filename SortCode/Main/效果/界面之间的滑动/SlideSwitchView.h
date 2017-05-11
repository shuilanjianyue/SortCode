//
//  SlideSwitchView.h
//  整理文
//
//  Created by dazaoqiancheng on 17/3/1.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SlideSwitchViewDelegate;

@interface SlideSwitchView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_rootScrollView;                  //主视图
    UIScrollView *_topScrollView;                   //顶部页签视图
    
    CGFloat _userContentOffsetX;
    BOOL _isLeftScroll;                             //是否左滑动
    BOOL _isRootScroll;                             //是否主视图滑动
    BOOL _isBuildUI;                                //是否建立了ui
    
    NSInteger _userSelectedChannelID;               //点击按钮选择名字ID
    
    UIImageView *_shadowImageView;
    UIImage *_shadowImage;
    
    UIColor *_tabItemNormalColor;                   //正常时tab文字颜色
    UIColor *_tabItemSelectedColor;                 //选中时tab文字颜色
    UIImage *_tabItemNormalBackgroundImage;         //正常时tab的背景
    UIImage *_tabItemSelectedBackgroundImage;       //选中时tab的背景
    NSMutableArray *_viewArray;                     //主视图的子视图数组
    
    UIButton *_rigthSideButton;                     //右侧按钮
    
    __weak id<SlideSwitchViewDelegate> _slideSwitchViewDelegate;
}

@property (nonatomic, strong)  UIScrollView *rootScrollView;
@property (nonatomic, strong)  UIScrollView *topScrollView;
@property (nonatomic, assign) CGFloat userContentOffsetX;
@property (nonatomic, assign) NSInteger userSelectedChannelID;
@property (nonatomic, assign) NSInteger scrollViewSelectedChannelID;
@property (nonatomic, weak)  id<SlideSwitchViewDelegate> slideSwitchViewDelegate;
@property (nonatomic, strong) UIColor *tabItemNormalColor;
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
@property (nonatomic, strong) UIImage *tabItemNormalBackgroundImage;
@property (nonatomic, strong) UIImage *tabItemSelectedBackgroundImage;
@property (nonatomic, strong) UIImage *shadowImage;
@property (nonatomic, strong) NSMutableArray *viewArray;

@property (nonatomic, strong)  UIButton *rigthSideButton;

- (void)setSelectedViewIndex:(NSInteger)selectedViewIndex andAnimation:(BOOL)animation;
/**
 * @method 创建子视图UI
 
 */
- (void)buildUI;

/**
 * @method 通过16进制计算颜色
 
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
@end

@protocol SlideSwitchViewDelegate <NSObject>

@required

/**
 * @method 顶部tab个数
 
 */
- (NSUInteger)numberOfTab:(SlideSwitchView *)view;

/**
 * @method 每个tab所属的viewController
 
 */
- (UIViewController *)slideSwitchView:(SlideSwitchView *)view viewOfTab:(NSUInteger)number;

@optional

/**
 * @method 滑动左边界时传递手势

 */
- (void)slideSwitchView:(SlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer*) panParam;

/**
 * @method 滑动右边界时传递手势
 
 */
- (void)slideSwitchView:(SlideSwitchView *)view panRightEdge:(UIPanGestureRecognizer*) panParam;

/**
 * @method 点击tab
 
 */
- (void)slideSwitchView:(SlideSwitchView *)view didselectTab:(NSUInteger)number;
@end
