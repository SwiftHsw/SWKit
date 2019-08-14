//
//  ATTabbarController.m
//  ATMinAnProject
//
//  Created by Shiwen Huang on 2019/3/26.
//  Copyright © 2019年 Shiwen Huang. All rights reserved.
//

#import "SWTabbarController.h"
#import "SWKit.h"
#import "SWNavigationViewController.h"
@interface SWTabbarController ()<UITabBarControllerDelegate>
@end

@implementation SWTabbarController
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.delegate =self;
//
//    UIViewController *circle = [[UIViewController alloc] init];
//    [self setupChildVc:circle title:@"首页" image:@"首页-未选择" selectedImage:@"首页-选择"];
//
//
//    UIViewController *mess = [[UIViewController alloc] init];
//    [self setupChildVc:mess title:@"旗袍师" image:@"旗袍师-未选择" selectedImage:@"旗袍师-选择"];
//
//
//    UIViewController *order = [[UIViewController alloc] init];
//    [self setupChildVc:order title:@"订单" image:@"订单-未选择" selectedImage:@"订单-选择"];
//
//    UIViewController *share = [[UIViewController alloc] init];
//    [self setupChildVc:share title:@"我的" image:@"我的-未选择" selectedImage:@"我的-选择"];
    
}


- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage  normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor{
    
    UIImage *originalImage = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *originalSelectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.title = title;
    vc.tabBarItem.image = originalImage;
    vc.tabBarItem.selectedImage = originalSelectedImage;
    
    // 默认
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = normalColor;
    
    // 选中
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    attrSelected[NSForegroundColorAttributeName] = selectColor;
    
    [vc.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
                                           
                                      
    
    SWNavigationViewController *nav = [[SWNavigationViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
//    
//    //拦截处理
//    if ([tabBarController.viewControllers indexOfObject:viewController] == 2) {
//        if (UserInfo) {
//            return YES;
//        }else{
//            [SWKit presenLogin];
//            return NO;
//        }
//    }
    return YES;
    
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tabBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - TabbarHeight, [UIScreen mainScreen].bounds.size.width, TabbarHeight);
    
    
    
}
 
@end
