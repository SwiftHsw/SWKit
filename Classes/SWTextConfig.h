//
//  SWTextConfig.h
//  CustomSWkitPod
//
//  Created by 黄世文 on 2021/12/15.
//  Copyright © 2021 黄世文. All rights reserved.
//

#import "UIColor+SW_Extension.h"
#import "UIView+SW_Extension.h"


//颜色
UIKIT_STATIC_INLINE UIColor * SWColor(NSString *colroStr)
{
    return [UIColor colorWithHexString:colroStr];
}

//随机色
UIKIT_STATIC_INLINE UIColor * SWRandomColor()
{
    return [UIColor randomColor];
}

//宽度适配
UIKIT_STATIC_INLINE CGFloat SWAuto(CGFloat width)
{
    if (SCREEN_WIDTH > 600)
    {
        return ((width / 375.0) * 415.0);
    }else{
        return ((width / 375.0) * SCREEN_WIDTH);
    }
}

//适配文字Font
UIKIT_STATIC_INLINE NSUInteger adaptSize(NSUInteger fontSize)
{
    return SWAuto(fontSize);
}

//平方细体Font适配
UIKIT_STATIC_INLINE UIFont * SWFont_Light(NSUInteger fontSize)
{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Light" size:adaptSize(fontSize)];
    if (!font)
    {
        font = [UIFont systemFontOfSize:fontSize weight:0.5];
    }
    return font;
}


//中粗体Font适配
UIKIT_STATIC_INLINE UIFont * SWFont_Semibold(NSUInteger fontSize)
{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:adaptSize(fontSize)];
    if (!font)
    {
        font = [UIFont systemFontOfSize:fontSize weight:2];
    }
    return font;
}

//常规体Font适配
UIKIT_STATIC_INLINE UIFont * SWFont_Regular(NSUInteger fontSize)
{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:adaptSize(fontSize)];
    if (!font)
    {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}

//中黑体Font适配
UIKIT_STATIC_INLINE UIFont * SWFont_Medium(NSUInteger fontSize)
{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:adaptSize(fontSize)];
    if (!font)
    {
        font = [UIFont boldSystemFontOfSize:fontSize];
    }
    return font;
}

//中黑体Font适配
UIKIT_STATIC_INLINE UIFont * SWFont_Bold(NSUInteger fontSize)
{
    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Bold" size:adaptSize(fontSize)];
    if (!font)
    {
        font = [UIFont boldSystemFontOfSize:fontSize];
    }
    return font;
}
//画圆角
UIKIT_STATIC_INLINE CAShapeLayer * shaperOLayer(CGFloat width , CGFloat height)
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(1, 1, width-2, height - 2) cornerRadius:(height - 2) * 0.5];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    return layer;
}
//清除空值
UIKIT_STATIC_INLINE NSString * SWString(NSString *str)
{
    return [NSString stringWithFormat:@"%@",str];
}
//整型转字符串
UIKIT_STATIC_INLINE NSString * SWIString(NSInteger f)
{
    return [NSString stringWithFormat:@"%ld",(long)f];
}

//浮点转字符串
UIKIT_STATIC_INLINE NSString * SWFString(CGFloat f)
{
    return [NSString stringWithFormat:@"%.2lf",f];
}
//转NSURL
UIKIT_STATIC_INLINE NSURL * SWUrl(NSString *str)
{
    return [NSURL URLWithString:SWString(str)];
}
