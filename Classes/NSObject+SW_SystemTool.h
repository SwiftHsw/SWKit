//
//  NSObject+SW_SystemTool.h
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

 
#import <Foundation/Foundation.h>
#import "SWKit.h"
#import <UIKit/UIKit.h>
 
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SW_SystemTool)

#pragma mark -
#pragma mark - 设备权限工具
//配置
#define iOS10Later ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)

//相机权限
+(BOOL)isAuthorizationStatus;

//麦克风权限
+(BOOL)isRecord;

//定位权限
+(BOOL)isLocation;

//版本适配
+(void)versionsJudge;


//是否支持声音输入
+ (BOOL)hasMicphone;

//系统音量，只能有用户设置，分为16个等级，返回值范围为：0-1
+ (float)currentVolumn;

+ (NSInteger)currentVolumeLevel;

+ (void)playShortSound:(NSString *)soundName soundExtension:(NSString *)soundExtension;

// 播放声音
+ (void)playSound;

// 震动
+ (void)playVibration;

+ (void)playNewMessageSoundAndVibration;

+ (void)configAudioSessionForPlayback;

// 震动反馈 ios10以上
+ (void)shockPhone;

//闪光灯
+ (void)turnTorchOn:(BOOL)on;

#pragma mark -- 获取设备当前ip地址

+ (void)deviceIpAddress:(void(^)(NSString *ip))resultHandler;
+ (NSString *)deviceIpAddress;
 
//配置
#define UIWindowLevelPopOver 10000000000
 

//获取系统版本
+ (CGFloat)systemVersion;
//当前手机是否支持PhotoKit照片库框架
+ (BOOL)canUsePhotiKit;
//拨打电话
+ (void)callPhoneNumber:(NSString *)phone;
//复制字符串到系统剪贴板
+ (void)copyToPasteboard:(NSString *)string;

//设置网络活动指示符可见(导航栏旋转图标)
+ (void)setNetworkActivityIndicatorVisible:(BOOL)visible;
//保存图片到系统相册
+ (void)saveImageToPhotoAlbum:(UIImage *)image;
//保存视频到系统相册
+ (void)saveVideoToPhotoAlbum:(NSString *)videoPath;

 
//移除控制器上所有的子视图以及其他控制器
+ (void)removeViewControllerFromParentViewController:(UIViewController *)viewController;
//开始观察runloop
+ (void)startObserveRunLoop;
//开始停止runloop
+ (void)stopObserveRunLoop;

//其他判断工具
/**是否纯数字 */
+ (BOOL)isPureNumandCharacters:(NSString *)string;
/** 手机号验证 */
+ (BOOL)isValidateMobile:(NSString *)mobile;
/** 邮箱验证 */
+ (BOOL)isValidateEmail:(NSString *)email;
 
+ (BOOL)isDevice_3x;

/*点赞数量*/
+ (NSString *)like_W:(NSString *)numer;
+ (NSString *)merNumber:(int )numer;

 
#pragma mark -
#pragma mark - 快速创建UI



/**
 通用Cell修改系统自带图片大小
 */
+(void)setupCellSystemImageSize:(CGSize)size
                  tableViewCell:(UITableViewCell *)cell;

/*
 通用Cell快速配置
 */
+(void)cellName:(UITableViewCell *)cell textLableString:(NSString *)textLableString detaileTextLableString:(NSString *)detaileTextLableString  textLableColor:(UIColor *)textLableColor detaileTextLableColor:(UIColor *)detaileTextLableColor textLableFont:(NSInteger)textLableFont detaileTextLableFont:(NSInteger)detaileTextLableFont;



/**textField 背景色 字体颜色 是否密文 字体大小 文字 默认文字 文字对齐方式*/
+(UITextField *)textFieldWithBackgroundColor:(UIColor *)backgrountColor textColor:(UIColor *)textColor secureTextEntry:(BOOL)secureTextEntry fontSize:(float)size font:(UIFont *)font text:(NSString *)text placeholder:(NSString *)placeholder textAlignment:(NSTextAlignment)textAlignment;

/**textView 背景色 字体颜色 字体大小 文字 文字对齐方式*/
+(UITextView *)textViewWithBackgroundColor:(UIColor *)backgrountColor textColor:(UIColor *)textColor fontSize:(float)size font:(UIFont *)font text:(NSString *)text  textAlignment:(NSTextAlignment)textAlignment;


/**UIImageView 背景色 是否可触摸 图片名字*/
+(UIImageView *)imageViewWithBackgroundColor:(UIColor *)backgrountColor userInteractionEnabled:(BOOL)userInteractionEnabled imageName:(NSString *)imageName;

/**UIImageView 背景色 是否可触摸 图片*/
+(UIImageView *)imageViewWithBackgroundColor:(UIColor *)backgrountColor userInteractionEnabled:(BOOL)userInteractionEnabled image:(UIImage *)image;

/**UIScrollView 背景色 是否可滑动 容量大小 是否可翻页滑动 是否显示横向滑动条 是否显示竖向滑动条*/
+(UIScrollView *)scrollViewWithBackgroundColor:(UIColor *)backgrountColor scrollEnabled:(BOOL)scrollEnabled contentSize:(CGSize)size pagingEnabled:(BOOL)pagingEnabled showsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator showsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator;

/**UITableView 背景色 是否可滑动 cell分割样式*/
+(UITableView *)tableViewWithBackgroundColor:(UIColor *)backgrountColor scrollEnabled:(BOOL)scrollEnabled separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle;

/**UICollectionView 背景色 是否可滑动 item大小 滚动方向 四周边距 item之间间距 行距 自定义cell的class identifier*/
+(UICollectionView *)collectionViewWithBackgroundColor:(UIColor *)backgrountColor scrollEnabled:(BOOL)scrollEnabled itemSize:(CGSize)size scrollDirection:(UICollectionViewScrollDirection)scrollDirection sectionInset:(UIEdgeInsets)sectionInset minimumInteritemSpacing:(float)minimumInteritemSpacing minimumLineSpacing:(float)minimumLineSpacing cellClass:(NSString *)cellClass identifier:(NSString *)identifier;

//切圆角
+(UIView *)ViewcornerRadius:(float)radius andColor:(UIColor *)color andWidth:(float)width :(UIView *)view;

//某个角度

+(void)maskPathView:(UIView *)view rad:(UIRectCorner)rad size:(CGSize)size;

 
//打开appStroe
+ (void)openAppStoreURL:(NSString *)url;
//静态存储

+(void)setIsYoukeLogon:(BOOL)isYk;
+(BOOL)isYouke;

//适配ios 11 以上 一般放在delegate入口
+ (void)setupiOS_11Sp;


//设置主题颜色
+ (void)setMainColor:(NSString *)color;
  

/*
 *  设置行间距和字间距
 *
 *  @param string    字符串
 *  @param lineSpace 行间距
 *  @param kern      字间距
 *  @param font      字体大小
 *
 *  @return 富文本
 */
+ (NSAttributedString *)getAttributedWithString:(NSString *)string WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font;

#pragma mark 类型为图片的时候做的操作
/**
 *  图片
 *
 *  @param imgV     赋值图片
 *  @param bgImgStr 图片底部气泡
 */
+(void)swSetBtnImgVWithChatImgV:(UIImageView*)imgV andbgImgVStr:(NSString*)bgImgStr;
 

@end

NS_ASSUME_NONNULL_END
