//
//  NSString+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "NSString+MCExtension.h"

#import <objc/runtime.h>
#import "CommonCrypto/CommonDigest.h"
#import "NSDate+MCExtension.h"

@implementation NSString (MCExtension)

+ (NSString *)MC_translation:(NSString *)arabStr
{
    NSInteger arabicNum = [arabStr integerValue];
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            
            [sums addObject:sum];
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}

- (NSString *)MC_timeInterval
{
    // 以前时间
    const long agoTimeLong = (long)[self longLongValue];
    // 当前系统时间
    const long currentTimeLong = [[NSDate date] timeIntervalSince1970];
    
    const long distanceSecond = currentTimeLong - agoTimeLong;
    
    // 返回与现在的时间差
    if (distanceSecond >= 86400) {
        return [self MC_dateTimeWithLonglongTimeFormat:@"yyyy-MM-dd HH:mm:ss"];
    } else if (distanceSecond >= 3600) {
        return [NSString stringWithFormat:@"%ld小时前",distanceSecond / 3600];
    } else if (distanceSecond >= 60) {
        return [NSString stringWithFormat:@"%ld分钟前",distanceSecond / 60];
    } else {
        return [NSString stringWithFormat:@"%ld秒前",distanceSecond];
    }
}

- (NSString *)MC_dateStringFromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:fromFormat];
    NSDate *date = [formatter dateFromString:self];
    [formatter setDateFormat:toFormat];
    return [formatter stringFromDate:date];
}

- (NSString *)MC_dayTimeInterval
{
    // 以前时间
    const long agoTimeLong = (long)[self longLongValue];
    // 当前系统时间
    const long currentTimeLong = [[NSDate date] timeIntervalSince1970];
    
    const long distanceSecond = currentTimeLong - agoTimeLong;
    
    // 返回与现在的时间差
    if (distanceSecond >= 86400) {
        return [self MC_dateTimeWithLonglongTimeFormat:@"yyyy-MM-dd"];
    } else if (distanceSecond >= 3600) {
        return [NSString stringWithFormat:@"%ld小时前",distanceSecond / 3600];
    } else if (distanceSecond >= 60) {
        return [NSString stringWithFormat:@"%ld分钟前",distanceSecond / 60];
    } else {
        return [NSString stringWithFormat:@"%ld秒前",distanceSecond];
    }
}

- (NSString *)MC_timeRemain
{
    const long remainTimeLong = (long)[self longLongValue] >= 0 ? (long)[self longLongValue]:0;
    
    NSInteger dayLong = (60 *60 *24);
    NSInteger hourLong = (60 *60);
    NSInteger minuteLong = 60;
    
    NSInteger remainDay = remainTimeLong / dayLong;
    NSInteger remainHour = (remainTimeLong % dayLong) / hourLong;
    NSInteger remainMinute = (remainTimeLong % hourLong) / minuteLong;
    NSInteger remainSecond = (remainTimeLong % minuteLong);
    
    NSMutableString *remainStr = @"".mutableCopy;
    if (remainDay > 0){
        [remainStr appendString:[NSString stringWithFormat:@"%@天",@(remainDay)]];
    }
    
    if (remainHour > 0 || remainStr.length != 0){
        [remainStr appendString:[NSString stringWithFormat:@"%@小时",@(remainHour)]];
    }
    
    if (remainMinute > 0 || remainStr.length != 0){
        [remainStr appendString:[NSString stringWithFormat:@"%@分",@(remainMinute)]];
    }
    
    
    [remainStr appendString:[NSString stringWithFormat:@"%@秒",@(remainSecond)]];
    return remainStr;
}

- (CGFloat)MC_heightWithContentWidth:(CGFloat)width font:(UIFont *)font
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    CGFloat height = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                            attributes: @{NSFontAttributeName :font,
                                                                          NSParagraphStyleAttributeName : paragraphStyle}
                                                               context:nil].size.height;
    return height;

}

- (CGFloat)MC_widthWithContentHeight:(CGFloat)height font:(UIFont *)font
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    CGFloat width2 = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes: @{NSFontAttributeName :font,
                                                   NSParagraphStyleAttributeName : paragraphStyle}
                                        context:nil].size.width;
    return width2;
    
}

