//
//  UIViewController+SW_Extension.h
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//
 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extension)
<
  UIImagePickerControllerDelegate,
  UINavigationControllerDelegate
>

/* 左边距*/
@property (nonatomic,assign) CGFloat sw_leftNavItemSpacing;

/* 右边距*/
@property (nonatomic,assign) CGFloat sw_rightNavItemSpacing;



/**
 拍照、不裁剪
 */
- (void)takePhotoForCamera;

/**
 拍照、是否裁剪
 */
- (void)takePhotoForCameraWithEditing:(BOOL)edit;

/**
 相册选择图片、是否裁剪
 */
- (void)takePhotoForLibraryWithEditing:(BOOL)edit;


@end



@interface UIBarButtonItem (Extension)

@property (nonatomic , assign) UIBarButtonSystemItem systemItem;

@end



NS_ASSUME_NONNULL_END
