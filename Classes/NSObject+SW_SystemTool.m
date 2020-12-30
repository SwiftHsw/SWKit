//
//  NSObject+SW_SystemTool.m
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

#import "NSObject+SW_SystemTool.h"
 
#import <arpa/inet.h>
#import <ifaddrs.h>
 

static BOOL isYouKe = NO;
static CFRunLoopObserverRef observer;

@implementation NSObject (SW_SystemTool)
 
 
#pragma mark - 权限工具
//相机权限
+(BOOL)isAuthorizationStatus
{
    BOOL isOpen;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted||authStatus ==AVAuthorizationStatusDenied) {
        isOpen = NO;
    }else{
        isOpen = YES;
    }
    return isOpen;
}
//麦克风权限
+(BOOL)isRecord
{
    BOOL isOpen;
    
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    AVAudioSessionRecordPermission authStatus = [audioSession recordPermission];
    if (authStatus == AVAudioSessionRecordPermissionUndetermined || authStatus == AVAudioSessionRecordPermissionDenied) {
        
        isOpen = NO;
        
    }else{
        isOpen = YES;
    }
    return isOpen;
    
}
//定位权限
+(BOOL)isLocation{
    BOOL isOpen;
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    if (authStatus == kCLAuthorizationStatusRestricted||authStatus==kCLAuthorizationStatusDenied) {
        isOpen = NO;
    }else{
        isOpen = YES;
    }
    return isOpen;
}
//版本适配
+(void)versionsJudge
{
    if (iOS10Later) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationLaunchOptionsLocationKey:@"是否开启定位"} completionHandler:nil];
        } else {
            // Fallback on earlier versions
        }
    } else {
        if( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
}
 


/**
 *  系统铃声播放完成后的回调
 */
void _SystemSoundFinishedPlayingCallback(SystemSoundID sound_id, void* user_data)
{
    AudioServicesDisposeSystemSoundID(sound_id);
}


+ (BOOL)hasMicphone {
    return [AVAudioSession sharedInstance].isInputAvailable;
}


#pragma mark 获得当前的音量
+ (float)currentVolumn {
    float volume;
    //以下API已废弃
    //    UInt32 dataSize = sizeof(float);
    //
    //    AudioSessionGetProperty (kAudioSessionProperty_CurrentHardwareOutputVolume,
    //                             &dataSize,
    //                             &volume);
    volume = [AVAudioSession sharedInstance].outputVolume;
    
    return volume;
}

+ (NSInteger)currentVolumeLevel {
    return round(16 *[self currentVolumn]);
}

// 播放短声音
+ (void)playShortSound:(NSString *)soundName soundExtension:(NSString *)soundExtension {
    NSURL *audioPath = [[NSBundle mainBundle] URLForResource:soundName withExtension:soundExtension];
    // 创建系统声音，同时返回一个ID
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(audioPath), &soundID);
    // Register the sound completion callback.
    AudioServicesAddSystemSoundCompletion(soundID,
                                          NULL, // uses the main run loop
                                          NULL, // uses kCFRunLoopDefaultMode
                                          _SystemSoundFinishedPlayingCallback, // the name of our custom callback function
                                          NULL // for user data, but we don't need to do that in this case, so we just pass NULL
                                          );
    
    AudioServicesPlaySystemSound(soundID);
    
}

// 震动
+ (void)playVibration
{
    // Register the sound completion callback.
    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate,
                                          NULL, // uses the main run loop
                                          NULL, // uses kCFRunLoopDefaultMode
                                          _SystemSoundFinishedPlayingCallback, // the name of our custom callback function
                                          NULL // for user data, but we don't need to do that in this case, so we just pass NULL
                                          );
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}


+ (void)playSound {
    [self playShortSound:@"qrcode_found" soundExtension:@"wav"];
}


+ (void)playNewMessageSoundAndVibration {
    // 收到消息时，播放音频
    [self playSound];
    // 收到消息时，震动
    [self playVibration];
}

