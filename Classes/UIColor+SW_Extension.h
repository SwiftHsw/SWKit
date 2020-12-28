//
//  UIColor+SW_Extension.h
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//


 #pragma mark -
 #pragma mark -颜色工具(包含16进制，RGB颜色，随机颜色)

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (SW_Extension)

//传入16进制字符 比如@"#FFF000" 返回一个颜色值
+ (UIColor *)colorWithHexString:(NSString *)color;
//传入16进制字符 比如@"#FFF000" 可设置透明度 返回一个颜色值
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
//获取随机颜色值 一般用于测试UI布局控件
+ (UIColor *)randomColor;
//获取随机颜色值 一般用于测试UI布局控件 可设置透明度
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;
 


@end

NS_ASSUME_NONNULL_END
