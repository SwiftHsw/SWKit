//
//  UILabel+SW_Extension.h
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

 
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (SW_Extension)
 //获取文本宽
+ (CGFloat)getTextWidth:(UILabel *)lable;
//获取文本高
+ (CGFloat)getTextHeight:(UILabel *)lable;


/**label 背景色 字体颜色 对齐方式 行数 字体大小 文字*/
+(UILabel *)labelWithBackgroundColor:(UIColor *)backgrountColor
                           textColor:(UIColor *)textColor
                       textAlignment:(NSTextAlignment)textAlignment
                       numberOfLines:(NSInteger)numberOfLines
                            fontSize:(float) size
                                font:(UIFont *)font
                                text:(NSString *)text;



+ (UILabel *)labelWithText:(NSString *)text
                  fontSize:(CGFloat)fontSize
                 textColor:(UIColor*)color
             textAlignment:(NSTextAlignment)textAlignment
                     frame:(CGRect)frame;



+ (id)yy_labelWithText:(NSString *)text
                     fontSize:(CGFloat)fontSize
                    textColor:(UIColor*)color
                textAlignment:(NSTextAlignment)textAlignment
                        frame:(CGRect)frame
                        block:(void(^)(void))actionBlock;

@end

NS_ASSUME_NONNULL_END
