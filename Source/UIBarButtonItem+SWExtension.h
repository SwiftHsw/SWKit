//
//  UIBarButtonItem+SWExtension.h
//  ATCloudCar
//
//  Created by Shiwen Huang on 2018/4/23.
//  Copyright © 2018年 ATEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SWExtension)

/**
 是否选中状态
 */
@property (assign, nonatomic) BOOL selected;


/**
  自定义快速创建导航栏按钮属性

 @param title 按钮标题
 @param imageName  图片默认名字
 @param highImageName 图片高亮名字
 @param target self
 @param action 绑定方法
 @return item
 */
+ (instancetype)itemWithTitle:(NSString *)title ImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

/**
 自定义快速创建导航栏按钮属性

 @param imageName 图片默认名字
 @param selectedImageName 图片选中名字
 @param target self
 @param action 绑定方法
 @return item
 */
+ (instancetype)itemWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action;


//系统统一按钮返回
+ (instancetype)itemWithNavImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action;
@end
