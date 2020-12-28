//
//  SWSuperViewContoller.h
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWSuperViewContoller : UIViewController

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;//数据源

//开启/关闭全屏手势
- (void)setNavEnable:(BOOL)isEnable;
//状态栏显示/隐藏
- (void) setStatusBarHidden:(BOOL) hidden;
//导航栏显示/隐藏
- (void) setNavgationBarHidden:(BOOL) hidden;
//状态栏自定义颜色
- (void) setStatusBarBackgroundColor:(UIColor *)color;
//状态栏样式
- (void) setStatusBarStyle:(UIStatusBarStyle)style;
//导航栏标题
- (void) setNavigationBarTitle:(NSString *)title;
//导航栏字体颜色
- (void) setNavigationBarTitleColor:(UIColor *)color;
//导航栏背景颜色
- (void) setNavigationBarBackgroundColor:(UIColor *)color;
//设置一下两个为 [UIImage new] 则透明导航栏
//1导航栏背景图片
- (void) setNavigationBarBackgroundImage:(UIImage *)image;
//2导航栏线条图片
- (void) setNavigationBarShadowImage:(UIImage *)image;
//返回上级
- (void) back;
- (void) dismiss;
- (void) backRoot;
//延时返回
- (void)dispatch_after_Back;
//获取导航栏高度
- (CGFloat) navagationBarHeight;
//自定义左侧按钮
- (void) setLeftButton:(NSString *)imageName;
//设置背景图
- (void) setBackgroundImage:(NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
