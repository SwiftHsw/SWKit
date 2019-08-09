//
//  ATHttpTool.h
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface ATHttpTool : NSObject

/**数据请求*/

+ (void)GET_urlWithString:(NSString *)url
               parameters:(id)parameters
                  success:(void(^)(id responseObject))success
                  failure:(void(^)(NSError *error))failure;

+ (void)POST_urlWithString:(NSString *)url
                parameters:(id)parameters
                   loading:(BOOL)showLoading
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;

/**
 *  网络检测
 */
+(void)checkNetWork;
/**
 *  网络检测
 */
+(BOOL)reachability;


/**
 上传图片到OSS
 
 @param image 图片
 @param completion 回调
 */

+ (void)uploadOssImage:(UIImage *)image
              filePath:(NSString *)filePath
            completion:(void(^)(BOOL isSuccess, NSString *imgUrl))completion
                 index:(NSInteger)imageIndex;



+ (void)uploadAFNImageData:(NSData *)data successBlock:(void(^)(NSString *url))block;

+ (void)uploadAFNUsermageData:(NSData *)data successBlock:(void(^)(NSString *url))block;
 
@end
