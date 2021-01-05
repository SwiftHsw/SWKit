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
 
///自定义占位文字内容
@property (nonatomic,copy) NSString *nodataString;
///是否展示占位view 默认不展示，需要展示请设置为YES
@property (nonatomic,assign) BOOL isShowNodata;


@end

NS_ASSUME_NONNULL_END
