//
//  CustomKeyboard.m
//  keyboard
//
//  Created by jagtu on 16-2-20.
//  Copyright (c) 2016年 jagtu. All rights reserved.
//

#import "JTKeyboard.h"
#define kLineWidth (1.0/[UIScreen mainScreen].scale)
#define kNumFont [UIFont systemFontOfSize:27]

@interface JTKeyboard()<UITextFieldDelegate>

@property(nullable, nonatomic,weak)   id<UITextFieldDelegate> delegate;             // default is nil. weak reference

@end

@implementation JTKeyboard


+(JTKeyboard *)keyboardWithType:(JTKeyboardType) aKeyboardType
{
    return [[JTKeyboard alloc] initWithKeyboardType:aKeyboardType];
}

-(id)initWithKeyboardType:(JTKeyboardType) aKeyboardType
{
    _keyboardType = aKeyboardType;
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 216);
        self.autoresizesSubviews = YES;
        [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        //
        arrLetter = [NSArray arrayWithObjects:@"ABC",@"DEF",@"GHI",@"JKL",@"MNO",@"RST",@"UVW",@"XYZW", nil];
        
        
        //
        for (int i=0; i<4; i++)
        {
            for (int j=0; j<3; j++)
            {
                UIButton *button = [self creatButtonWithX:i Y:j];
                //btn.tag = j+3*i+1
                [self addSubview:button];
            }
        }
        
        UIColor *color = [UIColor colorWithRed:188/255.0 green:192/255.0 blue:199/255.0 alpha:1];
        //
        CGFloat scale = [UIScreen mainScreen].bounds.size.width/320.0;
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(105*scale, 0, kLineWidth, 216)];
        line1.backgroundColor = color;
        [line1 setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleWidth];
        [self addSubview:line1];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(214*scale, 0, kLineWidth, 216)];
        line2.backgroundColor = color;
        [line2 setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleWidth];
        [self addSubview:line2];
        
        for (int i=0; i<3; i++)
        {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 54*(i+1), self.bounds.size.width, kLineWidth)];
            line.backgroundColor = color;
            [line setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
            [self addSubview:line];
        }
        
    }
    return self;
}


-(void)setResponder:(UITextField *)aResponder
{
    _responder = aResponder;
    _responder.inputView = self;
    self.delegate = _responder.delegate;
    _responder.delegate = self;
}


-(UIButton *)creatButtonWithX:(NSInteger) x Y:(NSInteger) y
{
    UIButton *button;
    //
    CGFloat frameX;
    CGFloat frameW;
    CGFloat scale = [UIScreen mainScreen].bounds.size.width/320.0;
    switch (y)
    {
        case 0:
            frameX = 0.0;
            frameW = 106.0 * scale;
            break;
        case 1:
            frameX = 105.0 * scale;
            frameW = 110.0 * scale;
            break;
        case 2:
            frameX = 214.0 * scale;
            frameW = 106.0 * scale;
            break;
            
        default:
            break;
    }
    CGFloat frameY = 54*x;
    
    //
    button = [[UIButton alloc] initWithFrame:CGRectMake(frameX, frameY, frameW, 54)];
    button.autoresizesSubviews = YES;
    
    UIViewAutoresizing btnAutoResizer= UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin
    |UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
    [button setAutoresizingMask:btnAutoResizer];
    
    //
    NSInteger num = y+3*x+1;
    button.tag = num;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIColor *colorNormal = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1];
    UIColor *colorHightlighted = [UIColor colorWithRed:186.0/255 green:189.0/255 blue:194.0/255 alpha:1.0];
    
    if (num == 10 || num == 12)
    {
        UIColor *colorTemp = colorNormal;
        colorNormal = colorHightlighted;
        colorHightlighted = colorTemp;
    }
    button.backgroundColor = colorNormal;
    CGSize imageSize = CGSizeMake(frameW, 54);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorHightlighted set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [button setBackgroundImage:[pressedColorImg stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
    
    

    if (num<10)
    {
        CGRect rect = CGRectMake(0, 5, frameW, 28);
        if (_keyboardType != JTKeyboardTypeDefault) {
            rect = CGRectMake(0, 15, frameW, 28);
        }
        UILabel *labelNum = [[UILabel alloc] initWithFrame:rect];
        labelNum.text = [NSString stringWithFormat:@"%d",(int)num];
        labelNum.textColor = [UIColor blackColor];
        labelNum.textAlignment = NSTextAlignmentCenter;
        labelNum.font = kNumFont;
        [labelNum setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight];
        [button addSubview:labelNum];
        
        if (num != 1 && _keyboardType == JTKeyboardTypeDefault)
        {
            UILabel *labelLetter = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, frameW, 16)];
            labelLetter.text = [arrLetter objectAtIndex:num-2];
            labelLetter.textColor = [UIColor blackColor];
            labelLetter.textAlignment = NSTextAlignmentCenter;
            labelLetter.font = [UIFont systemFontOfSize:12];
            [labelLetter setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight];
            [button addSubview:labelLetter];
        }
    }
    else if (num == 11)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, frameW, 28)];
        label.text = @"0";
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kNumFont;
        [label setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin];
        [button addSubview:label];
    }
    else if (num == 10)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, frameW, 28)];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [label setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [button addSubview:label];
        if(_keyboardType == JTKeyboardTypeNumberPad){
            label.text = @"完 成";
        }else if(_keyboardType == JTKeyboardTypeIdNoPad){
            label.text = @"X";
            label.font = kNumFont;
        }else{
            label.text = @"ABC";
        }
    }
    else
    {
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake((button.frame.size.width-22)*0.5, (button.frame.size.height-17)*0.5, 22, 17)];
        arrow.image = [UIImage imageNamed:@"arrowInKeyboard"];
        [arrow setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
        [button addSubview:arrow];
        
    }
    
    return button;
}