- (CGSize)MC_sizeWithFontSize:(CGFloat)fontSize
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                        options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                  attributes: @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize],
                                                   NSParagraphStyleAttributeName : paragraphStyle}
                                        context:nil].size;
    return size;
    
}

- (NSString *)MC_dateTimeWithLonglongTimeFormat:(NSString *)format
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[self longLongValue]]];
    
    return currentDateStr;
}

- (NSDate *)MC_convertToDateWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
}

+ (NSString *)MC_distanceWithTime:(NSString *)longLongTime
{
    // 以前时间
    const long agoTimeLong = (long)[longLongTime longLongValue];
    // 当前系统时间
    const long currentTimeLong = [[NSDate date] timeIntervalSince1970];
    
    const long distanceSecond = currentTimeLong - agoTimeLong;
    
    // 返回与现在的时间差
    if (distanceSecond > 0) {
        if (distanceSecond >= 31104000) {
            return [NSString stringWithFormat:@"%ld年前",distanceSecond / 31104000];
        } else if (distanceSecond >= 2592000) {
            return [NSString stringWithFormat:@"%ld个月前",distanceSecond / 2592000];
        } else if (distanceSecond >= 86400) {
            return [NSString stringWithFormat:@"%ld天前",distanceSecond / 86400];
        } else if (distanceSecond >= 3600) {
            return [NSString stringWithFormat:@"%ld小时前",distanceSecond / 3600];
        } else if (distanceSecond >= 60) {
            return [NSString stringWithFormat:@"%ld分钟前",distanceSecond / 60];
        } else {
            return [NSString stringWithFormat:@"%ld秒前",distanceSecond];
        }
    } else {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:agoTimeLong];
        NSDate *now = [NSDate date];
        NSInteger month = date.MC_month;
        NSInteger day = date.MC_day;
        NSInteger hour = date.MC_hour;
        NSInteger minute = date.MC_minute;
        if (date.MC_year == now.MC_year &&
            date.MC_month == now.MC_month) { // 同年同月
           if (day == now.MC_day) {
               return [NSString stringWithFormat:@"今天%zd:%zd",hour,minute];
           } else if (day == now.MC_day + 1) {
               return [NSString stringWithFormat:@"明天%zd:%zd",hour,minute];
           } else if (day == now.MC_day + 2) {
               return [NSString stringWithFormat:@"后天%zd:%zd",hour,minute];
           } else {
               return [NSString stringWithFormat:@"本月%zd日 %zd:%zd",day,hour,minute];
           }
        } else if(date.MC_year == now.MC_year &&
                  date.MC_month != now.MC_month){ // 同年不同月
           return [NSString stringWithFormat:@"%zd/%zd %zd:%zd",month,day,hour,minute];
        } else {
           return [NSString stringWithFormat:@"%zd/%zd/%zd %zd:%zd",date.MC_year,month,day,hour,minute];
        }
    }
}

