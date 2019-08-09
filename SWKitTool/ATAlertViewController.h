//
//  ATAlertViewController.h
//  云付通
//
//  Created by 陈俏俊 on 2017/8/18.
//  Copyright © 2017年 陈俏俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum{
    ATAlertButtonStyleOK,  // 确定
    ATAlertButtonStyleCancel // 取消
} ATAlertButtonStyle;

@interface ATAlertViewController : NSObject

/** 只有一个取消按钮时，传otherButtonTitle参数，cancelButtonTitle传nil */
+ (void)showInController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButtonTitle other:(NSString *)otherButtonTitle completionHandler:(void (^)(ATAlertButtonStyle buttonStyle))block;

@end
