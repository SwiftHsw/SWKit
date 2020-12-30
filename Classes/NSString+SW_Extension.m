//
//  NSString+SW_Encryption.m
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

#import "NSString+SW_Extension.h"
 //配置
#define URL_MAIL_SCHEME @"mailto"
#define URL_HTTP_SCHEME @"http"
#define URL_HTTPS_SCHEME @"https"
#define kSWTextLinkColor [UIColor redColor]


@implementation NSString (SW_Extension)


#pragma mark - 字符加密工具
+ (NSString*) sha1:(NSString *)AfferentString{
    const char *cstr = [AfferentString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:AfferentString.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}
+ (NSString *) md5 :(NSString *)AfferentString{
    const char *cStr = [AfferentString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}
+ (NSString *) sha1_base64:(NSString *)AfferentString {
    const char *cstr = [AfferentString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:AfferentString.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    NSString* encodeResult = [base64 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodeResult;
}
+ (NSString *) md5_base64 :(NSString *)AfferentString{
    const char *cStr = [AfferentString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    NSString* encodeResult = [base64 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodeResult;
}

+ (NSString *) base64 :(NSString *)AfferentString{
    NSData * data = [AfferentString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString* encodeResult = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodeResult;
}


+ (NSString *)getHiddenStringWithStar:(NSString *)string{
    
    if (string.length>1) {
        
        if (string.length>=11) {
            return [NSString stringWithFormat:@"%@****%@",[string substringToIndex:3],[string substringFromIndex:string.length-4]];
        }
        else
        {
            NSString *replacString;
            for (int i=0; i<string.length; i++) {
                
                if (i<string.length-1) {
                    if (replacString.length>0 && replacString!=nil) {
                        replacString = [replacString stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
                    }
                    else
                        replacString = [string stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
                }
            }
            return replacString;
        }
    }
    else
    {
        return string;
    }
}
+ (CGFloat)widthForSingleLineString:(NSString *)text font:(UIFont *)font {
    
    CGRect rect = [text
                   boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                   options:0
                   attributes:@{NSFontAttributeName:font}
                   context:nil];
    return rect.size.width;
    
}


//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstPinyinLetterOfString:(NSString *)aString
{
    if (aString.length == 0)
        return nil;
    
    //首字符就是字母
    unichar C = [aString characterAtIndex:0];
    if((C<= 'Z' && C>='A') || (C <= 'z' && C >= 'a')) {
        //转化为大写拼音
        NSString *pinYin = [[aString substringToIndex:1] capitalizedString];
        //获取并返回首字母
        return pinYin;
    }
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:[aString substringToIndex:1]];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstPinyinCharactorOfString:(NSString *)aString
{
    if (aString.length == 0)
        return nil;
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:[aString substringToIndex:1]];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return pinYin;
}


//获取拼音
+ (NSString *)pinyinOfString:(NSString *)aString
{
    if (aString.length == 0)
        return nil;
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return pinYin;
}



+ (NSMutableAttributedString *)highlightDefaultDataTypes:(NSMutableAttributedString *)attributedString {
    
    NSError *error;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber | NSTextCheckingTypeLink
                                                               error:&error];
    NSArray *matches = [detector matchesInString:attributedString.string
                                         options:kNilOptions
                                           range:NSMakeRange(0, [attributedString length])];
    
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        BOOL shouldHighlight = NO;
        
        if ([match resultType] == NSTextCheckingTypeLink) {
            NSURL *url = [match URL];
            if ([url.scheme isEqualToString:URL_MAIL_SCHEME] ||
                [url.scheme isEqualToString:URL_HTTP_SCHEME] ||
                [url.scheme isEqualToString:URL_HTTPS_SCHEME]) {
                shouldHighlight = YES;
            }
        }else if ([match resultType] == NSTextCheckingTypePhoneNumber) {
            shouldHighlight = YES;
        }
        
        if (shouldHighlight) {
            [attributedString addAttribute:NSForegroundColorAttributeName value:kSWTextLinkColor range:matchRange];
        }
        
    }
    
    return attributedString;
}

+ (CGSize)boundingSizeForText:(NSString *)text maxWidth:(CGFloat)maxWidth font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    CGSize calSize = CGSizeMake(maxWidth, MAXFLOAT);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = lineSpacing;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName: paragraphStyle
                                 };
    
    
    CGRect rect = [text boundingRectWithSize:calSize
                                     options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    
    return rect.size;
}


+ (NSString *)sizeStringWithStyle:(id)style size:(long long)size {
    if (size < 1024 * 1024) {
        return [NSString stringWithFormat:@"%ldK", (long)size/1024];
    }else {
        return [NSString stringWithFormat:@"%.1fM", size/(1024 * 1024.0)];
    }
}


+ (NSInteger)hideLabelLayoutHeight:(NSString *)content withTextFontSize:(CGFloat)mFontSize lineSpacing:(CGFloat)spac
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = spac;  // 段落高度

    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:content];
    
    [attributes addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:mFontSize] range:NSMakeRange(0, content.length)];
    [attributes addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
    
    CGSize attSize = [attributes boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-54, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    return attSize.height;
}

+ (NSString *)getRandomString
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

+(NSString *)getApplicationScheme{
    NSDictionary *bundleInfo    = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier  = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *URLTypes           = [bundleInfo valueForKey:@"CFBundleURLTypes"];
    
    NSString *scheme;
    for (NSDictionary *dic in URLTypes)
    {
        NSString *URLName = [dic valueForKey:@"CFBundleURLName"];
        if ([URLName isEqualToString:bundleIdentifier])
        {
            scheme = [[dic valueForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
            break;
        }
    }
    
    return scheme;
}
+(NSString *)appName{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
}

+ (NSString*)devicePlatformVersion
{
    size_t size;
    sysctlbyname("hw.machine",NULL, &size, NULL,0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size,NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}
+ (NSString *)deviceModelName
{
    NSString *platform = [self devicePlatformVersion];
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 1";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4s";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])  return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 Plus";
      if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
      if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
      if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
      if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
      if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
      if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
      if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
      if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
      if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
      if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
      if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    //iPot Touch
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5";
    //iPad
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad air";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad air";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad air";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad air 2";
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad air 2";
    if ([platform isEqualToString:@"iPhone Simulator"] || [platform isEqualToString:@"x86_64"] || [platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    return platform;
}


#pragma mark -- 字节大小转换

+ (NSString*)formatSizeFromByte:(long long)bytes{
    int multiplyFactor = 0;
    double convertedValue = bytes;
    NSArray *tokens = [NSArray arrayWithObjects:@"B",@"KB",@"MB",@"GB",@"TB",nil];
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    return [NSString stringWithFormat:@"%4.1f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}

#pragma mark -- 时长转换

+ (NSString *)convertDurationToString:(NSTimeInterval)duration{
    NSInteger hour = duration / 3600;
    NSInteger minute = (duration - hour*3600) / 60;
    NSInteger seconds = (duration - hour *3600 - minute*60);
    NSString *strDuration  = @"";
    
    strDuration = [NSString stringWithFormat:@"%02ld:",hour];
    strDuration = [strDuration stringByAppendingFormat:@"%02ld:",minute];
    strDuration = [strDuration stringByAppendingFormat:@"%02ld",seconds];
    return strDuration;
}

#pragma mark - 设备信息

+ (NSString *)deviceModel
{
    return [[UIDevice currentDevice] model];
}

+ (NSString *)deviceName
{
    return [[UIDevice currentDevice] name];
}

+ (NSString *)deviceSystemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)deviceSystemName
{
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)deviceCurrentLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    
    NSString *curLanguage = [languages objectAtIndex:0];
    
    return curLanguage;
}

+ (int)deviceBatteryValue
{
    return [[UIDevice currentDevice] batteryLevel]*100;
}

+ (CGSize)deviceResolution
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    return CGSizeMake(screenSize.width*scale, screenSize.height*scale);
}

+ (CGFloat)deviceScreenScale
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    return scale;
    
}

+ (NSString *)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (CGFloat)IOSVersion
{
    return [[self systemVersion] floatValue];
}

@end
