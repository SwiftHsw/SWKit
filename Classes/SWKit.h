//
//  SWKit.h
//  SWKit
//
//  Created by Shiwen Huang on 2018/6/21.
//  Copyright © 2018年 .SW. All rights reserved.
//



#import <Foundation/Foundation.h>
#import  <AVFoundation/AVFoundation.h>
#include <sys/sysctl.h> 
#import <CoreLocation/CoreLocation.h>
#import <CommonCrypto/CommonDigest.h>
#import "SWAlertViewController.h"         //弹窗工具
#import "SWNavigationViewController.h"    //导航基类
#import "SWTabbarController.h"            //Tabbar基类
#import "SWSuperViewContoller.h"          //基类减少代码量
#import "UIBarButtonItem+SWExtension.h"   //导航按钮工具
#import "UIButton+SWEdgeInsets.h"         //按钮分类
#import "UIButton+SW_Extention.h"         //按钮快速集成
#import "UIViewController+SW_Extension.h" //控制器拓展工具、拍照相册等
#import "UITextField+SW_Extension.h"      //动态输入框属性
#import "UIView+SW_Extension.h"           //坐标工具
#import "UIImage+SW_Extension.h"          //图片工具
#import "NSObject+SW_VideoTool.h"         //视频工具
#import "UIColor+SW_Extension.h"          //颜色转换
#import "NSDate+SW_Extension.h"           //时间管理大师
#import "NSObject+SW_SystemTool.h"        //设备工具等
#import "NSString+SW_Extension.h"          //字符串
#import "NSObject+SW_File.h"               //文件管理助手
#import "AppUserCache.h"                  //app用户登陆数据缓存
#import "UILabel+SW_Extension.h"          //文本
#import "ApplePayManager.h"               //Apple内购
#import "AppNetworkTool.h"                 //网络请求


//输出
#if DEBUG

#define SWLog(...) \
printf("[%s  第%d行]: %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
#define SWLog(...)
#endif


#define  SWMainColor [UIColor colorWithHexString:[kUserDefaults objectForKey:@"SWKitMainColor"]]

#pragma mark - 常用沙盒地址以及文件夹

#define SWDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define SWSqlitePath [NSString stringWithFormat:@"%@/userData/data.sqlite",SWDocumentPath]

 
#pragma mark - 获取设备屏幕尺寸

#define IS_IPHONE_5_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
#define IS_IPHONE_4_7 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE_4_0 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_3_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )

//当前版本号
#define GETSYSTEM   [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]
//常用设备宽高宏
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define Is_Iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define Is_Iphone_X (Is_Iphone && ScreenHeight >= 812.0) //>= iphoneX 系列手机
#define NavBarHeight (Is_Iphone_X ? 88 : 64)
#define StatusBarHeight (Is_Iphone_X ? 24 : 0)
#define TabbarHeight (Is_Iphone_X ? 83 : 49)
#define SafeBottomHeight (Is_Iphone_X ? 34 : 0)

//根据UI出的比例计算高度宽度(适配机型)
#define SWWidthProportion ScreenWidth/375
#define SWHeightProportion ScreenHeight/667

//单图屏幕宽高机型比列 w-屏幕宽 uiH-UI给出高度标注 uiW-UI给出宽度标注
#define SWImageHeightProportion(w,uiH,uiW) (w)*uiH/uiW

//iphonex系列

////判断是否是ipad
#define isIPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isIPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isIPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isIPad : NO)

#pragma mark - Load Font 加载字体大小
// 设置常规字体大小
#define kFontWithSize(size) [UIFont systemFontOfSize:size]

// 设置加粗字体大小
#define kBoldFontWithSize(size) [UIFont boldSystemFontOfSize:size]


#pragma mark - Load Image 加载图片
// 加载本地图片
#define kImageName(Name) ([UIImage imageNamed:Name])
// 通过路径加载本地图片
#define kImageOfFile(Name) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:Name ofType:nil]])
 
#pragma mark - System Singletons  单例
// 偏好设置单例
#define kUserDefaults [NSUserDefaults standardUserDefaults]

//通知单例
#define kNotificationCenter  [NSNotificationCenter defaultCenter]

// 文件管理单例
#define kFileManager [NSFileManager defaultManager]

// 简化通知
#define kPostNotificationWithName(notificationName) \
[kNotificationCenter postNotificationName:notificationName object:nil userInfo:nil]

// 简化通知
#define kPostNotificationWithNameAndUserInfo(notificationName, userInfo) \
[kNotificationCenter postNotificationName:notificationName object:nil userInfo:userInfo]


//单例快速写法
#define CREATE_SHARED_MANAGER(CLASS_NAME) \
+ (instancetype)sharedManager { \
static CLASS_NAME *_instance; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[CLASS_NAME alloc] init]; \
}); \
\
return _instance; \
}
//设置图片的contentMode
#define kImageContenMode(x) x.contentMode = UIViewContentModeScaleAspectFill;\
x.clipsToBounds = YES


