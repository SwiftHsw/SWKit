//
//  SWCountDownButton.h
//  CustomSWkitPod
//
//  Created by 黄世文 on 2021/10/11.
//  Copyright © 2021 黄世文. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class SWCountDownButton;

typedef NSString* _Nullable (^CountDownChanging)(SWCountDownButton *countDownButton,NSUInteger second);
typedef NSString* _Nullable (^CountDownFinished)(SWCountDownButton *countDownButton,NSUInteger second);
typedef void (^TouchedCountDownButtonHandler)(SWCountDownButton *countDownButton,NSInteger tag);


@interface SWCountDownButton : UIButton


@property(nonatomic,strong) id userInfo;
///倒计时按钮点击回调
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;

//倒计时时间改变回调
- (void)countDownChanging:(CountDownChanging)countDownChanging;

//倒计时结束回调
- (void)countDownFinished:(CountDownFinished)countDownFinished;

///开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second;

///停止倒计时
- (void)stopCountDown;


@end

NS_ASSUME_NONNULL_END
