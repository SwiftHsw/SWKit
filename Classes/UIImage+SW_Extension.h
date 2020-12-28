//
//  UIImage+SW_Extension.h
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//
 

#import <UIKit/UIKit.h>
#import "SWKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SW_Extension)
/**  压缩图片*/
+ (UIImage *)imageWithOriginalImage:(UIImage *)image;
/**  压缩图片 压缩质量 0 -- 1*/
+ (UIImage *)imageWithOriginalImage:(UIImage *)image quality:(CGFloat)quality;

/**  压缩图片成Data*/
+ (NSData *)dataWithOriginalImage:(UIImage *)image;

//通过View来绘制一张图片
+ (UIImage *)imageWithView:(UIView *)view;
//通过颜色值来获取一张图片 可设置大小
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
//通过颜色值来获取一张图片
+ (UIImage *)imageWithColor:(UIColor *)color;
//在rect创建图像
+ (UIImage *)createWithImageInRect:(CGRect)rect dataImage:(UIImage *)dataImage;
//获取灰度的图像
+ (UIImage *)getGrayImage:(UIImage *)image;
//获取变暗的图像
+ (UIImage *)darkenImage:(UIImage *)image;

+ (UIImage *) partialImageWithPercentage:(float)percentage
                                vertical:(BOOL)vertical
                           grayscaleRest:(BOOL)grayscaleRest
                               dataImage:(UIImage *)dataImage;
//获取图片的像素大小
+ (CGSize)pixelSize:(UIImage *)image;
//获取图像文件的大小
+ (NSInteger)imageFileSize:(UIImage *)image;

//GIF图片专区
+ (UIImage *)sw_animatedGIFNamed:(NSString *)name;
//传入Data类型返回一个gif图片
+ (UIImage *)sw_animatedGIFWithData:(NSData *)data;
//动画裁剪大小
- (UIImage *)sw_animatedImageByScalingAndCroppingToSize:(CGSize)size image:(UIImage *)image;
//GIF动画帧index source文件 --> CGImageSourceCreateWithData((__bridge CFDataRef)(gifData), NULL);
+ (float)sw_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source;

//生成二维码图片
+(UIImage *)createNonInterpolatedUIImageFormCIImage:(NSString *)dataString withSize:(CGFloat)sizeMax;

/**
 通用Cell箭头(图片)
 */
+ (UIImageView *)getAccessoryImage:(NSString *)imgName;


//获取单张图片的size
+ (CGSize)getSingleSize:(CGSize)singleSize max:(CGFloat)max;


@end

NS_ASSUME_NONNULL_END
