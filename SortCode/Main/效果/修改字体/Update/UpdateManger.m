//
//  UpdateManger.m
//  UpdateSystemFont
//
//  Created by dazaoqiancheng on 2017/5/15.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "UpdateManger.h"

NSString * const UpdateFontNormal = @"NORMAL";
NSString * const UpdateFontCustom = @"CUSTOM";


NSString *const UpdateFontNotification = @"UpdateFontNotification";

NSString * const UpdateFontVersionKey = @"com.dknightversion.manager.themeversi";
@implementation UpdateManger

//默认正常字体
+(UpdateManger *)shareManger{
    static dispatch_once_t onceToken;
    static UpdateManger *instance = nil;
    
    dispatch_once(&onceToken,^{
        //初始化
        instance = [[UpdateManger alloc] init];
        
        //默认正常字体
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        UpdateFont *updateFont = [userDefaults valueForKey:UpdateFontVersionKey];
        updateFont = updateFont ?: UpdateFontCustom;
        instance.updateFont = updateFont;
        
    });
    
    return instance;
    
}


//修改的字体的时候
- (void)setUpdateFont:(UpdateFont *)updateFont{
    
    if ([_updateFont isEqualToString:updateFont]) {
        return;
    }
    
    _updateFont = updateFont;
    
    // Save current font to user default
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:updateFont forKey:UpdateFontVersionKey];
    [userDefaults synchronize];
    
    //If change system font send notification
    [[NSNotificationCenter defaultCenter] postNotificationName:UpdateFontNotification object:nil];
    
}



- (UIFont *)getLabelTextFont:(CGFloat)fontSize
{
    
    NSString *fontName;
    
    
    if ([self.updateFont isEqual:UpdateFontNormal]) {
        
        fontName = @"";
        
        
    }else{
        
        fontName = @"FZLBJW--GB1-0";
       
    }
    
    
    return [UIFont fontWithName:fontName size:fontSize];
    
    
}


@end
