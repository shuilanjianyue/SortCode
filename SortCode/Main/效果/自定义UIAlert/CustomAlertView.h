//
//  CustomAlertView.h
//  整理文
//
//  Created by dazaoqiancheng on 17/3/17.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CustomAlertView;

typedef void(^CustAlertBlock)(NSInteger buttonIndex);//按钮点击


@interface CustomAlertView : UIView

@property (nonatomic, copy) CustAlertBlock clickedBlock;


#pragma mark - Block Way

/**
 *  返回一个 CustomAlert 对象, 类方法
 *
 *  @param title          提示标题
 *  @param message        提示内容
 *  @param buttonTitles   所有按钮的标题
 *  @param clicked        点击按钮的 block 回调
 *
 *
 */

+(instancetype)alertWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles clicked:(CustAlertBlock)clicked;

/**
 *  返回一个 CustomAlert 对象, 实例方法
 *
 *  @param title          提示标题
 *  @param buttonTitles   所有按钮的标题
 *  @param clicked        点击按钮的 block 回调
 *
 *
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles clicked:(CustAlertBlock)clicked;


@end
