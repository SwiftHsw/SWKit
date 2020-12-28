//
//  UIButton+SW_Extention.h
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

 
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (SW_Extention)

/**UIButton 背景色 默认文字颜色 默认文字 选中文字颜色 选中文字 字体大小 默认背景图片 选中背景图片 图片 选中图片*/
+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor titleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font backgroundImageForNormal:(NSString *)backgroundImageForNormal backgroundImageForSelete:(NSString *)backgroundImageForSelete imageForNormal:(NSString *)imageForNormal imageForSelete:(NSString *)imageForSelete;

 
/**UIButton 默认文字颜色 默认文字 选中文字颜色 选中文字 字体大小 默认背景图片 选中背景图片*/
+(UIButton *)buttonWithTitleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font backgroundImageForNormal:(NSString *)backgroundImageForNormal backgroundImageForSelete:(NSString *)backgroundImageForSelete;

/**UIButton 背景色 默认文字颜色 默认文字 选中文字颜色 选中文字 字体大小 图片 选中图片*/
+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor titleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font imageForNormal:(NSString *)imageForNormal imageForSelete:(NSString *)imageForSelete;

/**UIButton 背景色 默认文字颜色 默认文字 选中文字颜色 选中文字 字体大小*/
+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor titleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font;

/**UIButton 默认背景图片 选中背景图片*/
+(UIButton *)buttonWithBackgroundImageForNormal:(NSString *)backgroundImageForNormal backgroundImageForSelete:(NSString *)backgroundImageForSelete;

/**UIButton 背景色 图片 选中图片*/
+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor imageForNormal:(NSString *)imageForNormal imageForSelete:(NSString *)imageForSelete;


/**快速创建文字按钮 */
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)normalColor hilightedColor:(UIColor *)hilightedColor fontSize:(CGFloat)fontSize frame:(CGRect)frame;

/**快速创建图片按钮 */
+ (UIButton *)buttonWithImage:(UIImage *)image hilightedImage:(UIImage *)hilightedImage frame:(CGRect)frame;
/**快速创建背景图片按钮 */
+ (UIButton *)buttonWithBgImage:(UIImage *)image hilightedBgImage:(UIImage *)hilightedBgImage frame:(CGRect)frame text:(NSString *)text font:(NSInteger)font color:(UIColor *)textColor;


@end

NS_ASSUME_NONNULL_END