+ (void)configAudioSessionForPlayback {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&err];
    
}
// 手机震动
+ (void)shockPhone
{
    static BOOL canShock = YES;
    if (@available(iOS 10.0, *)) {
        if (!canShock) {
            return;
        }
        canShock = NO;
        UIImpactFeedbackGenerator *impactFeedBack = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [impactFeedBack prepare];
        [impactFeedBack impactOccurred];
        //防止同时触发几个震动
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            canShock = YES;
        });
    }
}
 
#pragma mark - 闪光灯

+ (void)turnTorchOn:(BOOL)on
{
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([captureDevice hasTorch] && [captureDevice hasFlash]){
        
        [captureDevice lockForConfiguration:nil];
        
        if (on){
            [captureDevice setTorchMode:AVCaptureTorchModeOn];
            [captureDevice setFlashMode:AVCaptureFlashModeOn];
        }else{
            [captureDevice setTorchMode:AVCaptureTorchModeOff];
            [captureDevice setFlashMode:AVCaptureFlashModeOff];
        }
        
        [captureDevice unlockForConfiguration];
    }
}

#pragma mark -- 获取设备当前ip地址

+ (void)deviceIpAddress:(void(^)(NSString *ip))resultHandler
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *ip = [self deviceIpAddress] ;
        
        if(resultHandler){
            resultHandler(ip);
        }
        
    });
}

+ (NSString *)deviceIpAddress
{
    @autoreleasepool {
        
        NSMutableDictionary* result = [NSMutableDictionary dictionary];
        
        struct ifaddrs*    addrs;
        
        BOOL success = (getifaddrs(&addrs) == 0);
        
        if (success) {
            
            const struct ifaddrs* cursor = addrs;
            
            while (cursor != NULL) {
                
                NSMutableString* ip;
                
                if (cursor->ifa_addr->sa_family == AF_INET) {
                    
                    const struct sockaddr_in* dlAddr = (const struct sockaddr_in*)cursor->ifa_addr;
                    
                    const uint8_t* base = (const uint8_t*)&dlAddr->sin_addr;
                    
                    ip = [NSMutableString new];
                    
                    for (int i = 0; i < 4; i++) {
                        
                        if (i != 0)
                            [ip appendFormat:@"."];
                        
                        [ip appendFormat:@"%d", base[i]];
                        
                    }
                    
                    [result setObject:(NSString*)ip forKey:[NSString stringWithFormat:@"%s", cursor->ifa_name]];
                    
                }
                
                cursor = cursor->ifa_next;
            }
            
            freeifaddrs(addrs);
        }
        
        if ([[result allKeys] containsObject:@"en0"]){
            
            return (NSString *)[result objectForKey:@"en0"];
            
        }
    }
    
    return nil ;
}



+(void)setupCellSystemImageSize:(CGSize)size tableViewCell:(UITableViewCell *)cell{
    CGSize itemSize = size;
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    ATViewRadius(cell.imageView, 18);
    UIGraphicsEndImageContext();
}


+(void)cellName:(UITableViewCell *)cell textLableString:(NSString *)textLableString detaileTextLableString:(NSString *)detaileTextLableString  textLableColor:(UIColor *)textLableColor detaileTextLableColor:(UIColor *)detaileTextLableColor textLableFont:(NSInteger)textLableFont detaileTextLableFont:(NSInteger)detaileTextLableFont{
    
    cell.textLabel.text = textLableString;
    cell.detailTextLabel.text = detaileTextLableString;
    
    cell.textLabel.textColor = textLableColor;
    cell.detailTextLabel.textColor = detaileTextLableColor;
    
    cell.textLabel.font = [UIFont systemFontOfSize:textLableFont];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:detaileTextLableFont];
}



#pragma mark - 设备
+(CGFloat)systemVersion{
    static CGFloat sw_version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sw_version = [[UIDevice currentDevice].systemVersion floatValue];
    });
    return sw_version;
}


+(BOOL)canUsePhotiKit{
    return  [self systemVersion] >= 8.0; //iOS>8.0即可
}
 
