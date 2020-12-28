//
//  NSObject+SW_File.h
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

 

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SWKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SW_File)
/**
 判断文件是否存在
 
 @param Path 文件路径
 
 @return 文件是否存在
 */
+(BOOL)isHaveFile:(NSString *)Path;
+ (NSString *)homeDirectory;
//文件目录
+ (NSString *)documentDirectory;
//缓存目录
+ (NSString *)cacheDirectory;
//临时目录
+ (NSString *)tmpDirectory;

//消息缩略图目录
+ (NSString *)messageThumbnailDirectory;
//创建一个文件folderName文件夹名称   夹在   directory目录
+ (NSURL *)createFolderWithName:(NSString *)folderName inDirectory:(NSString *)directory;
//获取数据路径
+ (NSString *)dataPath;
//删除文件路径
+ (void)removeFileAtPath:(NSString *)path;
//写入图片  path 文件路径 image 图片数据
+ (void)writeImageAtPath:(NSString *)path image:(UIImage *)image;
//返回文件大小，单位为字节
+ (unsigned long long)getFileSize:(NSString *)path;

//沙河文件主目录

+(void)creatFile:(NSString *)fileName filePath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
