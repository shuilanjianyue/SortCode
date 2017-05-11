//
//  NSString+Judge.m
//  总结
//
//  Created by dazaoqiancheng on 16/4/21.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "NSString+Judge.h"

@implementation NSString (Judge)


#pragma mark - 判断手机号
- (BOOL)validateMobile{
    
    NSString *phone=self;
    
    
    
    if (phone.length!=11) {
        return NO;
    }
    
    
    NSString *MOBILE = @"^1[34578]\\d{9}$";
    
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    
    
    if ([regexTestMobile evaluateWithObject:self]) {
        
        return YES;
        
        
    }else {
        
        
        return NO;
        
    }
}



#pragma mark - 判断邮箱

- (BOOL) validateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


#pragma mark - 判断身份证号
- (BOOL) validateIdentityCard
{
    NSString *identityCard=self;
    
    BOOL flag;
    
    if (identityCard.length !=18) {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    
    return [identityCardPredicate evaluateWithObject:identityCard];
}


#pragma mark - 判断银行卡号
- (BOOL) checkCardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    NSString *cardNo=self;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}



#pragma mark - 汉字获取首字母大写
-(NSString *)hanziPinYin{
    
    NSString *hanziText=self;
    
    NSString *upHanzi;

    if ([hanziText length]) {
        //转成了可变字符串
        NSMutableString *ms = [[NSMutableString alloc] initWithString:hanziText];
        
        //先转换为带声调的拼音 这是第一步，这两步一步都不能少
        CFStringTransform((CFMutableStringRef)ms,NULL, kCFStringTransformMandarinLatin,NO);
        //再转换为不带声调的拼音
        CFStringTransform((CFMutableStringRef)ms,NULL, kCFStringTransformStripDiacritics,NO);
        ////获取首字母
        upHanzi=[ms substringToIndex:1];
        //转化为大写拼音
        upHanzi=[upHanzi capitalizedString];
        
    }
    
    
    return upHanzi;
    
}


//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    
    return  [self boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}



//根据时间戳获取当前时间
- (NSString *)currentTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss(EEE)"];
    
    NSString *df=self;
    
    double fg=[df doubleValue];
    
    NSString *dateLoca = [NSString stringWithFormat:@"%f",fg];
    NSTimeInterval time=[dateLoca doubleValue];
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSString *timestr = [formatter stringFromDate:detaildate];
    
    
    return timestr;
    
    
}


//处理<null>
- (NSString *)setNull{
    
    NSString *setString=self;
    if ([setString isEqual:[NSNull null]]) {
        setString = @"";
    }else if (setString==nil){
        setString = @"";
    }else if (setString ==NULL){
        setString = @"";
    }
    
    return setString;
}



//时间戳转为格式时间
- (NSString *)timeIntervalToFormat:(NSTimeInterval)localTimeInterval{
    time_t timeInterval = (time_t)localTimeInterval;
    struct tm *time = localtime(&timeInterval);
    NSString *timeStr = [NSString stringWithFormat:@"%d-%02d-%02d %02d:%02d:%02d",time->tm_year + 1900,time->tm_mon + 1,time->tm_mday,time->tm_hour,time->tm_min, time->tm_sec];
    return timeStr;
}


//格式时间转为时间戳
- (long)formatToTimeInterval:(NSString *)timeStr{

    
    const char *str_time = [timeStr UTF8String];
    
    struct tm stm;
    int iY, iM, iD, iH, iMin, iS;
    memset(&stm,0,sizeof(stm));
    iY = atoi(str_time);
    iM = atoi(str_time+5);
    iD = atoi(str_time+8);
    iH = atoi(str_time+11);
    iMin = atoi(str_time+14);
    iS = atoi(str_time+17);
    stm.tm_year=iY-1900;
    stm.tm_mon=iM-1;
    stm.tm_mday=iD;
    stm.tm_hour=iH;
    stm.tm_min=iMin;
    stm.tm_sec=iS;
    return mktime(&stm);
}


@end
