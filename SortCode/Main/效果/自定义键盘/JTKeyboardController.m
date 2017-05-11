//
//  JTKeyboardController.m
//  整理文
//
//  Created by dazaoqiancheng on 16/10/14.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "JTKeyboardController.h"
#import "JTKeyboard.h"
@interface JTKeyboardController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,strong)UITextField *textField2;

@end

@implementation JTKeyboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navBar.titleLabel.text = @"自定义键盘";
    
    //输入手机号
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(10,NavHeight + 20, SCREEN_WIDTH - 20, 50)];
    self.textField.backgroundColor = [UIColor magentaColor];
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField.delegate = self;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.keyboardType = UIKeyboardTypeNamePhonePad;
    [self.view addSubview:self.textField];
    
    
    self.textField2 = [[UITextField alloc]initWithFrame:CGRectMake(10,self.textField.bottom + 20, SCREEN_WIDTH - 20, 50)];
    self.textField2.backgroundColor = [UIColor cyanColor];
    self.textField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textField2.delegate = self;
    self.textField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField2.keyboardType = UIKeyboardTypeNamePhonePad;
    [self.view addSubview:self.textField2];
    
    
    [JTKeyboard keyboardWithType:JTKeyboardTypeIdNoPad].responder = self.textField;
    
    [JTKeyboard keyboardWithType:JTKeyboardTypeNumberPad].responder = self.textField2;
    
    
    // Do any additional setup after loading the view.
}

-(void)keyboardChangeType
{
    [self.textField resignFirstResponder];
    self.textField.inputView = nil;
    [self.textField becomeFirstResponder];
}

-(void)keyboardBackspace
{
    if (self.textField.text.length != 0)
    {
        self.textField.text = [self.textField.text substringToIndex:self.textField.text.length -1];
    }
}

-(void)keyboardInput:(NSString *)number
{
    self.textField.text = [self.textField.text stringByAppendingString:number];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
    [self.textField2 resignFirstResponder];
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    NSLog(@"allow editing");
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    NSLog(@"became first responder");
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
{
    NSLog(@"allow editing to stop");
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
{
    NSLog(@"End Editing");
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    NSLog(@"change text %@,%@",string,NSStringFromRange(range));
    if ([string isEqualToString:@"5"]) {
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField               // called when clear button pressed. return NO to ignore (no notifications)
{
    NSLog(@"Should Clear");
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    NSLog(@"Should Return");
    [textField resignFirstResponder];
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
