//
//  ATTabbarController.h
//  ATMinAnProject
//
//  Created by Shiwen Huang on 2019/3/26.
//  Copyright © 2019年 Shiwen Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTabbarController : UITabBarController

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage  normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor;
@end

NS_ASSUME_NONNULL_END
