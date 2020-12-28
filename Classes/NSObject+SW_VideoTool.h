//
//  NSObject+SW_VideoTool.h
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

 

#import <Foundation/Foundation.h>
#import "SWKit.h"
#import  <AVFoundation/AVFoundation.h>

#pragma mark -
#pragma mark - 视频工具


NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SW_VideoTool)
//配置
#define AlAsset_Library_Scheme @"assets-library"


//将Apple视频录制的格式MOV转换为MP4格式
+ (void)convertVideoFromMOVToMP4:(NSURL *)movUrl complete:(void (^)(NSString *mp4Path, BOOL finished))completeCallback;

// 获取视频时长
+ (CGFloat)getVideoLength:(NSString *)videoPath;

// 获取视频显示尺寸
+ (CGSize)getVideoSize:(NSString *)videoPath;


// 获取视频缩略图
+ (UIImage *)getVideoThumbnailImage:(NSString *)videoPath;


//用户录制的视频压缩
+ (void)compressVideoForSend:(NSURL *)videoURL
               removeMOVFile:(BOOL)removeMOVFile
                  okCallback:(void (^)(NSString *mp4Path))okCallback
              cancelCallback:(void (^)(void))cancelCallback
                failCallback:(void (^)(void))failCallback;

//系统相册中视频压缩
+ (void)compressVideoAssetForSend:(AVURLAsset *)videoAsset
                       okCallback:(void (^)(NSString *mp4Path))okCallback
                   cancelCallback:(void (^)(void))cancelCallback
                     failCallback:(void (^)(void))failCallback
                  successCallback:(void (^)(NSString *mp4Path))successCallback;

 





@end

NS_ASSUME_NONNULL_END
