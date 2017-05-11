//
//  NSString+Judge.h
//  总结
//
//  Created by dazaoqiancheng on 16/4/21.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Judge)

/*
 *******判断手机号
 */
- (BOOL)validateMobile;

/*
 *******判断邮箱
 */
- (BOOL) validateEmail;

/*
 *判断身份证号
 */

- (BOOL) validateIdentityCard;

/*
 *******判断银行卡号
 */
- (BOOL) checkCardNo;

/*
 *******汉字获取首字母大写
 */

-(NSString *)hanziPinYin;


//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/*
 *******根据时间戳获取当前时间
 */

-(NSString *)currentTime;

/*
 *******处理<null>
 */

-(NSString *)setNull;


//时间戳转为格式时间
- (NSString *)timeIntervalToFormat:(NSTimeInterval)localTimeInterval;

//格式时间转为时间戳
- (long)formatToTimeInterval:(NSString *)timeStr;

@end
