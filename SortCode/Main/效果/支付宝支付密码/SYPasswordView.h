//
//  SYPasswordView.h
//  整理文
//
//  Created by dazaoqiancheng on 17/3/8.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYPasswordView : UIView<UITextFieldDelegate>

/**
 *  清除密码
 */
- (void)clearUpPassword;


@property (nonatomic, strong) UITextField *textField;



@end
