//
//  UIImage+SW_Extension.m
//  CustomSWkitPod
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 黄世文. All rights reserved.
//

#import "UIImage+SW_Extension.h"

//  图片工具

@implementation UIImage (SW_Extension)


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
    
    image = [[self alloc] imageCompressWithImage:image targetHeight:targetH targetWidth:targetW];
    
    
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

+ (UIImageView *)getAccessoryImage:(NSString *)imgName{
    UIImageView * pushImage = [UIImageView new];
    pushImage.image = [UIImage imageNamed:imgName];
    pushImage.frame = CGRectMake(0, 0, 10  ,10);
    return pushImage;
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
 
@end
