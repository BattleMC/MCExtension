//
//  MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (MCExtension)

#pragma mark - View 相关

/**
 计算字符串高度

 @param width 宽度
 @param font 字体
 @return 高度
 */
- (CGFloat)MC_heightWithContentWidth:(CGFloat)width font:(UIFont *)font;

- (CGFloat)MC_widthWithContentHeight:(CGFloat)height font:(UIFont *)font;

- (CGSize)MC_sizeWithFontSize:(CGFloat)fontSize;

/**
 阿拉伯数字转中文
 */
+ (NSString *)MC_translation:(NSString *)arebic;

#pragma mark - 日期相关

/**
 时间戳转日期 NSString

 @param format 日期格式
 @return 日期
 
*/
- (NSString *)MC_dateTimeWithLonglongTimeFormat:(NSString *)format;

/**
 日期转换格式

 @param fromFormat 源格式
 @param toFormat 目的格式
 @return 转换后的时间
 */
- (NSString *)MC_dateStringFromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat;

/**
 时间戳转时间间隔

 @return 时间间隔
 */
- (NSString *)MC_timeInterval;


/**
 时间戳转时间间隔，只精确到天数

 @return 时间间隔
 */
- (NSString *)MC_dayTimeInterval;

/**
 时间转换为剩余时间，精确到天
 
 @return 剩余时间
 */
- (NSString *)MC_timeRemain;


/**
 NSString 转 NSDate

 @param format 日期格式
 @return NSDate
 */
- (NSDate *)MC_convertToDateWithFormat:(NSString *)format;

/**
 返回一个字符串的时间距离 eg:10分钟前 / 1小时前
 
 @param longLongTime 时间戳
 @return 时间戳距当前时间的距离
 */
+ (NSString *)MC_distanceWithTime:(NSString *)longLongTime;


#pragma mark - 进制相关

/**
　十进制转十六进制

 @param denary 十进制整型
 @param length 十六进制长度
 @return 十六进制字符串
 */
- (instancetype)MC_hexStringWithDenary:(NSInteger)denary formatLength:(NSInteger)length;

/**
 十六进制字符串转补码
 */
- (instancetype)MC_complementHexString;

#pragma mark - 加密 / 解码 相关

/**
 MD5 加密
 
 @return MD5 String
 */
- (NSString *)MC_md5;

/**
 解码url编码

 @return 解码后的字符串
 */
- (NSString *)MC_decodeFromPercentEscapeString;

#pragma mark - 文件操作相关

/**
 把比特数转为需要的内存表现形式

 @param fileByteSize 比特数
 @return 表示内存的字符串
 */
+ (instancetype)MC_fileSizeToString:(unsigned long long)fileByteSize;


#pragma mark - 文本相关

/**
 格式化字符串，并过滤格式化后的字符串中的(null)

 @param format 格式
 @return 格式化后，过滤掉@"(null)"的字符串
 */
+ (instancetype)MC_stringWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 获得拼音

 @return 拼音字符串
 */
- (NSString *)MC_pinYin;

#pragma mark - 验证合法性相关

/**
 是否正确电话号码 (中国大陆)

 @return  YES/NO
 */
- (BOOL)MC_isPhoneNum;

/**
 是否正确 Email格式

 @return  YES/NO
 */
- (BOOL)MC_isEmail;

/**
 是否纯数字

 @return  YES/NO
 */
- (BOOL)MC_isPureInt;

/**
 是否纯汉字

 @return YES/NO
 */
- (BOOL)MC_isHanZi;

/**
 是否含有特殊字符

 @return YES/NO
 */
- (BOOL)MC_isHaveIllegalChar;

/**
 判空

 @return YES/NO
 */
- (BOOL)isEmpty;

/**
 价格，格式 (￥9.99)

 @return 价格
 */
- (NSString *)MC_price;

/**
 是否是身份证号码

 @return BOOL
 */
- (BOOL)verifyIDCardNumber;


/**
 搜索字串

 @param subStr 子串
 @param string 父串
 @return 所有位置(NSValue(NSRange))
 */
+ (NSArray*)rangeOfSubString:(NSString*)subStr inString:(NSString*)string;

/** 判断Emoji */
- (BOOL)MC_isEmoji;


/**
 分数星星
*/
+ (NSString *)starWithScore:(NSString *)score;

@end
