//
//  BHNavigationViewController.m
//
//
//  Created by 黄世文 on 2019/7/6.
//  Copyright © 2019 黄世文. All rights reserved.
//

#import "SWNavigationViewController.h"
#import "SWKit.h"

@interface SWNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation SWNavigationViewController

+ (void)initialize {
    
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:[UIColor whiteColor]];
    [bar setTintColor:SWMainColor];
    bar.translucent= NO;
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = kBoldFontWithSize(17) ;
    attrs[NSForegroundColorAttributeName] = SWMainColor;
    [bar setTitleTextAttributes:attrs];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor clearColor];
    
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的pop滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
#pragma clang diagnostic pop
}

#pragma mark -- UIGestureRecognizerDelegate

// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1 ) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    
    //全局消失键盘
    [[UIView getCurrentVC].view endEditing:YES];
    
    return YES;
}
//触发之后是否响应手势事件
//处理侧滑返回与UISlider的拖动手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    //如果手势是触摸的UISlider滑块触发的，侧滑返回手势就不响应
    if ([touch.view isKindOfClass:[UISlider class]] || _isEnabled) {
        return NO;
    }
    return YES;
}
/**
 重写返回箭头
 
 @param viewController 即将显示的控制器
 @param animated 是否有动画
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0)
    {
        
        UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tagButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [tagButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateSelected];
        tagButton.size = CGSizeMake(50, 50);
        tagButton.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        [tagButton addTarget:self  action:@selector(black) forControlEvents:UIControlEventTouchUpInside];
         
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:tagButton];
        viewController.hidesBottomBarWhenPushed = YES;
    }else
        viewController.hidesBottomBarWhenPushed = NO;
    
    [super pushViewController:viewController animated:animated];
    
    // 修正push控制器tabbar上移问题
    
//    if (@available(iOS 11.0, *)){
//        
//        // 修改tabBra的frame
//        
//        CGRect frame = self.tabBarController.tabBar.frame;
//        
//        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
//        
//        self.tabBarController.tabBar.frame = frame;
//        
//    }
}
- (void)black{
    [self popViewControllerAnimated:YES];
}



@end
