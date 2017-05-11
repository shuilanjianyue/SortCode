//
//  CustomKeyboard.h
//  keyboard
//
//  Created by jagtu on 16-2-20.
//  Copyright (c) 2016年 jagtu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, JTKeyboardType) {
    JTKeyboardTypeDefault = 0,                // Default type for the current input method.
    JTKeyboardTypeNumberPad = 100,              // A number pad (0-9). and done Button
    JTKeyboardTypeIdNoPad = 101               // A idNo pad (1-9, 0, X).
};

@interface JTKeyboard : UIView
{
    NSArray *arrLetter;
    JTKeyboardType _keyboardType;
}

@property (nonatomic,assign) UITextField * responder;

-(id)initWithKeyboardType:(JTKeyboardType) aKeyboardType;

+(JTKeyboard *)keyboardWithType:(JTKeyboardType) aKeyboardType;

@end
