//
//  NSDate+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "NSDate+MCExtension.h"

@implementation NSDate (MCExtension)

+ (NSString *)MC_currentDateStrWithFormat:(NSString *)format
{
    NSString *date;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:format];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    date = [fmt stringFromDate:[NSDate date]];
    NSString *str = [NSString stringWithFormat:@"%@",date];
    return str;
}

- (NSString *)MC_dateStrWithFormat:(NSString *)format
{
    NSString *date;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:format];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    date = [fmt stringFromDate:self];
    NSString *str = [NSString stringWithFormat:@"%@",date];
    return str;
}

+ (NSString *)MC_dateStrWithTimeStamp:(NSString *)timeStamp format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]]];
    
    return dateStr;
}

- (NSDate *)MC_dateAfterDays:(NSInteger)days
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:days];
    NSDate *date = [calendar dateByAddingComponents:comps toDate:self options:0];
    return date;
}


/**
 取年份
 */
- (NSInteger)MC_year
{
    NSDate  *currentDate = self;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    
    NSInteger year=[components year];
    return year;
}

/**
 取月份
 */
- (NSInteger)MC_month
{
    NSDate  *currentDate = self;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:currentDate];
    
    NSInteger month=[components month];
    return month;
}

/**
 取日期
 */
- (NSInteger)MC_day
{
    NSDate  *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:currentDate];
    
    NSInteger day=[components day];
    return day;
}

/**
 取小时
 */
- (NSInteger)MC_hour
{
    NSDate  *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:currentDate];
    
    NSInteger day=[components hour];
    return day;
}

/**
 取分钟
 */
- (NSInteger)MC_minute
{
    NSDate  *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:currentDate];
    
    NSInteger day=[components minute];
    return day;
}

@end
