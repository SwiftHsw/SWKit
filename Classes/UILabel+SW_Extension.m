//
//  UILabel+SW_Extension.m
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

#import "UILabel+SW_Extension.h"
#import "UIView+SW_Extension.h"

@implementation UILabel (SW_Extension)
//获取文本宽
+ (CGFloat)getTextWidth:(UILabel *)lable{
    CGSize newSize = [lable.text boundingRectWithSize:CGSizeMake(MAXFLOAT, lable.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lable.font} context:nil].size;
    
    return newSize.width;
}
//获取文本高
+ (CGFloat)getTextHeight:(UILabel *)lable{
    CGSize newSize = [lable.text boundingRectWithSize:CGSizeMake(lable.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lable.font} context:nil].size;
    return newSize.height;
}
+(UILabel *)labelWithBackgroundColor:(UIColor *)backgrountColor textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines fontSize:(float)size font:(UIFont *)font text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    if (backgrountColor) {
        label.backgroundColor = backgrountColor;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    if (text) {
        label.text = text;
    }
    label.numberOfLines = numberOfLines;
    label.textAlignment = textAlignment;
    if (size>0) {
        label.font = [UIFont systemFontOfSize:size];
    }else
        label.font = font;
        return label;
}


+ (UILabel *)labelWithText:(NSString *)text
                  fontSize:(CGFloat)fontSize
                 textColor:(UIColor*)color
             textAlignment:(NSTextAlignment)textAlignment
                     frame:(CGRect)frame
{
    UILabel *aLabel = [[UILabel alloc] initWithFrame:frame];
    aLabel.font = [UIFont systemFontOfSize:fontSize];
    aLabel.textColor = color;
    aLabel.text = text;
    aLabel.textAlignment = textAlignment;
    if ([text isEqualToString:@"您还未实名认证\n实名后才可以打赏哦~"]) {
        aLabel.numberOfLines = 2;
    }
    return aLabel;
}
+ (id)yy_labelWithText:(NSString *)text
              fontSize:(CGFloat)fontSize
             textColor:(UIColor*)color
         textAlignment:(NSTextAlignment)textAlignment
                 frame:(CGRect)frame
                 block:(void(^)(void))actionBlock{
    
//    YYLabel * yylable = [[YYLabel alloc]initWithFrame:frame];
//    yylable.textAlignment = textAlignment;
//    yylable.text = text;
//    yylable.font = [UIFont systemFontOfSize:fontSize];
//    yylable.textColor = color;
//    [yylable setTextTapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//        actionBlock();
//    }];
    return [UILabel new];
}


@end
