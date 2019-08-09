//
//  ATHttpTool.m
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "ATHttpTool.h"
static bool checkNetWork;

@implementation ATHttpTool
+ (void)GET_urlWithString:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if (success) {
    
            success(responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)POST_urlWithString:(NSString *)url parameters:(id)parameters loading:(BOOL)showLoading success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (showLoading) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showWithStatus:@"正在加载..."];
        });
    }
    
   
    
//    NSMutableDictionary *allParmeters = [ATHttpTool realPostParames:parameters];
    
//    NSMutableDictionary *parames =  [[NSMutableDictionary alloc]initWithDictionary:allParmeters];
  
//    if (APPTOKEN != nil) {
//        NSString *sign = [ATHttpTool signWithParames:allParmeters];
//         [parames setObject:sign forKey:@"sign"];
//    }
//
//    if ([url isEqualToString:@"http://test1.yalalat.com/cloud/platform/app/store/getCode"]) {
//
//    }else{
//         url = [BASE_URl stringByAppendingString:url];
//    }
   
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
 
        SWLog(@"===%@",responseDic);
 
        if ([responseDic[@"code"] intValue] == 1) {
            [SVProgressHUD dismiss];
            success(responseDic[@"data"]);
        }else{
            [SVProgressHUD showErrorWithStatus:responseDic[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if (showLoading) {
                [SVProgressHUD showErrorWithStatus:@"服务器开小差了，请稍后重试"];
            }
            failure(error);
        }
    }];
    
}

+(NSMutableDictionary *)realPostParames:(NSDictionary *)requestParames
{
    //金额
    NSMutableDictionary *allParmeters = [[NSMutableDictionary alloc]initWithDictionary:requestParames];
//    if ([allParmeters valueForKey:@"amount"]) {
//        NSString *amount = [allParmeters valueForKey:@"amount"];
//        NSString *newAmount = [NSString stringWithFormat:@"%0.f",[amount floatValue]*100];
//        [allParmeters setObject:newAmount forKey:@"amount"]; //金额统计做一次转换
//    }
//    if ([allParmeters valueForKey:@"nowReward"]) {
//        //当前
//        NSString *amount = [allParmeters valueForKey:@"nowReward"];
//        NSString *newAmount = [NSString stringWithFormat:@"%0.f",[amount floatValue]*100];
//        [allParmeters setObject:newAmount forKey:@"nowReward"]; //金额统计做一次转换
//    }
//    //期望
//    if ([allParmeters valueForKey:@"expectReward"]) {
//        NSString *amount = [allParmeters valueForKey:@"expectReward"];
//        NSString *newAmount = [NSString stringWithFormat:@"%0.f",[amount floatValue]*100];
//        [allParmeters setObject:newAmount forKey:@"expectReward"]; //金额统计做一次转换
//    }
//    //必要参数
//    [allParmeters setObject:@(versionNumber) forKey:@"versionCode"];
//    [allParmeters setObject:@"ios" forKey:@"platform"];
//    [allParmeters setObject:[ATHttpTool getTimes] forKey:@"time"];
    return  allParmeters;
}


+ (NSString *)signWithParames:(NSDictionary *)params{
//    NSMutableDictionary *keyValue = [[NSMutableDictionary alloc] init];
//
//    NSMutableArray *sortArr = [[NSMutableArray alloc] init];
//    //key转小写
//    for (int i = 0; i<[params allKeys].count; i++)
//    {
//        NSString *sort = [params allKeys][i];
//        [sortArr addObject:[sort lowercaseString]];
//        [keyValue setObject:[params allKeys][i] forKey:[sort lowercaseString]];
//    }
//    //排序
//    NSMutableArray *paixuArr = [[NSMutableArray alloc] init];
//    [paixuArr addObjectsFromArray:[sortArr sortedArrayUsingSelector:@selector(compare:)]];
//
//    //拼接value
//    NSString *valueStr = @"";
//    for (int i = 0; i<paixuArr.count; i++)
//    {
//        NSString *key = [keyValue valueForKey:paixuArr[i]];
//        NSString *value = [params valueForKey:key];
//        if (![value isEqual:@""])
//        {
//            if ([valueStr isEqual:@""])
//            {
//                valueStr = [NSString stringWithFormat:@"%@=%@",key,value];
//            }else
//                valueStr = [NSString stringWithFormat:@"%@&%@",valueStr,[NSString stringWithFormat:@"%@=%@",key,value]];
//        }
//    }
//
//    NSString *key = @"B@3D#382$EE";
//    NSString *base64 = [valueStr base64EncodedString];
//    NSString *md5Fist = [ATGeneralFuncUtil upMd5String:base64];
//
//    NSString *sign =  [NSString stringWithFormat:@"%@&%@%@%@",md5Fist,APPTOKEN,[ATHttpTool getTimes],key] ;
//    NSString *signMd5 = [ATGeneralFuncUtil upMd5String:sign];
//
//    SWLog(@"valueStr:%@ \n base64:%@ \n md5Fist:%@ \n sign:%@ \n signMd5:%@",valueStr,base64,md5Fist,sign,signMd5);
//    return signMd5;
    return @"";
}

