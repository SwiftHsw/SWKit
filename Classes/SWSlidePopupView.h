//
//  SWSlidePopupView.h
//  SWSlidePopupView
//
//  Created by 帅到不行 on 2021/1/26.
//  Copyright © 2021 lity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWSlidePopupView : UIView

/*
 frame 一般为全屏bounds
 contentView 需要弹出的view视图
 */
+ (instancetype)popupViewWithFrame:(CGRect)frame contentView:(UIView *)contentView;

- (instancetype)initWithFrame:(CGRect)frame contentView:(UIView *)contentView;

/*
 fromView 父视图 一般为self.view 或者window
 completion 弹出后需要做的事
 */
- (void)showFrom:(UIView *)fromView completion:(void (^)(void))completion;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
