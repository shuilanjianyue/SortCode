//
//  CaptchaView.h
//  总结
//
//  Created by dazaoqiancheng on 16/4/6.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaptchaView : UIView
@property (nonatomic, retain) NSArray *changeArray; //字符素材数组
@property (nonatomic, retain) NSMutableString *changeString;  //验证码的字符串

@end