//+ (NSString *)getTime{
//
//    long long time  = [ATGeneralFuncUtil longLongFromDate:[NSDate date]];
////    long long RequestTime = [ATGeneralFuncUtil requestTime] + time;
//    return [NSString stringWithFormat:@"%lld",time];
//}

+ (NSString *)getTimes{
    return [kUserDefaults objectForKey:@"times"];
    
}


#pragma mark- 网络监测
+(void)checkNetWork
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        // 当网络状态发生改变的时候调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                checkNetWork=YES;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                checkNetWork=YES;
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
            {
                checkNetWork=NO;
                // [MBProgressHUD showError:@"无网络连接"];
                
            }
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                checkNetWork=NO;
                //[MBProgressHUD showError:@"未知网络"];
                
                NSLog(@"未知网络");
                break;
                
        }
    }];
    // 开始监控
    [mgr startMonitoring];
}
+(BOOL)reachability
{
    return checkNetWork;
}
- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}




#pragma mark - 上传图片

+ (void)uploadOssImage:(UIImage *)image filePath:(NSString *)filePath completion:(void(^)(BOOL isSuccess, NSString *imgUrl))completion index:(NSInteger)imageIndex
{
    
//    [[ATOSSTool sharedInstance]OssSetupEnvironment];
//    [[ATOSSTool sharedInstance] OSSuploadObjectAsyn:filePath filePath:nil image:image isHead:YES index:0];
//    [SVProgressHUD show];
//    [[ATOSSTool sharedInstance] setUploadOrDownloadBlock:^(BOOL isSuccess, NSString *file, NSInteger index, NSInteger progress, BOOL isFinish) {
//        
//        [SVProgressHUD dismiss];
//        !completion?:completion(isSuccess, file);
//        
//    }];
  
}



#pragma mark - 上传图片
#define BASEURL @"http://vxqgyd.cn:89"

+ (void)uploadAFNImageData:(NSData *)data successBlock:(void(^)(NSString *url))block
{
    
    ///1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //2.上传文件
//    updataImage
    [manager POST:@"http://vxqgyd.cn:89/api/index/addAvatar" parameters:@{@"avatar":@"avatar.png"} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //上传文件参数
        [formData appendPartWithFileData:data name:@"avatar" fileName:@"fileName.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印上传进度
        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        SWLog(@"%.2lf%%", progress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        SWLog(@"请求成功：%@",responseObject);
        block([NSString stringWithFormat:@"%@%@",BASEURL,responseObject[@"data"]]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        SWLog(@"请求失败：%@",error);
        
    }];
    
    
}


+ (void)uploadAFNUsermageData:(NSData *)data successBlock:(void(^)(NSString *url))block
{
    
    ///1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //2.上传文件
    
    [manager POST:uploadAvatar parameters:@{@"avatar":@"avatar.png",@"user_id":UserInfo[@"user_id"]} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //上传文件参数
        [formData appendPartWithFileData:data name:@"avatar" fileName:@"fileName.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印上传进度
        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        SWLog(@"%.2lf%%", progress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        SWLog(@"请求成功：%@",responseObject);
        block([NSString stringWithFormat:@"%@%@",BASEURL,responseObject[@"data"]]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        SWLog(@"请求失败：%@",error);
        
    }];
    
    
}

@end
