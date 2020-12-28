//
//  NSDate+SW_Extension.h
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

 
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (SW_Extension)
/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)day;
- (NSUInteger)month;
- (NSUInteger)year;
- (NSUInteger)hour;
- (NSUInteger)minute;
- (NSUInteger)second;
+ (NSUInteger)day:(NSDate *)date;
+ (NSUInteger)month:(NSDate *)date;
+ (NSUInteger)year:(NSDate *)date;
+ (NSUInteger)hour:(NSDate *)date;
+ (NSUInteger)minute:(NSDate *)date;
+ (NSUInteger)second:(NSDate *)date;
// 获取格式化为 YYYY年MM月dd日 格式的日期字符串
- (NSString *)formatYMD;
- (NSString *)formatYMDWith:(NSString *)c;
- (NSString *)formatHM;
// 获取星期几
- (NSInteger)weekday;
+ (NSInteger)weekday:(NSDate *)date;
//获取星期几(名称)
- (NSString *)dayFromWeekday;
+ (NSString *)dayFromWeekday:(NSDate *)date;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)dateByAddingDays:(NSUInteger)days;
//获取月份
+ (NSString *)monthWithMonthNumber:(NSInteger)month;
//根据日期返回字符串
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)stringWithFormat:(NSString *)format;
+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format;
//获取指定月份的天数
- (NSUInteger)daysInMonth:(NSUInteger)month;
+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month;
//获取当前月份的天数
- (NSUInteger)daysInMonth;
+ (NSUInteger)daysInMonth:(NSDate *)date;
// 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
- (NSString *)timeInfo;
+ (NSString *)timeInfoWithDate:(NSDate *)date;
+ (NSString *)timeInfoWithDateString:(NSString *)dateString;

//获取当前时间戳 毫秒为单位
+(NSString *)getNowTimeTimestamp3;
//获取YYYYMMDDHHMMSS格式时间
+ (NSString *)getOSSName;
//将某个时间转化成 时间戳
+(NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
//获取当前时分秒
+(NSString*)getCurrentTimes;
@end

NS_ASSUME_NONNULL_END
