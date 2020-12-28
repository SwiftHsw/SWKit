//
//  UIView+SW_Extension.m
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

#import "UIView+SW_Extension.h"

CGFloat SCREEN_WIDTH;
CGFloat SCREEN_HEIGHT;
CGSize SCREEN_SIZE;
CGRect SCREEN_FRAME;
CGPoint SCREEN_CENTER;
 
@implementation UIView (SW_Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SCREEN_FRAME = [UIScreen mainScreen].bounds;
        SCREEN_SIZE = SCREEN_FRAME.size;
        SCREEN_WIDTH = SCREEN_SIZE.width;
        SCREEN_HEIGHT = SCREEN_SIZE.height;
        SCREEN_CENTER = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    });
}
 


- (CGFloat)top {
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setMaxX:(CGFloat)maxX{
    
}
-(CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

-(void)setMaxY:(CGFloat)maxY{
    
}

-(CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}



- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}


- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

-(CGFloat)getX{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)left {
    return self.frame.origin.x;
}

-(CGFloat)getY{
    return CGRectGetMaxY(self.frame);
}
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

+(UIStoryboard *)mainStoryboard{
    static UIStoryboard * sw_MainStroyBoad;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sw_MainStroyBoad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    });
    return  sw_MainStroyBoad;
}

+ (UIViewController *)rootViewController {
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

+ (UIWindow *)currentWindow {
    return [UIApplication sharedApplication].delegate.window;
}

 
+ (UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        nextResponder = window.rootViewController;
    }
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
        
        //        if ([appRootVC isKindOfClass:[UITabBarController class]]){
        //            UITabBarController * tabbar = (UITabBarController *)appRootVC;
        //            UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //            result=nav.childViewControllers.lastObject;
        //
        //        }else if ([appRootVC isKindOfClass:[UINavigationController class]]){
        //            UIViewController * nav = (UIViewController *)appRootVC;
        //            result = nav.childViewControllers.lastObject;
        //        }
        
    }
    return result;
}


- (UIViewController*)getCurrentViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
+(instancetype)sw_viewFromXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
#pragma mark -

- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self addGestureRecognizer:tap];
    
    return tap;
}

- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action target:(id)target numberTaps:(NSInteger)taps{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tap.numberOfTapsRequired = taps;
    tap.numberOfTouchesRequired = 1;
    
    [self addGestureRecognizer:tap];
    
    return tap;
}

- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action duration:(CGFloat)duration {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:action];
    longPress.minimumPressDuration = duration;
    [self addGestureRecognizer:longPress];
    
    return longPress;
}

- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action target:(id)target duration:(CGFloat)duration {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    longPress.minimumPressDuration = duration;
    [self addGestureRecognizer:longPress];
    
    return longPress;
}
-(void)removeAllSubviews{
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}


- (UIViewController *)getControllerFromView:(UIView *)view {
     // 遍历响应者链。返回第一个找到视图控制器
        UIResponder *responder = view;
        while ((responder = [responder nextResponder])){
            if ([responder isKindOfClass: [UIViewController class]]){
                return (UIViewController *)responder;
            }
        }
     // 如果没有找到则返回nil
   return nil;
}
@end

