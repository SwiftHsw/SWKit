//
//  NSString+SW_Encryption.h
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

 
#import <Foundation/Foundation.h>
#import "SWKit.h"




NS_ASSUME_NONNULL_BEGIN

@interface NSString (SW_Extension)

#pragma mark -
#pragma mark - 字符串加密工具

//配置AfferentString 传入需要操作的字符串

+ (NSString *) md5:(NSString *)AfferentString;

+ (NSString *) sha1:(NSString *)AfferentString;

+ (NSString *) sha1_base64:(NSString *)AfferentString;

+ (NSString *) md5_base64:(NSString *)AfferentString;

+ (NSString *) base64:(NSString *)AfferentString;


#pragma mark -
#pragma mark - 其他

/* 手机号 *** 隐藏部分 */
+ (NSString *)getHiddenStringWithStar:(NSString *)string;
 
//获取文字自适应
+ (CGFloat)widthForSingleLineString:(NSString *)text font:(UIFont *)font;

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstPinyinLetterOfString:(NSString *)aString;

//获取拼音
+ (NSString *)pinyinOfString:(NSString *)aString;

//计算k&M 千万单位
+ (NSString *)sizeStringWithStyle:(nullable id)style size:(long long)size;

//获取文字自适应
+ (CGSize)boundingSizeForText:(NSString *)text
                     maxWidth:(CGFloat)maxWidth
                         font:(UIFont *)font
                  lineSpacing:(CGFloat)lineSpacing;

+ (NSMutableAttributedString *)highlightDefaultDataTypes:(NSMutableAttributedString *)attributedString;

//获取富文本高
+ (NSInteger)hideLabelLayoutHeight:(NSString *)content
                  withTextFontSize:(CGFloat)mFontSize
                       lineSpacing:(CGFloat)spac;
//获取随机字符串
+ (NSString *)getRandomString;


//获取APP 名称
+ (NSString *)appName;

//获取APP Scheme
+ (NSString *)getApplicationScheme;

//设备型号名称
+ (NSString *)deviceModelName;

/** 字节大小转换 */
+ (NSString*)formatSizeFromByte:(long long)bytes;

/** 时长转换 */
+ (NSString *)convertDurationToString:(NSTimeInterval)duration;



#pragma mark - 手机信息
//设备名称
+ (NSString *)deviceName;

//设备类型
+ (NSString *)deviceModel;

//系统名称
+ (NSString *)deviceSystemName;

//系统版本号
+ (NSString *)deviceSystemVersion;

//设备当前使用语言
+ (NSString *)deviceCurrentLanguage;

//设备当前电量
+ (int)deviceBatteryValue;

//设备分辨率
+ (CGSize)deviceResolution;

//设备显示缩放率
+ (CGFloat)deviceScreenScale;

//系统版本
+ (NSString *)systemVersion;

//系统版本，返回float类型
+ (CGFloat)IOSVersion;

@end

NS_ASSUME_NONNULL_END