-(void)clickButton:(UIButton *)sender
{
    if (self.responder == nil) {
        return;
    }
    
    UITextPosition* beginning = self.responder.beginningOfDocument;
    UITextRange* selectedTextRange = self.responder.selectedTextRange;
    const NSInteger location = [self.responder offsetFromPosition:beginning toPosition:selectedTextRange.start];
    const NSInteger length = [self.responder offsetFromPosition:selectedTextRange.start toPosition:selectedTextRange.end];
    
    NSRange selectedRange = NSMakeRange(location, length);
    
    if (sender.tag == 10)
    {
        if (_keyboardType == JTKeyboardTypeIdNoPad) {
            
            NSString *changeText = @"X";
            [self changeCharactersInRange:selectedRange replacementString:changeText];
            
        }else if(_keyboardType == JTKeyboardTypeNumberPad){
            //done
            [self.responder.delegate textFieldShouldReturn:self.responder];
        }else{
            
            [self.responder resignFirstResponder];
            self.responder.inputView = nil;
            [self.responder becomeFirstResponder];
        }
        return;
    }
    else if(sender.tag == 12)
    {
        if (selectedRange.location == 0 && selectedRange.length==0){
            return;
        }
        if (selectedRange.length==0) {
            selectedRange.length = 1;
            selectedRange.location = selectedRange.location-1;
        }
        [self changeCharactersInRange:selectedRange replacementString:@""];
    }
    else
    {
        NSInteger num = sender.tag;
        if (sender.tag == 11)
        {
            num = 0;
        }
        NSString *changeText = [NSString stringWithFormat:@"%d",(int)num];
        [self changeCharactersInRange:selectedRange replacementString:changeText];
    }
}

-(void)changeCharactersInRange:(NSRange)changeRange replacementString:(NSString *)changeText
{
    BOOL shouldChange = [self.responder.delegate textField:self.responder shouldChangeCharactersInRange:changeRange replacementString:changeText];
    if (shouldChange) {
        self.responder.text = [self.responder.text stringByReplacingCharactersInRange:changeRange withString:changeText];
        
        NSRange range = NSMakeRange(changeRange.location+changeText.length, 0);
        UITextPosition* beginning = self.responder.beginningOfDocument;
        UITextPosition* startPosition = [self.responder positionFromPosition:beginning offset:range.location];
        UITextPosition* endPosition = [self.responder positionFromPosition:beginning offset:range.location + range.length];
        UITextRange* selectionRange = [self.responder textRangeFromPosition:startPosition toPosition:endPosition];
        
        [self.responder setSelectedTextRange:selectionRange];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return  [self.delegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    if (!_responder.inputView) {
        [_responder resignFirstResponder];
        _responder.inputView = self;
        [_responder becomeFirstResponder];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:textField];
    }
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.delegate textFieldShouldEndEditing:textField];
    }
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.delegate textFieldDidEndEditing:textField];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField               // called when clear button pressed. return NO to ignore (no notifications)
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.delegate textFieldShouldClear:textField];
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.delegate textFieldShouldReturn:textField];
    }
    [textField resignFirstResponder];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
