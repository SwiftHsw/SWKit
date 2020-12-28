//
//  NSObject+SW_File.m
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

#import "NSObject+SW_File.h"

  
@implementation NSObject (SW_File)
#pragma mark - 文件管理

+(void)creatFile:(NSString *)fileName filePath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",path,fileName] isDirectory:&isDir];
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",path,fileName] withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir)
        {
            NSLog(@"创建文件夹失败");
        }else
        {
            NSLog(@"创建文件夹成功");
        }
    }
}
+(BOOL)isHaveFile:(NSString *)Path
{
    BOOL is = false;
    NSFileManager *myFileManager=[NSFileManager defaultManager];
    BOOL isExist = [myFileManager fileExistsAtPath:Path];
    if (isExist)
    {
        is = true;
    }
    return is;
}

+(NSString *)homeDirectory{
    return NSHomeDirectory();
}

+(NSString *)documentDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    return docDir;
}

+(NSString *)cacheDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
    return cachesDir;
}

+(NSString *)tmpDirectory{
    NSString *tmpDir = NSTemporaryDirectory();
    return tmpDir;
}
#define MessageThumbnailDirectory @"MessageThumbnailDir/" //可自定(消息路径)

+(NSString *)messageThumbnailDirectory{
    static NSString * sw_dataPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sw_dataPath = [NSString stringWithFormat:@"%@/%@",[self documentDirectory],MessageThumbnailDirectory];
    });
    //存在就返回，不存在就创建
    if (![APP_FileManager fileExistsAtPath:sw_dataPath]) {
        NSError * error ;
        [APP_FileManager createDirectoryAtPath:sw_dataPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return sw_dataPath;
}


+(NSURL *)createFolderWithName:(NSString *)folderName inDirectory:(NSString *)directory{
    
    NSString * path = [directory stringByAppendingPathComponent:folderName];
    NSURL * folderURL = [NSURL URLWithString:path];
    if (![APP_FileManager fileExistsAtPath:path]) {
        NSError * error ;
        [APP_FileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (!error) {
            return folderURL;
        }else{
            NSLog(@"创建文件失败 %@", error.localizedFailureReason);
            return nil;
        }
    }
    return folderURL;
}
+ (void)removeFileAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        [fileManager removeItemAtPath:path error:&error];
        if (error) {
            NSLog(@"failed to remove file, error:%@.", error);
        }
    }
}

#define DATAPATHDIRECTORY @"/Library/ATAPPDATA/Movies_"  //可自定义

+(NSString *)dataPath{
    static NSString * sw_dataPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sw_dataPath = [NSString stringWithFormat:@"%@%@",[self homeDirectory],DATAPATHDIRECTORY];
 
    });
    if (![APP_FileManager fileExistsAtPath:sw_dataPath]) {
        [APP_FileManager createDirectoryAtPath:sw_dataPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return sw_dataPath;
}


+(void)writeImageAtPath:(NSString *)path image:(UIImage *)image{
 
    [APP_FileManager createFileAtPath:path contents:UIImageJPEGRepresentation(image, 1) attributes:nil];
}

+(unsigned long long)getFileSize:(NSString *)path{
    unsigned long long fileSize = 0;
    if ([APP_FileManager fileExistsAtPath:path]) {
        //获取文件的属性
        fileSize = [[APP_FileManager attributesOfItemAtPath:path error:nil][NSFileSize] longLongValue];
    }
    return fileSize;
}


@end
