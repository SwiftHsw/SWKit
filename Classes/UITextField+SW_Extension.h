//
//  UITextField+Extension.m
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UITextFieldLimitHandler)(void);


@interface UITextField (SW_Extension)

@property (nonatomic , strong) UIColor * _Nullable placeholdColor;

@property (nonatomic , strong) UIFont * _Nullable placeholdFont;

/**
 限制输入框文本的长度
 */
+(NSInteger)sw_limitTextField:(UITextField *_Nonnull)textField
               limitNumber:(NSInteger)number
             limitHandeler:(_Nullable UITextFieldLimitHandler)limitHandeler;

@end

NS_ASSUME_NONNULL_END
