//
//  NSDate+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MCExtension)

/**
 根据所给的格式生成一个NSString类型的当前日期

 @param format 日期格式
 @return 当前日期（NSString）
 */
+ (NSString *)MC_currentDateStrWithFormat:(NSString *)format;

/**
 *  日期转字符串
 */
- (NSString *)MC_dateStrWithFormat:(NSString *)format;

/**
 *  把时间戳转成自定义格式的日期字符串
 */
+ (NSString *)MC_dateStrWithTimeStamp:(NSString *)timeStamp format:(NSString *)format;

/**
 某天后的日期

 @param days 天数
 @return NSDate
 */
- (NSDate *)MC_dateAfterDays:(NSInteger)days;

/**
 取年份
 */
- (NSInteger)MC_year;

/**
 取月份
 */
- (NSInteger)MC_month;

/**
 取日期
 */
- (NSInteger)MC_day;

/**
 取小时
 */
- (NSInteger)MC_hour;

/**
 取分钟
 */
- (NSInteger)MC_minute;

@end
