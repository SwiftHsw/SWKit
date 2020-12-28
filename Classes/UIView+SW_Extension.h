//
//  UIView+SW_Extension.h
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

 
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
extern CGSize  SCREEN_SIZE;
extern CGRect  SCREEN_FRAME;
extern CGPoint SCREEN_CENTER;


@interface UIView (SW_Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign ,readonly) CGFloat maxX;
@property (nonatomic, assign ,readonly) CGFloat maxY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;


//获取Storyboard
+ (UIStoryboard *)mainStoryboard;

//获取根视图
+ (UIViewController *)rootViewController;
//获取window
+ (UIWindow *)currentWindow;
 
//获取当前控制器所在
+ (UIViewController *)getCurrentVC;

//获取当前界面控制器
- (UIViewController*)getCurrentViewController;

//获取当前view所在的控制器
- (UIViewController *)getControllerFromView:(UIView *)view;

//获取当前类的XIB 类直接调用
+(instancetype)sw_viewFromXib;
//view直接添加手势
- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action;
//view可传入双击手势
- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action
                                             target:(id)target numberTaps:(NSInteger)taps;
//添加长按手势
- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action
                                                       duration:(CGFloat)duration;
//添加长按手势 几秒后相应
- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action
                                                         target:(id)target
                                                       duration:(CGFloat)duration;
//移除当前View所有子视图
- (void)removeAllSubviews;


@end

NS_ASSUME_NONNULL_END
