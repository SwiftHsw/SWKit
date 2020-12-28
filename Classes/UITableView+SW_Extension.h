//
//  UITableView+SW_Extension.h
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SW_Extension)
/**
 背景视图
 */
@property (nonatomic , strong) UIView *backView;

/**
 不显示背景视图
 */
@property (nonatomic , assign) BOOL unShowBackView;

/**
 是否可以滑动背景视图
 */
@property (nonatomic , assign) BOOL canScrollBackView;

/**
 显示backView,忽略section的数组
 */
@property (nonatomic , strong) NSMutableArray<NSNumber *> *ignoreSectionShowBackViewArr;
@end

NS_ASSUME_NONNULL_END
