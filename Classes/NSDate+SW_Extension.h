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

#pragma mark 1、秒的字符串转化为 00:00:00 或者 00:00
/**
 秒的字符串转化为 00:00:00 或者 00:00 的时间格式，一般用于音视频显示时间

 @param second 秒的字符串
 @param timeType 1：00:00:00；
                 2：00:00
 @return 返回转换后的字符串
 */
+(NSString *)convertHourMinuteSecondTime:(NSString *)second withTimeType:(NSString *)timeType;

#pragma mark 2、自定义的时间戳字符串转时间字符串
/**
 自定义的时间戳字符串转时间字符串

 @param timestamp 时间戳字符串
 @param dateFormat 要的格式，如：yyyy-MM-dd HH:mm:ss、yyyy年MM月dd日，完全自定义
 @return 返回转换后的格式
 */
+(NSString *)convertTimestamp:(NSString *)timestamp withDateFormat:(NSString *)dateFormat;

#pragma mark 3、自定义的时间戳字符串转时间字符串(判断是否是今年)
/**
 自定义的时间戳字符串转时间字符串(判断是否是今年)

 @param timestamp 时间戳字符串
 @param dateFormat 要的格式，如：-MM-dd HH:mm:ss、年MM月dd日，完全自定义；提示：格式不要带有年
 @return 返回转换后的格式：yyyy-MM-dd HH:mm:ss或者MM-dd HH:mm:ss
 */
+(NSString *)convertJudgeYearTimestamp:(NSString *)timestamp withDateFormat:(NSString *)dateFormat;

#pragma mark 4、时间戳字符串转固定格式的时间
/**
 时间戳字符串转固定格式的时间

 @param timestamp 时间戳字符串
 @param dateType 1：2018 12/04；
                 2：2018 12/04 4:50；
                 3：2018-12-04
                 4：2018-12-04 16:57
                 不属于上面的类型的格式：2018-12-04 16:57
 @return 返回转换后的格式
 */
+(NSString *)convertTimestamp:(NSString *)timestamp withDateType:(NSString *)dateType withJudgeYear:(BOOL)judgeYear;

#pragma mark 5、自定义NSDate类型的时间转 格式时间的字符串
/**
 NSDate类型的时间转 格式时间的字符串

 @param date NSDate类型的时间
 @param dateFormat 要的格式，如：yyyy-MM-dd HH:mm:ss、yyyy年MM月dd日，完全自定义
 @return 返回转换后的格式
 */
+(NSString *)convertDate:(NSDate *)date withDateFormat:(NSString *)dateFormat;

#pragma mark 6、自定义NSDate类型的时间转 格式时间的字符串(判断是否是今年)
/**
 自定义NSDate类型的时间转 格式时间的字符串

 @param date NSDate类型的时间
 @param dateFormat -MM-dd HH:mm:ss、年MM月dd日，完全自定义；提示：格式不要带有年
 @return 返回转换后的格式: yyyy-MM-dd HH:mm:ss或者MM-dd HH:mm:ss
 */
+(NSString *)convertJudgeYearDate:(NSDate *)date withDateFormat:(NSString *)dateFormat;

#pragma mark 7、NSDate类型的时间转固定格式的时间
/**
 时间戳字符串转固定格式的时间

 @param date NSDate类型的时间
 @param dateType 1：2018 12/04；
 2：2018 12/04 4:50；
 3：2018-12-04
 4：2018-12-04 16:57
 不属于上面的类型的格式：2018-12-04 16:57
 @param judgeYear 是否判断年份
 @return 返回转化后的字符串
 */
+(NSString *)convertDate:(NSDate *)date withDateType:(NSString *)dateType withJudgeYear:(BOOL)judgeYear;

#pragma mark 8.1、时间差转多久之前
/**
 时间差转多久之前
 
 @param timestamp 时间戳
 @return 多久之前
 */
+ (NSString *)sw_time1TurnStringTimestamp:(NSString *)timestamp;

#pragma mark 8.2、时间差转多久之前
/**
 时间差转多久之前
 
 @param timestamp 时间戳
 @return 多久之前
 */
+ (NSString *)sw_time2TurnStringTimestamp:(NSString *)timestamp;

#pragma mark 9、剩余多少天
/**
 剩余多少天
 
 @param seconds 秒
 @return 剩余
 */
+ (NSString *)sw_laveTimeTurnString:(NSInteger)seconds;

#pragma mark 10、时间戳转年龄
/**
 时间戳转年龄
 
 @param timestamp 时间戳
 @return 年龄
 */
+ (NSString *)sw_ageConstellationWithStamp:(NSString *)timestamp;

#pragma mark 11、根据时间戳转星座
/**
 根据时间戳转星座

 @param timestamp 时间戳
 @return 星座
 */
+ (NSString *)sw_calculateConstellationWithStamp:(NSString *)timestamp;

#pragma mark 12、根据生日计算星座
/**
 根据生日计算星座

 @param month 月份
 @param day 日期
 @return 星座名称
 */
+(NSString *)sw_calculateConstellationWithMonth:(NSInteger)month day:(NSInteger)day;

#pragma mark 13、秒数转时间 xx:xx:xx
/**
 秒数转时间 xx:xx:xx
 
 @param seconds 秒数
 @return return value description
 */
+ (NSString *)sw_numberOfSecondsTurnString:(NSInteger)seconds;

#pragma mark 14.获取当月的天数
+(NSInteger)getNumberOfDaysInCurrentMonth;

#pragma mark 15.字符串转时间戳
/**
 字符串转时间戳

 @param timeStr 时间格式的字符串，如：2019-04-28 14:27:45
 @param format 时间格式，如：YYYY-MM-dd HH:mm:ss
 @return 返回时间戳的字符串，如上面返回：1556432865
 */
+(NSInteger)sw_cTimestampFromString:(NSString *)timeStr
                          format:(NSString *)format;

#pragma mark 16.获取本月1号的的：00：00：00 的时间戳
/**
 获取本月1号的的：00：00：00 的时间戳

 @return 返回：时间戳
 */
+(long)getNowMonthOneDayZeroTimeStamp;

#pragma mark 17.获取本周周一的：00：00：00 的时间戳
/**
 获取本周周一的：00：00：00 的时间戳

 @return 返回：时间戳
 */
+(long)getNowWeekMondayZeroTimeStamp;

#pragma mark 18.获取当天：00：00：00 的时间戳
/**
 获取当天：00：00：00 的时间戳

 @return 返回：时间戳
 */
+(long)getTodayZeroTimeStamp;

#pragma mark 19.获取某一天是星期几

/**
 获取某一天是星期几

 @param timeStamp 传进来时间戳
 @return 返回：周一、周二......
 */
+(NSString *)getWeekDayForDateTimeStamp:(NSTimeInterval)timeStamp;

#pragma mark 20.获取某一个时间的零点：00：00：00 的时间戳

/**
 获取某一个时间的零点：00：00：00 的时间戳

 @param date 时间
 @return 返回当个时间的时间戳
 */
+(NSTimeInterval)getTimeStamp:(NSDate *)date;

#pragma mark 21.获取当前时间戳有两种方法(以秒为单位)
+(NSString *)sw_getNowTimeTimestamp;
@end

NS_ASSUME_NONNULL_END
