# SWKit
快速开发APP的工具


## 通用
```
#pragma mark - 获取设备屏幕尺寸

#define IS_IPHONE_5_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
#define IS_IPHONE_4_7 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE_4_0 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_3_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )


//常用设备宽高宏
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define Is_Iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define Is_Iphone_X (Is_Iphone && ScreenHeight == 812.0)
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
#define weakSelf(object)            __weak typeof(object) weakSelf = object
//弱引用/强引用
#define SWWeakSelf(type)  __weak typeof(type) weak##type = type;
#define SWStrongSelf(type)  __strong typeof(type) type = weak##type;


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
#define KeyWindow       [[UIApplication sharedApplication] keyWindow]


//设置按钮通用按压效果等
#define ATBtnColorTool(View)\
[View setBackgroundImage:[UIImage imageNamed:@"btn_color_default"] forState:UIControlStateNormal];\
[View setBackgroundImage:[UIImage imageNamed:@"btn_color_pressed"]  forState:UIControlStateHighlighted];\
[View setBackgroundImage: [UIImage imageNamed:@"btn_color_pressed"] forState:UIControlStateSelected];\

//快速设置按钮点击效果
#define ATBtnColorEnableTool(View)\
[View setBackgroundImage:[UIImage imageWithColor:ATMainEnabledColor] forState:UIControlStateNormal];\
[View setBackgroundImage:[UIImage imageWithColor:ATMainEnabledColor]  forState:UIControlStateHighlighted];\
[View setBackgroundImage: [UIImage imageWithColor:ATMainEnabledColor] forState:UIControlStateSelected];\


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

//输出
#define SWLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
 
extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
extern CGSize  SCREEN_SIZE;
extern CGRect  SCREEN_FRAME;
extern CGPoint SCREEN_CENTER;

```
## 快速创建UI
```
/**label 背景色 字体颜色 对齐方式 行数 字体大小 文字*/
+(UILabel *)labelWithBackgroundColor:(UIColor *)backgrountColor textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines fontSize:(float) size font:(UIFont *)font text:(NSString *)text;

/**textField 背景色 字体颜色 是否密文 字体大小 文字 默认文字 文字对齐方式*/
+(UITextField *)textFieldWithBackgroundColor:(UIColor *)backgrountColor textColor:(UIColor *)textColor secureTextEntry:(BOOL)secureTextEntry fontSize:(float)size font:(UIFont *)font text:(NSString *)text placeholder:(NSString *)placeholder textAlignment:(NSTextAlignment)textAlignment;

/**textView 背景色 字体颜色 字体大小 文字 文字对齐方式*/
+(UITextView *)textViewWithBackgroundColor:(UIColor *)backgrountColor textColor:(UIColor *)textColor fontSize:(float)size font:(UIFont *)font text:(NSString *)text  textAlignment:(NSTextAlignment)textAlignment;

/**UIButton 背景色 默认文字颜色 默认文字 选中文字颜色 选中文字 字体大小 默认背景图片 选中背景图片 图片 选中图片*/
+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor titleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font backgroundImageForNormal:(NSString *)backgroundImageForNormal backgroundImageForSelete:(NSString *)backgroundImageForSelete imageForNormal:(NSString *)imageForNormal imageForSelete:(NSString *)imageForSelete;


/**UIButton 默认文字颜色 默认文字 选中文字颜色 选中文字 字体大小 默认背景图片 选中背景图片*/
+(UIButton *)buttonWithTitleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font backgroundImageForNormal:(NSString *)backgroundImageForNormal backgroundImageForSelete:(NSString *)backgroundImageForSelete;

/**UIButton 背景色 默认文字颜色 默认文字 选中文字颜色 选中文字 字体大小 图片 选中图片*/
+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor titleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font imageForNormal:(NSString *)imageForNormal imageForSelete:(NSString *)imageForSelete;

/**UIButton 背景色 默认文字颜色 默认文字 选中文字颜色 选中文字 字体大小*/
+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor titleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font;

/**UIButton 默认背景图片 选中背景图片*/
+(UIButton *)buttonWithBackgroundImageForNormal:(NSString *)backgroundImageForNormal backgroundImageForSelete:(NSString *)backgroundImageForSelete;

/**UIButton 背景色 图片 选中图片*/
+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor imageForNormal:(NSString *)imageForNormal imageForSelete:(NSString *)imageForSelete;


/**快速创建文字按钮 */
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)normalColor hilightedColor:(UIColor *)hilightedColor fontSize:(CGFloat)fontSize frame:(CGRect)frame;

/**快速创建图片按钮 */
+ (UIButton *)buttonWithImage:(UIImage *)image hilightedImage:(UIImage *)hilightedImage frame:(CGRect)frame;

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

```
## 设备有关
```

//获取系统版本
+ (CGFloat)systemVersion;
//当前手机是否支持PhotoKit照片库框架
+ (BOOL)canUsePhotiKit;
//拨打电话
+ (void)callPhoneNumber:(NSString *)phone;
//复制字符串到系统剪贴板
+ (void)copyToPasteboard:(NSString *)string;
//获取APP 名称
+ (NSString *)appName;
//获取APP Scheme
+ (NSString *)getApplicationScheme;
//设置网络活动指示符可见(导航栏旋转图标)
+ (void)setNetworkActivityIndicatorVisible:(BOOL)visible;
//保存图片到系统相册
+ (void)saveImageToPhotoAlbum:(UIImage *)image;
//保存视频到系统相册
+ (void)saveVideoToPhotoAlbum:(NSString *)videoPath;
//设备型号名称
+ (NSString *)deviceModelName;
//获取根视图
+ (UIViewController *)rootViewController;
//获取window
+ (UIWindow *)currentWindow;
//可获取window并且添加showInWidow弹窗
+ (UIWindow *)popOverWindow;
//获取当前控制器所在
+ (UIViewController *)getCurrentVC;
//添加一个View到Window
+ (void)addViewToPopOverWindow:(UIView *)view;
//从window移除View
+ (void)removeViewFromPopOverWindow:(UIView *)view;
//获取Appdelegate
+ (AppDelegate *)appDelegate;
//获取当前View所在的控制器
+ (UIViewController *)viewControllerForView:(UIView *)view;
//移除控制器上所有的子视图以及其他控制器
+ (void)removeViewControllerFromParentViewController:(UIViewController *)viewController;
//开始观察runloop
+ (void)startObserveRunLoop;
//开始停止runloop
+ (void)stopObserveRunLoop;


```