- (NSString *)MC_md5
{
    const char *cStr = [self UTF8String];//转换成utf-8
    unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    CC_MD5(cStr, (int)strlen(cStr), result);
    /*
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
}

//解编码
- (NSString *)MC_decodeFromPercentEscapeString
{
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (instancetype)MC_hexStringWithDenary:(NSInteger)denary formatLength:(NSInteger)length
{
    NSString *nLetterValue;
    NSString *str = @"";
    uint16_t ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig = denary % 16;
        denary = denary / 16;
        switch (ttmpig) {
            case 10:
                nLetterValue =@"A";
                break;
            case 11:
                nLetterValue =@"B";
                break;
            case 12:
                nLetterValue =@"C";
                break;
            case 13:
                nLetterValue =@"D";
                break;
            case 14:
                nLetterValue =@"E";
                break;
            case 15:
                nLetterValue =@"F";
                break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (denary == 0) {
            break;
        }
    }
    
    while (str.length < length) {
        str = [NSString stringWithFormat:@"0%@",str];
    }
    
    return str;
}

- (instancetype)MC_complementHexString
{
    // 字符串转char数组
    char hexChars[self.length];
    const char *str = [self cStringUsingEncoding:kCFStringEncodingUTF8];
    strcpy(hexChars,str);
    
    // 反码,按位取反
    NSMutableString *complementM = [NSMutableString string];
    for (int i = 0; i < self.length; i++) {
        int index = 0; // 十进制的索引
        if ((hexChars[i] >= 65 && hexChars[i] <= 70) || (hexChars[i] >= 97 && hexChars[i] <= 102)) { // A~F|a~f
            if (hexChars[i] <= 70) {
                index = 10 + hexChars[i] - 65;
            } else {
                index = 10 + hexChars[i] - 97;
            }
        } else { // 0~9
            index = hexChars[i] - 48;
        }
        index = 15 - index; // 转为补码的索引
        if (index > 9) { // A~F
            NSString *temp = nil;
            switch (index) {
                case 10:
                    temp = @"A";
                    break;
                case 11:
                    temp = @"B";
                    break;
                case 12:
                    temp = @"C";
                    break;
                case 13:
                    temp = @"D";
                    break;
                case 14:
                    temp = @"E";
                    break;
                case 15:
                    temp = @"F";
                    break;
            }
            [complementM appendFormat:@"%@",temp];
        } else { // 0~9
            [complementM appendFormat:@"%d",index];
        }
    }
    
    // 加一
    unsigned long hexValue = strtoul([complementM UTF8String],0,16) + 1;
    // 再转回十六进制
    NSString *result = [self MC_hexStringWithDenary:hexValue formatLength:4];
    
    return result;
}

+ (instancetype)MC_fileSizeToString:(unsigned long long)fileByteSize
{
    double convertedValue = (double)fileByteSize;
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"b",@"KB",@"MB",@"GB",nil];
    
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%4.1f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}

+ (instancetype)MC_stringWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2)
{
    va_list arglist;
    va_start(arglist, format);
    NSString *outStr = [[NSString alloc] initWithFormat:format arguments:arglist];
    va_end(arglist);
    
    return [outStr stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
}

- (NSString *)MC_pinYin
{
    // NSString转换为CFStringRef
    CFStringRef stringRef = (__bridge CFMutableStringRef)[NSMutableString stringWithString:self];
    // 汉字转换为拼音
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, stringRef);
    // 带声调符号的拼音
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    // 去掉声调符号
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    // CFStringRef转换为NSString
    NSMutableString *aNSString = (__bridge NSMutableString *)string;
    // 去掉空格
    NSString *finalString = [aNSString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%c", 32] withString:@""];
    return finalString;
}

- (BOOL)MC_isPhoneNum
{
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];
}

- (BOOL)MC_isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)MC_isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)MC_isHaveIllegalChar
{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@":;:[]{}（#%-*+=）\\|~(＜＞$%^&*)+"];
    NSRange range = [self rangeOfCharacterFromSet:doNotWant];
    return range.location<self.length;
}

- (BOOL)MC_isHanZi
{
    NSString *hanziRegex = @"^[\\u4e00-\\u9fa5]{0,}$";
    NSPredicate *hanziTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", hanziRegex];
    return [hanziTest evaluateWithObject:self];
}

- (BOOL)isEmpty
{
    if (self.length == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)MC_price {
    return [NSString stringWithFormat:@"￥%0.2f", self.floatValue];
}

- (BOOL)verifyIDCardNumber
{
    NSString *value = self;
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

+ (NSArray*)rangeOfSubString:(NSString*)subStr inString:(NSString*)string {
    NSMutableArray *rangeArray = [NSMutableArray array];
    NSString*string1 = [string stringByAppendingString:subStr];
    NSString *temp;
    for(int i =0; i < string.length; i ++) {
        temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
        if ([temp isEqualToString:subStr]) {
            NSRange range = {i,subStr.length};
            [rangeArray addObject: [NSValue valueWithRange:range]];
        }
    }
    return rangeArray;
}


//是否含有表情
- (BOOL)MC_isEmoji
{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+ (NSString *)starWithScore:(NSString *)score
{
    NSMutableString *s = [NSMutableString string];
    for (NSInteger i = 0 ; i < [score integerValue]; i++) {
        [s appendString:@"★"];
    }
    if ([score floatValue] > [score integerValue]) {
        [s appendString:@"☆"];
    }
    [s appendFormat:@"  %.1f",[score floatValue]];
    return s;
}

@end
