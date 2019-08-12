//
//  SWKit.m
//  SWKit
//
//  Created by Shiwen Huang on 2018/6/21.
//  Copyright © 2018年 .SW. All rights reserved.
//

#import "SWKit.h"
 
static CFRunLoopObserverRef observer;

#pragma mark -
#pragma mark - SWKit 工具框架
#pragma mark -

CGFloat SCREEN_WIDTH;
CGFloat SCREEN_HEIGHT;
CGSize SCREEN_SIZE;
CGRect SCREEN_FRAME;
CGPoint SCREEN_CENTER;

//static SDImageCache *circlePicCache;

static BOOL isYouKe = NO;


@implementation SWKit

#pragma mark - 通用

+ (void)setIsYoukeLogon:(BOOL)isYk{
    isYouKe = isYk;
}
+ (BOOL)isYouke{
    return isYouKe;
}
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SCREEN_FRAME = [UIScreen mainScreen].bounds;
        SCREEN_SIZE = SCREEN_FRAME.size;
        SCREEN_WIDTH = SCREEN_SIZE.width;
        SCREEN_HEIGHT = SCREEN_SIZE.height;
        SCREEN_CENTER = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    });
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
+(UILabel *)labelWithBackgroundColor:(UIColor *)backgrountColor textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines fontSize:(float)size font:(UIFont *)font text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    if (backgrountColor) {
        label.backgroundColor = backgrountColor;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    if (text) {
        label.text = text;
    }
    label.numberOfLines = numberOfLines;
    label.textAlignment = textAlignment;
    if (size>0) {
        label.font = [UIFont systemFontOfSize:size];
    }else
        label.font = font;
        return label;
}

+ (UILabel *)labelWithText:(NSString *)text
                  fontSize:(CGFloat)fontSize
                 textColor:(UIColor*)color
             textAlignment:(NSTextAlignment)textAlignment
                     frame:(CGRect)frame
{
    UILabel *aLabel = [[UILabel alloc] initWithFrame:frame];
    aLabel.font = [UIFont systemFontOfSize:fontSize];
    aLabel.textColor = color;
    aLabel.text = text;
    aLabel.textAlignment = textAlignment;
    if ([text isEqualToString:@"您还未实名认证\n实名后才可以打赏哦~"]) {
        aLabel.numberOfLines = 2;
    } 
    return aLabel;
}

+ (id)yy_labelWithText:(NSString *)text
              fontSize:(CGFloat)fontSize
             textColor:(UIColor*)color
         textAlignment:(NSTextAlignment)textAlignment
                 frame:(CGRect)frame
                 block:(void(^)(void))actionBlock{
    
//    YYLabel * yylable = [[YYLabel alloc]initWithFrame:frame];
//    yylable.textAlignment = textAlignment;
//    yylable.text = text;
//    yylable.font = [UIFont systemFontOfSize:fontSize];
//    yylable.textColor = color;
//    [yylable setTextTapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//        actionBlock();
//    }];
    return [UILabel new];
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
+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor titleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font backgroundImageForNormal:(NSString *)backgroundImageForNormal backgroundImageForSelete:(NSString *)backgroundImageForSelete imageForNormal:(NSString *)imageForNormal imageForSelete:(NSString *)imageForSelete
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (backgrountColor) {
        [button setBackgroundColor:backgrountColor];
    }
    if (titleForNormal) {
        [button setTitle:titleForNormal forState:0];
    }
    if (titleForSelete) {
        [button setTitle:titleForSelete forState:UIControlStateSelected];
    }
    if (titleColorForNormal) {
        [button setTitleColor:titleColorForNormal forState:0];
    }
    if (titleColorForSelete) {
        [button setTitleColor:titleColorForSelete forState:UIControlStateSelected];
    }
    if (size>0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }else
        button.titleLabel.font = font;
        if (backgroundImageForNormal) {
            [button setBackgroundImage: [UIImage imageNamed:backgroundImageForNormal] forState:0];
        }
    if (backgroundImageForSelete) {
        [button setBackgroundImage: [UIImage imageNamed:backgroundImageForSelete] forState:UIControlStateSelected];
    }
    if (imageForNormal) {
        [button setImage: [UIImage imageNamed:imageForNormal] forState:0];
    }
    if (imageForSelete) {
        [button setImage: [UIImage imageNamed:imageForSelete] forState:UIControlStateSelected];
    }
    return button;
}

