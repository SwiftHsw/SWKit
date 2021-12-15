//
//  SWActionSheet.h
//  CustomSWkitPod
//
//  Created by 黄世文 on 2021/10/9.
//  Copyright © 2021 黄世文. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWActionSheet;
NS_ASSUME_NONNULL_BEGIN
/**
 * block回调
 *
 * @param actionSheet SWActionSheet对象自身
 * @param index       被点击按钮标识,取消: 0, 删除: -1, 其他: 1.2.3...
 */
typedef void(^SWActionSheetBlock)(SWActionSheet *actionSheet, NSInteger index);

@interface SWActionSheet : UIView
 

/**
 * 创建SWActionSheet对象
 *
 * @param title                  提示文本
 * @param cancelButtonTitle      取消按钮文本
 * @param destructiveButtonTitle 删除按钮文本
 * @param otherButtonTitles      其他按钮文本
 * @param actionSheetBlock                  block回调
 *
 * @return SWActionSheet对象
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
                      handler:(SWActionSheetBlock)actionSheetBlock NS_DESIGNATED_INITIALIZER;

/**
 * 创建SWActionSheet对象(便利构造器)
 *
 * @param title                  提示文本
 * @param cancelButtonTitle      取消按钮文本
 * @param destructiveButtonTitle 删除按钮文本
 * @param otherButtonTitles      其他按钮文本
 * @param actionSheetBlock                  block回调
 *
 * @return SWActionSheet对象
 */
+ (instancetype)actionSheetWithTitle:(NSString *)title
                   cancelButtonTitle:(NSString *)cancelButtonTitle
              destructiveButtonTitle:(NSString *)destructiveButtonTitle
                   otherButtonTitles:(NSArray *)otherButtonTitles
                             handler:(SWActionSheetBlock)actionSheetBlock;

/**
 * 弹出SWActionSheet视图
 *
 * @param title                  提示文本
 * @param cancelButtonTitle      取消按钮文本
 * @param destructiveButtonTitle 删除按钮文本
 * @param otherButtonTitles      其他按钮文本
 * @param actionSheetBlock                  block回调
 
 */
+ (void)showActionSheetWithTitle:(NSString *)title
               cancelButtonTitle:(NSString *)cancelButtonTitle
          destructiveButtonTitle:(NSString *)destructiveButtonTitle
               otherButtonTitles:(NSArray *)otherButtonTitles
                         handler:(SWActionSheetBlock)actionSheetBlock;

/**
 * 弹出视图
 */
- (void)show;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
