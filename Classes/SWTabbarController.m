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
    return YES;
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tabBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - TABBAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, TABBAR_HEIGHT);
    
    
    
}
 
@end
