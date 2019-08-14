
//
//  ATAlertViewController.m
//  云付通
//
//  Created by 陈俏俊 on 2017/8/18.
//  Copyright © 2017年 陈俏俊. All rights reserved.
//

#import "SWAlertViewController.h"
#import "SWKit.h"
@implementation SWAlertViewController

+ (void)showInController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButtonTitle other:(NSString *)otherButtonTitle completionHandler:(void (^)(SWAlertButtonStyle buttonStyle))block;
{
    
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentLeft;
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[SWKit colorWithHexString:@"#111111"] range:NSMakeRange(0, alertControllerMessageStr.length)];
    [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:26/2] range:NSMakeRange(0,alertControllerMessageStr.length)];
    [alertCtr setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    if (cancelButtonTitle.length) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [MBProgressHUD hideAllHUDsForView:[ATGeneralFuncUtil getCurrentVC].view animated:YES];
            if (block) {
                [viewController setNeedsStatusBarAppearanceUpdate];
                block(SWAlertButtonStyleCancel);
            }
        }];
 
        [cancelAction setValue:[UIColor grayColor] forKey:@"titleTextColor"];
        [alertCtr addAction:cancelAction];
        if (otherButtonTitle.length) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [MBProgressHUD hideAllHUDsForView:[ATGeneralFuncUtil getCurrentVC].view animated:YES];
                if (block) {
                    [viewController setNeedsStatusBarAppearanceUpdate];
                    block(SWAlertButtonStyleOK);
                }
            }];
            [otherAction setValue:[SWKit colorWithHexString:@"#111111"] forKey:@"titleTextColor"];
            [alertCtr addAction:otherAction];
        }
    } else {
        if (otherButtonTitle.length) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [MBProgressHUD hideAllHUDsForView:[ATGeneralFuncUtil getCurrentVC].view animated:YES];
                if (block) {
                    [viewController setNeedsStatusBarAppearanceUpdate];
                    block(SWAlertButtonStyleOK);
                }
            }];
            [otherAction setValue:[SWKit colorWithHexString:@"#30C8EF"] forKey:@"titleTextColor"];
            [alertCtr addAction:otherAction];
        }
    }
    
    [viewController presentViewController:alertCtr animated:YES completion:nil];
    
}

 

@end
