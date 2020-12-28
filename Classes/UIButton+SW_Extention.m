//
//  UIButton+SW_Extention.m
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

#import "UIButton+SW_Extention.h"

 
@implementation UIButton (SW_Extention)
+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor titleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font backgroundImageForNormal:(NSString *)backgroundImageForNormal backgroundImageForSelete:(NSString *)backgroundImageForSelete imageForNormal:(NSString *)imageForNormal imageForSelete:(NSString *)imageForSelete
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (backgrountColor) {
        [button setBackgroundColor:backgrountColor];
    }
    if (titleForNormal) {
        [button setTitle:titleForNormal forState:0];
    }
    if (titleForSelete) {
        [button setTitle:titleForSelete forState:UIControlStateSelected];
    }
    if (titleColorForNormal) {
        [button setTitleColor:titleColorForNormal forState:0];
    }
    if (titleColorForSelete) {
        [button setTitleColor:titleColorForSelete forState:UIControlStateSelected];
    }
    if (size>0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }else
        button.titleLabel.font = font;
        if (backgroundImageForNormal) {
            [button setBackgroundImage: [UIImage imageNamed:backgroundImageForNormal] forState:0];
        }
    if (backgroundImageForSelete) {
        [button setBackgroundImage: [UIImage imageNamed:backgroundImageForSelete] forState:UIControlStateSelected];
    }
    if (imageForNormal) {
        [button setImage: [UIImage imageNamed:imageForNormal] forState:0];
    }
    if (imageForSelete) {
        [button setImage: [UIImage imageNamed:imageForSelete] forState:UIControlStateSelected];
    }
    return button;
}

+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor titleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font imageForNormal:(NSString *)imageForNormal imageForSelete:(NSString *)imageForSelete
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (backgrountColor) {
        [button setBackgroundColor:backgrountColor];
    }
    if (titleForNormal) {
        [button setTitle:titleForNormal forState:0];
    }
    if (titleForSelete) {
        [button setTitle:titleForSelete forState:UIControlStateSelected];
    }
    if (titleColorForNormal) {
        [button setTitleColor:titleColorForNormal forState:0];
    }
    if (titleColorForSelete) {
        [button setTitleColor:titleColorForSelete forState:UIControlStateSelected];
    }
    if (size>0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }else
        button.titleLabel.font = font;
        if (imageForNormal) {
            [button setImage: [UIImage imageNamed:imageForNormal] forState:0];
        }
    if (imageForSelete) {
        [button setImage: [UIImage imageNamed:imageForSelete] forState:UIControlStateSelected];
    }
    return button;
}


+(UIButton *)buttonWithTitleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font backgroundImageForNormal:(NSString *)backgroundImageForNormal backgroundImageForSelete:(NSString *)backgroundImageForSelete
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (titleForNormal) {
        [button setTitle:titleForNormal forState:0];
    }
    if (titleForSelete) {
        [button setTitle:titleForSelete forState:UIControlStateSelected];
    }
    if (titleColorForNormal) {
        [button setTitleColor:titleColorForNormal forState:0];
    }
    if (titleColorForSelete) {
        [button setTitleColor:titleColorForSelete forState:UIControlStateSelected];
    }
    if (size>0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }else
        button.titleLabel.font = font;
        if (backgroundImageForNormal) {
            [button setBackgroundImage: [UIImage imageNamed:backgroundImageForNormal] forState:0];
        }
    if (backgroundImageForSelete) {
        [button setBackgroundImage: [UIImage imageNamed:backgroundImageForSelete] forState:UIControlStateSelected];
    }
    return button;
}

+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor titleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (titleForNormal) {
        [button setTitle:titleForNormal forState:0];
    }
    if (titleForSelete) {
        [button setTitle:titleForSelete forState:UIControlStateSelected];
    }
    if (titleColorForNormal) {
        [button setTitleColor:titleColorForNormal forState:0];
    }
    if (titleColorForSelete) {
        [button setTitleColor:titleColorForSelete forState:UIControlStateSelected];
    }
    if (size>0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }else
        button.titleLabel.font = font;
        if (backgrountColor) {
            [button setBackgroundColor:backgrountColor];
        }
    return button;
}

+(UIButton *)buttonWithBackgroundImageForNormal:(NSString *)backgroundImageForNormal backgroundImageForSelete:(NSString *)backgroundImageForSelete
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (backgroundImageForNormal) {
        [button setBackgroundImage: [UIImage imageNamed:backgroundImageForNormal] forState:0];
    }
    
    if (backgroundImageForSelete) {
        [button setBackgroundImage: [UIImage imageNamed:backgroundImageForSelete] forState:UIControlStateSelected];
    }
    
    return button;
}

+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor imageForNormal:(NSString *)imageForNormal imageForSelete:(NSString *)imageForSelete
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (backgrountColor) {
        [button setBackgroundColor:backgrountColor];
    }
    if (imageForNormal) {
        [button setImage: [UIImage imageNamed:imageForNormal] forState:0];
    }
    
    if (imageForSelete) {
        [button setImage: [UIImage imageNamed:imageForSelete] forState:UIControlStateSelected];
    }
    
    return button;
}
+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)normalColor
               hilightedColor:(UIColor *)hilightedColor
                     fontSize:(CGFloat)fontSize
                        frame:(CGRect)frame
{
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [aButton setTitle:title forState:UIControlStateNormal];
    [aButton setTitleColor:normalColor forState:UIControlStateNormal];
    if (hilightedColor) {
        [aButton setTitleColor:hilightedColor forState:UIControlStateHighlighted];
    }
    aButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    aButton.frame = frame;
    return aButton;
}

+ (UIButton *)buttonWithImage:(UIImage *)image
               hilightedImage:(UIImage *)hilightedImage
                        frame:(CGRect)frame
{
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setImage:image forState:UIControlStateNormal];
    if (hilightedImage) {
        [aButton setImage:hilightedImage forState:UIControlStateHighlighted];
    }
    aButton.frame = frame;
    return aButton;
}


+ (UIButton *)buttonWithBgImage:(UIImage *)image hilightedBgImage:(UIImage *)hilightedBgImage frame:(CGRect)frame text:(NSString *)text font:(NSInteger)font color:(UIColor *)textColor
{
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setBackgroundImage:image forState:UIControlStateNormal];
    if (hilightedBgImage) {
        [aButton setBackgroundImage:hilightedBgImage forState:UIControlStateHighlighted];
        [aButton setBackgroundImage:hilightedBgImage forState:UIControlStateSelected];
    }
    if (text) {
        [aButton setTitle:text forState:UIControlStateNormal];
        [aButton setTitleColor:textColor forState:UIControlStateNormal];
    }
    if (font) {
        aButton.titleLabel.font = [UIFont systemFontOfSize:font];
    }
    aButton.frame = frame;
    return aButton;
}
@end