+ (void)callPhoneNumber:(NSString *)phone {
    NSString * str=[[NSString alloc] initWithFormat:@"telprompt://%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

+(void)copyToPasteboard:(NSString *)string{
    [UIPasteboard generalPasteboard].string = string;
}


+(void)saveImageToPhotoAlbum:(UIImage *)image{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

+(void)saveVideoToPhotoAlbum:(NSString *)videoPath{
    UISaveVideoAtPathToSavedPhotosAlbum(videoPath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
 
    }else {
   
    }
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo {
    if (error) {
    
    }else {
 
    }
}
+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9])|(17[0-9]))\\d{8}$";
//        NSString *phoneRegex = @"\\b(1)[3458][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\\b";
    // ^1[3456789]\d{9}$
//    NSString *phoneRegex = [ATServiceConfigurationTool mobile];
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
//    return YES;
}

+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

 

+ (NSString*)devicePlatformVersion
{
    size_t size;
    sysctlbyname("hw.machine",NULL, &size, NULL,0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size,NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}
+ (BOOL)isDevice_3x{

        NSString *platform = [self devicePlatformVersion];
    if ([platform containsString:@"iPhone"]) {
        NSLog(@"platform=%@",platform);
        
        NSArray *platformaarr = [platform componentsSeparatedByString:@"iPhone"];
        
        NSString *num = [platformaarr lastObject];
        
        NSArray *numarr = [num componentsSeparatedByString:@","];
        
        NSInteger one = [[numarr firstObject] integerValue];
        if (one >=8) {
            return YES;
        }else
            if ([platform isEqualToString:@"iPhone7,2"]) {
                return YES;
            }
            return false;
    }
    
    
    return YES;
 
}

+ (NSString *)like_W:(NSString *)numer{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.roundingMode = NSNumberFormatterRoundFloor;
    formatter.maximumFractionDigits = 1;
    int count = [numer intValue];
    
    NSString *defaultTitle = @"";
    if (count >= 10000) { // [10000, 无限大)
//        defaultTitle = [NSString stringWithFormat:@"%.1fw+", count / 10000.0];
        NSNumber *number  = @(count / 10000.0);
        NSString *str = [formatter stringFromNumber:number];
        defaultTitle = [NSString stringWithFormat:@"%@w+", str];
        // 用空串替换掉所有的.0
        if (count%10000 == 0 ) {
            //为整数
            defaultTitle = [NSString stringWithFormat:@"%.1fw", count / 10000.0];
        }
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else if (count < 10000 && count >= 1000){// [1000, 10000)
        NSNumber *number  = @(count / 1000.0);
        NSString *str = [formatter stringFromNumber:number];
        defaultTitle = [NSString stringWithFormat:@"%@k+", str];
        if (count%1000 == 0 ) {
            //为整数
            defaultTitle = [NSString stringWithFormat:@"%.1fk", count / 1000.0];
        }
        // 用空串替换掉所有的.0
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else if (count > 0) { // (0, 10000)
        defaultTitle = [NSString stringWithFormat:@"%d", count];
    }else if (count == 0){
        defaultTitle = @"0";
    }
    return defaultTitle;
}

+ (NSString *)merNumber:(int )numer{
    int count = numer;
    NSString *defaultTitle = @"";
    if (count >= 10000) { // [10000, 无限大)
        defaultTitle = [NSString stringWithFormat:@"%.1fw+人", count / 10000.0];
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else if (count < 10000 && count >= 1000){// [1000, 10000)
        defaultTitle = [NSString stringWithFormat:@"%.1fk+人", count / 1000.0];
        // 用空串替换掉所有的.0
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else{
        if (count >100 && count <200) {
            defaultTitle = @"100+人";
        }else if (count >200 && count <300){
             defaultTitle = @"200+人";
        }else if (count >300 && count <400){
            defaultTitle = @"300+人";
        }else if (count >400 && count <500){
            defaultTitle = @"400+人";
        }else if (count >500 && count <600){
            defaultTitle = @"500+人";
        }else if (count >600 && count <700){
            defaultTitle = @"600+人";
        }else if (count >700 && count <800){
            defaultTitle = @"700+人";
        }else if (count >800 && count <900){
            defaultTitle = @"800+人";
        }else if (count >900 && count <1000){
            defaultTitle = @"900+人";
        } else if (count < 100){
            defaultTitle = [NSString stringWithFormat:@"%d人", count ];;
        }
    }
    return defaultTitle;
}
void myRunLoopObserver(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    switch(activity)
    {
            // The entrance of run loop, before entering the event processing loop.
            // This activity occurs once for each call to CFRunLoopRun / CFRunLoopRunInMode
        case kCFRunLoopEntry:
            NSLog(@"run loop entry");
            break;
            // Inside the event processing loop before any timers are processed
        case kCFRunLoopBeforeTimers:
            NSLog(@"run loop before timers");
            break;
            // Inside the event processing loop before any sources are processed
        case kCFRunLoopBeforeSources:
            NSLog(@"run loop before sources");
            break;
            // Inside the event processing loop before the run loop sleeps, waiting for a source or timer to fire
            // This activity does not occur if CFRunLoopRunInMode is called with a timeout of o seconds
            // It also does not occur in a particular iteration of the event processing loop if a version 0 source fires
        case kCFRunLoopBeforeWaiting:
            NSLog(@"run loop before waiting");
            break;
            // Inside the event processing loop after the run loop wakes up, but before processing the event that woke it up
            // This activity occurs only if the run loop did in fact go to sleep during the current loop
        case kCFRunLoopAfterWaiting:
            NSLog(@"run loop after waiting");
            break;
            // The exit of the run loop, after exiting the event processing loop
            // This activity occurs once for each call to CFRunLoopRun and CFRunLoopRunInMode
        case kCFRunLoopExit:
            NSLog(@"run loop exit");
            break;
            /*
             A combination of all the preceding stages
             case kCFRunLoopAllActivities:
             break;
             */
        default:
            break;
    }
}

+ (void)startObserveRunLoop
{
    if (observer == nil) {
        // 建立自动释放池
        //  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        // 设置Run Loop observer的运行环境
        CFRunLoopObserverContext context = {0, NULL, NULL, NULL, NULL};
        
        // 创建Run loop observer对象
        // 第一个参数用于分配该observer对象的内存
        // 第二个参数用以设置该observer所要关注的的事件，详见回调函数myRunLoopObserver中注释
        // 第三个参数用于标识该observer是在第一次进入run loop时执行还是每次进入run loop处理时均执行
        // 第四个参数用于设置该observer的优先级
        // 第五个参数用于设置该observer的回调函数
        // 第六个参数用于设置该observer的运行环境
        observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &myRunLoopObserver, &context);
        
    }
    
    
    // 获得当前thread的Run loop
    NSRunLoop *myRunLoop = [NSRunLoop currentRunLoop];
    // 将Cocoa的NSRunLoop类型转换程Core Foundation的CFRunLoopRef类型
    CFRunLoopRef cfRunLoop = [myRunLoop getCFRunLoop];
    // 将新建的observer加入到当前的thread的run loop
    CFRunLoopAddObserver(cfRunLoop, observer, kCFRunLoopDefaultMode);
    
    
    // Creates and returns a new NSTimer object and schedules it on the current run loop in the default mode
    //    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(doFireTimer:) userInfo:nil repeats:YES];
    
    //    NSInteger loopCount = 10;
    //    do
    //    {
    //        // 启动当前thread的run loop直到所指定的时间到达，在run loop运行时，run loop会处理所有来自与该run loop联系的input sources的数据
    //        // 对于本例与当前run loop联系的input source只有Timer类型的source
    //        // 该Timer每隔0.1秒发送触发时间给run loop，run loop检测到该事件时会调用相应的处理方法（doFireTimer:）
    //        // 由于在run loop添加了observer，且设置observer对所有的run loop行为感兴趣
    //        // 当调用runUntilDate方法时，observer检测到run loop启动并进入循环，observer会调用其回调函数，第二个参数所传递的行为时kCFRunLoopEntry
    //        // observer检测到run loop的其他行为并调用回调函数的操作与上面的描述相类似
    //        [myRunLoop runUntilDate:[NSDate dateWithTimeIntervalSiceNow:1.0]];
    //        // 当run loop的运行时间到达时，会退出当前的run loop，observer同样会检测到run loop的退出行为，并调用其回调函数，第二个参数传递的行为是kCFRunLoopExit.
    //        --loopCount;
    //    }while(loopCount);
    
    // 释放自动释放池
    //    [pool release];
}

+ (void)stopObserveRunLoop {
    if (observer) {
        CFRunLoopObserverInvalidate(observer);
        observer = nil;
    }
}
+ (void)removeViewControllerFromParentViewController:(UIViewController *)viewController {
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}


#pragma mark - 快速创建UI工具
+(UIView *)ViewcornerRadius:(float)radius andColor:(UIColor *)color andWidth:(float)width :(UIView *)view
{
    view.layer.cornerRadius = radius;
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = width;
    [view.layer setMasksToBounds:YES];
    return view;
}

+(void)maskPathView:(UIView *)view rad:(UIRectCorner)rad size:(CGSize)size{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT *0.6+50) byRoundingCorners:rad cornerRadii:size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = view.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    view.layer.mask = maskLayer;
}

 


+ (NSAttributedString *)getAttributedWithString:(NSString *)string WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *attriDict = @{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kern),
                                NSFontAttributeName:font};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string attributes:attriDict];
    return attributedString;
}