## 文件管理

```
#define  SW_fileManager [NSFileManager defaultManager]
#define DATAPATHDIRECTORY @"/Library/ATAPPDATA/Movies_"  //可自定义
#define MessageThumbnailDirectory @"MessageThumbnailDir/" //可自定(消息路径)

//沙河文件主目录
+ (NSString *)homeDirectory;
//文件目录
+ (NSString *)documentDirectory;
//缓存目录
+ (NSString *)cacheDirectory;
//临时目录
+ (NSString *)tmpDirectory;
//获取Storyboard
+ (UIStoryboard *)mainStoryboard;
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


```


## 文本字符工具

```
//配置
#define URL_MAIL_SCHEME @"mailto"
#define URL_HTTP_SCHEME @"http"
#define URL_HTTPS_SCHEME @"https"
#define kSWTextLinkColor [UIColor redColor]

//获取文字自适应
+ (CGFloat)widthForSingleLineString:(NSString *)text font:(UIFont *)font;
//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstPinyinLetterOfString:(NSString *)aString;
//获取拼音
+ (NSString *)pinyinOfString:(NSString *)aString;
+ (NSString *)sizeStringWithStyle:(nullable id)style size:(long long)size;
//获取文字自适应
+ (CGSize)boundingSizeForText:(NSString *)text maxWidth:(CGFloat)maxWidth font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;
+ (NSMutableAttributedString *)highlightDefaultDataTypes:(NSMutableAttributedString *)attributedString;
 //获取文本宽
+ (CGFloat)getTextWidth:(UILabel *)lable;
//获取文本高
+ (CGFloat)getTextHeight:(UILabel *)lable;
//配置
#define URL_MAIL_SCHEME @"mailto"
#define URL_HTTP_SCHEME @"http"
#define URL_HTTPS_SCHEME @"https"
#define kSWTextLinkColor [UIColor redColor]

//获取文字自适应
+ (CGFloat)widthForSingleLineString:(NSString *)text font:(UIFont *)font;
//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstPinyinLetterOfString:(NSString *)aString;
//获取拼音
+ (NSString *)pinyinOfString:(NSString *)aString;
+ (NSString *)sizeStringWithStyle:(nullable id)style size:(long long)size;
//获取文字自适应
+ (CGSize)boundingSizeForText:(NSString *)text maxWidth:(CGFloat)maxWidth font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;
+ (NSMutableAttributedString *)highlightDefaultDataTypes:(NSMutableAttributedString *)attributedString;
 //获取文本宽
+ (CGFloat)getTextWidth:(UILabel *)lable;
//获取文本高
+ (CGFloat)getTextHeight:(UILabel *)lable;
```

## 视频工具

```
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
```

## 字符串加密工具
```
 //配置AfferentString 传入需要操作的字符串

+ (NSString *) md5:(NSString *)AfferentString;
+ (NSString *) sha1:(NSString *)AfferentString;
+ (NSString *) sha1_base64:(NSString *)AfferentString;
+ (NSString *) md5_base64:(NSString *)AfferentString;
+ (NSString *) base64:(NSString *)AfferentString;

```

