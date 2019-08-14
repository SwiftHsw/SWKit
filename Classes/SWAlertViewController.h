 
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum{
    SWAlertButtonStyleOK,  // 确定
    SWAlertButtonStyleCancel // 取消
} SWAlertButtonStyle;

@interface SWAlertViewController : NSObject

/** 只有一个取消按钮时，传otherButtonTitle参数，cancelButtonTitle传nil */
+ (void)showInController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButtonTitle other:(NSString *)otherButtonTitle completionHandler:(void (^)(SWAlertButtonStyle buttonStyle))block;

@end