#pragma mark - Judge 判断

// 判断它是否是空字符串1.

#define kIsEmptyString(s) (s == nil || [s isKindOfClass:[NSNull class]] || ([s isKindOfClass:[NSString class]] && s.length == 0))

//判断它是否是空字符串2。
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

// 判断它是否为nil或null对象。
#define kIsEmptyObject(obj) (obj == nil || [obj isKindOfClass:[NSNull class]])

// 判断它是否是一个有效的字典。
#define kIsDictionary(objDict) (objDict != nil && [objDict isKindOfClass:[NSDictionary class]])

// 判断它是否是一个有效的数组。
#define kIsArray(objArray) (objArray != nil && [objArray isKindOfClass:[NSArray class]])

//  判断是否是ipad
#define kIsIPad \
([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)]\
&& [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

// 判断当前定位是否为横向。
#define kIsLandscape (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))

//XIB 快速加载
#define LOADNIBWITHNAME(CLASS, OWNER) [[[NSBundle mainBundle] loadNibNamed:CLASS owner:OWNER options:nil] lastObject]

//解决循环引用

#define WeakSelf(type)  __weak typeof(type) weak##type = type;
#define StrongSelf(type)  __strong typeof(type) type = weak##type;



//设置圆角边框
#define ATViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]\

//设置圆角
#define ATViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\

//快速获取window
#define KeyWindow      [[UIApplication sharedApplication] keyWindow]


//设置按钮通用按压效果等
#define ATBtnColorTool(View)\
[View setBackgroundImage:[UIImage imageNamed:@"btn_loginsele"] forState:UIControlStateNormal];\
[View setBackgroundImage:[UIImage imageNamed:@"btn_loginsele"]  forState:UIControlStateHighlighted];\
[View setBackgroundImage: [UIImage imageNamed:@"btn_loginsele"] forState:UIControlStateSelected];\
[View setUserInteractionEnabled:YES];\
//快速设置按钮点击效果
#define ATBtnColorEnableTool(View)\
[View setBackgroundImage:[UIImage imageWithColor:k_DarkTextColor] forState:UIControlStateNormal];\
[View setBackgroundImage:[UIImage imageWithColor:k_DarkTextColor]  forState:UIControlStateHighlighted];\
[View setBackgroundImage: [UIImage imageWithColor:k_DarkTextColor] forState:UIControlStateSelected];\
[View setUserInteractionEnabled:NO];\

//宏定义
#define UIColorRGBA(_red, _green, _blue, _alpha) [UIColor colorWithRed:((_red)/255.0) \
green:((_green)/255.0) blue:((_blue)/255.0) alpha:(_alpha)]
#define UIColorRGB(red, green, blue) UIColorRGBA(red, green, blue, 1)
#define UIColorHexRGB(rgbString) [UIColor colorWithHexRGB:(rgbString)]
#define UIColorHexRGBA(rgbaString) [UIColor colorWithHexRGBA:(rgbaString)]
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度。 iPhone X 之前是 20 iPhone X 是 44
#define kSystemNavHeight 44.0
#define kNavbarHeight (kStatusBarHeight+kSystemNavHeight) //默认的NAVERgationBar 高度


//快速设置tableView 间距写法 带有头部14像素点(适配iphoneX)
#define ATTableViewHeadFooterLineSetting  - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {   return 14; }\
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{  return [UIView new];}\
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{ return 0.01f; }\
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{ return [UIView new]; } \

#pragma mark - GCD
//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);
 

//输出方法
#define SW_FUNC SWLog(@"%s",__func__ );

//获取当前控制器
#define kCurrentVC [SWKit getCurrentVC]

//普通白色按钮选中颜色
#define kBtnTouchImage [UIImage imageWithColor:[[UIColor grayColor] colorWithAlphaComponent:.2]]

//文件管理
#define  APP_FileManager [NSFileManager defaultManager]

 