+(UITextField *)textFieldWithBackgroundColor:(UIColor *)backgrountColor textColor:(UIColor *)textColor secureTextEntry:(BOOL)secureTextEntry fontSize:(float)size font:(UIFont *)font text:(NSString *)text placeholder:(NSString *)placeholder textAlignment:(NSTextAlignment)textAlignment
{
    UITextField *textField = [[UITextField alloc] init];
    if (backgrountColor) {
        textField.backgroundColor = backgrountColor;
    }
    if (textColor) {
        textField.textColor = textColor;
        
    }
    if (text) {
        textField.text = text;
    }
    if (placeholder) {
        textField.placeholder = placeholder;
    }
    
    if (size>0) {
        textField.font = [UIFont systemFontOfSize:size];
    }else
        textField.font = font;
        textField.secureTextEntry = secureTextEntry;
        textField.textAlignment = textAlignment;
        
        //    NSMutableDictionary *attrs = [NSMutableDictionary dictionary]; // 创建属性字典
        //    attrs[NSFontAttributeName] = font; // 设置font
        //    attrs[NSForegroundColorAttributeName] = KLightTextcol; // 设置颜色
        //    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:placeholder attributes:attrs]; // 初始化富文本占位字符串
        //    textField.attributedPlaceholder = attStr;
        
        return textField;
}
+(UITextView *)textViewWithBackgroundColor:(UIColor *)backgrountColor textColor:(UIColor *)textColor fontSize:(float)size font:(UIFont *)font text:(NSString *)text  textAlignment:(NSTextAlignment)textAlignment
{
    UITextView *textView = [[UITextView alloc] init];
    if (backgrountColor) {
        textView.backgroundColor = backgrountColor;
    }
    if (textColor) {
        textView.textColor = textColor;
    }
    if (text) {
        textView.text = text;
    }
    
    if (size>0) {
        textView.font = [UIFont systemFontOfSize:size];
    }else
        textView.font = font;
        return textView;
}
+(void)swSetBtnImgVWithChatImgV:(UIImageView*)imgV andbgImgVStr:(NSString*)bgImgStr
{
    
    UIImageView *bgImgV=[[UIImageView alloc]init];
    bgImgV.image=[UIImage imageNamed:bgImgStr];
    bgImgV.frame=imgV.frame;
    //拉伸
    [bgImgV setImage:[bgImgV.image stretchableImageWithLeftCapWidth:30 topCapHeight:30]];
    
    CALayer *layer= bgImgV.layer;
    layer.frame    = (CGRect){{0,0},bgImgV.layer.frame.size};
    imgV.layer.mask = layer;
    [imgV setNeedsDisplay];
}