+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor titleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font imageForNormal:(NSString *)imageForNormal imageForSelete:(NSString *)imageForSelete
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (backgrountColor) {
        [button setBackgroundColor:backgrountColor];
    }
    if (titleForNormal) {
        [button setTitle:titleForNormal forState:0];
    }
    if (titleForSelete) {
        [button setTitle:titleForSelete forState:UIControlStateSelected];
    }
    if (titleColorForNormal) {
        [button setTitleColor:titleColorForNormal forState:0];
    }
    if (titleColorForSelete) {
        [button setTitleColor:titleColorForSelete forState:UIControlStateSelected];
    }
    if (size>0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }else
        button.titleLabel.font = font;
        if (imageForNormal) {
            [button setImage: [UIImage imageNamed:imageForNormal] forState:0];
        }
    if (imageForSelete) {
        [button setImage: [UIImage imageNamed:imageForSelete] forState:UIControlStateSelected];
    }
    return button;
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

+(UIButton *)buttonWithTitleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font backgroundImageForNormal:(NSString *)backgroundImageForNormal backgroundImageForSelete:(NSString *)backgroundImageForSelete
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (titleForNormal) {
        [button setTitle:titleForNormal forState:0];
    }
    if (titleForSelete) {
        [button setTitle:titleForSelete forState:UIControlStateSelected];
    }
    if (titleColorForNormal) {
        [button setTitleColor:titleColorForNormal forState:0];
    }
    if (titleColorForSelete) {
        [button setTitleColor:titleColorForSelete forState:UIControlStateSelected];
    }
    if (size>0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }else
        button.titleLabel.font = font;
        if (backgroundImageForNormal) {
            [button setBackgroundImage: [UIImage imageNamed:backgroundImageForNormal] forState:0];
        }
    if (backgroundImageForSelete) {
        [button setBackgroundImage: [UIImage imageNamed:backgroundImageForSelete] forState:UIControlStateSelected];
    }
    return button;
}

+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor titleColorForNormal:(UIColor *)titleColorForNormal titleForNormal:(NSString *)titleForNormal titleForSelete:(NSString *)titleForSelete titleColorForSelete:(UIColor *)titleColorForSelete  fontSize:(float)size font:(UIFont *)font
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (titleForNormal) {
        [button setTitle:titleForNormal forState:0];
    }
    if (titleForSelete) {
        [button setTitle:titleForSelete forState:UIControlStateSelected];
    }
    if (titleColorForNormal) {
        [button setTitleColor:titleColorForNormal forState:0];
    }
    if (titleColorForSelete) {
        [button setTitleColor:titleColorForSelete forState:UIControlStateSelected];
    }
    if (size>0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }else
        button.titleLabel.font = font;
        if (backgrountColor) {
            [button setBackgroundColor:backgrountColor];
        }
    return button;
}

+(UIButton *)buttonWithBackgroundImageForNormal:(NSString *)backgroundImageForNormal backgroundImageForSelete:(NSString *)backgroundImageForSelete
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (backgroundImageForNormal) {
        [button setBackgroundImage: [UIImage imageNamed:backgroundImageForNormal] forState:0];
    }
    
    if (backgroundImageForSelete) {
        [button setBackgroundImage: [UIImage imageNamed:backgroundImageForSelete] forState:UIControlStateSelected];
    }
    
    return button;
}

+(UIButton *)buttonWithBackgroundColor:(UIColor *)backgrountColor imageForNormal:(NSString *)imageForNormal imageForSelete:(NSString *)imageForSelete
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (backgrountColor) {
        [button setBackgroundColor:backgrountColor];
    }
    if (imageForNormal) {
        [button setImage: [UIImage imageNamed:imageForNormal] forState:0];
    }
    
    if (imageForSelete) {
        [button setImage: [UIImage imageNamed:imageForSelete] forState:UIControlStateSelected];
    }
    
    return button;
}
+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)normalColor
               hilightedColor:(UIColor *)hilightedColor
                     fontSize:(CGFloat)fontSize
                        frame:(CGRect)frame
{
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [aButton setTitle:title forState:UIControlStateNormal];
    [aButton setTitleColor:normalColor forState:UIControlStateNormal];
    if (hilightedColor) {
        [aButton setTitleColor:hilightedColor forState:UIControlStateHighlighted];
    }
    aButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    aButton.frame = frame;
    return aButton;
}

+ (UIButton *)buttonWithImage:(UIImage *)image
               hilightedImage:(UIImage *)hilightedImage
                        frame:(CGRect)frame
{
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setImage:image forState:UIControlStateNormal];
    if (hilightedImage) {
        [aButton setImage:hilightedImage forState:UIControlStateHighlighted];
    }
    aButton.frame = frame;
    return aButton;
}


