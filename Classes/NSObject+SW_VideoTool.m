//
//  NSObject+SW_VideoTool.m
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

#import "NSObject+SW_VideoTool.h"
 

@implementation NSObject (SW_VideoTool)
 
+ (void)convertVideoFromMOVToMP4:(NSURL *)movUrl complete:(void (^)(NSString *mp4Path, BOOL finished))completeCallback{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    [self convertVideoFromMOVAssetToMP4:avAsset complete:completeCallback];
}


+ (void)convertVideoFromMOVAssetToMP4:(AVURLAsset *)avAsset complete:(void (^)(NSString *mp4Path, BOOL finished))completeCallback {
    NSString *path;
    if ([avAsset.URL.scheme isEqualToString:AlAsset_Library_Scheme]) {
        path = avAsset.URL.query;
        if (path.length == 0) {
            completeCallback(nil, NO);
            return;
        }
        
    }else {
        path = avAsset.URL.path;
        if (!path || ![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            completeCallback(nil, NO);
            return;
        }
    }
    
    NSString *mp4Path = [NSString stringWithFormat:@"%@/%@.mp4", [self dataPath], [NSString md5:path]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:mp4Path]) {
        if (completeCallback)
            completeCallback(mp4Path, YES);
        return;
    }
    
    NSURL *mp4Url;
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]
                                               initWithAsset:avAsset
                                               presetName:AVAssetExportPresetHighestQuality];
        
        mp4Url = [NSURL fileURLWithPath:mp4Path];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            BOOL finished = NO;
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed:
                    NSLog(@"AVAssetExportSessionStatusFailed, error:%@.", exportSession.error);
                    break;
                    
                case AVAssetExportSessionStatusCancelled:
                    NSLog(@"AVAssetExportSessionStatusCancelled.");
                    break;
                    
                case AVAssetExportSessionStatusCompleted:
                    NSLog(@"AVAssetExportSessionStatusCompleted.");
                    finished = YES; //成功转码
                    break;
                    
                case AVAssetExportSessionStatusUnknown:
                    NSLog(@"AVAssetExportSessionStatusUnknown");
                    break;
                    
                case AVAssetExportSessionStatusWaiting:
                    NSLog(@"AVAssetExportSessionStatusWaiting");
                    break;
                    
                case AVAssetExportSessionStatusExporting:
                    NSLog(@"AVAssetExportSessionStatusExporting");
                    break;
                    
            }
            if (completeCallback)
                completeCallback(mp4Path, finished);
        }];
        
    }
}



+ (CGFloat)getVideoLength:(NSString *)videoPath {
    NSDictionary *opts = @{AVURLAssetPreferPreciseDurationAndTimingKey: @(YES)};
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:videoPath] options:opts];
    if (!urlAsset)
        return 0;
    
    float audioDurationSeconds =CMTimeGetSeconds(urlAsset.duration);
    
    return audioDurationSeconds;
}

+ (CGSize)getVideoSize:(NSString *)videoPath {
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:videoPath] options:nil];
    if (!urlAsset)
        return CGSizeZero;
    
    NSArray<AVAssetTrack *> *videoTracks = [urlAsset tracksWithMediaType:AVMediaTypeVideo];
    if (videoTracks == nil || videoTracks.count <= 0)
        return CGSizeZero;
    AVAssetTrack *videoTrack = videoTracks[0];
    CGAffineTransform t = videoTrack.preferredTransform;
    CGSize size = CGSizeApplyAffineTransform(videoTrack.naturalSize, t);
    if (size.width < 0) size.width *= -1;
    if (size.height < 0) size.height *= -1;
    
    return size;
    
}

+ (UIImage *)getVideoThumbnailImage:(NSString *)videoPath {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoPath] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    return thumb;
    
}

+ (void)compressVideoForSend:(NSURL *)videoURL
               removeMOVFile:(BOOL)removeMOVFile
                  okCallback:(void (^)(NSString *mp4Path))okCallback
              cancelCallback:(void (^)(void))cancelCallback
                failCallback:(void (^)(void))failCallback {
    NSLog(@"准备中...show");
    [self convertVideoFromMOVToMP4:videoURL complete:^(NSString *mp4Path, BOOL finished) {
        if (removeMOVFile)
            [self removeFileAtPath:videoURL.path];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"完成");
            if (finished){
                CGFloat fileSize = [self getFileSize:mp4Path];
                NSString *fileSizeString = [self getFileSizeString:fileSize];
                NSString *msg = [NSString stringWithFormat:@"视频压缩后文件大小为%@，确定要发送吗？",fileSizeString];
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"发送"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction *action){
                                                                   if (okCallback)
                                                                       okCallback(mp4Path);
                                                               }];
                
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消"
                                                                  style:UIAlertActionStyleCancel
                                                                handler:^(UIAlertAction *action) {
                                                                    if (cancelCallback)
                                                                        cancelCallback();
                                                                }];
                
                [alertController addAction:action];
                [alertController addAction:action2];
                
                [[UIView getCurrentVC] presentViewController:alertController animated:YES completion:nil];
            }});
    }];
    
}


+ (void)compressVideoAssetForSend:(AVURLAsset *)videoAsset
                       okCallback:(void (^)(NSString *mp4Path))okCallback
                   cancelCallback:(void (^)(void))cancelCallback
                     failCallback:(void (^)(void))failCallback
                  successCallback:(void (^)(NSString *mp4Path))successCallback {
      NSLog(@"正在压缩...");
    [self convertVideoFromMOVAssetToMP4:videoAsset complete:^(NSString *mp4Path, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(),^{
            NSLog(@"压缩成功");
            if (finished){
                CGFloat fileSize = [self getFileSize:mp4Path];
                NSString *fileSizeString = [self getFileSizeString:fileSize];
                NSString * msg = [NSString stringWithFormat:@"视频压缩后文件大小为%@，确定要发送吗？",fileSizeString];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"发送"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction *action){
                                                                   if (okCallback)
                                                                       okCallback(mp4Path);
                                                               }];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消"
                                                                  style:UIAlertActionStyleCancel
                                                                handler:^(UIAlertAction *action) {
                                                                    if (cancelCallback)
                                                                        cancelCallback();
                                                                }];
                
                [alertController addAction:action];
                [alertController addAction:action2];
                
                [[UIView getCurrentVC] presentViewController:alertController animated:YES completion:nil];
            }
            //回调
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (successCallback)
                    successCallback(mp4Path);
            });
            
        });
                       
    }];
    
 
    
    
}


+ (NSString *)getFileSizeString:(CGFloat)fileSize {
    NSString *ret;
    fileSize /= 1024;
    if (fileSize < 1024) {
        ret = [NSString stringWithFormat:@"%.0fK", round(fileSize)];
    }else {
        ret = [NSString stringWithFormat:@"%.2fM", fileSize/1024];
    }
    
    return ret;
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