+(UIImageView *)imageViewWithBackgroundColor:(UIColor *)backgrountColor userInteractionEnabled:(BOOL)userInteractionEnabled imageName:(NSString *)imageName
{
    UIImageView  *imageView = [[UIImageView alloc] init];
    if (backgrountColor) {
        [imageView setBackgroundColor:backgrountColor];
    }
    imageView.userInteractionEnabled = userInteractionEnabled;
    imageView.image = [UIImage imageNamed:imageName];
    //    imageView.layer.masksToBounds = YES;
    //    imageView.contentMode = UIViewContentModeScaleAspectFit;
    //    imageView.clipsToBounds  = YES;
    return imageView;
}


+(UIImageView *)imageViewWithBackgroundColor:(UIColor *)backgrountColor userInteractionEnabled:(BOOL)userInteractionEnabled image:(UIImage *)image
{
    UIImageView  *imageView = [[UIImageView alloc] init];
    if (backgrountColor) {
        [imageView setBackgroundColor:backgrountColor];
    }
    imageView.userInteractionEnabled = userInteractionEnabled;
    if (image) {
        imageView.image = image;
    }
    //    imageView.layer.masksToBounds = YES;
    //    imageView.contentMode = UIViewContentModeScaleAspectFit;
    //    imageView.clipsToBounds  = YES;
    return imageView;
}