## 设备权限工具
```
//配置
#define iOS10Later ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
+(BOOL)isAuthorizationStatus;
+(BOOL)isRecord;
+(BOOL)isLocation;
+(void)versionsJudge;
```

## 颜色工具
```
//传入16进制字符 比如@"#FFF000" 返回一个颜色值
+ (UIColor *)colorWithHexString:(NSString *)color;
//传入16进制字符 比如@"#FFF000" 可设置透明度 返回一个颜色值
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
//获取随机颜色值 一般用于测试UI布局控件
+ (UIColor *)randomColor;
//获取随机颜色值 一般用于测试UI布局控件 可设置透明度
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;

```


## 图片处理工具
```
//配置使用,传入image即可返回一个image对象

//通过View来绘制一张图片
+ (UIImage *)imageWithView:(UIView *)view;
//通过颜色值来获取一张图片 可设置大小
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
//通过颜色值来获取一张图片
+ (UIImage *)imageWithColor:(UIColor *)color;
//可调整大小的图像
- (UIImage *)resizableImage:(UIImage *)image;
//可调整大小的图像
- (UIImage *)resizeImageToSize:(CGSize)size image:(UIImage *)image;
//绘制可调整大小的图像 并且可调整系数
- (UIImage *)resizeImageToSize:(CGSize)size
                        opaque:(BOOL)opaque
                         scale:(CGFloat)scale
                         image:(UIImage *)image;
//在rect创建图像
- (UIImage *)createWithImageInRect:(CGRect)rect dataImage:(UIImage *)dataImage;
//获取灰度的图像
- (UIImage *)getGrayImage:(UIImage *)image;
//获取变暗的图像
- (UIImage *)darkenImage:(UIImage *)image;

- (UIImage *) partialImageWithPercentage:(float)percentage
                                vertical:(BOOL)vertical
                           grayscaleRest:(BOOL)grayscaleRest
                               dataImage:(UIImage *)dataImage;
//获取图片的像素大小
- (CGSize)pixelSize:(UIImage *)image;
//获取图像文件的大小
- (NSInteger)imageFileSize:(UIImage *)image;

//GIF图片专区
+ (UIImage *)sw_animatedGIFNamed:(NSString *)name;
//传入Data类型返回一个gif图片
+ (UIImage *)sw_animatedGIFWithData:(NSData *)data;
//动画裁剪大小
- (UIImage *)sw_animatedImageByScalingAndCroppingToSize:(CGSize)size image:(UIImage *)image;
//GIF动画帧index source文件 --> CGImageSourceCreateWithData((__bridge CFDataRef)(gifData), NULL);
+ (float)sw_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source;


```

## UIView拓展工具

```
//获取当前view所在的控制器
- (UIViewController*)getCurrentViewController;
//获取当前类的XIB 类直接调用
+(instancetype)sw_viewFromXib;
//view直接添加手势
- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action;
- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action target:(id)target;
//添加长按手势
- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action duration:(CGFloat)duration;
//添加长按手势 几秒后相应
- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action target:(id)target duration:(CGFloat)duration;
//移除当前View所有子视图
- (void)removeAllSubviews;

```

## NSDate拓展工具

```



- (NSUInteger)day;
- (NSUInteger)month;
- (NSUInteger)year;
- (NSUInteger)hour;
- (NSUInteger)minute;
- (NSUInteger)second;
+ (NSUInteger)day:(NSDate *)date;
+ (NSUInteger)month:(NSDate *)date;
+ (NSUInteger)year:(NSDate *)date;
+ (NSUInteger)hour:(NSDate *)date;
+ (NSUInteger)minute:(NSDate *)date;
+ (NSUInteger)second:(NSDate *)date;
// 获取格式化为 YYYY年MM月dd日 格式的日期字符串
- (NSString *)formatYMD;
- (NSString *)formatYMDWith:(NSString *)c;
- (NSString *)formatHM;
// 获取星期几
- (NSInteger)weekday;
+ (NSInteger)weekday:(NSDate *)date;
//获取星期几(名称)
- (NSString *)dayFromWeekday;
+ (NSString *)dayFromWeekday:(NSDate *)date;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)dateByAddingDays:(NSUInteger)days;
//获取月份
+ (NSString *)monthWithMonthNumber:(NSInteger)month;
//根据日期返回字符串
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)stringWithFormat:(NSString *)format;
+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format;
//获取指定月份的天数
- (NSUInteger)daysInMonth:(NSUInteger)month;
+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month;
//获取当前月份的天数
- (NSUInteger)daysInMonth;
+ (NSUInteger)daysInMonth:(NSDate *)date;
// 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
- (NSString *)timeInfo;
+ (NSString *)timeInfoWithDate:(NSDate *)date;
+ (NSString *)timeInfoWithDateString:(NSString *)dateString;
```


# 工具使用,拖入到工程即可;如果有什么建议~可以私信我的邮箱,392287145@qq.com 🙏 cocopods 可使用