+ (UIButton *)buttonWithBgImage:(UIImage *)image hilightedBgImage:(UIImage *)hilightedBgImage frame:(CGRect)frame text:(NSString *)text font:(NSInteger)font color:(UIColor *)textColor
{
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setBackgroundImage:image forState:UIControlStateNormal];
    if (hilightedBgImage) {
        [aButton setBackgroundImage:hilightedBgImage forState:UIControlStateHighlighted];
        [aButton setBackgroundImage:hilightedBgImage forState:UIControlStateSelected];
    }
    if (text) {
        [aButton setTitle:text forState:UIControlStateNormal];
        [aButton setTitleColor:textColor forState:UIControlStateNormal];
    }
    if (font) {
        aButton.titleLabel.font = [UIFont systemFontOfSize:font];
    }
    aButton.frame = frame;
    return aButton;
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

+(NSString *)appName{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
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


+(NSString *)getApplicationScheme{
    NSDictionary *bundleInfo    = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier  = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *URLTypes           = [bundleInfo valueForKey:@"CFBundleURLTypes"];
    
    NSString *scheme;
    for (NSDictionary *dic in URLTypes)
    {
        NSString *URLName = [dic valueForKey:@"CFBundleURLName"];
        if ([URLName isEqualToString:bundleIdentifier])
        {
            scheme = [[dic valueForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
            break;
        }
    }
    
    return scheme;
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
+ (NSString *)deviceModelName
{
    NSString *platform = [self devicePlatformVersion];
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 1";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4s";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])  return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 Plus";
      if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
      if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
      if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
      if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
      if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
      if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
      if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
      if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
      if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
      if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
      if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    //iPot Touch
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5";
    //iPad
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad air";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad air";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad air";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad air 2";
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad air 2";
    if ([platform isEqualToString:@"iPhone Simulator"] || [platform isEqualToString:@"x86_64"] || [platform isEqualToString:@"i386"]) return @"iPhone Simulator";
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


+(void)setNetworkActivityIndicatorVisible:(BOOL)visible{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
}

+ (UIViewController *)rootViewController {
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

+ (UIWindow *)currentWindow {
    return [UIApplication sharedApplication].delegate.window;
}

 
+ (UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        nextResponder = window.rootViewController;
    }
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
        
        //        if ([appRootVC isKindOfClass:[UITabBarController class]]){
        //            UITabBarController * tabbar = (UITabBarController *)appRootVC;
        //            UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //            result=nav.childViewControllers.lastObject;
        //
        //        }else if ([appRootVC isKindOfClass:[UINavigationController class]]){
        //            UIViewController * nav = (UIViewController *)appRootVC;
        //            result = nav.childViewControllers.lastObject;
        //        }
        
    }
    return result;
}



//+ (AppDelegate *)appDelegate {
//    return (AppDelegate *)[UIApplication sharedApplication].delegate;
//}

+ (UIViewController *)viewControllerForView:(UIView *)view {
    if (!view) return nil;
    UIResponder *responder = view.nextResponder;
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }
    
    return nil;
}

+ (void)removeViewControllerFromParentViewController:(UIViewController *)viewController {
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}

+ (void)addViewController:(UIViewController *)viewController  toViewController:(UIViewController *)parentViewController {
    [parentViewController addChildViewController:viewController];
    //    viewController.view.frame = parentViewController.view.bounds;
    [parentViewController.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:parentViewController];
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

+ (NSString *)getHiddenStringWithStar:(NSString *)string{
    
    if (string.length>1) {
        
        if (string.length>=11) {
            return [NSString stringWithFormat:@"%@****%@",[string substringToIndex:3],[string substringFromIndex:string.length-4]];
        }
        else
        {
            NSString *replacString;
            for (int i=0; i<string.length; i++) {
                
                if (i<string.length-1) {
                    if (replacString.length>0 && replacString!=nil) {
                        replacString = [replacString stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
                    }
                    else
                        replacString = [string stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
                }
            }
            return replacString;
        }
    }
    else
    {
        return string;
    }
}

//- (void)doFireTimer:(NSTimer *)timer {
//    NSLog(@"doFireTimer");
//}
//＝＝＝observer的回调函数：
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

+(NSString *)messageThumbnailDirectory{
    static NSString * sw_dataPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sw_dataPath = [NSString stringWithFormat:@"%@/%@",[self documentDirectory],MessageThumbnailDirectory];
    });
    //存在就返回，不存在就创建
    if (![SW_fileManager fileExistsAtPath:sw_dataPath]) {
        NSError * error ;
        [SW_fileManager createDirectoryAtPath:sw_dataPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return sw_dataPath;
}
+(UIStoryboard *)mainStoryboard{
    static UIStoryboard * sw_MainStroyBoad;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sw_MainStroyBoad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    });
    return  sw_MainStroyBoad;
}


+(NSURL *)createFolderWithName:(NSString *)folderName inDirectory:(NSString *)directory{
    
    NSString * path = [directory stringByAppendingPathComponent:folderName];
    NSURL * folderURL = [NSURL URLWithString:path];
    if (![SW_fileManager fileExistsAtPath:path]) {
        NSError * error ;
        [SW_fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
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

+(NSString *)dataPath{
    static NSString * sw_dataPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sw_dataPath = [NSString stringWithFormat:@"%@%@",[self homeDirectory],DATAPATHDIRECTORY];
 
    });
    if (![SW_fileManager fileExistsAtPath:sw_dataPath]) {
        [SW_fileManager createDirectoryAtPath:sw_dataPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return sw_dataPath;
}


+(void)writeImageAtPath:(NSString *)path image:(UIImage *)image{
 
    [SW_fileManager createFileAtPath:path contents:UIImageJPEGRepresentation(image, 1) attributes:nil];
}

+(unsigned long long)getFileSize:(NSString *)path{
    unsigned long long fileSize = 0;
    if ([SW_fileManager fileExistsAtPath:path]) {
        //获取文件的属性
        fileSize = [[SW_fileManager attributesOfItemAtPath:path error:nil][NSFileSize] longLongValue];
    }
    return fileSize;
}
+ (CGSize)getSingleSize:(CGSize)singleSize max:(CGFloat)max
{
    CGFloat max_width = SCREEN_WIDTH - max;
    CGFloat max_height = SCREEN_WIDTH - max;
    CGFloat image_width = singleSize.width;
    CGFloat image_height = singleSize.height;
    
    CGFloat result_width = 0;
    CGFloat result_height = 0;
    if (image_height/image_width > 3.0) {
        result_height = max_height;
        result_width = result_height/2;
    }  else  {
        result_width = max_width;
        result_height = max_width*image_height/image_width;
        if (result_height > max_height) {
            result_height = max_height;
            result_width = max_height*image_width/image_height;
        }
    }
    return CGSizeMake(result_width, result_height);
}
 

#pragma mark - 文本工具

+ (NSString *)sizeStringWithStyle:(id)style size:(long long)size {
    if (size < 1024 * 1024) {
        return [NSString stringWithFormat:@"%ldK", (long)size/1024];
    }else {
        return [NSString stringWithFormat:@"%.1fM", size/(1024 * 1024.0)];
    }
}

+ (CGSize)boundingSizeForText:(NSString *)text maxWidth:(CGFloat)maxWidth font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    CGSize calSize = CGSizeMake(maxWidth, MAXFLOAT);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = lineSpacing;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName: paragraphStyle
                                 };
    
    
    CGRect rect = [text boundingRectWithSize:calSize
                                     options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    
    return rect.size;
}

+ (CGFloat)widthForSingleLineString:(NSString *)text font:(UIFont *)font {
    
    CGRect rect = [text
                   boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                   options:0
                   attributes:@{NSFontAttributeName:font}
                   context:nil];
    return rect.size.width;
    
}


//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstPinyinLetterOfString:(NSString *)aString
{
    if (aString.length == 0)
        return nil;
    
    //首字符就是字母
    unichar C = [aString characterAtIndex:0];
    if((C<= 'Z' && C>='A') || (C <= 'z' && C >= 'a')) {
        //转化为大写拼音
        NSString *pinYin = [[aString substringToIndex:1] capitalizedString];
        //获取并返回首字母
        return pinYin;
    }
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:[aString substringToIndex:1]];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstPinyinCharactorOfString:(NSString *)aString
{
    if (aString.length == 0)
        return nil;
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:[aString substringToIndex:1]];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return pinYin;
}


//获取拼音
+ (NSString *)pinyinOfString:(NSString *)aString
{
    if (aString.length == 0)
        return nil;
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return pinYin;
}



+ (NSMutableAttributedString *)highlightDefaultDataTypes:(NSMutableAttributedString *)attributedString {
    
    NSError *error;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber | NSTextCheckingTypeLink
                                                               error:&error];
    NSArray *matches = [detector matchesInString:attributedString.string
                                         options:kNilOptions
                                           range:NSMakeRange(0, [attributedString length])];
    
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        BOOL shouldHighlight = NO;
        
        if ([match resultType] == NSTextCheckingTypeLink) {
            NSURL *url = [match URL];
            if ([url.scheme isEqualToString:URL_MAIL_SCHEME] ||
                [url.scheme isEqualToString:URL_HTTP_SCHEME] ||
                [url.scheme isEqualToString:URL_HTTPS_SCHEME]) {
                shouldHighlight = YES;
            }
        }else if ([match resultType] == NSTextCheckingTypePhoneNumber) {
            shouldHighlight = YES;
        }
        
        if (shouldHighlight) {
            [attributedString addAttribute:NSForegroundColorAttributeName value:kSWTextLinkColor range:matchRange];
        }
        
    }
    
    return attributedString;
}
//获取文本宽
+ (CGFloat)getTextWidth:(UILabel *)lable{
    CGSize newSize = [lable.text boundingRectWithSize:CGSizeMake(MAXFLOAT, lable.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lable.font} context:nil].size;
    
    return newSize.width;
}
//获取文本高
+ (CGFloat)getTextHeight:(UILabel *)lable{
    CGSize newSize = [lable.text boundingRectWithSize:CGSizeMake(lable.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lable.font} context:nil].size;
    return newSize.height;
}

+ (NSInteger)hideLabelLayoutHeight:(NSString *)content withTextFontSize:(CGFloat)mFontSize lineSpacing:(CGFloat)spac
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = spac;  // 段落高度

    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:content];
    
    [attributes addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:mFontSize] range:NSMakeRange(0, content.length)];
    [attributes addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
    
    CGSize attSize = [attributes boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-54, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    return attSize.height;
}

+ (NSString *)getRandomString
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

#pragma mark - 视频工具

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
    
    NSString *mp4Path = [NSString stringWithFormat:@"%@/%@.mp4", [self dataPath], [self md5:path]];
    
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
                
                [[self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
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
                
                [[self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
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
#pragma mark - 字符加密工具
+ (NSString*) sha1:(NSString *)AfferentString{
    const char *cstr = [AfferentString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:AfferentString.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}
+ (NSString *) md5 :(NSString *)AfferentString{
    const char *cStr = [AfferentString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}
+ (NSString *) sha1_base64:(NSString *)AfferentString {
    const char *cstr = [AfferentString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:AfferentString.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    NSString* encodeResult = [base64 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodeResult;
}
+ (NSString *) md5_base64 :(NSString *)AfferentString{
    const char *cStr = [AfferentString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    NSString* encodeResult = [base64 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodeResult;
}

+ (NSString *) base64 :(NSString *)AfferentString{
    NSData * data = [AfferentString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString* encodeResult = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodeResult;
}

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

#pragma mark - 颜色工具

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

+ (UIColor *)randomColor {
    CGFloat red = arc4random_uniform(256) / 255.0;
    CGFloat green = arc4random_uniform(256) / 255.0;
    CGFloat blue = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha {
    CGFloat red = arc4random_uniform(256) / 255.0;
    CGFloat green = arc4random_uniform(256) / 255.0;
    CGFloat blue = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
#pragma mark - 图片处理工具




#pragma mark   -  图片
/**  压缩图片*/
+ (UIImage *)imageWithOriginalImage:(UIImage *)image{
    // 宽高比
    CGFloat ratio = image.size.width/image.size.height;
    
    // 目标大小
    CGFloat targetW = 1280;
    CGFloat targetH = 1280;
    
    // 宽高均 <= 1280，图片尺寸大小保持不变
    if (image.size.width<1280 && image.size.height<1280) {
        return image;
    }
    // 宽高均 > 1280 && 宽高比 > 2，
    else if (image.size.width>1280 && image.size.height>1280){
        
        // 宽大于高 取较小值(高)等于1280，较大值等比例压缩
        if (ratio>1) {
            targetH = 1280;
            targetW = targetH * ratio;
        }
        // 高大于宽 取较小值(宽)等于1280，较大值等比例压缩
        else{
            targetW = 1280;
            targetH = targetW / ratio;
        }
        
    }
    // 宽或高 > 1280
    else{
        // 宽图 图片尺寸大小保持不变
        if (ratio>2) {
            targetW = image.size.width;
            targetH = image.size.height;
        }
        // 长图 图片尺寸大小保持不变
        else if (ratio<0.5){
            targetW = image.size.width;
            targetH = image.size.height;
        }
        // 宽大于高 取较大值(宽)等于1280，较小值等比例压缩
        else if (ratio>1){
            targetW = 1280;
            targetH = 1280 / ratio;
        }
        // 高大于宽 取较大值(高)等于1280，较小值等比例压缩
        else{
            targetH = 1280;
            targetW = 1280 * ratio;
        }
    }
    
    image = [[SWKit alloc] imageCompressWithImage:image targetHeight:targetH targetWidth:targetW];
    
    
    return image;
}

/**  重绘*/
- (UIImage *)imageCompressWithImage:(UIImage *)sourceImage targetHeight:(CGFloat)targetHeight targetWidth:(CGFloat)targetWidth
{
    //    CGFloat targetHeight = (targetWidth / sourceImage.size.width) * sourceImage.size.height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**  压缩图片 压缩质量 0 -- 1*/
+ (UIImage *)imageWithOriginalImage:(UIImage *)image quality:(CGFloat)quality{
    
    UIImage *newImage = [self imageWithOriginalImage:image];
    NSData *imageData = UIImageJPEGRepresentation(newImage, quality);
    return [UIImage imageWithData:imageData];
}

/**  压缩图片成Data*/
+ (NSData *)dataWithOriginalImage:(UIImage *)image{
    return UIImageJPEGRepresentation([self imageWithOriginalImage:image], 1);
}

+ (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage*)getGrayImage:(UIImage *)image
{
    int width = image.size.width;
    int height = image.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), image.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    
    return grayImage;
}

- (UIImage *)resizableImage:(UIImage *)image {
    CGFloat capWidth =  floorf(image.size.width / 2);
    CGFloat capHeight =  floorf(image.size.height / 2);
    UIImage *capImage = [image resizableImageWithCapInsets:
                         UIEdgeInsetsMake(capHeight, capWidth, capHeight, capWidth)];
    
    return capImage;
}


+ (UIImage *)createWithImageInRect:(CGRect)rect dataImage:(UIImage *)dataImage{
    CGImageRef imageRef = CGImageCreateWithImageInRect([dataImage CGImage],rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:dataImage.scale orientation:dataImage.imageOrientation];
    CGImageRelease(imageRef);
    
    return image;
}

+ (UIImage *)darkenImage:(UIImage *)image{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    [[UIColor redColor] setFill];
    
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)
           blendMode:kCGBlendModeDarken
               alpha:0.6];
    UIImage *highlighted = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return highlighted;
}

//http://stackoverflow.com/questions/1298867/convert-image-to-grayscale
+ (UIImage *) partialImageWithPercentage:(float)percentage vertical:(BOOL)vertical grayscaleRest:(BOOL)grayscaleRest
dataImage:(UIImage *)dataImage{
    const int ALPHA = 0;
    const int RED = 1;
    const int GREEN = 2;
    const int BLUE = 3;
    
    // Create image rectangle with current image width/height
    //创建当前图像宽度/高度的图像矩形
    CGRect imageRect = CGRectMake(0, 0, dataImage.size.width * dataImage.scale, dataImage.size.height * dataImage.scale);
    
    int width = imageRect.size.width;
    int height = imageRect.size.height;
    
    // the pixels will be painted to this array
    //像素将被绘制到这个数组中
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    //清除像素以保持透明度
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    //创建一个RGBA像素背景
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    //将位图绘制到填充像素数组的上下文中
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [dataImage CGImage]);
    
    int x_origin = vertical ? 0 : width * percentage;
    int y_to = vertical ? height * (1.f -percentage) : height;
    
    for(int y = 0; y < y_to; y++) {
        for(int x = x_origin; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            
            if (grayscaleRest) {
                // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
                uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
                
                // set the pixels to gray
                rgbaPixel[RED] = gray;
                rgbaPixel[GREEN] = gray;
                rgbaPixel[BLUE] = gray;
            }
            else {
                rgbaPixel[ALPHA] = 0;
                rgbaPixel[RED] = 0;
                rgbaPixel[GREEN] = 0;
                rgbaPixel[BLUE] = 0;
            }
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image
                                                 scale:dataImage.scale
                                           orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(image);
    
    return resultUIImage;
}

+ (CGSize)pixelSize:(UIImage *)image{
    return CGSizeMake(image.size.width * image.scale, image.size.height * image.scale);
}

+ (NSInteger)imageFileSize:(UIImage *)image {
    return image.size.width * image.size.height * image.scale * image.scale * 4;
}



+ (UIImage *)sw_animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            duration += [self sw_frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
}

+ (float)sw_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}

+ (UIImage *)sw_animatedGIFNamed:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return [self sw_animatedGIFWithData:data];
        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [self sw_animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
    else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [self sw_animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
}

- (UIImage *)sw_animatedImageByScalingAndCroppingToSize:(CGSize)size image:(UIImage *)image{
    if (CGSizeEqualToSize(image.size, size) || CGSizeEqualToSize(size, CGSizeZero)) {
        return image;
    }
    
    CGSize scaledSize = size;
    CGPoint thumbnailPoint = CGPointZero;
    
    CGFloat widthFactor = size.width / image.size.width;
    CGFloat heightFactor = size.height / image.size.height;
    CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor : heightFactor;
    scaledSize.width = image.size.width * scaleFactor;
    scaledSize.height = image.size.height * scaleFactor;
    
    if (widthFactor > heightFactor) {
        thumbnailPoint.y = (size.height - scaledSize.height) * 0.5;
    }
    else if (widthFactor < heightFactor) {
        thumbnailPoint.x = (size.width - scaledSize.width) * 0.5;
    }
    
    NSMutableArray *scaledImages = [NSMutableArray array];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
   
    [image.images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [image drawInRect:CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledSize.width, scaledSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        [scaledImages addObject:newImage];
    }];
    
    
    UIGraphicsEndImageContext();
    
    return [UIImage animatedImageWithImages:scaledImages duration:image.duration];
}

+(UIImage *)createNonInterpolatedUIImageFormCIImage:(NSString *)dataString withSize:(CGFloat)sizeMax{
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    // 2. 给滤镜添加数据
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    // 4. 显示二维码
    return [self toUIImageFormCIImage:image withSize:sizeMax];
}
+ (UIImage *)toUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+ (UIImageView *)getAccessoryImage{
    UIImageView * pushImage = [UIImageView new];
    pushImage.image = [UIImage imageNamed:@"组 16 拷贝"];
    pushImage.frame = CGRectMake(0, 0, 10  ,10);
    return pushImage;
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

@end





@implementation UIView (SWExt)

- (CGFloat)top {
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setMaxX:(CGFloat)maxX{
    
}
-(CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

-(void)setMaxY:(CGFloat)maxY{
    
}

-(CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}



- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}


- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

-(CGFloat)getX{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)left {
    return self.frame.origin.x;
}

-(CGFloat)getY{
    return CGRectGetMaxY(self.frame);
}
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}



- (UIViewController*)getCurrentViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
+(instancetype)sw_viewFromXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
#pragma mark -

- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self addGestureRecognizer:tap];
    
    return tap;
}

- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action target:(id)target numberTaps:(NSInteger)taps{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tap.numberOfTapsRequired = taps;
    tap.numberOfTouchesRequired = 1;
    
    [self addGestureRecognizer:tap];
    
    return tap;
}

- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action duration:(CGFloat)duration {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:action];
    longPress.minimumPressDuration = duration;
    [self addGestureRecognizer:longPress];
    
    return longPress;
}

- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action target:(id)target duration:(CGFloat)duration {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    longPress.minimumPressDuration = duration;
    [self addGestureRecognizer:longPress];
    
    return longPress;
}
-(void)removeAllSubviews{
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

@end


@implementation NSDate (Extension)

- (NSUInteger)day {
    return [NSDate day:self];
}

- (NSUInteger)month {
    return [NSDate month:self];
}

- (NSUInteger)year {
    return [NSDate year:self];
}

- (NSUInteger)hour {
    return [NSDate hour:self];
}

- (NSUInteger)minute {
    return [NSDate minute:self];
}

- (NSUInteger)second {
    return [NSDate second:self];
}

+ (NSUInteger)day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}


- (BOOL)isLeapYear {
    return [NSDate isLeapYear:self];
}

+ (BOOL)isLeapYear:(NSDate *)date {
    NSUInteger year = [date year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)formatYMD {
    return [NSString stringWithFormat:@"%lu年%02lu月%02lu日", (unsigned long)[self year],(unsigned long)[self month], (unsigned long)[self day]];
}

- (NSString *)formatYMDWith:(NSString *)c
{
    return [NSString stringWithFormat:@"%lu%@%02lu%@%02lu", (unsigned long)[self year], c, (unsigned long)[self month], c, (unsigned long)[self day]];
}

- (NSString *)formatHM {
    return [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)[self hour], (unsigned long)[self minute]];
}

- (NSInteger)weekday {
    return [NSDate weekday:self];
}

+ (NSInteger)weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)dayFromWeekday {
    return [NSDate dayFromWeekday:self];
}

+ (NSString *)dayFromWeekday:(NSDate *)date {
    switch([date weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (NSDate *)dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date stringWithFormat:format];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}

- (NSUInteger)daysInMonth:(NSUInteger)month {
    return [NSDate daysInMonth:self month:month];
}

+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)daysInMonth {
    return [NSDate daysInMonth:self];
}

+ (NSUInteger)daysInMonth:(NSDate *)date {
    return [self daysInMonth:date month:[date month]];
}

- (NSString *)timeInfo {
    return [NSDate timeInfoWithDate:self];
}

+ (NSString *)timeInfoWithDate:(NSDate *)date {
    return [self timeInfoWithDateString:[self stringWithDate:date format:@"yyyy-MM-dd HH:mm:ss"]];
}

+ (NSString *)timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self dateWithString:dateString format:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate month] - [date month]);
    int year = (int)([curDate year] - [date year]);
    int day = (int)([curDate day] - [date day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate month] == 1 && [date month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self daysInMonth:date month:[date month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate day] + (totalDays - (int)[date day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate month];
            int preMonth = (int)[date month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

+(NSString *)getNowTimeTimestamp3{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
    
}

+(NSString *)getOSSName{
    NSDate *date = [NSDate date];
    //获取当前时间
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYYMMDDHHMMSS"];
    NSString *curretDateAndTime = [dateFormat stringFromDate:date];
    return curretDateAndTime;
}

#pragma mark - 将某个时间转化成 时间戳

+(NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];

    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdat
    //时间转时间戳的方法:
//    *1000 = 13位数
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    SWLog(@"==%@",timeSp);
    return timeSp;
    
}

//获取当前时分秒
+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@" HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
}
    
@end

#import "SWNavigationViewController.h"
@implementation SWSuperViewContoller


-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
/**
 *  懒加载UITableView
 *
 *  @return UITableView
 */
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - SafeBottomHeight) style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.scrollsToTop = YES;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorColor = [SWKit colorWithHexString:@"#F5F5F5"];
        _tableView.delaysContentTouches = NO;
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
/**
 *  懒加载collectionView
 *
 *  @return collectionView
 */
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemW = (SCREEN_WIDTH - 45)/2;
        flow.itemSize = CGSizeMake(itemW, itemW);
        flow.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT - NavBarHeight - SafeBottomHeight) collectionViewLayout:flow];
        _collectionView.scrollsToTop = YES;
    }
    return _collectionView;
}

-(void)setNavEnable:(BOOL)isEnable{
    SWNavigationViewController  * nav = (SWNavigationViewController*)self.navigationController;
    nav.isEnabled = isEnable;
}

- (void) setStatusBarHidden:(BOOL) hidden {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [[UIApplication sharedApplication] setStatusBarHidden:hidden];
#pragma clang diagnostic pop
}

- (void) setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void) setNavigationBarTitle:(NSString *)title {
    self.navigationItem.title = title;
}

- (void) setNavigationBarTitleColor:(UIColor *)color {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
}

- (void) setNavigationBarBackgroundColor:(UIColor *)color {
    [self.navigationController.navigationBar setBackgroundColor:color];
}

- (void) setNavigationBarBackgroundImage:(UIImage *)image {
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void) setStatusBarStyle:(UIStatusBarStyle)style {
    [UIApplication sharedApplication].statusBarStyle = style;
}

- (void) setNavigationBarShadowImage:(UIImage *)image {
    [self.navigationController.navigationBar setShadowImage:image];
}

- (void) back {
    [self.navigationController popViewControllerAnimated:true];
}
- (void)dispatch_after_Back{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:true];
    });
}
- (void) backRoot  {
    [self.navigationController popToRootViewControllerAnimated:true];
}
- (void) dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat) navagationBarHeight {
    return self.navigationController.navigationBar.frame.size.height;
}

- (void) setLeftButton:(NSString *)imageName {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(15.0f, StatusBarHeight + 11, 20.0f, 20.0f);
    [leftButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view bringSubviewToFront:leftButton];
    });
}

- (void) setBackgroundImage:(NSString *)imageName {
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.clipsToBounds = YES;
    background.contentMode = UIViewContentModeScaleAspectFill;
    background.image = [UIImage imageNamed:imageName];
    [self.view addSubview:background];
    
}
- (void)setNavgationBarHidden:(BOOL)hidden {
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [SVProgressHUD dismiss];
}

@end