+(UIScrollView *)scrollViewWithBackgroundColor:(UIColor *)backgrountColor scrollEnabled:(BOOL)scrollEnabled contentSize:(CGSize)size pagingEnabled:(BOOL)pagingEnabled showsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator showsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator
{
    UIScrollView  *scrollView = [[UIScrollView alloc] init];
    if (backgrountColor) {
        [scrollView setBackgroundColor:backgrountColor];
    }
    scrollView.contentSize = size;
    scrollView.scrollEnabled = scrollEnabled;
    scrollView.pagingEnabled = pagingEnabled;
    scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator;
    scrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator;
    return scrollView;
}

+(UITableView *)tableViewWithBackgroundColor:(UIColor *)backgrountColor scrollEnabled:(BOOL)scrollEnabled separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = backgrountColor;
    tableView.scrollEnabled = scrollEnabled;
    tableView.separatorStyle = separatorStyle;
    return tableView;
}

+(UICollectionView *)collectionViewWithBackgroundColor:(UIColor *)backgrountColor scrollEnabled:(BOOL)scrollEnabled itemSize:(CGSize)size scrollDirection:(UICollectionViewScrollDirection)scrollDirection sectionInset:(UIEdgeInsets)sectionInset minimumInteritemSpacing:(float)minimumInteritemSpacing minimumLineSpacing:(float)minimumLineSpacing cellClass:(NSString *)cellClass identifier:(NSString *)identifier
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = size;
    flowLayout.scrollDirection = scrollDirection;
    flowLayout.sectionInset = sectionInset;
    flowLayout.minimumInteritemSpacing = minimumInteritemSpacing;
    flowLayout.minimumLineSpacing = minimumLineSpacing;
    UICollectionView *collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionview.backgroundColor = backgrountColor;
    [collectionview registerClass:[cellClass class] forCellWithReuseIdentifier:identifier];
    return collectionview;
}
 

+(void)setNetworkActivityIndicatorVisible:(BOOL)visible{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
}
 
#pragma mark - 通用

+ (void)setIsYoukeLogon:(BOOL)isYk{
    isYouKe = isYk;
}
+ (BOOL)isYouke{
    return isYouKe;
}
+ (void)setupiOS_11Sp{
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        [UITableView appearance].estimatedRowHeight = 0.f;
        [UITableView appearance].estimatedSectionFooterHeight = 0.f;
        [UITableView appearance].estimatedSectionHeaderHeight = 0.f;
    }
}

+ (void)setMainColor:(NSString *)color{
    [kUserDefaults setObject:color forKey:@"SWKitMainColor"];
}

+ (void)openAppStoreURL:(NSString *)url{
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", url ];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
}
 


@end
