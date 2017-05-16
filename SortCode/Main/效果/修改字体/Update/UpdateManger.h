//
//  UpdateManger.h
//  UpdateSystemFont
//
//  Created by dazaoqiancheng on 2017/5/15.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NSString UpdateFont;

extern UpdateFont *const UpdateFontNormal;//系统

extern UpdateFont *const UpdateFontCustom;//自定义

extern NSString *const UpdateFontNotification;//字体改变通知



@interface UpdateManger : NSObject

//默认正常字体
@property(nonatomic,strong)UpdateFont *updateFont;

//单例
+(UpdateManger *)shareManger;

- (UIFont *)getLabelTextFont:(CGFloat)fontSize;

@end
